function height = wrf_gethe(filename, staind, endind)
%   ����ÿ�������Ӧ�ĸ߶�
%  ���������
%       filename  :  ���о���·�����ļ������ַ�����
%       staind    :  ��ʼ����������Ԫ��������
%                  ÿһ��Ԫ�طֱ�Ϊ���ȣ�γ�ȣ��߶ȣ�ʱ��
%       endind    :  �յ�������ͬ staind
%  ���������
%      height  : �߶ȡ� ��λ��m
%%
%  Date : 16.11.3
%%
ts    = staind(4);
hs    = staind(3);
lats  = staind(2);
lons  = staind(1);
tn    = endind(4) - ts + 1;
hn    = endind(3) - hs + 1;
latn  = endind(2) - lats;
lonn  = endind(1) - lons;

PH  =  squeeze(ncread(filename, 'PH',[lons lats hs ts ], [lonn latn hn tn]));
PHB =  squeeze(ncread(filename, 'PHB',[lons lats hs ts ], [lonn latn hn tn]));
PH  =  PH + PHB;

dims = size(PH);
dimh = dims(3);
PH  = 0.5*(PH(:,:,1:dimh-1) + PH(:,:,2:dimh)); % unstagger
height = PH/9.81 ;  % height (m)

end