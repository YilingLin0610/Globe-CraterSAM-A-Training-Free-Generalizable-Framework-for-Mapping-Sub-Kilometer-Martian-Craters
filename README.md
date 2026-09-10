# Globe-CraterSAM

This repository provides the main code and benchmark datasets associated with Globe-CraterSAM, a training-free framework for sub-kilometer Martian crater mapping.

## Code

### 1. Shape-from-Shading (SfS)

The SfS implementation is modified from:

[yqueau/shape_from_shading: Matlab codes for shape from shading](https://github.com/yqueau/shape_from_shading)

The codes used to calculate illumination azimuth, elevation, and the related spherical harmonic parameters are provided in the `SFS` folder.

### 2. Segment Anything Model (SAM)

The Segment Anything Model code is based on the official implementation:

[facebookresearch/segment-anything](https://github.com/facebookresearch/segment-anything)

The batch-processing scripts used to apply SAM to the Martian imagery are provided in the `SAM` folder.

### 3. Post-processing

The post-processing modules used in Globe-CraterSAM are provided in the `Post-processing` folder, including:

- BSLS
- Circularity filter
- Depression filter

## Datasets

The datasets used in this study are provided in the `Datasets` folder.
