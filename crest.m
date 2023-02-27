function c = crest(x)
%CREST      Crest factor of signal
%           c = crest(x)
%           c = maximax/rms 
%           x   input signal vector

%   Copyright (c) 2001-2006, Axiom EduTech AB, Sweden. All rights reserved.
%   URL: http://www.vibratools.com Email: support@vibratools.com
%   Revision: 1.1  Date: 2001-05-18 

c = max([abs(max(x)) abs(min(x))])/rms(x);

