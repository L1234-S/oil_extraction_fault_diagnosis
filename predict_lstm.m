function y_pred = predict_lstm(model, X_test)
    % =========================================================
    % 模型预测
    % 返回数值标签（与 y_test 格式一致）
    % =========================================================

    % 使用 classify 函数预测分类标签
    [~, predLabels] = classify(model, X_test);
    
    % 将 categorical 转换为数值标签
    % 得到 0, 1, 2, 3, 4, 5 的形式
    y_pred = double(predLabels) - 1;
    
    % 确保是列向量
    y_pred = y_pred(:);
end
