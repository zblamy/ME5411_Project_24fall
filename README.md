# ME5411_project_24fall

This repository contains codes for NUS ME5411 course project in AY24-25 S1

These codes are created by zbl

Anyone is welcome to take them as a reference, but please no plagiarism

The assignment contents are in *Prj_Computer - ME5411.pdf*

# Q1

Codes for question 1 are in *Q1.m*.

Here I used three methods to realize contrast enhancement including constrast stretching, histogram equlization (see function *hist_eq.m*), geometric transformation.

# Q23

Codes for question 2 and 3 are in *Q23.m*.

For questions 2, average filter are implemented in *avg_filter.m*.

# Q4567

Codes for question 4,5,6,7 are in *Q4567.m*.

Sobel and Laplacian operator are implemented in *sobel.m* and *Laplacian.m* respectively.

# Q8

Q8 are realized in *Q8CNN.m*, *Q8SVM.m*, and *Q8compare.mlx*.

## Training Models

You can use *Q8CNN.m* to train a CNN model and use *Q8SVM.m* to train a SVM model.

Remenber to set your dataset path and model saving path properly.

Several models I trained are also provided:

*CNN9.mat* for batchsize 128, learning rate 0.001

*CNN9_batch256.mat* for batchsize 256, learning rate 0.01

*CNN9_256_5e3.mat* for batchsize 256, learning rate 0.005, which I think has the best performance.

*SVM.mat* for linear kernel SVM and *labelmap.mat* is the label map for the model.

## Compare CNN and SVM

*Q8compare.mlx* is for comparing CNN and SVM models. 

Remenber to set your image path and model path properly.

# Final Report

Final report is also provided for reference, see *final_report.pdf*.



