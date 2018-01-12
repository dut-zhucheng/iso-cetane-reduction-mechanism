format short;

global w c1 c2 r1 r2 T  N n M; % set global constants
c1 = 2;         % assign the value of c1 (accelerate constant)
c2 = 2;         % assign the value of c2 (accelerate constant)
w = 0.4;        % assign the value of w (inertia weight)
% % c1 = 2;         % assign the value of c1 (accelerate constant)
% % c2 = 2;         % assign the value of c2 (accelerate constant)
% % w = 0.4;        % assign the value of w (inertia weight)
r1 = rand;      % assign the random value of r1
r2 = rand;      % assign the random value of r2

n = 2*2;         % the number of position dimension
M = 1;         % the number of objectives

N = 2;          % the number of pops
T = 2;         % assign the number of iteration

tic;

%==========================================================================
%initialize parameters
pop = -1+2*rand([N n]);  % initialize the pop

v = zeros(N,n);   % initialize the velocity
pbest = pop;

Obj = obj_value(pbest);  % N*m
EA = pop_ea(pop);

POP = cell(T+1,1);  % set POP as pop swarm
OBJ = cell(T+1,1);  % store the object funtion value into OBJ during 
PBest = cell(T+1,1);% store the pbest into PBest during iterations
PB_OBJ = cell(T+1,1);
COEF = cell(T+1,1);

POP{1} = pop;
OBJ{1} = Obj;
PBest{1} = pbest;
PB_OBJ{1} = Obj;
COEF{1} = EA;
REF = obj_ref();  

gbest=ini_gbest(pbest,Obj,N);

SG = zeros(T,n);
SO = zeros(T,M);
% FX = -inf;
% ==========================================================================
% 
% main iteration
figure;
for t = 1:T
    [pop,v] = update_pop(pop,v,pbest,gbest,w,r1,r2,c1,c2,N);
    pop = mutate_pop(pop,N,Obj,M,n);
    [pop,v] = variant_limit(pop,v,n,N);
    POP{t+1} = pop;

    Obj = obj_value(pop);
    COEF{t+1} = pop_ea(pop);
    OBJ{t+1} = Obj; 

    [pbest,PO] = update_pbest(OBJ,POP,t,N,pbest,M);
    PB_OBJ{t+1} = PO;
    PBest{t+1} = pbest;
    
    [single_gbest,gbest,single_gbestobj] = update_gbest(pbest,PO,N);
    
%     [gbest,I,FX] = update_gbest(PBest,Obj,REF,FX,t,N,M,T);   
%     [single_gbest,single_gbestobj,gbest] = arrup_gbest(PB_OBJ,gbest,I,N);

    SG(t,:) = single_gbest;
    SO(t,:) = single_gbestobj;
    
	TO = SO;
    for i = 2:t
        if check_dominance(TO(i-1,:),TO(i,:))==1
            TO(i,:) = TO(i-1,:);
        elseif check_dominance(TO(i-1,:),TO(i,:))==-1
            TO(i,:) = TO(i,:);
        elseif check_dominance(TO(i-1,:),TO(i,:))==0
            c = unidrnd(2);
            if c==1
                TO(i,:) = TO(i-1,:);
            else
                TO(i,:) = TO(i,:);
            end
        end
    end
    true_gbestobj = TO(t,:);
    
    semilogy(1:M,TO(t,:),'.');
    xlabel('ʵ���');
    ylabel('������ʵ���Ĳ�ֵ');
    hold on;
    
    
    fprintf('Progress %4s%%\n',num2str(roundn(t/T*100,-1)));
end

for t = 1:T+1
    for i = 1:N
        if check_dominance(REF,OBJ{t}(i,:)) == -1
            fprintf('����ռ�����ӣ�t=%3.0f    n=%3.0f\n',t,i);
            if sum(REF)>sum(OBJ{t}(i,:))
                fprintf('�߼�ռ������:t=%3.0f    n=%4.0f\n',t,i);
            end
        end
    end
end


    

semilogy(1:M,REF,'+');
hold on;
semilogy(1:M,single_gbestobj,':');


disp(['CPU time: ',num2str(toc)]);

save data;
%------------------------------------------------%
%                   �Զ��庯��                    %
%------------------------------------------------%
% tic;
% [~,~]=dos('D:\Chemkin work dir\iC8\ST0.25\ST0.25.bat');
% toc
% disp(['CPU time: ',num2str(toc)]);

%ɾ���ļ�����
% delete('D:\Chemkin work dir\singlepointtest\C8ST0.25\*.csv');

better_pop = [];
for t = 1:T+1
    for i = 1:N
        if check_dominance(REF,OBJ{t}(i,:)) == -1
            fprintf('����ռ�����ӣ�t=%3.0f    n=%3.0f\n',t,i);
            if sum(REF)>sum(OBJ{t}(i,:))
                fprintf('�߼�ռ������:t=%3.0f    n=%4.0f\n',t,i);
            end
            better_pop = [better_pop;POP{t}(i,:)];
        end
    end
end