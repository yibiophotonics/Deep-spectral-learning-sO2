 close all; 
 clear;
 clc;
 
 %% parameters for figure display purpose (scale ranges)
L=0.4;H=1;
L0=0.4;H0=1;
LA=35;HA=210;

%% display so2 en face maps: 

% customized colormap
sf3=0.32;%0.32;
c=hsv(1000);
sc = 0.9;%.9;             
st = 1; ed = 1000.*sf3; 
newCM1 = c(ed:-1:st,:)*sc; 

%%  display sO2 en face maps of nomaxia: sO2=80% by oximeter reading (ground-truth label) 

% oximeter reading (ground-truth label):
Or=0.8; 

% load in vessel binary mask and so2 predictions with uncertainty
load('OCT_14_53_00_05V_vessel_mask.mat');

ttso2_NN=load('NN_uncertainty_map_so2_14_53_00_o2.mat');
ttso2_CNN=load('CNN_uncertainty_map_so2_14_53_00_o2.mat');
ttval_NN=load('NN_uncertainty_map_val_14_53_00_o2.mat');
ttval_CNN=load('CNN_uncertainty_map_val_14_53_00_o2.mat');

% load in OCTA intensity map (with different tricks to enhance OCTA intensity)
load('OCTA_14_53_00_1.mat')
load('OCTA_14_53_00_2.mat')

% load in so2 calculated by least-squares fitting method
load('OCT_14_53_00_05V_vesSO2.mat');

% load in OCT structure en face map
load('14_53_00_tmp.mat');

% reconstruct so2 and uncertainty of each vessel by FNN and CNN models
tt2_NN=reshape(ttso2_NN.predictions_so2,[400,512,10]);
for i=1:size(tt2_NN,3)
    tt3_NN(:,:,i)=tt2_NN(:,:,i).*tm(:,:,i);
end

ttval2_NN=reshape(ttval_NN.predictions_so2_val,[400,512,10]);
for i=1:size(ttval2_NN,3)
    ttval3_NN(:,:,i)=sqrt(ttval2_NN(:,:,i)).*tm(:,:,i);
end

tt2_CNN=reshape(ttso2_CNN.predictions_so2,[400,512,10]);
for i=1:size(tt2_CNN,3)
    tt3_CNN(:,:,i)=tt2_CNN(:,:,i).*tm(:,:,i);
end

ttval2_CNN=reshape(ttval_CNN.predictions_so2_val,[400,512,10]);
for i=1:size(ttval2_CNN,3)
    ttval3_CNN(:,:,i)=sqrt(ttval2_CNN(:,:,i)).*tm(:,:,i);
end

% remove striped noise of OCTA
column_offsets = median(angios);
column_offsets = column_offsets - min(column_offsets);
new_angios = bsxfun(@minus,angios,column_offsets);

% enhance OCTA comtrast
angioF=1./tmp.^4.*angio+(1-sum(tm,3)).*new_angios.*40;

% display
figure('units','normalized','outerposition',[0 0 1 1])
subplot(221);
so2_2D=sum(tt3_NN,3);
so2_2D(isnan(so2_2D))=0;
hue1=mat2gray(so2_2D,[L H]);  %% change the second number here for the red and green colors
HSV1(:,:,1)=(1-hue1).*sf3;
HSV1(:,:,3)=mat2gray(angioF,[LA HA]);  
HSV1(:,:,2)=mat2gray(so2_2D,[0 0.02]);
RGB1=hsv2rgb(HSV1);
image(RGB1);
colormap(newCM1); 
colorbar; 
title('sO_2 map by FNN');
axis square;
axis off;

subplot(222);
so2_2D=sum((tt3_CNN),3);
so2_2D(isnan(so2_2D))=0;
hue1=mat2gray(so2_2D,[L H]);  %% change the second number here for the red and green colors
HSV1(:,:,1)=(1-hue1).*sf3;
HSV1(:,:,3)=mat2gray(angioF,[LA HA]);  
HSV1(:,:,2)=mat2gray(so2_2D,[0 0.02]);
RGB1=hsv2rgb(HSV1);
image(RGB1);
colormap(newCM1); 
colorbar; 
title('sO_2 map by CNN');
axis square;
axis off;

