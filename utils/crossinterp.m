function [var, varargout] = crossinterp(vard, interptype, varargin)
% ���ڶ���ѡWRFģʽ����������д�ֱ�����ֵ��Ȼ�󷵻ز�ֵ��ı������ڻ��ƴ�ֱ����ͼ
%  �����������ڶ��κ���ά�������в�ֵ����ֵ����Ѻ�NCL�����ƽ���Աȣ�����һ�¡�
%  ���������
%          vard : ��ѡ����������Ϊ��ֵ�͡� ά��Ϊ��ά���飬�ֱ���X����Y�����Z����
%                  ʱ��ά��Ӧ�ڴ���ʱѡ����
%    interptype : ָ�����淽ʽ��Ϊ�ַ��ͱ�����
%                'se'  : ��ʾ����ѡ����ʼ������յ����꣬����ָ�������ߡ�
%                    'stapos' : ��ʼ����㣬��Ԫ���������ֱ�Ϊx��y����ʼ�㣬
%                               ��һ��ֵΪx����ʼ�㣬�ڶ���ֵΪy����ʼ�㡣
%                    'endpos' : �յ����꣬��Ԫ���������ֱ�Ϊx��y���յ㣬
%                               ��һ��ֵΪx���յ㣬�ڶ���ֵΪy���յ㡣
%                'md'  : ��ʾ����ͨ��ָ���е��������б�Ƕ�ѡ�������ߡ�
%                    'midpos' : �е����꣬��Ԫ��������
%                               ��һ��ֵΪx���е����꣬�ڶ���ֵΪy���е����ꡣ
%                    'angle'  : ����ָ����б�Ƕȣ���ֱ��б�ʡ� Ĭ��ֵΪ45�ȡ�
%                               ȡֵ��ΧӦ�� -90 �� 90 ֮�䡣
%                  ����ѡ�������ߵ�ģʽ����һ�� step ���������ڿ��Ʋ�ֵ�ļ����
%                   'step'  :  ���ڿ��Ʋ�ֵ�ļ�����������ܶȡ�Ĭ��ֵΪ 1
%                           һ������²���Ĭ��ֵ���ɣ�����ѡ������������ʱ����
%                           �ʵ���С��ֵ����Ӧ��֤����0������ᱨ��
%                           ���Ҵ�ֵԽС��ֵ�õ�������Խ�ܣ����Ƶ�ͼ���ܸ���pcolor
%                           ���Ƶ�ͼ�Ρ����ȡֵ����1�����������棬����������
%                           �ᵼ�²�ֵ������ϡ�裬������ͼ�ο��ܲ����׷ֱ�ϸ΢�Ĳ��
%                           ��˲�����ȡֵ����ͬ��������ȡֵ̫С�����ȡֵ��Χ��0.5-1
%                           ֮�䡣���ݾ���������ʵ����ڡ�
%  ���������
%       var  : ��ֵ�����ڻ��ƴ�ֱ����ͼ�ı���
%     ��ѡ���������
%       croline  �� �ṹ����������ڻ��������ߡ�
%           x ��洢���� �����ߵ� x������
%           y ��洢���� �����ߵ� y������
%%  �ɲ���croline���ص�x,y������������ߣ�ֱ��ͨ����������ֹ����л���
%   ע�⣺ �����ȡ��ѡ��������ά�ȵ�ȫ��������ʾ����̫���޷���ȡ�Ļ��ɶ�ȡ��������
%% ʾ��
%   [var, croline] = CrossInterp(vard, 'se', 'stapos', [1 81], 'step', 0.8, 'endpos', [85 1]);
%   [var, croline] = CrossInterp(vard, 'md', 'midpos', [40 35], 'angle', -45);
%%
p = inputParser;
validVard = @(x) ndims(x)==3;
validAngle = @(x) isnumeric(x) && x >= -90 && x <= 90;
validValue = @(x) isvector(x) && min(x) >=0 && ~isempty(x);
validStep  = @(x) isnumeric(x) && x>=0;
defaultStep  =  1;   % Ĭ�ϲ�ֵ����
defaultAngle = 45;   % Ĭ������Ƕ�
addRequired(p, 'vard', validVard)
addRequired(p, 'interptype', @isstr)
addParameter(p, 'stapos', validValue)
addParameter(p, 'step', defaultStep, validStep)
addParameter(p, 'endpos', validValue)
addParameter(p, 'midpos', validValue)
addParameter(p, 'angle', defaultAngle, validAngle)
parse(p, vard, interptype, varargin{:})
% ������Ϣ
errstr1 = 'The max value must be lesser than %d.';
errstr2 = [errstr1, 'and the best value range is [%d %d].'];
errstr3 = 'Are you want to test the program? If yes, another way could be a good idea!';
% ��ȡÿһά�ȵĴ�С
if ndims(vard) == 3
    [xv, yv, zv] = size(vard);
else
    error('The dimensions of the variable is %d!Must be 4D!Please check it!', ndims(vard))
end
step   = p.Results.step;
if  step >1
    warning('The value of input arguments %s is %d and should be lesser than 1!', 'step', step)
end
% �ж�ѡ�����ִ�ֱ���淽ʽ�����ֱ�߷���
if strcmp(p.Results.interptype, 'se')
    stapos = p.Results.stapos;
    endpos = p.Results.endpos;
    if ~islogical(stapos(1)) && ~islogical(endpos(1))
        if stapos(1) > xv || endpos(1) > xv
            error(errstr1, xv)
        elseif stapos(2) > yv || endpos(2) > yv
            error(errstr1, yv)
        end
    elseif ~islogical(p.Results.midpos(1))
        error(errstr3)
    else
        error('Input arguments %s and %s must be vector with two elements!', 'stapos', 'endpos')
    end
    %  ����������ʼ���յ������ֱ�߷��̣�ͨ��x��������ֱ�߷����ϵ�y��ĵ�
    x = stapos(1):step:endpos(1);
    y = ((endpos(2)-stapos(2))/(endpos(1)-stapos(1))).*(x - endpos(1)) + endpos(2);
elseif strcmp(p.Results.interptype, 'md')
    midpos = p.Results.midpos;
    if ~islogical(midpos(1))
        if midpos(1) > xv
            error(errstr2, xv, xv/4, 3*xv/4)
        elseif midpos(2) > yv
            error(errstr2, yv, yv/4, 3*yv/4)
        end
    elseif ~islogical(p.Results.stapos(1)) || ~islogical(p.Results.endpos(1))
        error(errstr3)
    else
        error('Variable %s must be vertor with two elements!', 'midpos')
    end
    angle  = p.Results.angle;
%  ���x�������б��Ϊ tan(angle)��midpos�������ֱ���ϵ�y��ĵ�
%  ����ѡ�����е������ֱ��б�ʣ�������÷��̼������y���������ֳ�����Χ��
    x = [1:step:midpos(1),midpos(1)+step:step:xv];
    y = tan((angle*3.1415926)/180)*(x - midpos(1)) + midpos(2);
    yind = y >=0 & y <= yv;
    x = x(yind);
    y = y(yind);
end
xl = length(x);
intevar = zeros(xl, xl, zv);
[X, Y] = ndgrid(x,y);
for i = 1:zv
    F = griddedInterpolant(vard(:,:,i), 'nearest');
    intevar(:,:,i)  =  F(X, Y);
end
var = zeros(xl, zv);
% ��ȡ��ֱ���ϵ�ÿһ��߶ȵĵ�
for i = 1:zv
    var(:,i) = diag(intevar(:,:,i));
end
crossline.x = x;
crossline.y = y;
varargout{1} = crossline;
end