function vec = zero_pad(v, l)
% Function call:
%
% >> vec = zero_pad(v, l)
%
% INPUT:
% v: vector
% l: desired length after zero-padding

vec = [v zeros(1, l - length(v))];