% ---------------------------------------------
 % initialize the gbest
 function gbest=ini_gbest(pbest,Obj,N)
 pbest0 = pbest;
 Tobj = Obj;
 for i = 2:N
     if check_dominance(Tobj(i-1),Tobj(i)) == 1
         Tobj(i)=Tobj(i-1);
         pbest0(i,:) = pbest(i-1,:);
     elseif check_dominance(Tobj(i-1),Tobj(i)) == -1
         Tobj(i)=Tobj(i);
         pbest0(i,:) = pbest(i,:);
     else
         c = unidrnd(2);
         if c == 1
             Tobj(i)=Tobj(i);
             pbest0(i,:) = pbest(i,:);
         else
             Tobj(i)=Tobj(i-1);
             pbest0(i,:) = pbest(i-1,:);
         end
     end
end
gbest = repmat(pbest0(N,:),N,1); 
end