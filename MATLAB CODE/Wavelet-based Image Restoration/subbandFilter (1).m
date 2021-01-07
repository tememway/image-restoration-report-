function ex = subbandFilter(y,h,LO_R,level,sigma,gamma,alpha);
%
% ex = subbandFilter(y,h,LO_R,level,sigma,gamma,alpha);
% 
% Regularized inverse filtering for each subband (with different)
% regularized parameter alpha) followed by wavelet thresholding 
% to remove the noise.
% 
% Ref: Richb's paper and Donoho's wavelet shrinkage scheme
% Created: Tue May 4 16:39:27 CDT 1999, Huipin Zhang

N = size(y,1);
[yl,yh] = mrdwt(y,LO_R,level);
gamma0 = 0.5;
alpha0 = 1;
eyl = wienerFilter(yl,h,sigma,gamma0,alpha0);

eyh = [];
for j = 1:level*3
  alp = alpha/2^round((j+1)/3-1);
  eyh = [eyh wienerFilter(yh(:,(j-1)*N+1:j*N),h,sigma,gamma,alp)];
end
ex = mirdwt(eyl,eyh,LO_R,level);

for k = 1:level 
  cx(k) = corrbound(LO_R,k,0);
end
thres = sqrt(2*log(N)*(1+cx))*sigma*gamma/3;

eyh = eyh.*(abs(eyh) > kron(thres,ones(N,3*N)));
ex = mirdwt(eyl,eyh,LO_R,level);

return