subplot(223);
so2_2D=sum(tm(:,:,1:2:9),3).*Or;
hue1=mat2gray(so2_2D,[L H]);  %% change the second number here for the red and green colors
HSV1(:,:,1)=(1-hue1).*sf3;
HSV1(:,:,3)=mat2gray(angioF,[LA HA]);  
HSV1(:,:,2)=mat2gray(so2_2D,[0 0.02]);
RGB1=hsv2rgb(HSV1);
image(RGB1);
colormap(newCM1); 
colorbar; 
title(['Oximeter readings of arteriole sO_2: ',num2str(Or.*100),'%']);
axis square;
axis off;

subplot(224);
so2_2D=nansum(vesSO2,3);
so2_2D(isnan(so2_2D))=0;
hue1=mat2gray(so2_2D,[L0 H0]);  %% change the second number here for the red and green colors
HSV1(:,:,1)=(1-hue1).*sf3;
HSV1(:,:,3)=mat2gray(angioF,[LA HA]);  
HSV1(:,:,2)=mat2gray(so2_2D,[0 0.02]);
RGB1=hsv2rgb(HSV1);
image(RGB1);
colormap(newCM1); 
colorbar; 
title('sO_2 map by least square fitting');
axis square;
axis off;

%% display sO2 en face maps of hypoxia: sO2=70% by oximeter reading (ground-truth label) 

Or=0.7;

load('OCT_14_48_16_05V_vessel_mask.mat');
ttso2_NN=load('NN_uncertainty_map_so2_14_48_16_o2.mat');
ttso2_CNN=load('CNN_uncertainty_map_so2_14_48_16_o2.mat');
ttval_NN=load('NN_uncertainty_map_val_14_48_16_o2.mat');
ttval_CNN=load('CNN_uncertainty_map_val_14_48_16_o2.mat');

load('OCTA_14_48_16_1.mat')
load('OCTA_14_48_16_2.mat')

load('OCT_14_48_16_05V_vesSO2.mat')
load('14_48_16_tmp.mat')

tt2_NN=reshape(ttso2_NN.predictions_so2,[400,512,10]);
for i=1:size(tt2_NN,3)
    tt3_NN(:,:,i)=tt2_NN(:,:,i).*tm(:,:,i);
end

ttval2_NN=reshape(ttval_NN.predictions_so2_val,[400,512,10]);
for i=1:size(ttval2_NN,3)
    ttval3_NN(:,:,i)=sqrt(ttval2_NN(:,:,i)).*tm(:,:,i);
end

tt2_CNN=reshape(ttso2_CNN.predictions_so2,[400,512,10]);
for i=1:size(tt2_CNN,3)
    tt3_CNN(:,:,i)=tt2_CNN(:,:,i).*tm(:,:,i);
end

ttval2_CNN=reshape(ttval_CNN.predictions_so2_val,[400,512,10]);
for i=1:size(ttval2_CNN,3)
    ttval3_CNN(:,:,i)=sqrt(ttval2_CNN(:,:,i)).*tm(:,:,i);
end

column_offsets = median(angios);
column_offsets = column_offsets - min(column_offsets);
new_angios = bsxfun(@minus,angios,column_offsets);

angioF=1./tmp.^4.*angio+(1-sum(tm,3)).*new_angios.*40;

figure('units','normalized','outerposition',[0 0 1 1])
subplot(221);
so2_2D=sum(tt3_NN,3);
so2_2D(isnan(so2_2D))=0;
hue1=mat2gray(so2_2D,[L H]);  %% change the second number here for the red and green colors
HSV1(:,:,1)=(1-hue1).*sf3;
HSV1(:,:,3)=mat2gray(angioF,[LA HA]);  
HSV1(:,:,2)=mat2gray(so2_2D,[0 0.02]);
RGB1=hsv2rgb(HSV1);
image(RGB1);
colormap(newCM1); 
colorbar; 
title('sO_2 map by FNN');
axis square;
axis off;

