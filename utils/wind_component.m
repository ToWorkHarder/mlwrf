function uv = wind_component(wspd, wdir)
% �� ����ͷ��� ���� u, v
% ����������
%    ��������� 
%        wspd  ��  ����.  ��λ�� m/s
%        wdir  ��  ����.  ��λ�� ��
%    ���������
%        uv  �� ���� u , v.  ��λ�� m/s
%  =========================================================
%    date  :  2017.1.8
%    by    :  ly
%    email :  libravo@foxmail.com
%%  �ο� NCL �� wind_component  ����

rad = vpa(0.17452925199433);
uvmsg = 1e20;
uveps = 1e-5;
uvzero = 0.0;

u = -wspd*sin(wdir*rad);
v = -wspd*cos(wdir*rad);

uv = [u;v];
uv(uv <= uveps) = uvzero;

end