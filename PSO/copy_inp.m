X = 0.1+9.9*rand(3,18);
coef = [8.00E+15	0	45150;
1.09E+09	0.7	-541;
1.00E+08	1.9	58.5;
6.15E+08	1.9	21910;
1.00E+06	2	2500;
1.12E+14	0	17690;
4.35E+11	0	8165;
2.51E+13	0	27400;
1.51E+11	0	19000;
1.00E+11	0	11000;
3.16E+11	0	6000;
3.16E+11	0	19500;
3.50E+12	0	28810;
2.51E+13	0	27400;
8.91E+10	0	17000;
6.98E+15	0	43000;
3.16E+13	0	10000;
3.16E+13	0	10000];
muti = [325104502653.129,1.69073220103213,10.1949600012185,3801230.28398717...
    ,48.2158191509460,32394.3484267736,120.740537397144,9688473.72907853,...
    69901.0417126579,637.824297425873,33.8716958889277,93749.7373616013,...
    22170069.1251688,9688473.72907853,21604.1906329782,92009233716.6071,...
    354.591430558863,354.591430558863];
for m = 1:size(X(:,1))
    
%����e��ܺ�ָǰ����a��
    for t = 1:size(coef(:,1))
        e(t) = log(X(m,t)*muti(t)*((3/10)^coef(t,2)))*60*1.98718/7;
        a(t) = X(m,t)*muti(t)/(600^coef(t,2))/exp(-e(t)/1.98718/600);
    end
%-----------��Ҫ���������chem�ű��ļ�-------------
    % �޸Ļ���inp�ļ��Ļ������
    fid1 = fopen('D:\Chemkin work dir\CODE_cal\IMPSO\C12chem basic.inp');
    fin1 = fopen('D:\Chemkin work dir\CODE_cal\IMPSO\C12chem basic1.inp','wt');
    %tline = fgetl(fid);
    n=1;
    while ~feof(fid1)               % �ж��ǲ����ļ�ĩβ
        tline=fgetl(fid1);          % ��ȡһ�У�ע�⣬����һ�к󣬹��ͻ��Զ�����һ��
        k=strfind(tline,'&');      % Ѱ�ұ��
        if isempty(k)
            fprintf(fin1,'%s\n',tline);
        else
            g=e(n);
            n=n+1;
            AM= tline;
            h=num2str(g);                    % strcat: �ַ�����
            AB=strrep(AM,'&',h);                     % strrep: ��AM���ҵ�char(c)���������滻Ϊh
            fprintf(fin1,'%s\n',AB);
        end
    end
    fclose(fin1);
    fclose(fid1);
    %-----------------------------------------------------------------

    % �޸Ļ���inp�ļ���ָǰ����
    fid2 = fopen('D:\Chemkin work dir\CODE_cal\IMPSO\C12chem basic1.inp');
    fin2 = fopen('D:\Chemkin work dir\CODE_cal\IMPSO\C12chem.inp','wt');
    n=1;
    while ~feof(fid2)               % �ж��ǲ����ļ�ĩβ
        tline=fgetl(fid2);          % ��ȡһ�У�ע�⣬����һ�к󣬹��ͻ��Զ�����һ��
        k=strfind(tline,'*');      % Ѱ�ұ��
        if isempty(k)
            fprintf(fin2,'%s\n',tline);
        else
            g=a(n);
            n=n+1;
            AM= tline;
            h=num2str(g);                    % strcat: �ַ�����
            AB=strrep(AM,'*',h);             % strrep: ��AM���ҵ�char(c)���������滻Ϊh
            fprintf(fin2,'%s\n',AB);
        end
    end
    fclose(fin2);
    fclose(fid2);
    %-----------------------------------------------------
    
end