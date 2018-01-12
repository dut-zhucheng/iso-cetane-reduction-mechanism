clc;clear;
% ae = dir('D:\Chemkin work dir\C16\DRG0.07\*.csv');
ae = dir('D:\Chemkin work dir\C16\1600step\*.csv');
al=length(ae)-10;
for j = 1:al
% filename = char(['D:\Chemkin work dir\C16\DRG0.07\CKSoln_rate-of-production_for_solution_no_',int2str(j),'.csv']);
filename = char(['D:\Chemkin work dir\C16\1600step\CKSoln_rate-of-production_for_solution_no_',int2str(j),'.csv']);

% file_path = char(['D:\Chemkin work dir\C16\DRG0.07\主消耗反应位置',int2str(j),'.out' ]);
% file_path1 = char(['D:\Chemkin work dir\C16\DRG0.07\主消耗反应',int2str(j),'.out' ]);
file_path = char(['D:\Chemkin work dir\C16\1600step\主消耗反应位置',int2str(j),'.out' ]);
file_path1 = char(['D:\Chemkin work dir\C16\1600step\主消耗反应',int2str(j),'.out' ]);

fin = fopen(file_path,'wt');
fid = fopen(file_path1,'wt');

[AA,BB] = xlsread(filename);
AA(:,1) = [];
BB(:,1) = [];

b = [];
for i = 1:length(BB)
    a = cell2mat(strfind(BB(i),'Total'));
    if a > 0
        b=[b,i];
    end
end
b = [b,length(BB)+1];

CC = cell(length(b)-1,1);
for i = 1:length(b)-1
    CC{i} = num2cell(AA(:,b(i)+1:b(i+1)-1));
end

%反应消耗率大于消耗最大的0.08
for i = 1:length(b)-1
    D = [];
    for j = 1:length(CC{i}(1,:))
        cc = cell2mat(CC{i});
        D(j) = min(cc(:,j));
    end
    [d,dinx] = sort(D,'ascend');
    
%     figure;
    for k = 1:length(d)
        if abs(d(k)) > abs(d(1)*0.01)
          fprintf(fin,'第%1.0f种组分在rop文件中第%1.0f列:%s\n',i,b(i)+dinx(k)+1,char(BB(b(i)+dinx(k))));
          [s1,s2] = strtok(char(BB(b(i)+dinx(k))),'#');
          s3 = strtok(s2,'#');
          s4 = strtok(s3,'_');
%           filename1 = fopen('D:\Chemkin work dir\C16\DRG0.07\test_matlab.out');
          filename1 = fopen('D:\Chemkin work dir\C16\1600step\test_matlab.out');
          while ~feof(filename1)
              tline = fgetl(filename1);
              s5 = strtok(tline,'.');
              ss4 = str2num(s4);
              ss5 = str2num(s5);
              t = strfind(tline,'G');
              if (ss4 == ss5) & isempty(t)
                  fprintf(fid,'%s\n',tline);
%                   break;
              end
          end
          fclose(filename1);
          plot(AA(:,b(i)+dinx(k)),'-');hold on;
        end
    end
end

fclose(fin);
fclose(fid);
fclose all;


end


fclose all;
for t = 1:9
% file_name = char(['D:\Chemkin work dir\C16\DRG0.07\主消耗反应位置_',int2str(t),'.out']);
file_name = char(['D:\Chemkin work dir\C16\1600step\主消耗反应位置',int2str(t),'.out']);
filename = fopen(file_name,'r');

STEP = [];
while ~feof(filename)
    tline = fgetl(filename);
    [s1,s2]=strtok(tline,'#');
    s3 = strtok(s2,'#');
    s4=strtok(s3,'_');
    step = str2double(s4);
    STEP = [STEP,step];
end

step = unique(STEP);
step=[0,step];

% file_fin = char(['D:\Chemkin work dir\C16\DRG0.07\C16drg_rop_',int2str(t),'.inp']);
file_fin = char(['D:\Chemkin work dir\C16\1600step\1600_rop_',int2str(t),'.inp']);
j=0;
% fid = fopen('D:\Chemkin work dir\C16\DRG0.07\C16_drgep.inp');
fid = fopen('D:\Chemkin work dir\C16\1600step\1600.inp');
fin = fopen(file_fin,'wt');
while ~feof(fid)      %判断是不是文件末尾
   tline=fgetl(fid);    %读取一行，注意，读完一行后，光标就会自动到下一行
k=strfind(tline,'=');      %寻找反应标记
if ~isempty(k)
j=j+1;%给反应编号
end
ind = find(step==j);
if ~isempty(ind)%剔除m号反应
fprintf(fin,'%s\n',tline);
end
end
fprintf(fin,'%s\n','END');
fclose(fin);
fclose(fid);
fclose(filename);
fclose all;

end

STEP_ALL = [];
for tt = 1:9
% file_name = char(['D:\Chemkin work dir\C16\DRG0.07\主消耗反应位置_',int2str(tt),'.out']);
file_name = char(['D:\Chemkin work dir\C16\1600step\主消耗反应位置',int2str(tt),'.out']);
filename = fopen(file_name,'r');

STEP = [];
while ~feof(filename)
    tline = fgetl(filename);
    [s1,s2]=strtok(tline,'#');
    s3 = strtok(s2,'#');
    s4=strtok(s3,'_');
    step = str2double(s4);
    STEP = [STEP,step];
end

step = unique(STEP);  
STEP_ALL = [STEP_ALL,step];
end
step_all = unique(STEP_ALL);
step_all = [0,step_all];
j=0;
% fid = fopen('D:\Chemkin work dir\C16\DRG0.07\C16_drgep.inp');
% fin = fopen('D:\Chemkin work dir\C16\DRG0.07\C16drg_rop_total.inp','wt');
fid = fopen('D:\Chemkin work dir\C16\1600step\1600.inp');
fin = fopen('D:\Chemkin work dir\C16\1600step\1600_rop_total.inp','wt');
while ~feof(fid)      %判断是不是文件末尾
tline=fgetl(fid);    %读取一行，注意，读完一行后，光标就会自动到下一行
k=strfind(tline,'=');      %寻找反应标记
if ~isempty(k)
j=j+1;%给反应编号
end
ind = find(step_all==j);
if ~isempty(ind)%剔除m号反应
fprintf(fin,'%s\n',tline);
end
end
fprintf(fin,'%s\n','END');
fclose(fin);
fclose(fid);




% %反应消耗率大于消耗最大的0.1
% for i = 1:length(b)-1
%     D = [];
%     for j = 1:length(CC{i}(1,:))
%         cc = cell2mat(CC{i});
%         D(j) = min(cc(:,j));
%     end
%     [d,dinx] = sort(D,'ascend');
%     
%     figure;
%     for k = 1:length(d)
%         if abs(d(k)) > abs(d(1)*0.1)
%           fprintf(fin,'第%1.0f种组分在rop文件中第%1.0f列:%s\n',i,b(i)+dinx(k)+1,char(BB(b(i)+dinx(k))));
%           plot(AA(:,b(i)+dinx(k)),'-');hold on;
%         end
%     end
% end

