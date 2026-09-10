import argparse
import numpy as np
import torch
import matplotlib.pyplot as plt
import cv2
# from memory_profiler import profile
import os
import time
from tqdm import *
from pre_processing.cut_patches import TifCrop
from pre_processing.Convert_JPEGImages import batch_processing
from osgeo import gdal

class ImageDataset(torch.utils.data.Dataset):
    def __init__(self, images_path, output_path, transform=None):
        # 获取图片路径下的所有图片文件名
        self.images = os.listdir(images_path)
        output = os.listdir(output_path)
        output = [ it[:-3] + 'jpg' for it in output]
        print("Processed:", len(output))
        self.images = list(set(self.images) - set(output))
        print("Unprocessed:", len(self.images))
        # 拼接图片路径和文件名
        self.images = [os.path.join(images_path, img) for img in self.images]
        # 定义一个可选的数据转换函数
        self.transform = transform

    def __len__(self):
        # 返回数据集的长度
        return len(self.images)

    def __getitem__(self, index):
        # 根据索引获取一张图片
        image = cv2.imread(self.images[index])
        image = cv2.cvtColor(image, cv2.COLOR_BGR2RGB)
        # print(image.shape)
        # image = Image.open(self.images[index])
        # 如果有转换函数，就对图片进行转换
        if self.transform:
            image = self.transform(image)
        # 返回图片和文件名（不含后缀）
        filename = os.path.splitext(os.path.basename(self.images[index]))[0]
        return image, filename


# @profile
def show_anns(anns):
    if len(anns) == 0:
        return
    sorted_anns = sorted(anns, key=(lambda x: x['area']), reverse=True)
    ax = plt.gca()
    ax.set_autoscale_on(False)
    polygons = []
    color = []
    for ann in sorted_anns:
        m = ann['segmentation']
        img = np.ones((m.shape[0], m.shape[1], 3))
        color_mask = np.random.random((1, 3)).tolist()[0]
        for i in range(3):
            img[:, :, i] = color_mask[i]
        ax.imshow(np.dstack((img, m * 0.35)))

def resample(input_raster_path, output_raster_path, dst_resolution, resample_alg=gdal.GRA_Bilinear):
    # 打开原始栅格文件
    src_ds = gdal.Open(input_raster_path)
    if src_ds is None:
        raise ValueError("无法打开输入文件: {}".format(input_raster_path))

    # 获取原始分辨率
    src_geotransform = src_ds.GetGeoTransform()
    # 使用 gdal.Warp 进行重采样
    gdal.Warp(
        output_raster_path,  # 输出文件路径
        src_ds,              # 输入数据集
        format='GTiff',      # 输出格式
        xRes=dst_resolution,  # 目标 x 方向分辨率
        yRes=dst_resolution,  # 目标 y 方向分辨率
        resampleAlg=resample_alg  # 重采样方法
    )

    print(f"重采样后的影像已保存到: {output_raster_path}")
    #os.remove(input_raster_path)
# @profile
def test_on_single(args):
    from segment_anything import sam_model_registry, SamAutomaticMaskGenerator, SamPredictor
    image = cv2.imread(args.image)
    image = cv2.cvtColor(image, cv2.COLOR_BGR2RGB)
    sam = sam_model_registry[args.model](checkpoint=args.ckpt)
    sam.to(device=args.device)

    mask_generator = SamAutomaticMaskGenerator(
        model=sam,
        points_per_batch=128,
        box_nms_thresh=0.1,
        crop_n_layers=1,
        crop_nms_thresh=0.5,
        crop_n_points_downscale_factor=2,
    )

    masks = mask_generator.generate(image)
    # print(masks[0].keys())
    # 将多个masks合并，使用或运算
    mask = np.zeros((masks[0]['segmentation'].shape[0], masks[0]['segmentation'].shape[1]))
    for i in range(len(masks)):
        mask = np.logical_or(mask, masks[i]['segmentation'])
    # 将全部值均为true/false的mask存为二值图
    mask = mask.astype(np.uint8)
    cv2.imwrite(args.output + '/' + args.image.split('/')[-1].split('.')[0] + '.png', mask * 255)

    # plt.figure(figsize=(20,20))
    # plt.imshow(image)
    # show_anns(masks)
    # plt.axis('off')
    # # plt.show()
    # plt.savefig(args.output + '/' + args.image.split('/')[-1].split('.')[0] + '.png')


