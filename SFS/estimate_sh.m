clear all;


%计算太阳直射方位角和高度角
% lon_s=deg2rad(360-297.57);
% lat_s=deg2rad(-24.97);
% lon_m=deg2rad(106.01);
% lat_m=deg2rad(-1.17); % 11
% lon_s=deg2rad(360-70.53);
% lat_s=deg2rad(-2.56);
% lon_m=deg2rad(325.05);
% lat_m=deg2rad(-14.09);%0
% lon_s=deg2rad(360-36.43);
% lat_s=deg2rad(22.42);
% lon_m=deg2rad(5.57);
% lat_m=deg2rad(40.78);%12
% lon_s=deg2rad(360-77.44);
% lat_s=deg2rad(21.76);
% lon_m=deg2rad(326.11);
% lat_m=deg2rad(-16.22);%2
% lon_s=deg2rad(360-323.19);
% lat_s=deg2rad(21.16);
% lon_m=deg2rad(82.91);
% lat_m=deg2rad(35.99);%13
% lon_s=deg2rad(360-359.83);
% lat_s=deg2rad(23.12);
% lon_m=deg2rad(50.37);
% lat_m=deg2rad(42.46);%14
% lon_s=deg2rad(360-117.45);
% lat_s=deg2rad(21.07);
% lon_m=deg2rad(296.29);
% lat_m=deg2rad(-23.62);%15
% lon_s=deg2rad(360-184.26);
% lat_s=deg2rad(4.36);
% lon_m=deg2rad(213.84);
% lat_m=deg2rad(23.88);%16
% lon_s=deg2rad(360-359.83);
% lat_s=deg2rad(23.12);
% lon_m=deg2rad(50.37);
% lat_m=deg2rad(42.46);%17
% lon_s=deg2rad(360-358.89);
% lat_s=deg2rad(-7.57);
% lon_m=deg2rad(53.99);
% lat_m=deg2rad(39.96);%18
% lon_s=deg2rad(360-74.37);
% lat_s=deg2rad(21.59);
% lon_m=deg2rad(331.89);
% lat_m=deg2rad(-0.3);%19
% lon_s=deg2rad(360-57.41);
% lat_s=deg2rad(-3.24);
% lon_m=deg2rad(338.5);
% lat_m=deg2rad(-24.37);%20
% lon_s=deg2rad(360-314.96);
% lat_s=deg2rad(5.7);
% lon_m=deg2rad(97.87);
% lat_m=deg2rad(45.54);%21
% lon_s=deg2rad(360-53.13);
% lat_s=deg2rad(11.64);
% lon_m=deg2rad(0.52);
% lat_m=deg2rad(36.88);%22
% lon_s=deg2rad(360-115.96);
% lat_s=deg2rad(-0.14);
% lon_m=deg2rad(296.06);
% lat_m=deg2rad(43.81);%23
% lon_s=deg2rad(360-272.85);
% lat_s=deg2rad(12.61);
% lon_m=deg2rad(134.73);
% lat_m=deg2rad(28.72);%24
% lon_s=deg2rad(360-6.64);
% lat_s=deg2rad(18.88);
% lon_m=deg2rad(43.98);
% lat_m=deg2rad(43.89);%25
% lon_s=deg2rad(360-50.07);
% lat_s=deg2rad(25.45);
% lon_m=deg2rad(357.16);
% lat_m=deg2rad(44.25);%26
% lon_s=deg2rad(360-283.27);
% lat_s=deg2rad(9.34);
% lon_m=deg2rad(133.77);
% lat_m=deg2rad(-0.98);%27
% lon_s=deg2rad(360-242.55);
% lat_s=deg2rad(-15.98);
% lon_m=deg2rad(149.36);
% lat_m=deg2rad(-6.48);%28
% lon_s=deg2rad(360-314.48);
% lat_s=deg2rad(24.45);
% lon_m=deg2rad(93.46);
% lat_m=deg2rad(-4.49);%29
% lon_s=deg2rad(360-288.55);
% lat_s=deg2rad(-15.52);
% lon_m=deg2rad(107.9);
% lat_m=deg2rad(-42.47);%30
% lon_s=deg2rad(360-50.34);
% lat_s=deg2rad(-3.16);
% lon_m=deg2rad(8.71);
% lat_m=deg2rad(-67.12);%1
% lon_s=deg2rad(360-6.04);
% lat_s=deg2rad(-11.2);
% lon_m=deg2rad(57.71);
% lat_m=deg2rad(-69.83);%3
% lon_s=deg2rad(360-125.83);
% lat_s=deg2rad(-2.86);
% lon_m=deg2rad(284.75);
% lat_m=deg2rad(27.88);%31
lon_s=deg2rad(360-72.15);
lat_s=deg2rad(21.94);
lon_m=deg2rad(331.91);
lat_m=deg2rad(17.74);%32
% lon_s=deg2rad(360-199.35);
% lat_s=deg2rad(-25.4);
% lon_m=deg2rad(203.47);
% lat_m=deg2rad(-27.87);%33
% lon_s=deg2rad(360-236.94);
% lat_s=deg2rad(22.23);
% lon_m=deg2rad(169.19);
% lat_m=deg2rad(8.67);%34
% lon_s=deg2rad(360-157.25);
% lat_s=deg2rad(-1.21);
% lon_m=deg2rad(259.37);
% lat_m=deg2rad(26.39);%35
% lon_s=deg2rad(360-57.15);
% lat_s=deg2rad(20.69);
% lon_m=deg2rad(356.33);
% lat_m=deg2rad(-19.56);%4
% lon_s=deg2rad(360-1.75);
% lat_s=deg2rad(-11.73);
% lon_m=deg2rad(53.96);
% lat_m=deg2rad(-27.89);%5
% lon_s=deg2rad(360-299.45);
% lat_s=deg2rad(24.78);
% lon_m=deg2rad(109.96);
% lat_m=deg2rad(26.06);%6
lon_s=deg2rad(360-248.39);
lat_s=deg2rad(20.77);
lon_m=deg2rad(163.03);
lat_m=deg2rad(36.76);%7
% lon_s=deg2rad(360-121.06);
% lat_s=deg2rad(2.55);
% lon_m=deg2rad(275.53);
% lat_m=deg2rad(2.11);%9
% lon_s=deg2rad(360-90.94);
% lat_s=deg2rad(-15.31);
% lon_m=deg2rad(302.39);
% lat_m=deg2rad(-0.57);%10
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
