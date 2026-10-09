% =========================================================
% 石油开采过程故障诊断与建模主程序
% 适合 MATLAB R2020a 及以上版本
% =========================================================

clc; clear; close all;

% 1. 生成仿真数据
fprintf('Step 1: generating synthetic oil production data...\n');
data = generate_oil_data();

% 2. 数据预处理
fprintf('Step 2: preprocessing data...\n');
[cleanData, labels] = preprocess_data(data);

% 3. 特征提取
fprintf('Step 3: extracting features...\n');
[features, featureNames] = feature_extraction(cleanData, labels);

% 4. 划分训练集和测试集
rng(42);
idx = randperm(size(features, 1));
trainRatio = 0.7;
trainIdx = idx(1:round(trainRatio * length(idx)));
testIdx = idx(round(trainRatio * length(idx)) + 1:end);

X_train = features(trainIdx, :);
y_train = labels(trainIdx);
X_test = features(testIdx, :);
y_test = labels(testIdx);

% 5. 训练 LSTM 模型
fprintf('Step 5: training deep learning model...\n');
model = train_lstm_model(X_train, y_train);

% 6. 预测测试集
fprintf('Step 6: evaluating model...\n');
y_pred = predict_lstm(model, X_test);

% 7. 评估
results = evaluate_model(y_test, y_pred);

% 8. 可视化
fprintf('Step 7: plotting results...\n');
plot_results(X_test, y_test, y_pred, results);

fprintf('Complete. Please check results folder.\n');
