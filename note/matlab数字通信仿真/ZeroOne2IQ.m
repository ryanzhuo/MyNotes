function  [I,Q] = ZeroOne2IQ(arrayFour)
    n = length(arrayFour);
    
    I = zeros(1,n);
    Q = zeros(1,n);
    for i = 1: n
        switch arrayFour(i)
            case 0
                I(i) = 1;
                Q(i) = 1;
            case 1
                I(i) = -1;
                Q(i) = 1;
            case 2
                I(i) = 1;
                Q(i) = -1;
            case 3
                I(i) = -1;
                Q(i) = -1;
        end
    end
end

