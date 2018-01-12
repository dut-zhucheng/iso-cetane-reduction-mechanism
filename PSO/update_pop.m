%粒子进化更新函数
function [pop,v] = update_pop(pop,v,pbest,gbest,w,r1,r2,c1,c2,N)
for i = 1:N
    v1 = w*v(i,:) + c1*r1*(pbest(i,:)-pop(i,:)) + c2*r2*(gbest(i,:)-pop(i,:));
    pop1 = pop(i,:) + v(i,:);
    v(i,:)=v1;
    pop(i,:)=pop1;
end
end