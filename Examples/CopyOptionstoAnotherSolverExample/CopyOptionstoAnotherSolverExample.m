%% Copy Options to Another Solver  
% Transfer nondefault options for the |fmincon| solver to options for the
% |fminunc| solver.   

%% 
% Create nondefault options for the |fmincon| solver. 
oldoptions = optimoptions(@fmincon,'Algorithm','sqp','MaxIterations',1500)     

%% 
% Transfer the applicable options to the |fminunc| solver. 
options = optimoptions(@fminunc,oldoptions)      