subplot(222);
so2_2D=sum((tt3_CNN),3);
so2_2D(isnan(so2_2D))=0;
hue1=mat2gray(so2_2D,[L H]);  %% change the second number here for the red and green colors
HSV1(:,:,1)=(1-hue1).*sf3;
HSV1(:,:,3)=mat2gray(angioF,[LA HA]);  
HSV1(:,:,2)=mat2gray(so2_2D,[0 0.02]);
RGB1=hsv2rgb(HSV1);
image(RGB1);
colormap(newCM1); 
colorbar; 
title('sO_2 map by CNN');
axis square;
axis off;

subplot(223);
so2_2D=sum(tm(:,:,1:2:9),3).*Or;
hue1=mat2gray(so2_2D,[L H]);  %% change the second number here for the red and green colors
HSV1(:,:,1)=(1-hue1).*sf3;
HSV1(:,:,3)=mat2gray(angioF,[LA HA]);  
HSV1(:,:,2)=mat2gray(so2_2D,[0 0.02]);
RGB1=hsv2rgb(HSV1);
image(RGB1);
colormap(newCM1); 
colorbar; 
title(['Oximeter readings of arteriole sO_2: ',num2str(Or.*100),'%']);
axis square;
axis off;

subplot(224);
so2_2D=nansum(vesSO2,3);
so2_2D(isnan(so2_2D))=0;
hue1=mat2gray(so2_2D,[L0 H0]);  %% change the second number here for the red and green colors
HSV1(:,:,1)=(1-hue1).*sf3;
HSV1(:,:,3)=mat2gray(angioF,[LA HA]);  
HSV1(:,:,2)=mat2gray(so2_2D,[0 0.02]);
RGB1=hsv2rgb(HSV1);
image(RGB1);
colormap(newCM1); 
colorbar; 
title('sO_2 map by least square fitting');
axis square;
axis off;
%% display sO2 en face maps of hyperoxia: sO2=98% by oximeter reading (ground-truth label)

Or=0.98;

load('OCT_14_27_16_05V_vessel_mask.mat');

ttso2_NN=load('NN_uncertainty_map_so2_14_27_16_o2.mat');
ttso2_CNN=load('CNN_uncertainty_map_so2_14_27_16_o2.mat');
ttval_NN=load('NN_uncertainty_map_val_14_27_16_o2.mat');
ttval_CNN=load('CNN_uncertainty_map_val_14_27_16_o2.mat');

load('OCTA_14_27_16_1.mat')
load('OCTA_14_27_16_2.mat')

load('OCT_14_27_16_05V_vesSO2.mat')
load('14_27_16_tmp.mat')

tt2_NN=reshape(ttso2_NN.predictions_so2,[400,512,10]);
for i=1:size(tt2_NN,3)
    tt3_NN(:,:,i)=tt2_NN(:,:,i).*tm(:,:,i);
end

ttval2_NN=reshape(ttval_NN.predictions_so2_val,[400,512,10]);
for i=1:size(ttval2_NN,3)
    ttval3_NN(:,:,i)=sqrt(ttval2_NN(:,:,i)).*tm(:,:,i);
end

tt2_CNN=reshape(ttso2_CNN.predictions_so2,[400,512,10]);
for i=1:size(tt2_CNN,3)
    tt3_CNN(:,:,i)=tt2_CNN(:,:,i).*tm(:,:,i);
end

ttval2_CNN=reshape(ttval_CNN.predictions_so2_val,[400,512,10]);
for i=1:size(ttval2_CNN,3)
    ttval3_CNN(:,:,i)=sqrt(ttval2_CNN(:,:,i)).*tm(:,:,i);
end

column_offsets = median(angios);
column_offsets = column_offsets - min(column_offsets);
new_angios = bsxfun(@minus,angios,column_offsets);

angioF=1./tmp.^4.*angio+(1-sum(tm,3)).*new_angios.*40;

figure('units','normalized','outerposition',[0 0 1 1])
subplot(221);
so2_2D=sum(tt3_NN,3);
so2_2D(isnan(so2_2D))=0;
hue1=mat2gray(so2_2D,[L H]);  %% change the second number here for the red and green colors
HSV1(:,:,1)=(1-hue1).*sf3;
HSV1(:,:,3)=mat2gray(angioF,[LA HA]);  
HSV1(:,:,2)=mat2gray(so2_2D,[0 0.02]);
RGB1=hsv2rgb(HSV1);
image(RGB1);
colormap(newCM1); 
colorbar; 
title('sO_2 map by FNN');
axis square;
axis off;

