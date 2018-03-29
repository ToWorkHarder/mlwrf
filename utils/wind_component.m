function uv = wind_component(wspd, wdir)
% ���ݷ��ٺͷ������x��y����ˮƽ��
%% ����˵��:
%  �������:
%   wspd :  ����. һά����.  ��λ: m/s
%   wdir :  ����. һά����.  ��λ: ��. ��ΧӦ�� 0-360
%  �������:
%    uv : x��y ����ˮƽ���С
%      uv(1, :) ��ʾ u ����, ��λ: m/s
%      uv(2, :) ��ʾ v ����, ��λ: m/s
%% 
%    date  :  2017.1.8
%    by    :  ly
%    email :  libravo@foxmail.com
%%

uveps = 1e-5;
uvzero = 0.0;

u = -wspd.*sin(wdir*pi/180);
v = -wspd.*cos(wdir*pi/180);

uv = [u; v];
uv(abs(uv) <= uveps) = uvzero;

end