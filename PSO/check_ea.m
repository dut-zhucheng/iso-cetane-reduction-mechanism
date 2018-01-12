coef = [3.341E+06   2.768  8.147E+03;
5.630E+06   1.800  1.431E+03;
1.000E+14   0.00   1.601E+04;
2.000E+16   0.000  4.600E+04;
3.000E+14  -0.14   2.678E+04;
4.520E+12   0.000  0.000E+00;
7.500E+11   0.000  2.400E+04;
4.520E+12   0.000  0.000E+00;
5.500E+11   0.000  2.100E+04;
1.784E+15   0.0    3.910E+04;
3.160E+13   0.00   1.000E+04;
3.160E+11   0.000  6.000E+03;
4.743E+07   1.80   9.300E+02;
2.500E+16   0.00   7.100E+04;
3.400E+05   2.500  2.492E+03;
5.200E+06   2.000 -2.980E+02;
9.504E+11   0.773  3.070E+04;
5.230E+47  -9.740  7.426E+04];

Tem=(600:100:2000);
for j=1:size(coef,1)
a=coef(j,1);
b=coef(j,2);
E=coef(j,3);
for i=1:length(Tem)
c(i,j)=a*Tem(i)^b*exp(-E/1.98718/Tem(i));
end
end
muti_ref=[];
for i=1:size(coef,1)
    muti_ref(i)=c(15,i)/c(1,i);
end

%input ea
ea = COEF{unidrnd(T)}(unidrnd(N),:);
%替换
for i=1:18
    coef(i,3)=ea(i);
    coef(i,1)=ea(i+18);
end

for j=1:size(coef,1)
a=coef(j,1);
b=coef(j,2);
E=coef(j,3);
for i=1:length(Tem)
c(i,j)=a*Tem(i)^b*exp(-E/1.98718/Tem(i));
end
end
muti_pop=[];
for i=1:size(coef,1)
    muti_pop(i)=c(15,i)/c(1,i);
end

check_muti=[];
for i=1:size(coef,1)
    check_muti(i) = muti_pop(i)/muti_ref(i);
    if check_muti(i)<0.1 || check_muti(i)>10
        fprintf('反应参数%1.0f有误！\n',i);
    end
end