clear all;


%计算太阳直射方位角和高度角
lon_s=deg2rad(360-297.57);
lat_s=deg2rad(-24.97);
lon_m=deg2rad(106.01);
lat_m=deg2rad(-1.17); 

H=lon_s-lon_m;
Z=acos(sin(lat_m)*sin(lat_s)+cos(lat_s)*cos(lat_m)*cos(H));
Z=rad2deg(Z);
Z=90-Z
A=atan(sin(H)/(cos(lat_m)*tan(lat_s)-sin(lat_m)*cos(H)));
s1=cos(lat_m)*tan(lat_s)-sin(lat_m)*cos(H)
s2=sin(H)
A=rad2deg(A);
A

if(s1/s2<0)
    A=A+180;
end
A
%     
% A=A+90;
% if(A>360)
%     A=A-360;
% end
% A


% 假设光源的入射角和方位角
theta_inc = Z; % 入射角 (度)
phi_inc = A;   % 方位角 (度)

% 将角度转换为弧度
theta_inc = deg2rad(theta_inc);
phi_inc = deg2rad(phi_inc);

% 定义光源辐射强度 I0
I0 = 1;  % 假设光源辐射强度为1（可以根据实际情况修改）
n=100;
[Nx,Ny] = meshgrid(1:n,1:n);
r = 0.5*n;
Nx = Nx-r;
Ny = Ny-r;
mask = r^2-Nx.^2-Ny.^2 > 0;
Nz = sqrt(r^2-Nx.^2-Ny.^2);
Nz(mask==0) = NaN;
Nz = -Nz;
norm = sqrt(Nx.^2+Ny.^2+Nz.^2);
Nx = Nx./norm;
Ny = Ny./norm;
Nz = Nz./norm;
%Ny=-Ny;
Nx(mask==0) = NaN;
Ny(mask==0) = NaN;

%计算法线
X1=Nx;
Y1=Ny;
Z1=Nz;
%计算光源方向
light_vector = [cos(theta_inc) * sin(phi_inc), -cos(theta_inc) * cos(phi_inc), sin(theta_inc)];
dot_product = X1 * light_vector(1) + Y1 * light_vector(2) + Z1 * light_vector(3);
theta_l = acos(dot_product);
I = I0 * cos(theta_l); 
figure;
imshow(I);
caxis([min(min(I)) max(max(I))]);

%估算球谐函数
X_reshape=reshape(Nx, [], 1);
Y_reshape=reshape(Ny, [], 1);
Z_reshape=reshape(Nz, [], 1);
I_reshape=reshape(I, [], 1);
nan_idx = isnan(X_reshape);
X_reshape(nan_idx) = []; 
Y_reshape(nan_idx) = [];
Z_reshape(nan_idx) = [];
I_reshape(nan_idx) = [];
N = cat(3,X_reshape,Y_reshape,Z_reshape);


%拟合
fitFunc = @(p, N) p(1).*N(:,1)+p(2).*N(:,2)+p(3).*N(:,3)...
    +p(4)+p(5).*N(:,1).*N(:,2)+p(6).*N(:,1).*N(:,3)+p(7)*N(:,2).*N(:,3)+p(8)*(N(:,1).^2-N(:,2).^2)+p(9)*(3*N(:,3).^2-1);


% 初始猜测值 p0（假设为全零）
p0 = ones(1, 9);

% 使用 lsqcurvefit 进行非线性最小二乘拟合
opts = optimset('Display','off');  % 设置优化选项
[p_opt, resnorm] = lsqcurvefit(fitFunc, p0, N, I_reshape, [], [], opts);
p_opt
% 输出拟合结果
disp('Optimal parameters:');
disp(p_opt);
y=p_opt(1)*N(:,1)+p_opt(2)*N(:,2)+p_opt(1)*N(:,3);
figure;
scatter(N(:,1),N(:,2),100,y);
colorbar

