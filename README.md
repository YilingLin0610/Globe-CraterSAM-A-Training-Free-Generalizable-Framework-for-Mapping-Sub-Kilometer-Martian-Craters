# Globe-CraterSAM

This repository provides the code and datasets used in Globe-CraterSAM for sub-kilometer Martian crater mapping.

## Code

### 1. Shape-from-Shading (SfS)

The SfS implementation is modified from:

[yqueau/shape_from_shading: Matlab codes for shape from shading](https://github.com/yqueau/shape_from_shading)

The codes used to calculate illumination azimuth, elevation, and the related spherical harmonic parameters are provided in the `SFS` folder.

### 2. Segment Anything Model (SAM)

The Segment Anything Model code is based on the official implementation:

[facebookresearch/segment-anything](https://github.com/facebookresearch/segment-anything)

### 3. Post-processing

The post-processing modules used in Globe-CraterSAM are provided in the `Post-processing` folder, including:

- BSLS
- Circularity filter
- Depression filter

## Datasets

The datasets used in this study are provided in the `Datasets` folder.
