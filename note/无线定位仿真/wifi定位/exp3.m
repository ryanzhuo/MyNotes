tic
clear all
close all
clc
n=1;
% ·����λ������
BS(1,:) = [0 0];
BS(2,:) = [0 21];
BS(3,:) = [21 0];
BS(4,:) = [21 21];

% ·����Ĳ�������
d0 = 1;
p0= -30;
eta = -3;
sigma = 1;

% ���潨��ָ�ƿ� off-line building 20m*20m���� 400���ο���
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

% ����1000��
sum = [0, 0];
for i = 1: 1000
% ��λ���� on-line matching
% Ŀ��ָ������
position_target = [9.5,10.7];
for m=1:4
   tmp = position_target-BS(m,:);
   d(m) = sqrt(tmp * tmp');
   RSS_target(m) = p0 + eta*10*log10(d(m)/d0) + randn(1)*sigma;
end
% ����ͨ��Ŀ��ָ��ƥ���ҳ�Ŀ��λ��
sum = sum + locate(RSS_target, FingerDB);
end
location = sum / 1000
toc

