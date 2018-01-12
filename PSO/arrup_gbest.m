function [single_gbest,single_gbestobj,gbest] = arrup_gbest(PB_OBJ,gbest,I,N)
gbest_obj = PB_OBJ{I};
for i = 2:N
	if check_dominance(gbest_obj(i-1,:),gbest_obj(i,:)) == 1
        gbest_obj(i,:)=gbest_obj(i-1,:);
        gbest(i,:) = gbest(i-1,:);
	elseif check_dominance(gbest_obj(i-1,:),gbest_obj(i,:)) == -1
            gbest_obj(i,:)=gbest_obj(i,:);
            gbest(i,:) = gbest(i,:);
	else
        c = unidrnd(2);
        if c == 1
            gbest_obj(i,:)=gbest_obj(i-1,:);
            gbest(i,:) = gbest(i-1,:);
        else
            gbest_obj(i,:)=gbest_obj(i,:);
            gbest(i,:) = gbest(i,:);
        end
	end
end
single_gbestobj = gbest_obj(N,:);
single_gbest = gbest(N,:);
gbest = repmat(single_gbest,N,1);
end