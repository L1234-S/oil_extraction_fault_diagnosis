function y_pred = predict_lstm(model, X_test)
    % =========================================================
    % 模型预测
    % =========================================================

    X_seq = num2cell(X_test, 2);
    [~, predLabels] = classify(model, X_seq);
    y_pred = double(predLabels) - 1;
end
