function t = maketime(x,fs)
%MAKETIME   Make Time Vector
%           t = maketime(x,fs)
%           t  time vector in seconds with length corresponding to x
%           x  data vector
%           fs sampling frequency in Hz

%   Copyright (c) 2001-2006, Axiom EduTech AB, Sweden. All rights reserved.
%   URL: http://www.vibratools.com Email: support@vibratools.com

t = 0:1/fs:(length(x)-1)/fs;
t = t(:);

