function [ output_a,output_b ] = MadHG(inm,inn,iny)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%-------该程序的目的是输入行数列数，生成LDPC码(3,6)需要的无圈校验H和G--------%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%% 最佳使用方法 [H,G] = MadHG(m,n); %%%%%%%%%%%%%%%%%%%%%%%%%%%%

Hm = inm;
Hn = inn;
x = HGrandom2(Hm,Hn);% 调用HGrandom2程序生成一个初始的校验矩阵x
y = iny;% 标志位，确定最后生成的G是右边为单位阵(iny = 1),还是左边为单位阵(iny = else)
%x = HGrandom2(252,504);
% for i = 1:3
    x=x(randperm(Hm),:);
    x=x(:,randperm(Hn));
% end;
%}
[outputH,outputG]=GassianXY(x,y);% 调用GassianXY将x处理，返回一个最终的校验矩阵H和生成矩阵G

output_a = outputH;% 输出校验矩阵H
output_b = outputG;% 输出生成矩阵G

% p = mod(G*H',2);% 可以用该语句检验生成的H和G满足要求
% a = sum(H,1);% 可以用该语句检查H的列重，输出是一个值固定为3的向量则正确
% b = sum(H,2);% 可以用该语句检查H的行重，输出是一个值固定为6的向量则正确
% flag = tellloop(H(1,:)',H(2:1000,:)');% 可以用该语句检查H是否存在环，输出一个标志位，值为0则说明没有环
% flag2 = askloop(H);%可以用该语句检查Ho是否每两行存在度为4的圈，输出一个长度为m/2的列向量
% 若该向量某一个元素i值非零，则说明输入矩阵Ho的第(i-1)*2+1行
% 与第(i-1)*2+2行存在圈，圈的度为sum(Ho((i-1)*2+1,:).*Ho((i-1)*2+2,:))
% 若向量某一元素i值为0，说明上述两行没有圈
% flag3 = checkloop(H);可以测试输入矩阵的每行与其他各行是否有环，
% 输出是一个与H行数相同的列向量，第i个位置的值代表H的第i行与其他行是否有圈的度量值，若>=2则说明有环