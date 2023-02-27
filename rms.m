function [xrms]=rms(x)
% RMS calculates the Root Mean Square of x
%       [xrms] = rms(x)
%       x       Time series input data in columns
%       xrms    rms of each column of x

% Written by: PS Heyns Date: 2003-02-24

xrms=sqrt(sum(x.*x)/length(x));
