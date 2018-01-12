% function [gbest,single_gbest,single_gbestobj] = UP_gbest(PO,pbest,N)
% single_gbest=[];
% for i = 2:N
%     if check_dominance(PO(i-1,:),PO(i,:)) == 1
%         single_gbest = pbest(i-1,:);
%         single_gbestobj = PO(i-1,:);
%     elseif check_dominance(PO(i-1,:),PO(i,:)) == -1
%         single_gbest = pbest(i,:);
%         single_gbestobj = PO(i,:);
%     else
%         c = unidrnd(2);
%         if c==1
%             single_gbest = pbest(i-1,:);
%             single_gbestobj = PO(i-1,:);
%         else
%             single_gbest = pbest(i,:);
%             single_gbestobj = PO(i,:);
%         end
%     end
% end
% gbest = repmat(single_gbest,N,1);
% end
function [gbest,single_gbest,single_gbestobj]=UP_gbest(OBJ,N,t,POP)
single_gbest=[];
for i = 1:N
    for j = 2:t+1
        if check_dominance(OBJ{j-1}(i,:),OBJ{j-1}(i,:)) == 1
            single_gbestobj = OBJ{j-1}(i,:);
            single_gbest = POP{j-1}(i,:);
        elseif check_dominance(OBJ{j-1}(i,:),OBJ{j-1}(i,:)) == -1
            single_gbestobj = OBJ{j}(i,:);
            single_gbest = POP{j}(i,:);
        else
            c = unidrnd(2);
            if c==1
                single_gbestobj = OBJ{j-1}(i,:);
                single_gbest = POP{j-1}(i,:);
            else
                single_gbestobj = OBJ{j}(i,:);
                single_gbest = POP{j}(i,:);
            end
        end
    end
end
gbest = repmat(single_gbest,N,1);
end
    