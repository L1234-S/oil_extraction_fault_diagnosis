function data = generate_oil_data()
    % =========================================================
    % 生成仿真油井生产数据
    % 数据包含：时间、井口压力、流量、温度、功率、冲次等
    % 同时模拟不同故障工况
    % =========================================================

    fs = 10;
    T = 3600;
    t = (0:1/fs:T-1/fs)';

    n = length(t);
    data = struct();

    basePressure = 18 + 2 * sin(2*pi*0.01*t);
    baseFlow = 120 + 8 * sin(2*pi*0.02*t);
    baseTemp = 65 + 3 * cos(2*pi*0.015*t);
    basePower = 16 + 1.5 * sin(2*pi*0.03*t);
    baseStroke = 12 + 2 * sin(2*pi*0.04*t);

    pressure = zeros(n, 1);
    flow = zeros(n, 1);
    temperature = zeros(n, 1);
    power = zeros(n, 1);
    stroke = zeros(n, 1);
    labels = zeros(n, 1);

    % 故障标签：0 正常，1 供液不足，2 气锚，3 管柱堵塞，4 泵效下降，5 设备异常
    normalEnd = round(n * 0.2);
    lowFluidEnd = round(n * 0.4);
    gasAnchorEnd = round(n * 0.6);
    clogEnd = round(n * 0.75);
    pumpDropEnd = round(n * 0.9);

    for i = 1:n
        if i <= normalEnd
            label = 0;
            pressure(i) = basePressure(i) + 0.5 * randn();
            flow(i) = baseFlow(i) + 1.0 * randn();
            temperature(i) = baseTemp(i) + 0.5 * randn();
            power(i) = basePower(i) + 0.2 * randn();
            stroke(i) = baseStroke(i) + 0.3 * randn();
        elseif i <= lowFluidEnd
            label = 1;
            pressure(i) = basePressure(i) + 2.5 + 1.5 * sin(2*pi*0.02*t(i));
            flow(i) = baseFlow(i) * 0.70 + 1.0 * randn();
            temperature(i) = baseTemp(i) + 0.8 + 0.3 * randn();
            power(i) = basePower(i) * 0.9 + 0.2 * randn();
            stroke(i) = baseStroke(i) * 0.8 + 0.4 * randn();
        elseif i <= gasAnchorEnd
            label = 2;
            pressure(i) = basePressure(i) + 5.0 * sin(2*pi*0.08*t(i));
            flow(i) = baseFlow(i) * 0.55 + 1.5 * randn();
            temperature(i) = baseTemp(i) + 2.5 + randn();
            power(i) = basePower(i) * 1.2 + 0.5 * randn();
            stroke(i) = baseStroke(i) * 0.6 + 0.6 * randn();
        elseif i <= clogEnd
            label = 3;
            pressure(i) = basePressure(i) + 7.0 + 2.0 * sin(2*pi*0.05*t(i));
            flow(i) = baseFlow(i) * 0.42 + 1.5 * randn();
            temperature(i) = baseTemp(i) + 4.0 + randn();
            power(i) = basePower(i) * 1.4 + 0.5 * randn();
            stroke(i) = baseStroke(i) * 0.5 + 0.7 * randn();
        elseif i <= pumpDropEnd
            label = 4;
            pressure(i) = basePressure(i) + 3.0 + 0.6 * sin(2*pi*0.025*t(i));
            flow(i) = baseFlow(i) * 0.8 + 1.0 * randn();
            temperature(i) = baseTemp(i) + 1.0 + 0.5 * randn();
            power(i) = basePower(i) * 1.15 + 0.4 * randn();
            stroke(i) = baseStroke(i) * 0.75 + 0.4 * randn();
        else
            label = 5;
            pressure(i) = basePressure(i) + 8.0 + 2.0 * sin(2*pi*0.1*t(i));
            flow(i) = baseFlow(i) * 0.3 + 2.0 * randn();
            temperature(i) = baseTemp(i) + 6.0 + randn();
            power(i) = basePower(i) * 1.6 + 0.8 * randn();
            stroke(i) = baseStroke(i) * 0.55 + 0.8 * randn();
        end

        labels(i) = label;
    end

    data.time = t;
    data.pressure = pressure;
    data.flow = flow;
    data.temperature = temperature;
    data.power = power;
    data.stroke = stroke;
    data.label = labels;

    data.pressure = data.pressure + 0.1 * randn(n,1);
    data.flow = data.flow + 0.1 * randn(n,1);
    data.temperature = data.temperature + 0.1 * randn(n,1);
    data.power = data.power + 0.1 * randn(n,1);
    data.stroke = data.stroke + 0.1 * randn(n,1);
end
