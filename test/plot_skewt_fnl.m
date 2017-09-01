clear, clc

dbstop if error

filename = 'fnl_20160623_06_00.grib2';
%  ָ����γ������
longitudes = 120;
latitudes  = 33;

setup_nctoolbox();  % ���� nctoolbox������
data = ncdataset(filename);

pres = squeeze(data.data('isobaric2'));  % ѹ����
lon  = squeeze(data.data('lon'));
lat  = squeeze(data.data('lat'));

num = length(pres);
latind = find(lat == round(latitudes));
lonind = find(lon == round(180 + longitudes));

tk = data.data('Temperature_isobaric', [1 1 latind lonind], [1 num latind lonind])';  % �¶�  ��λ�� K
rh = data.data('Relative_humidity_isobaric', [1 1 latind lonind], [1 num latind lonind])';  % ���ʪ��
u  = data.data('u-component_of_wind_isobaric', [1 1 latind lonind], [1 num latind lonind])'; 
v  = data.data('v-component_of_wind_isobaric', [1 1 latind lonind], [1 num latind lonind])';

wdir = wind_direction(u, v, 0);  % �������
wspd = sqrt(u.^2 + v.^2);   % �������

skewTlogP_plot(pres/100, tk - 273.15, rh*0.01, wdir, wspd);