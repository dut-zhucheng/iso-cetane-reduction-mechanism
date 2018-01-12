clc;clear all;
REAC = [];
for i = 1:9
file_path = char(['D:\Chemkin work dir\C16\1600step\�����ķ�Ӧλ��',int2str(i),'.out' ]);
filename = fopen(file_path,'r');

while ~feof(filename)
    tline = fgetl(filename);
    ss = strfind(tline,'��');
    tt = strfind(tline,'��');
    nn = str2double(tline(ss+1:tt-1));
    reac = nn;
    [s1,s2]=strtok(tline,'#');
    s3 = strtok(s2,'#');
    s4=strtok(s3,'_');
    mm = str2double(s4);
    reac = [reac,mm];
    REAC = [REAC;reac];
end
fclose(filename);
fclose all;
end

[a,b] = unique(REAC(:,2),'first');
REAC = REAC(b,:);

spec_index = sortrows(REAC);

rem_index = [];
abs_index = [];
for i = 1:length(spec_index(:,1))
    aa = [41,42,43,80,81,82,83];
    if max(ismember(aa,spec_index(i,1)))
        rem_index = [rem_index;spec_index(i,:)];
    end
    if min(~ismember(aa,spec_index(i,1)))
        abs_index=[abs_index;spec_index(i,:)];
    end
end


IGN = [];
DEVI = [];
for tt = 3:length(abs_index(:,1))
    backup = abs_index;
    backup(tt,:) = [];
    backup = [backup;rem_index];
    
    step = unique(backup(:,2));
    step = [0;step];
    
    file_fin = char(['D:\Chemkin work dir\C16\700step\ABS.inp']);
    j=0;
    fid = fopen('D:\Chemkin work dir\C16\1600step\1600.inp');
    fin = fopen(file_fin,'wt');
    while ~feof(fid)      %�ж��ǲ����ļ�ĩβ
       tline=fgetl(fid);    %��ȡһ�У�ע�⣬����һ�к󣬹��ͻ��Զ�����һ��
    k=strfind(tline,'=');      %Ѱ�ҷ�Ӧ���
    if ~isempty(k)
    j=j+1;%����Ӧ���
    end
    ind = find(step==j);
    if ~isempty(ind)%�޳�m�ŷ�Ӧ
    fprintf(fin,'%s\n',tline);
    end
    end
    fprintf(fin,'%s\n','END');
    fclose(fin);
    fclose(fid);
    fclose all;
    
    
    delete('D:\Chemkin work dir\C16\700step\*.csv');
    delete('D:\Chemkin work dir\C16\700step\*.xml');
    delete('D:\Chemkin work dir\C16\700step\*.zip');

    [~,~]=dos('D:\Chemkin work dir\C16\700step\ST.bat');
    ae=dir('D:\Chemkin work dir\C16\700step\*.csv');
    al=length(ae)-1;
    ID6 = zeros(1,al);
    for j=1:al
        filename =char(['D:\Chemkin work dir\C16\700step\CKSoln_solution_no_' ,int2str(j), '.csv';]);
        A= csvread(filename,1,0);
        DA=[];%%%
        for i=2:size(A,1)
            if A(i,1)==A(i-1,1)
                DA(i)=0;
            else
                DA(i)= (A(i,2)-A(i-1,2))/(A(i,1)-A(i-1,1));
            end
        end
    % 	[~,In]=max(DA);
        peaks = findpeaks(DA);
        MPE = max(peaks);
        index=[];
        for l = 1:length(peaks)
            if (peaks(l)/MPE)>0.1
                ind = find(DA==peaks(l));
                index = [index,ind];
            end
        end
        In = index(end);
        if In ==1
            BF = inf;
        else
            BF= (A(1,2)-A(In-1,2))/(A(In,2)-A(In-1,2))*(A(In,1)-A(In-1,1))+A(In-1,1);
        end
            ID6(j)= BF*1000000;
    end
    
    detail = [20292.29883	932.9851647	0.133081304	22964.13756	188.368277	1.749017535	14430.72329	4465.747196	0.631910691];
    
    deviation = abs(detail-ID6)./detail;
    IGN = [IGN;ID6];
    DEVI = [DEVI;deviation];
    fclose all;
end

save SA;