subplot(222);
so2_2D=sum((tt3_CNN),3);
so2_2D(isnan(so2_2D))=0;
hue1=mat2gray(so2_2D,[L H]);  %% change the second number here for the red and green colors
HSV1(:,:,1)=(1-hue1).*sf3;
HSV1(:,:,3)=mat2gray(angioF,[LA HA]);  
HSV1(:,:,2)=mat2gray(so2_2D,[0 0.02]);
RGB1=hsv2rgb(HSV1);
image(RGB1);
colormap(newCM1); 
colorbar; 
title('sO_2 map by CNN');
axis square;
axis off;

subplot(223);
so2_2D=sum(tm(:,:,1:2:9),3).*Or;
hue1=mat2gray(so2_2D,[L H]);  %% change the second number here for the red and green colors
HSV1(:,:,1)=(1-hue1).*sf3;
HSV1(:,:,3)=mat2gray(angioF,[LA HA]);  
HSV1(:,:,2)=mat2gray(so2_2D,[0 0.02]);
RGB1=hsv2rgb(HSV1);
image(RGB1);
colormap(newCM1); 
colorbar; 
title(['Oximeter readings of arteriole sO_2: ',num2str(Or.*100),'%']);
axis square;
axis off;

subplot(224);
so2_2D=nansum(vesSO2,3);
so2_2D(isnan(so2_2D))=0;
hue1=mat2gray(so2_2D,[L0 H0]);  %% change the second number here for the red and green colors
HSV1(:,:,1)=(1-hue1).*sf3;
HSV1(:,:,3)=mat2gray(angioF,[LA HA]);  
HSV1(:,:,2)=mat2gray(so2_2D,[0 0.02]);
RGB1=hsv2rgb(HSV1);
image(RGB1);
colormap(newCM1); 
colorbar; 
title('sO_2 map by least square fitting');
axis square;
axis off;

%% display so2 uncertainty en face maps: 

% customized colormap
sf3=0.9;
c=hsv(1000);
sc = 0.9;              
st = 600; ed = 1000.*sf3; 
offset=st/1000;
newCM2 = c(st:1:ed,:)*sc;  

%% display uncertainty en face maps of nomaxia: sO2=80% by oximeter reading (ground-truth label)

Or=0.8;

load('OCT_14_53_00_05V_vessel_mask.mat');

ttso2_NN=load('NN_uncertainty_map_so2_14_53_00_o2.mat');
ttso2_CNN=load('CNN_uncertainty_map_so2_14_53_00_o2.mat');
ttval_NN=load('NN_uncertainty_map_val_14_53_00_o2.mat');
ttval_CNN=load('CNN_uncertainty_map_val_14_53_00_o2.mat');

load('OCTA_14_53_00_1.mat')
load('OCTA_14_53_00_2.mat')

load('OCT_14_53_00_05V_vesSO2.mat')
load('14_53_00_tmp.mat')
%
tt2_NN=reshape(ttso2_NN.predictions_so2,[400,512,10]);
for i=1:size(tt2_NN,3)
    tt3_NN(:,:,i)=tt2_NN(:,:,i).*tm(:,:,i);
end

ttval2_NN=reshape(ttval_NN.predictions_so2_val,[400,512,10]);
for i=1:size(ttval2_NN,3)
    ttval3_NN(:,:,i)=sqrt(ttval2_NN(:,:,i)).*tm(:,:,i);
end

tt2_CNN=reshape(ttso2_CNN.predictions_so2,[400,512,10]);
for i=1:size(tt2_CNN,3)
    tt3_CNN(:,:,i)=tt2_CNN(:,:,i).*tm(:,:,i);
end

ttval2_CNN=reshape(ttval_CNN.predictions_so2_val,[400,512,10]);
for i=1:size(ttval2_CNN,3)
    ttval3_CNN(:,:,i)=sqrt(ttval2_CNN(:,:,i)).*tm(:,:,i);
end

