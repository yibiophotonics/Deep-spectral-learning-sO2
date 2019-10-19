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

![Test Image 1](Figure1.tiff)
