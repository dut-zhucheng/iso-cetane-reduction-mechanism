%±äÒì²Ù×÷
function pop = mutate_pop(pop,N,Obj,M,n)
lambd = zeros(1,M);                 % 1*m
zt = zeros();
ztv = zeros();
for i = 1:M
    zt(i) = min(Obj(:,i));    % value
    ztv(i) = max(Obj(:,i));   % value
    if zt(i) == ztv(i)
        lambd(i) = 1/(abs(zt(i)*10^(-5))); % value
    else
        lambd(i) = 1/(abs(zt(i)-ztv(i))); % value
    end
end
Obj_zt0 = zeros();                  % N*m
Obj_zt = zeros(); 
for k = 1:M
    for h = 1:N
        Obj_zt(h,k) = (Obj(h,k)-zt(k));
        Obj_zt0(h,k) = lambd(k)*Obj_zt(h,k);
    end
end
j = randi(N);         % select a concrete pop randomly
dtx = max(Obj_zt0(j,:)) + (10^(-6))*sum(Obj_zt(j));
pop(j,:) = pop(j,:) + dtx*rand(1,n);
end