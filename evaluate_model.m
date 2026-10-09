function results = evaluate_model(y_test, y_pred)
    % =========================================================
    % 评估模型
    % =========================================================

    % 确保都是列向量且数据类型一致
    y_test = double(y_test(:));
    y_pred = double(y_pred(:));

    % 获取所有标签
    labels = unique([y_test; y_pred]);
    labels = sort(labels);
    
    % 生成混淆矩阵
    cm = confusionmat(y_test, y_pred, 'Order', labels);

    % 计算准确率
    acc = sum(diag(cm)) / sum(cm(:));
    
    % 初始化精确率、召回率、F1分数
    precision = zeros(length(labels), 1);
    recall = zeros(length(labels), 1);
    f1 = zeros(length(labels), 1);

    % 对每个类别计算指标
    for i = 1:length(labels)
        tp = cm(i, i);  % 真正例
        fp = sum(cm(:, i)) - tp;  % 假正例
        fn = sum(cm(i, :)) - tp;  % 假负例

        precision(i) = tp / (tp + fp + eps);
        recall(i) = tp / (tp + fn + eps);
        f1(i) = 2 * precision(i) * recall(i) / (precision(i) + recall(i) + eps);
    end

    % 存储结果
    results.accuracy = acc;
    results.precision = precision;
    results.recall = recall;
    results.f1 = f1;
    results.confusionMatrix = cm;
    results.labels = labels;

    % 打印结果
    fprintf('\n========== Model Evaluation Results ==========\n');
    fprintf('Overall Accuracy: %.4f\n', acc);
    fprintf('Average F1-score: %.4f\n', mean(f1));
    fprintf('\nPer-class Metrics:\n');
    
    for i = 1:length(labels)
        fprintf('  Class %d: Precision=%.4f, Recall=%.4f, F1=%.4f\n', ...
            labels(i), precision(i), recall(i), f1(i));
    end
    fprintf('=============================================\n\n');
end
