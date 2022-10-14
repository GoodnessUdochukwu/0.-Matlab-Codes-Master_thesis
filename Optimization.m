%=========================================================================
%                          Warm Material Model
%                              Optimization
%                 Modified by: Goodness Udochukwu Okoh
%                               based on original work 
%                                       by
%                              SeyedAmirHossein Motaman
%
%                             Last modified: 09.07.2021
%=========================================================================

tic

% format long;

%-------------------------------------------------------------------------
% Constants
%-------------------------------------------------------------------------
%delta_eps_p = 0.001;

props(1) = 25.0;     % T_0 [C]
props(2) = -273.15;  % T_abs0 [C]
props(3) = 1.0e12;   % rho_0 [m^-2]
props(4) = 8.15e4;   % mu_0 [MPa]
props(5) = 3.16;      % M [-]
props(6) = 2.55e-10; % b [m]

%-------------------------------------------------------------------------
% Initial set of parameters and bounds
%-------------------------------------------------------------------------
%           sigma_v00 alpha_w0 alpha_c0 rho_cm0  rho_ci0   rho_wi0
sigma_0  = [1.5,       0.60,    0.40,    0.05,    0.05,     1.80 ];
sigma_lb = [0.2,       0.30,    0.10,    0.001,   0.001,   1.7192];
sigma_ub = [3.5,       1.00,    0.50,     2.0,     2.0,      5.0 ];
%            1           2        3        4        5          6

%         c_mgn  c_man_0 c_ian_0 c_wan_0 c_mtr_0 c_wnc_0 c_iac  c_wac c_irm_0 c_wrm_0
c_0    = [5.00,   0.10,   0.10,   0.10,   1.00,   1.00,  1.00,   0.50,  1.00,  0.50 ];
c_lb   = [0.10,   0.001,  0.001,  0.001,  0.001,   0.1,  0.001,  0.10,  0.001, 0.10 ];
c_ub   = [30.0,   10.0,   10.0,   10.0,   10.0,   10.0,   10.0,  10.0,  10.0,  10.0 ];
%           7       8       9      10      11      12      13     14     15     16
 
%         r_gaw s_gaw r_gac s_gac  r_v   s_v
rsa_0  = [1.5,   2.5,  1.0,  2.5,  1.0,  1.5];
rsa_lb = [-10,   -10,  -10,  -10,  -10,  -10];
rsa_ub = [ 10,    10,   10,   10,   10,   10];
%          17     18    19    20    21    22

%         r_man s_man r_ian s_ian r_wan s_wan r_mtr s_mtr r_wnc s_wnc r_irm s_irm r_wrm s_wrm
rsc_0  = [2.0,   1.5,  1.0,  1.5,  1.0,  1.5,  1.0,  1.5,  1.0,  1.5,  1.0,  1.5,  1.0,  1.5];
rsc_lb = [-10,   -10,  -10,  -10,  -10,  -10,  -10,  -10,  -10,  -10,  -10,  -10,  -10,  -10];
rsc_ub = [ 10,    10,   10,   10,   10,   10,   10,   10,   10,   10,   10,   10,   10,   10];
%          23     24    25    26    27    28    29    30    31    32    33    34    35    36

%         m_man  m_ian  m_wan  m_mtr   m_wnc   m_irm  m_wrm
m_c0   = [0.01,  0.10,  0.10,  0.10,   0.10,   0.10,  0.10 ];
m_c_lb = [0.001, 0.001, 0.001, 0.001,  0.001,  0.001, 0.001];    
m_c_ub = [ 0.5,   0.5,   0.5,   0.5,    0.5,    0.5,   0.5 ];
%          37     38     39     40      41      42     43


m_v0   = 0.02;
m_v_lb = 0.001;
m_v_ub = 0.1;
%        44

%         r_man  r_ian  r_wan  r_mtr   r_wnc   r_irm  r_wrm
r_c0   = [1.0,    1.5,   1.5,   1.5,    2.0,    1.5,   1.0];
r_c_lb = [-10,    -10,   -10,   -10,    -10,    -10,   -10];
r_c_ub = [ 10,     10,    10,    10,     10,     10,    10];
%          45      46     47     48      49      50     51

%         s_man  s_ian  s_wan  s_mtr   s_wnc   s_irm  s_wrm
s_c0   = [1.0,    1.5,   1.0,   1.5,    2.0,    1.5,   1.5];
s_c_lb = [-10,    -10,   -10,   -10,    -10,    -10,   -10];
s_c_ub = [ 10,     10,    10,    10,     10,     10,    10];
%          52      53     54     55      56      57     58

%
rs_v0  = [1.0,    2.0];
rsv_lb = [-10,    -10];
rsv_ub = [ 10,     10];
%          59      60


x_0   = cat(2,sigma_0 ,c_0 ,rsa_0 ,rsc_0,m_c0,m_v0,r_c0,s_c0,rs_v0);
x_lb  = cat(2,sigma_lb,c_lb,rsa_lb,rsc_lb,m_c_lb,m_v_lb,r_c_lb,s_c_lb,rsv_lb);
x_ub  = cat(2,sigma_ub,c_ub,rsa_ub,rsc_ub,m_c_ub,m_v_ub,r_c_ub,s_c_ub,rsv_ub);

%-------------------------------------------------------------------------
% Submition of problem to optimization solver
%-------------------------------------------------------------------------
% options = optimoptions(@fmincon,'Algorithm','interior-point',...
%                        'MaxIterations',7500,'MaxFunctionEvaluations',250000,...
%                        'FunctionTolerance',5.0e-5,'StepTolerance',1.0e-6,...
%                        'FiniteDifferenceType','central',...
%                        'UseParallel',true,'PlotFcn',@optimplotfval);
options = optimoptions(@fmincon,'Algorithm','interior-point', ...
                       'MaxIterations',10000,'MaxFunctionEvaluations',200000, ...
                       'FunctionTolerance',1.0e-5,'StepTolerance',1.0e-6, ...
                       'UseParallel',true,'PlotFcn',@optimplotfval);

R = @(x)Error(x,props,fc);

problem = createOptimProblem('fmincon','options',options, ...
                             'objective',R,'x0',x_0,'lb',x_lb,'ub',x_ub);

gs = GlobalSearch('NumTrialPoints',20000, ...
                  'Display','iter','PlotFcn',@gsplotbestf);

[x,error,ouput,solutions,allmins] = run(gs,problem)

% [x,fval,exitflag,output] = fmincon(R,x_0,[],[],[],[],x_lb,x_ub,[],options)

% options = optimoptions(@ga,'HybridFcn',@fmincon, ...
%                        'MaxGenerations',10000,'FunctionTolerance',1.0e-6, ...
%                        'UseParallel',true,'UseVectorized',false);
% [x,fval,exitflag,output] = ga(R,36,[],[],[],[],x_lb,x_ub,[],options)

%-------------------------------------------------------------------------
% Printing the results on screen
%-------------------------------------------------------------------------
%[sigma_v00,alpha_0,rho_0,c_0,r_ma,s_ma,r_v,s_v,r_c,s_c] = Parameters(x)

toc