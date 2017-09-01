function tc = wrf_gettc(filename, staind, endind)
%   ����ÿ�������Ӧ���¶�ֵ
%  ���������
%       filename  :  ���о���·�����ļ������ַ�����
%       staind    :  ��ʼ����������Ԫ��������
%                  ÿһ��Ԫ�طֱ�Ϊ���ȣ�γ�ȣ��߶ȣ�ʱ��
%       endind    :  �յ�������ͬ staind
%  ���������
%      tc  : �¶ȡ���λ����
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

T  =  squeeze(ncread(filename, 'T',[lons lats hs ts ], [lonn latn hn tn]));
P  =  squeeze(ncread(filename, 'P',[lons lats hs ts ], [lonn latn hn tn]));
PB =  squeeze(ncread(filename, 'PB',[lons lats hs ts ], [lonn latn hn tn]));

tc = ((P+PB)/100000).^(0.285714).*(T+300)-273.16;

end