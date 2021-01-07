function ex = inverseFilter(y,h,gamma);
%
% ex = inverseFilter(y,h,gamma);
%
% Generalized inverse filtering using threshold gamma:
%
%  inv_g(H) = gamma*abs(fft(h))/fft(h), if abs(fft(h)) <= 1/gamma
%  inv_g(H) = inv(H),			otherwise
%
% Reference: Lim's book
% Created: Tue May 4 16:22:57 CDT 1999, Huipin Zhang

N = size(y,1);
Yf = fft2(y);
Hf = fft2(h,N,N);

% handle singular case (zero case)
sHf = Hf.*(abs(Hf)>0)+1/gamma*(abs(Hf)==0);
iHf = 1./sHf;

%lengthzero = length(abs(Hf)==0)
% invert Hf using threshold gamma
iHf = iHf.*(abs(Hf)*gamma>1)+gamma*abs(sHf).*iHf.*(abs(sHf)*gamma<=1);
ex = real(ifft2(iHf.*Yf));

return
