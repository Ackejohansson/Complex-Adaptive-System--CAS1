%%
clc
clear all

syms x r sigma z y
A = [-sigma, sigma, 0; r-z, -1, -x; y, x, -1];
det(A)/sigma