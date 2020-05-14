function continuousZeroOne = generateContinuousZeroOne(Time, timeSlotRandomZeroOne, width)
    continuousZeroOne = pulstran(Time-width/2, timeSlotRandomZeroOne,'rectpuls', width);
end