column_offsets = median(angios);
column_offsets = column_offsets - min(column_offsets);
new_angios = bsxfun(@minus,angios,column_offsets);

angioF=1./tmp.^4.*angio+(1-sum(tm,3)).*new_angios.*40;

figure('units','normalized','outerposition',[0 0 1 1])
subplot(221);
val_2D=sum((ttval3_NN),3);
val_2D(isnan(val_2D))=0;
hue1=mat2gray(val_2D,[0 0.08]);  %% change the second number here for the red and green colors
HSV1(:,:,1)=(hue1).*(sf3-offset)+offset;
HSV1(:,:,3)=mat2gray(angioF,[LA HA]);  
HSV1(:,:,2)=mat2gray(val_2D,[0 0.02]);
RGB1=hsv2rgb(HSV1);
image(RGB1);
colormap(newCM2); 
colorbar; 
title('sO_2 uncertainty map by FNN (sO_2=80%)');
axis square;
axis off;

subplot(222);
val_2D=sum((ttval3_CNN),3);
val_2D(isnan(val_2D))=0;
hue1=mat2gray(val_2D,[0 0.08]);  %% change the second number here for the red and green colors
HSV1(:,:,1)=(hue1).*(sf3-offset)+offset;
HSV1(:,:,3)=mat2gray(angioF,[LA HA]);  
HSV1(:,:,2)=mat2gray(val_2D,[0 0.02]);
RGB1=hsv2rgb(HSV1);
image(RGB1);
colormap(newCM2); 
colorbar; 
title('sO_2 uncertainty map by CNN (sO_2=80%)');
axis square;
axis off;

%%  display uncertainty en face maps of hypoxia: sO2=70% by oximeter reading (ground-truth label)

Or=0.7;

load('OCT_14_48_16_05V_vessel_mask.mat');
ttso2_NN=load('NN_uncertainty_map_so2_14_48_16_o2.mat');
ttso2_CNN=load('CNN_uncertainty_map_so2_14_48_16_o2.mat');
ttval_NN=load('NN_uncertainty_map_val_14_48_16_o2.mat');
ttval_CNN=load('CNN_uncertainty_map_val_14_48_16_o2.mat');

load('OCTA_14_48_16_1.mat')
load('OCTA_14_48_16_2.mat')

load('OCT_14_48_16_05V_vesSO2.mat')
load('14_48_16_tmp.mat')

tt2_NN=reshape(ttso2_NN.predictions_so2,[400,512,10]);
for i=1:size(tt2_NN,3)
    tt3_NN(:,:,i)=tt2_NN(:,:,i).*tm(:,:,i);
end

ttval2_NN=reshape(ttval_NN.predictions_so2_val,[400,512,10]);
for i=1:size(ttval2_NN,3)
    ttval3_NN(:,:,i)=sqrt(ttval2_NN(:,:,i)).*tm(:,:,i);
end

tt2_CNN=reshape(ttso2_CNN.predictions_so2,[400,512,10]);
for i=1:size(tt2_CNN,3)
    tt3_CNN(:,:,i)=tt2_CNN(:,:,i).*tm(:,:,i);
end

ttval2_CNN=reshape(ttval_CNN.predictions_so2_val,[400,512,10]);
for i=1:size(ttval2_CNN,3)
    ttval3_CNN(:,:,i)=sqrt(ttval2_CNN(:,:,i)).*tm(:,:,i);
end

column_offsets = median(angios);
column_offsets = column_offsets - min(column_offsets);
new_angios = bsxfun(@minus,angios,column_offsets);

angioF=1./tmp.^4.*angio+(1-sum(tm,3)).*new_angios.*40;

figure('units','normalized','outerposition',[0 0 1 1])
subplot(221);
val_2D=sum((ttval3_NN),3);
val_2D(isnan(val_2D))=0;
hue1=mat2gray(val_2D,[0 0.08]);  %% change the second number here for the red and green colors
HSV1(:,:,1)=(hue1).*(sf3-offset)+offset;
HSV1(:,:,3)=mat2gray(angioF,[LA HA]);  
HSV1(:,:,2)=mat2gray(val_2D,[0 0.02]);
RGB1=hsv2rgb(HSV1);
image(RGB1);
colormap(newCM2); 
colorbar; 
title('sO_2 uncertainty map by FNN (sO_2=70%)');
axis square;
axis off;

