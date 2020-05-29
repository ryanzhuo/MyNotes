tic
clear all
close all
clc
n=1;
% 路由器位置设置
BS(1,:) = [0 0];
BS(2,:) = [0 21];
BS(3,:) = [21 0];
BS(4,:) = [21 21];

% 路径损耗参数设置
d0 = 1;
p0= -30;
eta = -3;
sigma = 1;

% 仿真建立指纹库 off-line building 20m*20m区域 400个参考点
for i=1:20
    for j=1:20
        FingerDB(n).position = [i,j]; 
        for m=1:4
            tmp1 = FingerDB(n).position;
            tmp2 = tmp1(1:2)-BS(m,:);
            d(m) = sqrt(tmp2*tmp2');
            RSS(m) = p0 + eta*10*log10(d(m)/d0) + randn(1)*sigma;
        end
        tmp=RSS;
        FingerDB(n).RSS = RSS;
        n=n+1;
    end
end

% 测量1000次
sum = [0, 0];
for i = 1: 1000
% 定位场景 on-line matching
% 目标指纹生成
position_target = [9.5,10.7];
for m=1:4
   tmp = position_target-BS(m,:);
   d(m) = sqrt(tmp * tmp');
   RSS_target(m) = p0 + eta*10*log10(d(m)/d0) + randn(1)*sigma;
end
% 任务：通过目标指纹匹配找出目标位置
sum = sum + locate(RSS_target, FingerDB);
end
location = sum / 1000
toc

