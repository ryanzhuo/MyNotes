clear;
close all;
clc;
% 产生随机10序列
randomZeroOne = getZeroOne(1, 20)
% 产生连续模拟10序列信号
Time = 0:0.01:10;
timeSlot = 0:0.5:9.5;
timeSlotRandomZeroOne = [timeSlot;randomZeroOne].';
continuousZeroOne = generateContinuousZeroOne(Time, timeSlotRandomZeroOne, 1/2);
figure("Name", "Order and IQ");
subplot(311);
plot(Time, continuousZeroOne);
%QPSK调制
% 2进制序列转4进制序列
arrayFour = b2f(randomZeroOne);
% I路和Q路转换
[I,Q] = ZeroOne2IQ(arrayFour);
% 产生IQ序列图像

timeSlot = 0:9; % 应为I路Q路的时间间隔是原信号的2倍
timeSlotRandomZeroOne = [timeSlot;I].';
continuousZeroOneI = generateContinuousZeroOne(Time, timeSlotRandomZeroOne, 1);
subplot(312);
plot(Time,continuousZeroOneI);
timeSlot = 0:9; % 应为I路Q路的时间间隔是原信号的2倍
timeSlotRandomZeroOne = [timeSlot;Q].';
continuousZeroOneQ = generateContinuousZeroOne(Time, timeSlotRandomZeroOne, 1);
subplot(313);
plot(Time,continuousZeroOneQ);
% 星座图
scatterplot(I+Q*1i);
% 产生连续模拟10序列信号 用于I路 Q路
figure("Name", "IQ路序列图像");
subplot(211);
stem(I, '.');
subplot(212);
stem(Q, '.');
% 上采样 原信号2Hz IQ信号1Hz 采样用800Hz采样 
M = 8;
IUpsampling = upsample(continuousZeroOneI, M);
QUpsampling = upsample(continuousZeroOneQ, M);
figure("Name","upsampling");
subplot(211);
stem(IUpsampling, '.');
subplot(212);
stem(QUpsampling, '.');
% 低通滤波
Fs = 800; %通过10s采集8000样本点
Fd = 1; % 因为是对IQ路做采样 
rolloff = 0.5;
filterRcosdesign = rcosdesign(rolloff, 3, Fs/Fd);
IFilterLow = conv(IUpsampling, filterRcosdesign);
QFilterLow = conv(QUpsampling, filterRcosdesign);
figure("Name","低通滤波");
subplot(211);
stem(IFilterLow, ".");
subplot(212);
stem(QFilterLow, ".");
% AWGN
SNR = 3;
IAwgn = awgn(IFilterLow, SNR, "measured");
QAwgn = awgn(QFilterLow, SNR, "measured");
figure("Name", "AWGN 模拟信道")
subplot(211);
stem(IAwgn, '.');
subplot(212);
stem(QAwgn, '.');
% 匹配滤波
IMatchedFilter = filterRcosdesign;
QMatchedFilter = filterRcosdesign;
IMatchedFilterResult = filter(IMatchedFilter,1, IAwgn);
QMatchedFilterResult = filter(QMatchedFilter,1, QAwgn);
figure("Name", "Result of MatchedFilter");
subplot(211);
stem(IMatchedFilterResult, '.');
subplot(212);
stem(QMatchedFilterResult, '.');
% 下采样
Idownsampling=downsample(IMatchedFilterResult,M);
Qdownsampling=downsample(QMatchedFilterResult,M);
figure("Name", "downsampling");
subplot(211);
stem(Idownsampling, '.');
subplot(212);
stem(Qdownsampling, '.');
% 抽样检查
[ISampling, QSampling] = sampling(Idownsampling, Qdownsampling);
ISampling = ISampling(4:end);
QSampling = QSampling(4:end);
figure("Name", "抽样检查后的01序列");
subplot(211);
stem(ISampling, '.');
subplot(212);
stem(QSampling, '.');
% 抽样后的星座图
scatterplot(ISampling+QSampling*1i);
% 解调
demodulationArrayIO2Four = IQ2Four(ISampling, QSampling);
demodulationArrayZeroOne = f2b(demodulationArrayIO2Four);
figure("Name", "发送信号序列和接受信号序列对比图");
subplot(211);
stem(randomZeroOne,'.');
subplot(212);
stem(demodulationArrayZeroOne, '.');