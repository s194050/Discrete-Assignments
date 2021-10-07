function signal = circular_convolution(x, h)

len = length(x) + length(h) - 1;

x_zpd = zero_pad(x, len);
h_zpd = zero_pad(h, len);

X = fft(x_zpd);
H = fft(h_zpd);

Y = X .* H;

signal = ifft(Y);