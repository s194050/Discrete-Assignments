function [B,A] = fir_bandpass(w_c, Gp_dB, L, win_L)

% NOTE: 
% Current iteration does NOT accept even numbered lengths (uneven orders)

% w_c is a vector containing the two normalized cutoff frequencies
% Gp_dB is the passband gain in dB
% L is the length of filter (order + 1)
% win_L is the window length percentage of L

Gp = 10^(Gp_dB/20); %linear gain

delta_w = 2/L; %normalized frequency resolution

w = -1:delta_w:(1 - delta_w); %normalized frequency vector

%finding the index in the w-vector containing the closest value to the given cutoff frequency
wc_1_idx = interp1(w,1:length(w),w_c(1),'nearest');
wc_2_idx = interp1(w,1:length(w),w_c(2),'nearest');
%constructing magnitude values for positive frequencies without DC-component
Y_pos = [ones(1, wc_1_idx - ((L-1)/2) - 1) Gp*ones(1, wc_2_idx - wc_1_idx - 1) ones(1, L - wc_2_idx + 1)];
Y_neg = flip(Y_pos);

Y = [Y_neg 1 Y_pos];
h = fftshift(ifft(ifftshift(Y)));

hann_window = zero_pad(transpose(hann(round(win_L * L))), L);

h_window = h .* hann_window;

%For FIR-filters the A-polynomial is just 1 and the values of the impulse response equal the coefficients of the B-polynomial.
A = 1;
B = h_window;

end

