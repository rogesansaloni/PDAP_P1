function confusionMatrix = confusionMatrix(testGT,testPred)
categories = unique(testGT);
numCategories = size(categories,1);
confusionMatrix = zeros(numCategories)
for i = 1:size(testGT)
    name_category_real = testGT(i);
    name_category_predict = testPred(i);
    position_real = find(categories == name_category_real);
    position_predict = find(categories == name_category_predict);
    confusionMatrix(position_real, position_predict) = confusionMatrix(position_real, position_predict) + 1;
end
end

