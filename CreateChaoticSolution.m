

function chaotic_p=CreateChaoticSolution(pop,vars_dim )

     %sum_dim = sum(vars_dim);
     X_tmp=zeros(pop,vars_dim); 
 for  i=1:pop  
     cxl = rand();
    for j=1:vars_dim  
       if cxl==0
            cxl=0.1;
        end
        if cxl==0.25
            cxl=0.26;
        end
        if cxl==0.5
            cxl=0.51;
        end
        if cxl==0.75
            cxl=0.76;
        end
        
        X_tmp(i,j) = cxl;
   
        cxl=4*cxl.*(1-cxl);   %The logic chaotic equation generates chaotic values
    end 
 end
 for i=1:pop
       mean_val = mean(X_tmp(i,:));
        for d=1:vars_dim 
            if X_tmp(i,d) > mean_val
                X_tmp(i,d)=1;
            else
                 X_tmp(i,d)=0; 
            end
        end
end
    chaotic_p = X_tmp;
    