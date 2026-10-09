function model = train_lstm_model(X_train, y_train)
    % =========================================================
    % 训练 LSTM 模型
    % 解决方案：不使用 sequenceInputLayer + num2cell 结构
    % 因为当前输入是特征矩阵，不是 true sequence
    % 改为普通深度学习网络进行训练，避免维度不匹配
    % =========================================================

    numFeatures = size(X_train, 2);
    numClasses = numel(unique(y_train));

    % 标签转换为分类标签
    Y_seq = categorical(y_train);

    % 设计一个简单但稳定的深度学习网络
    layers = [
        featureInputLayer(numFeatures, 'Name', 'input', 'Normalization', 'none')
        fullyConnectedLayer(128, 'Name', 'fc1')
        reluLayer('Name', 'relu1')
        dropoutLayer(0.3, 'Name', 'dropout1')
        fullyConnectedLayer(64, 'Name', 'fc2')
        reluLayer('Name', 'relu2')
        dropoutLayer(0.2, 'Name', 'dropout2')
        fullyConnectedLayer(numClasses, 'Name', 'fc3')
        softmaxLayer('Name', 'softmax')
        classificationLayer('Name', 'classOutput')
    ];

    options = trainingOptions('adam', ...
        'MaxEpochs', 50, ...
        'MiniBatchSize', 32, ...
        'ValidationFrequency', 5, ...
        'Shuffle', 'every-epoch', ...
        'Verbose', true, ...
        'Plots', 'training-progress', ...
        'LearnRateSchedule', 'piecewise', ...
        'LearnRateDropFactor', 0.5, ...
        'LearnRateDropPeriod', 10);

    model = trainNetwork(X_train, Y_seq, layers, options);
end
