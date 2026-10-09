function [cleanData, labels] = preprocess_data(data)
    % =========================================================
    % 数据预处理
    % 1. 合并多列特征
    % 2. 处理缺失值
    % 3. 归一化
    % =========================================================

    X = [data.pressure, data.flow, data.temperature, data.power, data.stroke];
    labels = data.label;

    X = fillmissing(X, 'nearest');

    X_min = min(X, [], 1);
    X_max = max(X, [], 1);
    X_norm = (X - X_min) ./ (X_max - X_min + eps);

    cleanData = X_norm;
end
