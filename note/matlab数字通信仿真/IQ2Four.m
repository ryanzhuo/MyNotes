function arrayFour = IQ2Four(I, Q)
    n = length(I);
    arrayFour = zeros(1, n);
    for i = 1: n
        if I(i) == 0 || I(i) == 0
            arrayFour(i) = 4;
            continue;
        end
        
        if I(i) == 1
            if Q(i) == 1
                arrayFour(i) = 0;
            else
                arrayFour(i) = 2;
            end
        else
            if Q(i) == 1
                arrayFour(i) = 1;
            else
                arrayFour(i) = 3;
            end
        end
    end
end