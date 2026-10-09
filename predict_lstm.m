function y_pred = predict_lstm(model, X_test)
    % =========================================================
    % 模型预测
    % =========================================================

    % 直接使用 classify 函数预测分类标签
    [~, predLabels] = classify(model, X_test);
    y_pred = double(predLabels) - 1;  % 将分类结果转换为数字标签
end
