function send_email(address, passwd, rece, varargin)
% ����e-mail��ָ������
% ���������
%      address  :  ���ڷ����ʼ��������ַ��   ���ͣ�string
%      passwd   :  �����ʼ����������롣  ���ͣ�string
%      rece     :  �����ʼ������䡣  ���ͣ�string
% ��ѡ���������
%      subject  :  e-mail���⡣  ���ͣ�string
%                  Ĭ��ֵ��  Hello
%      contents :  e-mail���ݡ�  ���ͣ�string
%                  Ĭ��ΪFrom MATLAB on ϵͳ�� platform  
%      attach   :  ������ Ĭ��Ϊ�ա� ���ͣ�struct �� cell.
%      smtp     :  ����smtp���������á� ���ͣ� string
%                  Ĭ��ʹ��qq���䷢���ʼ������smtp����������Ϊ smtp.qq.com
%                  �������ʹ������������ã��粻֪���ɲ�ѯʹ���������Ϣ��    
%   Ŀǰ�Ѳ�����qq������foxmail��,126,163,139�Լ�gmail���䡣
%      example:  smtp = 'smtp.126.com'
%% set input arguments and check validation of all of arguments
p = inputParser;

subjectDefault = 'Hello';
contentsDefault = sprintf('From MATLAB on %s platform.',computer('arch'));
attachDefault = {};
smtpDefault = 'smtp.qq.com';
attachValidFcn = @(x) iscell(x) || isstruct(x);

addRequired(p, 'address', @ischar);
addRequired(p, 'passwd', @ischar);
addRequired(p, 'rece', @ischar);
addParameter(p, 'subject', subjectDefault, @ischar,'PartialMatchPriority', 3);
addParameter(p, 'contents', contentsDefault, @ischar);
addParameter(p, 'attach', attachDefault, attachValidFcn);
addParameter(p, 'smtp', smtpDefault, @ischar, 'PartialMatchPriority',2);

parse(p, address, passwd, rece, varargin{:});
%% assign arguments to variables
mail_attach   = p.Results.attach;

attachCheck = {'.','..'};
setpref('Internet', 'E_mail', p.Results.address);
setpref('Internet', 'SMTP_Server', p.Results.smtp);
setpref('Internet', 'SMTP_Username', p.Results.address);
setpref('Internet', 'SMTP_Password', p.Results.passwd);
props = java.lang.System.getProperties;
props.setProperty('mail.smtp.auth','true');
props.setProperty('mail.smtp.socketFactory.class','javax.net.ssl.SSLSocketFactory');
% �ı�smtp���������������ʹ�õĶ˿ںſ�����Ҫ�ı䣬����˿ں����ѯ��ʹ������
props.setProperty('mail.smtp.socketFactory.port','465'); 

% send email
if isempty(p.Results.attach)
    sendmail(p.Results.rece, p.Results.subject, p.Results.contents);
else
    if isstruct(p.Results.attach)
        mail_attach = struct2cell(mail_attach);
    end
    if size(mail_attach,2) >=2 && (ismember(mail_attach(1,1), attachCheck) || ismember(mail_attach(1,2), attachCheck))
        mail_attach = mail_attach(:,3:end);
    end
    sendmail(p.Results.rece, p.Results.subject, p.Results.contents, mail_attach(1,:));
end

end
