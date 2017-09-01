function height = pre2height(pressure)
% �������ѹ��������Ӧλ�Ƹ߶�
%   ���������
%        pressure  : ѹ����ֵ
%                    ����Ϊ�� ��ֵ����
%                    ��  λ�� hPa
%   ���������
%        height   �� λ�Ƹ߶ȣ���λ�� m
% �������ѹ����С��54.75 hPa �򷵻� NaN
%%
if nargin==1
    if isvector(pressure)
        grearr = pressure > 226.4;
        lesarr = pressure >= 54.75 & pressure<= 226.4;
        nonarr = pressure < 54.75;
        height = zeros(1,length(pressure));
        height(grearr) = 44331*(1-(pressure(grearr)/1013.25).^0.1903);
        height(lesarr) = 11000 + 6340*log(226.4./pressure(lesarr));     
        height(nonarr) = NaN;
    else
        error('Input arguments should be vector!')
    end
else
    error('The number of input arguments is wrong!')
end
end