function  height = eta2height(eta, ptop)
%  ��WRFģʽ��eta����Ӧֵת��Ϊ���Ӧ��ĸ߶�ֵ
%   �������:
%        eta  :  ��Ӧ�� eta ��ֵ
%                ���������
%       ptop  :  ģʽ����ѹֵ����λ: hPa
%   �������:
%       height :  eta ���Ӧ�ĸ߶�ֵ
%%
pbot = 1013.1;
if isvector(eta)
    p = eta.*(pbot - ptop) + ptop;
    height = pre2height(p);
else
    error('Input arguments must be vector!')
end
end