# @profile
def test_on_multi(model,ckpt,device,images,output,batch_size,num_work):
    from segment_anything import sam_model_registry, SamAutomaticMaskGenerator, SamPredictor

    sam = sam_model_registry[model](checkpoint=ckpt)
    sam.to(device=device)

    mask_generator = SamAutomaticMaskGenerator(
        model=sam,
        points_per_batch=128,
        box_nms_thresh=0.1,
        crop_n_layers=1,
        crop_nms_thresh=0.5,
        crop_n_points_downscale_factor=2,
    )
    dataset = ImageDataset(images, output, transform=None)
    dataloader = torch.utils.data.DataLoader(dataset, batch_size=batch_size, shuffle=False,
                                             num_workers=num_work)
    with torch.no_grad():
        for image, filename in tqdm(dataloader):
            try:

                # st = time.time()
                filename = filename[0]
                image = torch.squeeze(image, dim=0)
                masks = mask_generator.generate(image.numpy())
                mask = np.zeros((masks[0]['segmentation'].shape[0], masks[0]['segmentation'].shape[1]))
                masks.sort(key=lambda x: x['area'], reverse=True)
                for i in range(1, len(masks)):
                    mask = np.logical_or(mask, masks[i]['segmentation'], dtype=bool)
                plt.imsave(output + '/' + filename + '.png', mask, cmap='gray')
            except:
                print(filename[0])
            
            # ed = time.time()
            #print("Process ", filename)
            # exit()


if __name__ == '__main__':

    chunks_from_file = []
    total_path = r"/data/C/Yiling/Mars_SFS/CTX_images_process_5/"
    with open('/data/C/Yiling/Mars_SFS/CTX_images_process_5/CTX_images_C_5.txt', 'r') as f:
        lines = f.read().splitlines()
        chunks_from_file.append(lines)
    #chunks_from_file=chunks_from_file[0]
    chunks_from_file=chunks_from_file[0]
    # chunks_from_file=['MurrayLab_GlobalCTXMosaic_V01_E-052_N-52','MurrayLab_GlobalCTXMosaic_V01_E-028_N60',
    #                   'MurrayLab_GlobalCTXMosaic_V01_E000_N-64']
    print(chunks_from_file)
    for name in tqdm(chunks_from_file):
        print("..................................." + name)
        path = total_path + name + "/"

        Tifpath = [path + x for x in os.listdir(path) if x.endswith("Mosaic_resample.tif")]
        print(Tifpath)
        if(len(Tifpath) >0):
            Tifpath = [path + x for x in os.listdir(path) if x.endswith("Mosaic_resample.tif")][0]
        else:
            print("Resample")
            rasterpath = [path + x for x in os.listdir(path) if x.endswith("tif")][0]
            resample(rasterpath, rasterpath[0:-4] + "_resample.tif", 6)
            Tifpath = [path + x for x in os.listdir(path) if x.endswith("resample.tif")][0]


        CroppedTifPath = path + "tifs/"
        print(CroppedTifPath)

        PatchSize = 1024
        OverlapRate = 0.1
        # CroppedJpgPath=r"/data/A/Yiling/Mars_SAM_crater/training_testing_data/data/3d_ratio/testing_data/"+str(study_area)+"/tifs_jpgs"
        CroppedJpgPath = path + "tifs_jpgs/"
        print(CroppedJpgPath)
        try:
            os.mkdir(CroppedJpgPath)
        except:
            print("exist")
        # args=parser.parse_args()
        print(Tifpath)
        output_file_path = path + "results/prediction"
        if os.path.exists(CroppedTifPath):
            print("exist crop")
        else:
            try:
                TifCrop(Tifpath, CroppedTifPath, PatchSize, OverlapRate)
            except:
                os.remove(Tifpath)
                Tifpath = [path + x for x in os.listdir(path) if x.endswith("Mosaic_resample.tif")]
                print("Resample")
                rasterpath = [path + x for x in os.listdir(path) if x.endswith("tif")][0]
                resample(rasterpath, rasterpath[0:-4] + "_resample.tif", 6)
                Tifpath = [path + x for x in os.listdir(path) if x.endswith("resample.tif")][0]
                TifCrop(Tifpath, CroppedTifPath, PatchSize, OverlapRate)
            batch_processing(CroppedTifPath, CroppedJpgPath)
            try:
                os.mkdir(path + "results/")
                os.mkdir(output_file_path)
            except:
                pass
        # crop_num=os.listdir(CroppedTifPath)
        # SAM_num=os.listdir(output_file_path)
        # if(len(crop_num) > len(SAM_num)):
        #     print("start SAM")
        #     model = 'vit_h'
        #     images = CroppedJpgPath
        #     ckpt = 'ckpt/sam_vit_h_4b8939.pth'
        #     device = 'cuda'
        #     output = output_file_path
        #     batch_size = 1
        #     num_work = 4
        #     test_on_multi(model, ckpt, device, images, output, batch_size, num_work)





    # Delete the jpg and png

    
    
    
