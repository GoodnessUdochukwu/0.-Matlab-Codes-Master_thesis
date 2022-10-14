%=========================================================================
%                          Warm Material Model
%                    Error Function for Flow Curves
%                 Written by: Goodness Udochukwu Okoh
%                              based on original work 
%                                       by 
%                               SeyedAmirHossein Motaman
%                       Last modified: 14.06.2021
%=========================================================================

function [SigmaStrainRate,error,error_fc] = PlotResult(u,fc)

%-------------------------------------------------------------------------
% Constants
%-------------------------------------------------------------------------
T_0    = 25.0;     % T_0 [C]
T_abs0 = -273.15;  % T_abs0 [C]
rho0   = 1.0e12;   % rho_0 [m^-2]
mu_0   = 8.15e4;   % mu_0 [MPa]
M      = 3.16;     % M [-]
b      = 2.55e-10; % b [m]

%-------------------------------------------------------------------------
% Material parameters
%-------------------------------------------------------------------------
[sigma_v00,alpha_0,rho_0,c_0,r_ma, ...
    s_ma,r_v,s_v,r_c,s_c,m_c0,m_v0,r_c0,s_c0,r_v0,s_v0] = ParametersPlot(u);

%-------------------------------------------------------------------------
% Calulcation of mean error for flow curves
%-------------------------------------------------------------------------
n_fc = numel(fc);
error_fc = zeros(n_fc,1);
Sigma_v = zeros(n_fc,1);
C_an_cm = zeros(n_fc,1);
C_an_ci = zeros(n_fc,1);
C_an_wi = zeros(n_fc,1);
C_tr_cm = zeros(n_fc,1);
C_nc_wi = zeros(n_fc,1);
C_rm_ci = zeros(n_fc,1);
C_rm_wi = zeros(n_fc,1);
M_v = zeros(n_fc,1);
mu_alpha_w = zeros(n_fc,1);
mu_alpha_c = zeros(n_fc,1);



for i = 1:n_fc
    N = fc(i).n;
    T = fc(i).T;
   %w(i) = fc(i).w;
    eps = fc(i).e;
    
    
    [c,mu_alpha,sigma_v,m_v] = TS(T,T_0,T_abs0,eps,c_0,mu_0,alpha_0, ...
                              sigma_v00,r_c,s_c,r_ma,s_ma,r_v, ...
                              s_v,m_c0,m_v0,r_c0,s_c0,r_v0,s_v0);
    
    C_an_cm(i) = c(2);
    C_an_ci(i) = c(3);
    C_an_wi(i) = c(4);
    C_tr_cm(i) = c(5);
    C_nc_wi(i) = c(6);
    C_rm_ci(i) = c(9);
    C_rm_wi(i) = c(10);
    M_v(i) = m_v;
    mu_alpha_w(i) = mu_alpha(1);
    mu_alpha_c(i) = mu_alpha(2);
    Sigma_v(i) = sigma_v;                      
    rho = rho_0;
    delta_eps_p = fc(i).delta_exp;
    sigmay_num = zeros(N,1);
    rhocm = zeros(N,1);
    rhoci = zeros(N,1);
    rhowi = zeros(N,1);
    rhot = zeros(N,1);
    del_rhocm = zeros(N,1);
    del_rhoci = zeros(N,1);
    del_rhowi = zeros(N,1);
    sigmay_pc = zeros(N,1);
    sigmay_pw = zeros(N,1);
    
    for j = 1:N
        
        sigma_pc = M * b * mu_alpha(2) * sqrt(rho0 * rho(2));
        sigma_pw = M * b * mu_alpha(1) * sqrt(rho0 * rho(3));
        sigma_p = sigma_pc + sigma_pw;
        
        sigmay_pc(j) = sigma_pc;
        sigmay_pw(j) = sigma_pw;
        sigmay_num(j) = sigma_v + sigma_p;
        
        [rho,del_rho] = DDE(M,delta_eps_p(j),c,rho);
        
        rhocm(j) = rho(1);
        rhoci(j) = rho(2);
        rhowi(j) = rho(3);
        rhot(j) = rhocm(j) + rhoci(j) + rhowi(j);
        del_rhocm(j) = del_rho(1);
        del_rhoci(j) = del_rho(2);
        del_rhowi(j) = del_rho(3);
                       
    end
    
    SigmaStrainRate(i).Sigma = sigmay_num;
    SigmaStrainRate(i).Sigmay_pc = sigmay_pc;
    SigmaStrainRate(i).Sigmay_pw = sigmay_pw;
    
    SigmaStrainRate(i).Rhocm = [rho_0(1);rhocm(1:N-1)];
    SigmaStrainRate(i).Rhoci = [rho_0(2);rhoci(1:N-1)];
    SigmaStrainRate(i).Rhowi = [rho_0(3);rhowi(1:N-1)];
    SigmaStrainRate(i).Rhot = [sum(rho_0);rhot(1:N-1)];
    
    SigmaStrainRate(i).Del_rhocm = del_rhocm;
    SigmaStrainRate(i).Del_rhoci = del_rhoci;
    SigmaStrainRate(i).Del_rhowi = del_rhowi;
    
    SigmaStrainRate(i).strhard_cell = ((SigmaStrainRate(i).Del_rhoci .* ...
                                SigmaStrainRate(i).Sigmay_pc)...
                                        ./(2 .* SigmaStrainRate(i).Rhoci));
                                    
    SigmaStrainRate(i).strhard_wall = ((SigmaStrainRate(i).Del_rhowi .* ...
                                SigmaStrainRate(i).Sigmay_pw)...
                                        ./(2 .* SigmaStrainRate(i).Rhowi));
    
    SigmaStrainRate(i).theta = SigmaStrainRate(i).strhard_cell + ...
                               SigmaStrainRate(i).strhard_wall;
      
    
    SigmaStrainRate(i).c_an_cm = C_an_cm;
    SigmaStrainRate(i).c_an_ci = C_an_ci;
    SigmaStrainRate(i).c_an_wi = C_an_wi;
    SigmaStrainRate(i).c_tr_cm = C_tr_cm;
    SigmaStrainRate(i).c_nc_wi = C_nc_wi;
    SigmaStrainRate(i).c_rm_ci = C_rm_ci;
    SigmaStrainRate(i).c_rm_wi = C_rm_wi;
    SigmaStrainRate(i).m_v = M_v;
    SigmaStrainRate(i).mu_alpha_w = mu_alpha_w;
    SigmaStrainRate(i).mu_alpha_c = mu_alpha_c;
    SigmaStrainRate(i).sigma_v = Sigma_v;
    
    error_fc(i) = sum(abs(fc(i).sigmay_exp(1:N) - sigmay_num) ...
             ./ fc(i).sigmay_exp(1:N)) / N;
         
end

    error = sum(error_fc);
    
end