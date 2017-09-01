function  eta = height2eta(height, ptop)
%  ��WRFģʽ��eta����Ӧֵת��Ϊ���Ӧ��ĸ߶�ֵ
%   �������:
%        height  :  �߶�ֵ
%                ���������
%       ptop  :  ģʽ����ѹֵ����λ: hPa
%   �������:
%        eta  :  ��Ӧ�߶�ֵ��Ӧ��eta��
%%
pbot = 1013.1;
if isvector(height)
    pre = height2pre(height);
    eta = (pre - ptop)/(pbot - ptop);
else
    error('Input arguments must be vector!')
end
end