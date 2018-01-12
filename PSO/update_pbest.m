%局部最优更新
function [pbest,PO] = update_pbest(OBJ,POP,t,N,pbest,M)
PO = zeros(N,M);
TPO = POP;
TOB = OBJ;
for i = 1:N
	for j = 2:t+1
        if check_dominance(TOB{j-1}(i,:),TOB{j}(i,:)) == 1
            TOB{j}(i,:)=TOB{j-1}(i,:);
            TPO{j}(i,:)=TPO{j-1}(i,:);
		elseif check_dominance(TOB{j-1}(i,:),TOB{j}(i,:)) == -1
            TOB{j}(i,:)=TOB{j}(i,:);
			TPO{j}(i,:)=TPO{j}(i,:);
		elseif check_dominance(TOB{j-1}(i,:),TOB{j}(i,:)) == 0
			c = unidrnd(2);
            if c==1
				TOB{j}(i,:)=TOB{j-1}(i,:);
                TPO{j}(i,:)=TPO{j-1}(i,:);
			else
				TOB{j}(i,:)=TOB{j}(i,:);
                TPO{j}(i,:)=TPO{j}(i,:);
            end
        end
	end
    PO(i,:) = TOB{t+1}(i,:);
	pbest(i,:) = TPO{t+1}(i,:);
end