subplot(222);
val_2D=sum((ttval3_CNN),3);
val_2D(isnan(val_2D))=0;
hue1=mat2gray(val_2D,[0 0.08]);  %% change the second number here for the red and green colors
HSV1(:,:,1)=(hue1).*(sf3-offset)+offset;
HSV1(:,:,3)=mat2gray(angioF,[LA HA]);  
HSV1(:,:,2)=mat2gray(val_2D,[0 0.02]);
RGB1=hsv2rgb(HSV1);
image(RGB1);
colormap(newCM2); 
colorbar; 
title('sO_2 uncertainty map by CNN (sO_2=70%)');
axis square;
axis off;

%% display uncertainty en face maps of hyperoxia: sO2=98% by oximeter reading (ground-truth label)

Or=0.98;

load('OCT_14_27_16_05V_vessel_mask.mat');
ttso2_NN=load('NN_uncertainty_map_so2_14_27_16_o2.mat');
ttso2_CNN=load('CNN_uncertainty_map_so2_14_27_16_o2.mat');
ttval_NN=load('NN_uncertainty_map_val_14_27_16_o2.mat');
ttval_CNN=load('CNN_uncertainty_map_val_14_27_16_o2.mat');

load('OCTA_14_27_16_1.mat')
load('OCTA_14_27_16_2.mat')

load('OCT_14_27_16_05V_vesSO2.mat')
load('14_27_16_tmp.mat')

tt2_NN=reshape(ttso2_NN.predictions_so2,[400,512,10]);
for i=1:size(tt2_NN,3)
    tt3_NN(:,:,i)=tt2_NN(:,:,i).*tm(:,:,i);
end

ttval2_NN=reshape(ttval_NN.predictions_so2_val,[400,512,10]);
for i=1:size(ttval2_NN,3)
    ttval3_NN(:,:,i)=sqrt(ttval2_NN(:,:,i)).*tm(:,:,i);
end

tt2_CNN=reshape(ttso2_CNN.predictions_so2,[400,512,10]);
for i=1:size(tt2_CNN,3)
    tt3_CNN(:,:,i)=tt2_CNN(:,:,i).*tm(:,:,i);
end

ttval2_CNN=reshape(ttval_CNN.predictions_so2_val,[400,512,10]);
for i=1:size(ttval2_CNN,3)
    ttval3_CNN(:,:,i)=sqrt(ttval2_CNN(:,:,i)).*tm(:,:,i);
end

column_offsets = median(angios);
column_offsets = column_offsets - min(column_offsets);
new_angios = bsxfun(@minus,angios,column_offsets);

angioF=1./tmp.^4.*angio+(1-sum(tm,3)).*new_angios.*40;

figure('units','normalized','outerposition',[0 0 1 1])
subplot(221);
val_2D=sum((ttval3_NN),3);
val_2D(isnan(val_2D))=0;
hue1=mat2gray(val_2D,[0 0.08]);  %% change the second number here for the red and green colors
HSV1(:,:,1)=(hue1).*(sf3-offset)+offset;
HSV1(:,:,3)=mat2gray(angioF,[LA HA]);  
HSV1(:,:,2)=mat2gray(val_2D,[0 0.02]);
RGB1=hsv2rgb(HSV1);
image(RGB1);
colormap(newCM2); 
colorbar; 
title('sO_2 uncertainty map by FNN (sO_2=98%)');
axis square;
axis off;

subplot(222);
val_2D=sum((ttval3_CNN),3);
val_2D(isnan(val_2D))=0;
hue1=mat2gray(val_2D,[0 0.08]);  %% change the second number here for the red and green colors
HSV1(:,:,1)=(hue1).*(sf3-offset)+offset;
HSV1(:,:,3)=mat2gray(angioF,[LA HA]);  
HSV1(:,:,2)=mat2gray(val_2D,[0 0.02]);
RGB1=hsv2rgb(HSV1);
image(RGB1);
colormap(newCM2); 
colorbar; 
title('sO_2 uncertainty map by CNN (sO_2=98%)');
axis square;
axis off;
