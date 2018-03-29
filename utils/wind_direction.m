function wdir = wind_direction(u, v, fillvalue)
%  ���� u, v �����������
%% ����˵��:
%    �������:
%      u  :  ����u����. һά��ֵ����.  ��λ: m/s
%      v  :  ����v����. һά��ֵ����.  ��λ: m/s
%         u �� v������С��ͬ.
%   fillvalue : ���������Чֵ. ����. 
%     �������:
%        wdir : ����.  һά����. ��С�� u, v ��С��ͬ. ��λ: ��. ��������Ϊ0��. 
%% 
%    date  :  2017.1.8
%    by    :  ly
%    email :  libravo@foxmail.com
%%

if nargin == 2
    fillvalue = 0;
end

zero = 0;
con = 180.0;
wcrit = 360 - 0.00002;
radi = 1.0/0.01745329;

wdir = atan2(u, v)*radi + con;
wdir(wdir >= wcrit) = zero;  % ǿ�ƴ��� 360 ��Ϊ��������
wdir(u == 0 & v == 0) = fillvalue; 
end