% 球面坐标系上的每个点的天顶角和方位角
theta = linspace(0, pi, 100);  % 天顶角从0到pi
phi = linspace(0, 2*pi, 100);  % 方位角从0到2*pi

% 创建网格
[THETA, PHI] = meshgrid(theta, phi);

% 计算球面上的法线方向（转换到笛卡尔坐标）
[X, Y, Z] = sph2cart(PHI, pi/2-THETA, 1);  % 球面坐标转换成笛卡尔坐标
X1=-X;
Y1=-Y;
Z1=-Z;
% 计算光线与法线的夹角
% 假设光源方向（从光源到球面表面）为 (sin(phi_inc) * cos(theta_inc), sin(phi_inc) * sin(theta_inc), cos(phi_inc))
light_vector = [-cos(theta_inc) * cos(phi_inc), cos(theta_inc) * sin(phi_inc), -sin(theta_inc)];

% 计算每个点的法线与光线之间的夹角
dot_product = X1 * light_vector(1) + Y1 * light_vector(2) + Z1 * light_vector(3);
theta_l = acos(dot_product);  % 光线与法线的夹角

% 计算辐射强度（假设朗伯反射模型）
I = I0 * cos(theta_l);  % 漫反射模型：I = I0 * cos(θl)

% 可视化辐射分布（用球面网格）
figure;
hold on;
% 绘制球面
sphere;

% 将球面上的辐射强度映射到颜色上
% 在球面上绘制辐射分布
h = surf(X, Y, Z, cos(acos( X * 1 + Y * 0 + Z * 0)));  % 根据辐射强度绘制辐射分布图
set(h, 'EdgeColor', 'none');  % 关闭网格线
view(2)
colormap('jet');  % 颜色映射
colorbar;  % 添加色条
xlabel('X');
ylabel('Y');
zlabel('Z');
title('Radiation Distribution on the Sphere');

% 设置光照和视角
% light;
% lighting gouraud;
view(3);  % 三维视角
axis equal;
hold off;





% 可视化辐射分布（用球面网格）
figure;
hold on;
% 绘制球面
sphere;

% 将球面上的辐射强度映射到颜色上
% 在球面上绘制辐射分布
h = surf(X, Y, Z, I);  % 根据辐射强度绘制辐射分布图
set(h, 'EdgeColor', 'none');  % 关闭网格线
colormap('jet');  % 颜色映射
colorbar;  % 添加色条
xlabel('X');
ylabel('Y');
zlabel('Z');
title('Radiation Distribution on the Sphere');

% 设置光照和视角
% light;
% lighting gouraud;
view(3);  % 三维视角
axis equal;
hold off;
%%
%估算球谐函数
X_reshape=reshape(X, [], 1);
Y_reshape=reshape(Y, [], 1);
Z_reshape=reshape(Z, [], 1);
I_reshape=reshape(I, [], 1);
N = cat(3,X_reshape,Y_reshape,Z_reshape);
%%
%拟合
fitFunc = @(p, N) p(1)*N(:,1)+p(2)*N(:,2)+p(3)*N(:,3)...
    +p(4)+p(5)*N(:,1).*N(:,2)+p(6).*N(:,1).*N(:,3)+p(7)*N(:,2).*N(:,3)+p(8)*(N(:,1).^2-N(:,2).^2)+p(9)*(3*N(:,3).^2-1);


% 初始猜测值 p0（假设为全零）
p0 = ones(1, 9);

% 使用 lsqcurvefit 进行非线性最小二乘拟合
opts = optimset('Display','off');  % 设置优化选项
[p_opt, resnorm] = lsqcurvefit(fitFunc, p0, N, I_reshape, [], [], opts);

% 输出拟合结果
disp('Optimal parameters:');
disp(p_opt);
y=p_opt(1)*N(:,1)+p_opt(2)*N(:,2)+p_opt(1)*N(:,3);
figure;
scatter(N(:,1),N(:,2),100,y);
colorbar
