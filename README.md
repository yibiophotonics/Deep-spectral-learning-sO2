# Deep-spectral-learning-oxygen-saturation

#### Python (Keras) implementation of paper: 
##### Deep	spectral	learning	for	label-free	optical	imaging	oximetry	with	uncertainty	quantification. 

We provide models (a fully connected neural network and a convolutional neural network) with pre-trained weights, input spectra for model training, results of test data, statistical analysis, and reconsturction of en face maps of oxygen saturation & uncertainty.

#### Citation
If you find this project useful in your research, please consider citing our paper:
Deep	spectral	learning	for	label-free	optical	imaging	oximetry	with	uncertainty	quantification
Rongrong	Liu, Shiyi	Cheng, Lei Tian, Ji	Yi

#### Abstract
Measurement of blood oxygen saturation (sO2) by optical imaging oximetry provides invaluable insight into local tissue functions and metabolism. Despite different embodiments and modalities, all label-free optical imaging oximetry techniques utilize the same principle of sO2-dependent spectral contrast from haemoglobin. Traditional approaches for quantifying sO2 often rely on analytical models that are fitted by the spectral measurements. These approaches in practice suffer from uncertainties due to biological variability, tissue geometry, light scattering, systemic spectral bias, and variations in the experimental conditions. Here, we propose a new data-driven approach, termed deep spectral learning (DSL), to achieve oximetry that is highly robust to experimental variations and, more importantly, able to provide uncertainty quantification for each sO2 prediction. To demonstrate the robustness and generalizability of DSL, we analyse data from two visible light optical coherence tomography (vis-OCT) setups across two separate in vivo experiments on rat retinas. Predictions made by DSL are highly adaptive to experimental variabilities as well as the depth-dependent backscattering spectra. Two neural-network-based models are tested and compared with the traditional least-squares fitting (LSF) method. The DSL-predicted sO2 shows significantly lower mean-square errors than those of the LSF. For the first time, we have demonstrated en face maps of retinal oximetry along with a pixel-wise confidence assessment. Our DSL overcomes several limitations of traditional approaches and provides a more flexible, robust, and reliable deep learning approach for in vivo non-invasive label-free optical oximetry. 

#### Requirements

python 3.7.1

keras 2.2.4

numpy 1.16.4

matplotlib 3.1.0

scikit-learn 0.21.2

ipython 7.5.0



#### Work Flow:

![  ](https://github.com/yibiophotonics/Deep-spectral-learning-sO2/blob/master/Figures-for-readme/Figure1.png)

#### Network Structure: 

The fully connected neural network (FNN) model and the convolutional neural network (CNN) model 

![  ](https://github.com/yibiophotonics/Deep-spectral-learning-sO2/blob/master/Figures-for-readme/Figure3.png)

#### Training and testing data from two literatures:

![  ](https://github.com/yibiophotonics/Deep-spectral-learning-sO2/blob/master/Figures-for-readme/Figure2.png)



#### How to run the demo:

1. The demo code is written by Ipython Notebook and in the file: So2_FNN_CNN_rolling_avg_100_9_O2Norm_Finaldemo.ipynb

2. The input spectra are in csv files:

   data_test_rolling_avg_whole_pixels_100_4Lsn_Light_revised_shuffled_LSF2

   data_test_rolling_avg_whole_pixels_SYC_100_3Bsn_Light_revised_shuffled_LSF2

   data_train_rolling_avg_whole_pixels_100_random5_Light_revised_shuffled_LSF2

   You can make different splits of training and testing data in the demo.
   
   

3. Results of so2 predictions and uncertainties in saved in:

   NN_uncertainty_map_so2_XX_XX_XX_o2 for so2 predicted by FNN model

   NN_uncertainty_map_val_XX_XX_XX_o2 for so2 uncertainty by FNN model

   CNN_uncertainty_map_so2_XX_XX_XX_o2 for so2 predicted by CNN model

   CNN_uncertainty_map_val_XX_XX_XX_o2 for so2 uncertainty by CNN model



4. Statistical analysis for test data as explained in the paper are in the file: Matlab statistical analysis, with code (Statistical_Analysis.m) written in Matlab

5. Reconstruction of en face maps of so2 and uncertainty as explaied in the paper are in the file: Display of en face maps, with code (Display_so2_uncertainty_maps.m) written in Matlab


#### Results:

Predictions by the FNN and the CNN models:

![  ](https://github.com/yibiophotonics/Deep-spectral-learning-sO2/blob/master/Figures-for-readme/Figure4.png)

Reconstrcuted sO2 en face maps at hypoxia, nomaxia, and hyperxoia:

![  ](https://github.com/yibiophotonics/Deep-spectral-learning-sO2/blob/master/Figures-for-readme/Figure6.png)

Reconstrcuted sO2 uncertainty en face maps at hypoxia, nomaxia, and hyperxoia:

![  ](https://github.com/yibiophotonics/Deep-spectral-learning-sO2/blob/master/Figures-for-readme/Figure7.png)
