function [ k ] = rbf_kernel( u, v, sigma )
%UNTITLED7 Summary of this function goes here
%   Detailed explanation goes here

k = exp(-(u-v)*(u-v)'/(2*sigma^2));

end

