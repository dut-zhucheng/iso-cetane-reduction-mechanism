% %全局最优更新
% function [gbest,I,FX] = update_gbest(PBest,Obj,REF,FX,t,N,M,T)
% dxj = zeros();
% for m = 1:N
%     dxj(m) = crowd_distance(Obj,m,M,N); % 1*N
% end
% dx = crowd_avg_distance(dxj,N);        % value
% FdX = distribution_measure(dx,dxj,N);    % value
% FhX = hypervolume_measure(Obj,REF,M,N);    % value
% alpha = factor_weight(t,T);
% FX = [FX,func_weight(alpha,FdX,FhX)];    % value
% [~,I] = max(FX);                       % FX: 1*T
% gbest = PBest{I};                      % N*n
% 
% %拥挤距离
% function dxj = crowd_distance(Obj,j,M,N)
% Dis = zeros();
% for i = 1:M
%     D = [];
%     for l = 1:N
%         d = abs(Obj(j,i)-Obj(l,i));
%         D = [D,d];
%     end
%     Dis(i) = sum(D);
% end
% dxj = min(Dis);
% end 
% 
% %平均拥挤距离
% function dx = crowd_avg_distance(dxj,N)
% DX = 0;
% for i = 1:N
%     DX = DX + dxj(i);
% end
% dx = DX/N;
% end
% 
% %平均分布测度
% function FdX = distribution_measure(dx,dxj,N)
% fdx = 0;
% for i = 1:N
%     fdx = fdx + (dx-dxj(i))/(N-1);
% end
% FdX = sqrt(abs(fdx));
% end
% 
% %超体测度【待修改】
% function FhX = hypervolume_measure(Obj,REF,M,N)
% fhx = zeros(N,1);
% for j = 1:N
%     for i = 1:M
%         if REF(i) > Obj(j,i)
%             fhx(j) = fhx(j) + REF(i)-Obj(j,i);
%         end
%     end   
% end
% FhX = prod(fhx);
% end
% 
% %加权函数
% function FX = func_weight(alpha,FdX,FhX)
% FX = alpha*FhX + (1-alpha)*FdX;
% end
% 
% %加权系数
% function alpha = factor_weight(t,T)
% alpha = exp((-0.5*T*log10(2))/(T-t));
% end
% end




function [single_gbest,gbest,single_gbestobj] = update_gbest(pbest,PO,N)
TPO = PO;
tpbest = pbest;
for i = 2:N
    if check_dominance(TPO(i-1,:),TPO(i,:)) == 1
        TPO(i,:)=TPO(i-1,:);
        tpbest(i,:)=tpbest(i-1,:);
    elseif check_dominance(TPO(i-1,:),TPO(i,:)) == -1
        TPO(i,:)=TPO(i,:);
        tpbest(i,:)=tpbest(i,:);
    else
        c = unidrnd(2);
        if c==1
            TPO(i,:)=TPO(i-1,:);
            tpbest(i,:)=tpbest(i-1,:);
        else
            TPO(i,:)=TPO(i,:);
            tpbest(i,:)=tpbest(i,:);
        end
    end      
end
single_gbest = tpbest(N,:);
single_gbestobj = TPO(N,:);
gbest = repmat(single_gbest,N,1);
end