function  getuwyo(year, mo, day, hour, station, filename)
% �� http://weather.uwyo.edu/upperair/sounding.html  ��վ
% ��ȡ̽������
%   ����˵����
%     ���������
%        year  �� ��.  ����.
%         mo   �� ��.  ����.
%        day   �� ��.  ����.
%        hour  �� ʱ.  ����.
%      station �� վ��.  ����.
%     filename �� ����ļ������粻����·����Ϊ��ǰ·��.
% ----------------------------------------------------------------------
%    date : 2017.1.9
% modified: 2017.2.13
%     by  :   ly
%   email : libravo@foxmail.com
%% ��ȡ̽������ҳ
[str,status] = urlread(sprintf('http://www.weather.uwyo.edu/cgi-bin/sounding?region=seasia&TYPE=TEXT%%3ALIST&YEAR=%4d&MONTH=%02d&FROM=%02d%02d&TO=%02d%02d&STNM=%d',...
    year,mo,day,hour,day,hour,station));

if status == 0
    error('Fail to scrapy sounding data!\n str = %s', str);
end
h2ind  = strfind(str, '<H2>');
h3ind  = strfind(str, '<H3>');
preind = strfind(str, '</PRE>');

substr  = regexprep(str(h2ind(1):h3ind(1)-1), '<H2>|</H2>|<H3>|</H3>|<PRE>|</PRE>','');
infostr = regexprep(str(preind(1)-1:preind(2)-1), '<H3>|</H3>|<PRE>|</PRE>','');
% ��ʾ��Ӧ̽������ҳ�Ĳ�����Ϣ
disp(infostr)
dlmwrite(filename, substr, 'delimiter', '')
end