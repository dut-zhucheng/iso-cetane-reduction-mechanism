function [pop,v] = variant_limit(pop,v,n,N)
for i = 1:N
    for j = 1:n
        if v(i,j)<-2 
            v(i,j) = -2+0.1*rand;
        elseif v(i,j)>2
            v(i,j) = 2-0.1*rand;  
        end
        if pop(i,j)<-1
            pop(i,j)=-1+0.1*rand;
        elseif pop(i,j)>1
            pop(i,j)=1-0.1*rand;
        end
    end
end
end