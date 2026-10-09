function model = train_lstm_model(X_train, y_train)
    % =========================================================
    % 训练 LSTM 模型
    % =========================================================

    numFeatures = size(X_train, 2);
    numClasses = numel(unique(y_train));

    X_seq = num2cell(X_train, 2);
    Y_seq = categorical(y_train);

    layers = [
        sequenceInputLayer(numFeatures, 'Name', 'input')
        lstmLayer(64, 'OutputMode', 'last', 'Name', 'lstm1')
        fullyConnectedLayer(numClasses, 'Name', 'fc1')
        softmaxLayer('Name', 'softmax')
        classificationLayer('Name', 'classOutput')
    ];

    options = trainingOptions('adam', ...
        'MaxEpochs', 30, ...
        'MiniBatchSize', 64, ...
        'ValidationFrequency', 10, ...
        'Shuffle', 'every-epoch', ...
        'Verbose', true, ...
        'Plots', 'training-progress');

    model = trainNetwork(X_seq, Y_seq, layers, options);
end
