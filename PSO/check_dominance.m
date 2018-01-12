%支配占优判断函数
function flag = check_dominance(x,y)
% for i  = 1:length(x)
%     if x(i)<=y(i) && max(x ~= y) == 1    % x支配y
%         flag = 1;
%     elseif y(i)<=x(i) && max(x ~= y) == 1 % y支配x
%         flag = -1;
%     else
%         if arr_dominance(x,y) == 1
%             flag = 1;
%         elseif arr_dominance(x,y) == -1
%             flag = -1;
%         else
%             flag = 0;
%         end
%     end
% end
% %非支配解的支配比较
% function flag = arr_dominance(x,y)
f = zeros();
for i  = 1:length(x)
    if x(i)<y(i)   
        f(i) = 1;
    elseif y(i)<x(i)  
        f(i) = -1;
    else
        f(i) = 0;
    end
end
if sum(ismember(f,-1))==0 && sum(f)>0
    flag = 1;  
elseif sum(ismember(f,1))==0 && sum(f)<0
    flag = -1; 
else
    if sum(f)>0
        flag = 1;
    elseif sum(f)<0
        flag = -1;
    else
        if sum(x)<sum(y)
            flag = 1;
        elseif sum(x)>sum(y)
            flag=-1;
        else
            flag=0;
        end
    end
end
% f = [];
% for i  = 1:length(x)
%     if x(i)<y(i)   
%         f(i) = 1;
%     elseif y(i)<x(i)  
%         f(i) = -1;
%     else
%         f(i) = 0;
%     end
% end
% if sum(ismember(f,-1))==0 && sum(f)>0
%     flag = 1;  
% elseif sum(ismember(f,1))==0 && sum(f)<0
%     flag = -1; 
% else
%     flag = 0;
% end
% if sum(x)<sum(y)
%     flag = 1;
% elseif sum(x)>sum(y)
%     flag = -1;
% elseif sum(x)==sum(y)
%     flag = 0;
% end

end


