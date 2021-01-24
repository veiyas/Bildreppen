function [maxDiff, meanDiff] = labinator(XYZinput, ref)
loopSize = size(XYZinput, 2);
refValues = zeros(3, loopSize);
labValues = zeros(3, loopSize);
for i = 1:loopSize
    [L, a, b] = xyz2lab(XYZinput(1,i), XYZinput(2,i), XYZinput(3,i));
    labValues(1, i) = L;
    labValues(2, i) = a;
    labValues(3, i) = b;
end

for i = 1:loopSize
    [L, a, b] = xyz2lab(ref(1,i), ref(2,i), ref(3,i));
    refValues(1, i) = L;
    refValues(2, i) = a;
    refValues(3, i) = b;
end

colorDiff = refValues - labValues;

maxDiff = max(colorDiff(:));
meanDiff = mean(colorDiff(:));
end

