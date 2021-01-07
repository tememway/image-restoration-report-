# image-restoration-report-
The purpose of image restoration is to "compensate for" or "undo" defects which degrade an image. Degradation comes in many forms such as motion blur, noise, and camera misfocus. In cases like motion blur, it is possible to come up with a very good estimate of the actual blurring function and "undo" the blur to restore the original image. In cases where the image is corrupted by noise, the best we may hope to do is to compensate for the degradation it caused. In this project, we will introduce and implement several of the methods used in the image processing world to restore images 





# We can describe image blurring process in most common cases as its convolution with some blur kernels. To restore degraded image we use deconvolution techniques such as inverse filtering and Wiener filtering. But we can observe that even in our examples (where the image was first artificially blurred by convolution) we didn’t get the expected results — restored images do not look exactly like the originals (especially for inverse filtering). This happens because small values of the Fourier transformed blur kernel turn to big ones of the restoration filter which significantly amplifies the noise.
