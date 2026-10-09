# 石油开采过程故障诊断与建模工程

这是一个基于 MATLAB 的中等难度工程，针对石油开采过程中的典型故障问题，构建了多变量时序数据建模和深度学习故障诊断框架。

## 工程目标

- 模拟油井正常工况和典型故障工况
- 提取井口压力、流量、温度、功率、冲次等特征
- 利用深度学习模型（LSTM）进行故障识别
- 计算模型精度和诊断结果
- 提供可视化输出，便于分析与汇报

## 目录结构

```text
oil_fault_diagnosis/
├── main.m
├── generate_oil_data.m
├── preprocess_data.m
├── feature_extraction.m
├── train_lstm_model.m
├── predict_lstm.m
├── evaluate_model.m
├── plot_results.m
└── README.md
```

## 运行方法

1. 打开 MATLAB。
2. 进入该工程目录：
   ```matlab
   cd <你的工程目录路径>
   ```
3. 在命令窗口中输入：
   ```matlab
   main
   ```

## 代码说明

- `generate_oil_data.m`：生成仿真油井生产数据，模拟正常工况和多种故障工况。
- `preprocess_data.m`：处理缺失值、归一化数据，增强模型训练稳定性。
- `feature_extraction.m`：利用滑动窗口和统计量提取时序特征。
- `train_lstm_model.m`：使用 LSTM 网络训练故障分类模型。
- `predict_lstm.m`：用训练好的模型进行故障类别预测。
- `evaluate_model.m`：计算准确率、F1-score 和混淆矩阵。
- `plot_results.m`：绘制故障预测结果和分类图形。

## 设计思路

该工程以石油开采中的井口动态数据为对象，构建多变量时间序列模型，并结合深度学习方法实现故障诊断。通过对油井压力、流量、温度、功率和冲次等指标的时序建模，系统能够在正常工况和不同故障工况之间进行区分。

## 核心知识点

- 过程建模
- 多变量时序分析
- 特征工程
- 深度学习（LSTM）
- 分类模型评估
- 工业故障诊断

## 扩展建议

可以进一步扩展为：
- CNN-LSTM 混合模型
- Autoencoder 异常检测
- 状态空间模型与深度学习结合
- 使用真实油田数据替换仿真数据

## 注意事项

运行前请确认 MATLAB 已安装：
- Deep Learning Toolbox
- Statistics and Machine Learning Toolbox

如果需要进一步扩展成论文版或更真实的工业案例版本，我也可以继续补充。
