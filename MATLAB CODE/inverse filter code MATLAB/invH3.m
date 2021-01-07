N=256;
lambda=0.1;
f=freadbin('lenna.256',N,N);
figure(1)
imagesc(f)
colormap(gray)
F=fft2(f);
b=ones(4,4)/16;
B=fft2(b,N,N);
G=F.*B;
%g=ifft2(G)+10*randn(N,N);
%G=fft2(g);
figure(2)
imagesc(abs(ifft2(G)))
colormap(gray)
K=lambda*G;
for l=1:1500,
  if mod(l,25)==0
    lambda=lambda/5;
  end
  A=G-K.*B;
  K=K+lambda*A;
  if mod(l,50)==0
     l 
     sum(sum(A))
     figure(3)
     imagesc(abs(ifft2(K)))
     colormap(gray)
     pause
  end
end
