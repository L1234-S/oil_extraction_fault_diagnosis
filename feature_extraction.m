function [features, featureNames] = feature_extraction(cleanData, labels)
    % =========================================================
    % 从时序数据中提取特征
    % 提取特征包括：统计特征、变化率特征、滑动窗特征
    % =========================================================

    n = size(cleanData, 1);
    m = size(cleanData, 2);

    window = 20;

    features = [];
    featureNames = {};

    for j = 1:m
        col = cleanData(:, j);

        meanVal = movmean(col, window);
        stdVal = movstd(col, window);
        diffVal = [0; diff(col)];
        slopeVal = [0; diff(col)] * 10;

        skewVal = zeros(n, 1);
        kurtVal = zeros(n, 1);

        for i = 1:n
            startIdx = max(1, i - window + 1);
            endIdx = i;
            seg = col(startIdx:endIdx);

            skewVal(i) = skewness(seg);
            kurtVal(i) = kurtosis(seg);
        end

        feat = [meanVal, stdVal, diffVal, slopeVal, skewVal, kurtVal];

        for k = 1:6
            switch k
                case 1
                    name = sprintf('var%d_mean', j);
                case 2
                    name = sprintf('var%d_std', j);
                case 3
                    name = sprintf('var%d_diff', j);
                case 4
                    name = sprintf('var%d_slope', j);
                case 5
                    name = sprintf('var%d_skew', j);
                otherwise
                    name = sprintf('var%d_kurt', j);
            end
            featureNames{end+1} = name;
        end

        features = [features, feat];
    end

    features = features(1:end, :);
end
