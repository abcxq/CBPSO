%Chaotic Binary Particle Swarm Optimization
%by Ying Xiong  and Qi Xiong
function [BestX,BestF,PSOCurve] = CBPSOxq(pop,dim,fobj,MaxIter,Vmax,Vmin)
%% Parameter setting
w = 0.9;       
c1 = 2;        
c2 = 2;       
%Binary initialization particle swarm population
rand('state',sum(100*clock));    % Reset random number generator status
X = zeros(pop,dim);

X = CreateChaoticSolution(pop,dim);
%Initialization speed
for i = 1:pop
   V(i,:) = (Vmax-Vmin).*rand(1,dim)+Vmin; 
end
%Calculate fitness value
for i = 1:pop
fitness(i) = fobj(X(i,:));
end
[BestF,index] = max(fitness);
BestX = X(index,:);
PbestX = X;
PbestFit = fitness;


for t = 1:MaxIter
   for i = 1:pop
       V(i,:) =  w*V(i,:) + c1*rand*(PbestX(i,:) - X(i,:)) + c2*rand*(BestX - X(i,:));
       %compute sigmoid
       for j = 1:dim
            if V(i,j)>Vmax
                SigV(i,j)=0.98;
                V(i,j) = Vmax;
            elseif V(i,j)<Vmin
                 SigV(i,j)=-0.98;
                 V(i,j) = Vmin;
            else
               SigV(i,j) = 1/(1+exp(-V(i,j)));
            end   
       end
       %Update Location
       for j = 1:dim
            if rand<SigV(i,j)
                X(i,j)= 1;
            else
                X(i,j)= 0;
            end
       end
   end
   for i = 1:pop
        fitness(i) = fobj(X(i,:));
        if fitness(i)>PbestFit(i)
            PbestFit(i) = fitness(i);
            PbestX(i,:) = X(i,:);
        end
        if fitness(i)>BestF
            BestF = fitness(i);
            BestX = X(i,:);
        end
   end  
   chaotic_sol = CreateChaoticSolution(10,dim);%Generate 10 chaotic random initial numbers

   for it=1:10
       chaotic_sol(it,:) = bitand(BestX,chaotic_sol(it,:));
         chao_fit = fobj(chaotic_sol(it,:)); 
         % Gbest update Eq(5)
        if chao_fit > BestF
            BestF = chao_fit;
            BestX = chaotic_sol(it,:);
        end
   end
   PSOCurve(t) = BestF;    
end
 
end