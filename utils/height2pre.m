function pressure = height2pre(height)
% �������λ�Ƹ߶�����Ӧ��ѹ��
%   ���������
%        height   �� λ�Ƹ߶ȣ���λ�� m
%   ���������
%        pressure  : ѹ����ֵ
%                    ����Ϊ�� ��ֵ����
%                    ��  λ�� hPa
%  �������λ�Ƹ߶ȳ��� 20km �򷵻� NaN
%%
if nargin==1
    if isvector(height)
        grearr = height < 11000;
        lesarr = height <= 20000 & height>= 11000;
        nonarr = height > 20000;
        pressure = zeros(1,length(height));
        pressure(grearr) = exp((log(1-height(grearr)/44331))/0.1903)*1013.25;
        pressure(lesarr) = 226.4./exp((height(lesarr)-11000)/6340);     
        pressure(nonarr) = NaN;
    else
        error('Input arguments should be vector!')
    end
else
    error('The number of input arguments is wrong!')
end
end