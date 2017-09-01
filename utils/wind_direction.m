function wdir = wind_direction(u, v, fillvalue)
%  ���� u, v ���� wspd, wdir
%  ����������
%     ��������� 
%        u,v    �� ��Ϊ����. ��λ : m/s.
%     fillvalue �� ȱʡֵ����.  Ĭ��Ϊ 0.
%                ��Ϊ ���� �� NaN
%     ���������
%        wdir  ��  ����. 
%  ================================================================
%    date  :  2017.1.8
%    by    :  ly
%    email :  libravo@foxmail.com
%%  �ο� NCL �� wind_direction ����
% ��������
if nargin == 2
    fillvalue = 0;
end
zero = 0;
con = 180.0;
wcrit = 360 - 0.00002;
radi = 1.0/0.01745329;

wdir = atan2(u, v)*radi + con;
wdir(wdir >= wcrit) = zero;  % force 360 "north winds"
wdir(u == 0 & v == 0) = fillvalue; 
end