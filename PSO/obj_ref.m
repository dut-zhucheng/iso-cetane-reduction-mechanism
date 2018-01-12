
function fit = obj_ref()

 %--------------------------ST0.5----------------------------
% [~,~]=dos('D:\Chemkin work dir\C16\REF\ST0.5\ST.bat');
ae=dir('D:\Chemkin work dir\C16\REF\ST0.5\*.csv');
al=length(ae)-1;
ID1 = zeros(1,al);
for j=1:al
	filename =char(['D:\Chemkin work dir\C16\REF\ST0.5\CKSoln_solution_no_' ,int2str(j), '.csv';]);
	A= csvread(filename,1,0);
	DA = [];
	for i=2:size(A,1)
        if A(i,1)==A(i-1,1)
            DA(i)=0;
        else
            DA(i)= (A(i,2)-A(i-1,2))/(A(i,1)-A(i-1,1));
        end
	end
    [~,In]=max(DA);
	if In ==1
        BF = inf;
    else
        BF= (A(1,2)-A(In-1,2))/(A(In,2)-A(In-1,2))*(A(In,1)-A(In-1,1))+A(In-1,1);
	end
	ID1(j)= BF*1000000;
end

filename1 =char('D:\Chemkin work dir\C16\ST_LTdata.xlsx');
A1= xlsread(filename1,1);

FIT1 = abs((ID1' - A1(:,1))./ID1'); 
fit1 = sum(FIT1(1:5));
fit2 = sum(FIT1(6:end));
%-------------------------ST1.0-----------------------------
% [~,~]=dos('D:\Chemkin work dir\C16\REF\ST1.0\ST.bat');
ae=dir('D:\Chemkin work dir\C16\REF\ST1.0\*.csv');
al=length(ae)-1;
ID2 = zeros(1,al);
for j=1:al
	filename =char(['D:\Chemkin work dir\C16\REF\ST1.0\CKSoln_solution_no_' ,int2str(j), '.csv';]);
	A= csvread(filename,1,0);
	DA = [];
	for i=2:size(A,1)
        if A(i,1)==A(i-1,1)
            DA(i)=0;
        else
            DA(i)= (A(i,2)-A(i-1,2))/(A(i,1)-A(i-1,1));
        end
	end
	[~,In]=max(DA);
	if In ==1
        BF = inf;
    else
        BF= (A(1,2)-A(In-1,2))/(A(In,2)-A(In-1,2))*(A(In,1)-A(In-1,1))+A(In-1,1);
	end
	ID2(j)= BF*1000000;
end

A2= xlsread(filename1,2);

FIT2 = abs((ID2' - A2(:,1))./ID2'); 
fit3 = sum(FIT2(1:3));
fit4 = sum(FIT2(4:end));
%--------------------------ST1.5----------------------------
% [~,~]=dos('D:\Chemkin work dir\C16\REF\ST1.5\ST.bat');
ae=dir('D:\Chemkin work dir\C16\REF\ST1.5\*.csv');
al=length(ae)-1;
ID3 = zeros(1,al);
for j=1:al
	filename =char(['D:\Chemkin work dir\C16\REF\ST1.5\CKSoln_solution_no_' ,int2str(j), '.csv';]);
	A= csvread(filename,1,0);
	DA = [];
	for i=2:size(A,1)
        if A(i,1)==A(i-1,1)
            DA(i)=0;
        else
            DA(i)= (A(i,2)-A(i-1,2))/(A(i,1)-A(i-1,1));
        end
	end
	[~,In]=max(DA);
	if In ==1
        BF = inf;
    else
        BF= (A(1,2)-A(In-1,2))/(A(In,2)-A(In-1,2))*(A(In,1)-A(In-1,1))+A(In-1,1);
	end
	ID3(j)= BF*1000000;
end

A3= xlsread(filename1,3);

FIT3 = abs((ID3' - A3(:,1))./ID3');
fit5 = sum(FIT3(1:5));
fit6 = sum(FIT3(6:end));
    
%     %-----------------修改输出清单--------------------------
%     fid4 = fopen('D:\Chemkin work dir\C12\CKSolnList_JSR.txt');
%     fin4 = fopen('D:\Chemkin work dir\C12\CKSolnList.txt','wt');
%     while ~feof(fid4)               % 判断是不是文件末尾
%         tline=fgetl(fid4);          % 读取一行，注意，读完一行后，光标就会自动到下一行
%         fprintf(fin4,'%s\n',tline);
%     end
%     fclose(fin4);
%     fclose(fid4);
%     %------------------------------------------------------    
%     [~,~]=dos('D:\Chemkin work dir\C12\JSR.bat');
%     filename2 =char('D:\Chemkin work dir\C12\CKSoln_solution_vs_solution_number.csv');
%     filename3 =char('D:\Chemkin work dir\C12\C12JSR_data.xlsx');
%     B= csvread(filename2,1,0);
%     B1= xlsread(filename3);
%     
%     fit6 = sum(abs((B(1:12,3)/4-B1(1:12,3))./(B(1:12,3)/4)));
%     fit7 = sum(abs((B(1:12,4)-B1(1:12,4))./B(1:12,4)));
%     fit8 = sum(abs((B(1:12,5)-B1(1:12,5))./B(1:12,5)));
%     fit9 = sum(abs((B(1:12,6)-B1(1:12,6))./B(1:12,6)));
%     fit10 = sum(abs((B(5:12,7)*200-B1(5:12,7))./(B(5:12,7)*200)));
%     fit11 = sum(abs((B(1:12,8)*5-B1(1:12,8))./(B(1:12,8)*5)));
%     
%     fit12 = sum(abs((B(13:24,3)/2-B1(13:24,3))./(B(13:24,3)/2)));
%     fit13 = sum(abs((B(13:24,4)-B1(13:24,4))./B(13:24,4)));
%     fit14 = sum(abs((B(13:24,5)-B1(13:24,5))./B(13:24,5)));
%     fit15 = sum(abs((B(13:24,6)-B1(13:24,6))./B(13:24,6)));
%     fit16 = sum(abs((B(20:24,7)*100-B1(20:24,7))./(B(20:24,7)*100)));
%     fit17 = sum(abs((B(13:24,8)*5-B1(13:24,8))./(B(13:24,8)*5)));
%     
%     fit18 = sum(abs((B(25:36,3)-B1(25:36,3))./B(25:36,3)));
%     fit19 = sum(abs((B(25:36,4)-B1(25:36,4))./B(25:36,4)));
%     fit20 = sum(abs((B(25:36,5)-B1(25:36,5))./B(25:36,5)));
%     fit21 = sum(abs((B(25:36,6)-B1(25:36,6))./B(25:36,6)));
%     fit22 = sum(abs((B(31:36,7)*100-B1(31:36,7))./(B(31:36,7)*100)));
%     fit23 = sum(abs((B(25:36,8)*5-B1(25:36,8))./(B(25:36,8)*5)));
    
fit = [fit1,fit2,fit3,fit4,fit5,fit6];
for i=1:length(fit)
    if isnan(fit(i))==1
        fit(i) = 10^15;
    end
end
end
