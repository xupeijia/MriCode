function c = kurtosis(x)
% KURTOSIS  returns the kurtosis value of vector x
%           c = kurtosis(x)
%           x  input data vector
%              mean is subtracted
 
%   Copyright (c) 2001-2006, Axiom EduTech AB, Sweden. All rights reserved.
%   URL: http://www.vibratools.com Email: support@vibratools.com
%   Revision: 1.1  Date: 2001-05-21 


x = x-mean(x);  
c = sum(x.^4)*length(x)/sum(x.^2)/sum(x.^2);

