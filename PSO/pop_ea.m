
function EA = pop_ea(pop)
coef = [2.0E12 0.0 0.0E0;
2.0E10 0.0 2.4E4;];
%-----求原机理燃烧速率的幅度倍数------------

EA = [];
for m = 1:size(pop,1)
    for t = 1:size(coef,1)
        e(t) = coef(t,3)+pop(m,t)*3922;
        a(t) = coef(t,1)*10^pop(m,t+(0.5*size(pop,2)))*(exp(pop(m,t)*3.2894));
    end
    EA(m,:) = [e,a];
end

end
