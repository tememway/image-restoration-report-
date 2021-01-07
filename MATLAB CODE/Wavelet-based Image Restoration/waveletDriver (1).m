clear;clf;

% Input and display the binary image
N = 256;
x = readbin('lenna.256',N,N);
figure(1)
imshow(x,gray(256))

% Blur the image, corrupt the image using WGN and display it
% h is the blurring filter, and sigma is the noise std
h = ones(4,4)/16;
sigma = 10;

Xf = fft2(x);
Hf = fft2(h,N,N);
y = real(ifft2(Hf.*Xf))+sigma*randn(N,N); % circular convolution
%y = filter2(h,x)+sigma*randn(N,N);	  % linear convolution

figure(2)
imshow(y,gray(256))

% restoration using generalized inverse filtering
gamma = 2;
eix = inverseFilter(y,h,gamma);
figure(3)
imshow(eix,gray(256))

% restoration using generalized Wiener filtering
gamma = 1;
alpha = 1;
ewx = wienerFilter(y,h,sigma,gamma,alpha);
figure(4)
imshow(ewx,gray(256))

% Wavelet denoising using Daubechies tap 8 wavelet transform
level = 6;
[LO_D,HI_D,LO_R,HI_R] = wfilters('db4');

[yl,yh] = mrdwt(ewx,LO_R,level);
for k = 1:level 
  cx(k) = corrbound(LO_R,k,0);
end
thres = sqrt(2*log(N)*(1+cx))*sigma*gamma/3;

eyh = yh.*(abs(yh) > kron(thres,ones(N,3*N)));
ee = mirdwt(yl,eyh,LO_R,level);
figure(5)
imshow(ee,gray(256))                             

gamma = 1;
alpha = 1;
esx = subbandFilter(y,h,LO_R,level,sigma,gamma,alpha);
figure(6)
imshow(esx,[])                             

[psnr(y,x) psnr(eix,x) psnr(ewx,x) psnr(ee,x) psnr(esx,x)]
return
