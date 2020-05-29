function guessTarget = locate(RSS_target, FingerDB)
    n = 0;
    min = 10000000000;
    guessTarget = [1,1];
    for i = 1:20
        for j = 1:20
            n = n + 1;
            varRSS = FingerDB(n).RSS - RSS_target;
            distance = norm(varRSS, 2);
            if distance <= min
                min = distance;
                guessTarget = [i, j];
            end
        end
    end
end