close all;
clear all;

%% load in so2 predictions and uncertainties by CNN and FNN mdoels
CNN_so2=load('CNN_uncertainty_so2.mat');
CNN_val=load('CNN_uncertainty_val.mat');

NN_so2=load('NN_uncertainty_so2.mat');
NN_val=load('NN_uncertainty_val.mat');

label0=load('test_so2_label.mat');
ls=load('least_square_test_so2');

%% set the constant epsilon for error bound:
% |true-prediction| < epsilon * std
const=[0.1,0.2,0.3,0.4,0.5,0.6,0.7,0.8,0.9,1,1.1,1.2,1.3,1.4,1.5,1.6,1.7,1.8,1.9,2,2.5,3];

% ==========================
% set uncertainty ranges for statistical analysis:
% for example: 4% and 6% corresponds to 5% +/- 1%
low_bound=0.04;
high_bound=0.06;
% ==========================

int2a=high_bound;%0.1;
int2b=high_bound;%0.1;
int1a=low_bound;
sigma0a=(int1a+int2a)/2;
int1b=low_bound;
sigma0b=(int1b+int2b)/2;

%% display so2 prediction, uncertainty and errors by CNN, FNN, and least-squares fitting method

 figure('Renderer', 'painters', 'Position', [10 10 2010 610])
 subplot(3,8,[1,2,3,4]);
 plot(ls.Yf,'green','linewidth',1.5);hold on;
 plot(CNN_so2.rounded2b,'blue','linewidth',1.5);hold on;
 plot(label0.Yt,'red','linewidth',1.5);
 legend('LS fitting results','CNN Predictions','Labels','location','best');
 axis([0 502 0.2 1.05]);title('CNN Predictions');
  xlabel('Spectra number');
 ylabel('sO_2')
 
 subplot(3,8,[9,10,11,12]);
 plot(sqrt(CNN_val.rounded2_valb),'black','linewidth',1.5);hold on;
 axis([0 502 0 0.15]);
 title('CNN unvertainty (\sigma)');
 xlabel('Spectra number');
 ylabel('sO_2')
  
  
 subplot(3,8,[17,18,19,20]);
 plot(abs(ls.Yf-label0.Yt),'green','linewidth',1.5);hold on;
 plot(abs(CNN_so2.rounded2b-label0.Yt),'blue','linewidth',1.5);hold on;
 legend('LS fitting errors','CNN error','location','best');
 axis([0 502 0 0.4]);
 title('CNN Error')
 xlabel('Spectra number');
 ylabel('sO_2')
 
 subplot(3,8,[5,6,7,8]);
 plot(ls.Yf,'green','linewidth',1.5);hold on;
 plot(NN_so2.rounded2d,'blue','linewidth',1.5);hold on;
 plot(label0.Yt,'red','linewidth',1.5);hold off;
 legend('LS fitting results','FNN Predictions','Labels','location','best');
 axis([0 502 0.2 1.05]);title('FNN Predictions');
  xlabel('Spectra number');
 ylabel('sO_2')
 
 subplot(3,8,[13,14,15,16]);
 plot(sqrt(NN_val.rounded2_vald),'black','linewidth',1.5);hold on;
 axis([0 502 0 0.15]);
 title('FNN unvertainty (\sigma)');
 xlabel('Spectra number');
 ylabel('sO_2')
 
 subplot(3,8,[21,22,23,24]);
 plot(abs(ls.Yf-label0.Yt),'green','linewidth',1.5);hold on;
 plot(abs(NN_so2.rounded2d-label0.Yt),'blue','linewidth',1.5);hold on;
 legend('LS fitting errors','FNN error','location','best');
 axis([0 502 0 0.4]);
 title('FNN Error')
 xlabel('Spectra number');
 ylabel('sO_2')

%% statistical analysis:

so2=CNN_so2.rounded2b(sqrt(CNN_val.rounded2_valb)>=int1a & sqrt(CNN_val.rounded2_valb)<=int2a);
label=label0.Yt(sqrt(CNN_val.rounded2_valb)>=int1a & sqrt(CNN_val.rounded2_valb)<=int2a);
length(label)

for i=1:length(const)
ratio1(i)=length(find(abs(label-so2)<=const(i).*sigma0a))./length(label);
end

figure('Renderer', 'painters', 'Position', [310 310 610 610])
eps=[0.07966,0.15852,0.23582,0.31084,0.3829,0.4515,0.51608,0.57628,0.63188,0.6827,0.7286,0.7698,0.8064,0.8385,0.8664,0.8904,0.9109,0.9281,0.9426,0.9545,0.9876,0.9973];
x=eps;
plot(0:1,0:1,'black:','linewidth',2);hold on;

y1=ratio1;
[P,S,mu]=polyfit(x,y1,1);
[y_fit,delta] = polyval(P,x,S,mu);
P0=polyfit(x,y1,1);
yfit=x.*P0(1)+P0(2);
plot(x,y1,'ro','linewidth',2);hold on;
plot(x,y_fit,'r-','linewidth',2);hold on;

hT1 = text(0.05, 0.95, ['CNN slope: ',num2str(P0(1))]);
hT2 = text(0.05, 0.9, ['CNN constant: ',num2str(P0(2))]);%
hT3 = text(0.05, 0.85, ['CNN number of data points: ',num2str(length(label))]);%

so2=NN_so2.rounded2d(sqrt(NN_val.rounded2_vald)>=int1b & sqrt(NN_val.rounded2_vald)<=int2b);
label=label0.Yt(sqrt(NN_val.rounded2_vald)>=int1b & sqrt(NN_val.rounded2_vald)<=int2b);
length(label)

for i=1:length(const)
ratio2(i)=length(find(abs(label-so2)<=const(i).*sigma0b))./length(label);
end

y2=ratio2;
[P,S,mu]=polyfit(x,y2,1);
[y_fit,delta] = polyval(P,x,S,mu);
P0=polyfit(x,y2,1);
yfit=x.*P0(1)+P0(2);
plot(x,y2,'bo','linewidth',2);hold on;
plot(x,y_fit,'b-','linewidth',2);hold on;
legend('Slope=1','CNN results','CNN linear fit','FNN results','FNN linear fit','location','southeast')
axis([0 1 0 1]);axis square;
title(['CNN and FNN: ','\sigma_m_e_a_n = ',num2str(sigma0b)]);
xlabel('Theoretical Confidence');
ylabel('P(\sigma_0,\eta)');
hT1 = text(0.05, 0.75, ['FNN slope: ',num2str(P0(1))]);
hT2 = text(0.05, 0.7, ['FNN constant: ',num2str(P0(2))]);
hT3 = text(0.05, 0.65, ['FNN number of data points: ',num2str(length(label))]);%
