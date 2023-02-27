function Level = calOneThirdLevel(y,fs,fc,base,coefficient)
    % Set the default coefficient to 20
    if nargin < 5
        coefficient = 20;
    end
    % Set constant&Initialize output
    oc6 = 2^(1/6);
    nc = length(fc);
    yc = zeros(1,nc);
    Level = zeros(1,nc);
    L = length(y);
    % Judge whether the input data type is complex
    if isreal(y)
        Y = fft(y);
    else
        Y = y;
    end
    
    % Calculate level of every octave
    for i = 1:nc
        fl = fc(i)/oc6;
        fu = fc(i)*oc6;
        nl = round(fl*L/fs+1);
        nu = round(fu*L/fs+1);
        b = zeros(1,L);
        b(nl:nu) = Y(nl:nu);
        b(L-nu+2:L-nl+2) = Y(L-nu+2:L-nl+2);
        c = real(ifft(b,L));
        yc(i) = sqrt(var(c(1 : L)));
        Level(i) = coefficient*log10(yc(i)/base);
    end   