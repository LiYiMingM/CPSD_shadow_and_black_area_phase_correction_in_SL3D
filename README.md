# CPSD Method

<div align="center">

<h1> Global phase accuracy enhancement of structured light system calibration and 3D reconstruction by overcoming inevitable unsatisfactory intensity modulation

<div>
    <p> <b>Tsinghua SIGS</b> </p>
</div>

![colored_mesh (1)](assets/describtion_problem.png)

</div>

## Introduction

- Fringe projection profilometry (FPP) faces challenges in measuring unsatisfactory intensity modulation areas, especially shadow and black areas, causing pseudo phases and obvious nonlinear calibration error in 3D measurement. To address these issues, we proposed a cyclic phase-shifts difference (CPSD) module based on phase-shifting gratings. CPSD uses double layer circulation to retain the pixels with higher light intensity and finally create a mask that removes black and shadow areas. Removing the necessity for further post-processing or projection in phase adjustment, we achieved the global phase accuracy enhancement and high-precision 3D point clouds without pseudo points. The method’s efficacy was proven through experiments on three calibration planes, achieving a significant reduction in mean absolute error (MAE) and standard deviation (STD) in plane reconstruction (up to 50.9% and 56.1% respectively). We believe CPSD has potential for wide application across various FPP related fields.

  ![colored_mesh (1)](assets/effect.png)

  
## Code
### * just run the test_run.m in matlab
 

  ```matlab
  -  test_run.m


  %%code of CPC and CPSD
  %%See the 'function' file for subfunctions
  %%The test data is in folder <test_data_calibration_plane> and <test_data_object>

```

  


## Updates
- [03/2024] We will continue to update the related research. Stay tuned!



## Agreement

Authors reserve the right to terminate your access to the Dataset at any time.

## More informarion
Details about the code and dataset can be found in this paper. 
## How to Cite

Please cite this paper when using the related content:

```bibtex
@article{li2024global,
  title={Global phase accuracy enhancement of structured light system calibration and 3D reconstruction by overcoming inevitable unsatisfactory intensity modulation},
  author={Li, Yiming and Li, Zinan and Liang, Xiaojun and Huang, Haozhen and Qian, Xiang and Feng, Feng and Zhang, Chaobo and Wang, Xiaohao and Gui, Weihua and Li, Xinghui},
  journal={Measurement},
  volume={236},
  pages={114952},
  year={2024},
  publisher={Elsevier}
}
```
## Contact
- Yiming Li (lemonymtree@163.com)

