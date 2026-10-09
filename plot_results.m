function plot_results(X_test, y_test, y_pred, results)
    % =========================================================
    % 绘制结果图
    % 1. 混淆矩阵
    % 2. 实际与预测对比
    % 3. 某变量趋势图
    % =========================================================

    figure;
    cm = results.confusionMatrix;
    heatmap(cm, 'Colormap', parula);
    title('Fault Diagnosis Confusion Matrix');
    xlabel('Predicted Label');
    ylabel('True Label');

    figure;
    plot(y_test, 'o-', 'LineWidth', 1.5, 'DisplayName', 'Actual');
    hold on;
    plot(y_pred, 'x-', 'LineWidth', 1.5, 'DisplayName', 'Predicted');
    xlabel('Sample Index');
    ylabel('Fault Type');
    legend('show');
    title('Fault Type Prediction Comparison');
    grid on;

    figure;
    t = 1:size(X_test, 1);
    plot(t, X_test(:,1), 'b', 'LineWidth', 1.2);
    hold on;
    plot(t, y_pred / max(y_pred + 1), 'r--', 'LineWidth', 1.2);
    xlabel('Sample Index');
    ylabel('Normalized Value');
    title('Normalized Pressure vs Predicted Fault Trend');
    legend('Pressure', 'Fault Trend');
    grid on;
end
