function arrayZeroOne = f2b(arrayFour)
    n = length(arrayFour);
    for i = 1:n
        if arrayFour(i) == 4
            arrayFour = [arrayFour(1:i-1),arrayFour(i+1:end)];
        end
    end
    n = length(arrayFour);
    arrayZeroOne = zeros(1, n * 2);
    for i = 1:n
        switch arrayFour(i)
            case 0
                arrayZeroOne((i-1)*2+1) = 0;
                arrayZeroOne((i-1)*2+2) = 0;
            case 1
                arrayZeroOne((i-1)*2+1) = 0;
                arrayZeroOne((i-1)*2+2) = 1;
            case 2
                arrayZeroOne((i-1)*2+1) = 1;
                arrayZeroOne((i-1)*2+2) = 0;
            case 3
                arrayZeroOne((i-1)*2+1) = 1;
                arrayZeroOne((i-1)*2+2) = 1;
        end
    end
    

end