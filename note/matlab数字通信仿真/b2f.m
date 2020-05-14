function arrayFour = b2f(arrayZeroOne)
    bm = [0,1,2,3];
    arrayFour = zeros(1, length(arrayZeroOne) / 2);
    for i = 1:length(arrayFour)
        twoSum = 0;
        twoSum = twoSum + arrayZeroOne((i-1) * 2 +1) * 2 + arrayZeroOne((i-1) * 2 +2);
        arrayFour(i) = bm(twoSum+1);
    end
end