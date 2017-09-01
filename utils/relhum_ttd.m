function rh = relhum_ttd(tk, td)
%  �����¶Ⱥ�¶���¶ȼ������ʪ��
%   ����������
%     ���������
%        tk  ��  �¶�.  ��λ�� K
%        td  ��  ¶���¶�.  ��λ�� K
%     ������� ��
%        rh  �� ���ʪ��. ����[0 1]
%  ================================================================
%    date  :  2017.1.8
%    by    :  ly
%    email :  libravo@foxmail.com
%%  �ο� NCL �� rhlhum_ttd ����
gc = 461.5; % J/{kg-k}  gas constant water vapor
gc = gc/(1000*4.186);
lhv = vpa((597.3 - 0.57*(tk - 273))); % latent heat vap

rh = exp( (lhv/gc).*(1.0./tk - 1.0./td) );
end