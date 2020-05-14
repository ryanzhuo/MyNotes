function [I, Q] = sampling(IDownsampling, QDownsampling)
    n = length(IDownsampling);
    head = 1;
    tail = round(n / 100);
    I = zeros(1, tail+1);
    Q = zeros(1, tail+1);
    for i = head: tail
        if IDownsampling((i-1)*100+50) >= 0
            I(i) = 1;
        else
            I(i) = -1;
        end
        if QDownsampling((i-1)*100+50) >= 0
            Q(i) = 1;
        else
            Q(i) = -1;
        end
    end
end

