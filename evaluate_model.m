function results = evaluate_model(y_test, y_pred)
    % =========================================================
    % 评估模型
    % =========================================================

    labels = unique([y_test; y_pred]);
    cm = confusionmat(y_test, y_pred, 'Order', labels);

    acc = sum(diag(cm)) / sum(cm(:));
    precision = zeros(length(labels), 1);
    recall = zeros(length(labels), 1);
    f1 = zeros(length(labels), 1);

    for i = 1:length(labels)
        tp = cm(i, i);
        fp = sum(cm(:, i)) - tp;
        fn = sum(cm(i, :)) - tp;

        precision(i) = tp / (tp + fp + eps);
        recall(i) = tp / (tp + fn + eps);
        f1(i) = 2 * precision(i) * recall(i) / (precision(i) + recall(i) + eps);
    end

    results.accuracy = acc;
    results.precision = precision;
    results.recall = recall;
    results.f1 = f1;
    results.confusionMatrix = cm;

    fprintf('Accuracy: %.4f\n', acc);
    fprintf('Average F1-score: %.4f\n', mean(f1));
end
