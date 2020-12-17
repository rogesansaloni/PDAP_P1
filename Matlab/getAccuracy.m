function accuracy = getAccuracy(testPred,testGT)
okPositions = find(testPred==testGT);
koPositions = find(testPred~=testGT);
accuracy = (length(okPositions)/(length(okPositions)+length(koPositions)))*100;
end

