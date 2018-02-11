function [ Xq ] = UniformQuantizer( x,Q )
%UNIFORMQUANTIZER Summary of this function goes here
%   Detailed explanation goes here

k = floor((x+1)*Q/2)+1; % index of the each term that which they are quantized to
Xq = -1 + 1/(Q) + (k-1)/(Q/2);%from their index actual quantization values determined

end

