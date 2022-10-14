function [P] = ExportParameters(x)

sigma_v00  = x(1) * 1.0e2;  % sigma_v_not_not

alpha_0(1) = x(2);          % alpha_not_w 
alpha_0(2) = x(3) * x(2);   % alpha_not_c 

rho_0(1) = x(4) * 1.0e+2;   % rho_hat_cm_not
rho_0(2) = x(5) * 1.0e+2;   % rho_hat_ci_not
rho_0(3) = x(6) * 1.0e+2;   % rho_hat_wi_not

c_0(1)  = x(7)  * 1.0e+2;   % c_gn_cm
c_0(2)  = x(8);             % c_an_cm_not
c_0(3)  = x(9);             % c_an_ci_not
c_0(4)  = x(10);            % c_an_wi_not
c_0(5)  = x(11);            % c_tr_cm_not
c_0(6)  = x(12) * 1.0e-3;   % c_nc_wi_not
c_0(7)  = x(13);            % c_ac_ci
c_0(8)  = x(14) * x(13);    % c_ac_wi
c_0(9)  = x(15);            % c_rm_ci_not
c_0(10) = x(16) * x(15);    % c_rm_wi_not

r_ma(1) = x(17);            % r_G_alpha_w
s_ma(1) = x(18);            % s_G_alpha_w
r_ma(2) = x(19);            % r_G_alpha_c
s_ma(2) = x(20);            % r_G_alpha_c

r_v = x(21);                
s_v = x(22);

r_c(1)  = 0.0;
s_c(1)  = 0.0;
r_c(2)  = x(23);            % r_an_cm
s_c(2)  = x(24);            % s_an_cm
r_c(3)  = x(25);            % r_an_ci
s_c(3)  = x(26);            % s_an_ci
r_c(4)  = x(27);            % r_an_wi
s_c(4)  = x(28);            % s_an_wi
r_c(5)  = x(29);            % r_tr_cm
s_c(5)  = x(30);            % s_tr_cm
r_c(6)  = x(31);            % r_nc_wi
s_c(6)  = x(32);            % s_nc_wi
r_c(7)  = 0.0;
s_c(7)  = 0.0;
r_c(8)  = 0.0;
s_c(8)  = 0.0;
r_c(9)  = x(33);            % r_rm_ci
s_c(9)  = x(34);            % s_rm_ci
r_c(10) = x(35);            % r_rm_wi
s_c(10) = x(36);            % s_rm_wi

m_c0(1) = 0.0;
m_c0(2) = x(37);            % m_an_cm_not
m_c0(3) = x(38);            % m_an_ci_not
m_c0(4) = x(39);            % m_an_wi_not
m_c0(5) = x(40);            % m_tr_cm_not
m_c0(6) = x(41);            % m_nc_wi_not
m_c0(7) = 0.0;              % m_ac_ci
m_c0(8) = 0.0;              % m_ac_wi
m_c0(9) = x(42);            % m_rm_ci_not
m_c0(10)= x(43);            % m_rm_wi_not

m_v0    = x(44);

r_c0(1) = 0.0;
r_c0(2) = x(45);            % r_an_cm_not
r_c0(3) = x(46);            % r_an_ci_not
r_c0(4) = x(47);            % r_an_wi_not
r_c0(5) = x(48);            % r_tr_cm_not
r_c0(6) = x(49);            % r_nc_wi_not
r_c0(7) = 0.0;              % r_ac_ci
r_c0(8) = 0.0;              % r_ac_wi
r_c0(9) = x(50);            % r_rm_ci_not
r_c0(10)= x(51);            % r_rm_wi_not

s_c0(1) = 0.0;
s_c0(2) = x(52);            % s_an_cm_not
s_c0(3) = x(53);            % s_an_ci_not
s_c0(4) = x(54);            % s_an_wi_not
s_c0(5) = x(55);            % s_tr_cm_not
s_c0(6) = x(56);            % s_nc_wi_not
s_c0(7) = 0.0;              % s_ac_ci
s_c0(8) = 0.0;              % s_ac_wi
s_c0(9) = x(57);            % s_rm_ci_not
s_c0(10)= x(58);            % s_rm_wi_not

r_v0    = x(59);
s_v0    = x(60);


P = [sigma_v00,alpha_0,rho_0,c_0,r_ma(1),s_ma(1),r_ma(2),s_ma(2),r_v,s_v, ...
    r_c(2),s_c(2),r_c(3),s_c(3),r_c(4),s_c(4),r_c(5),s_c(5),r_c(6),s_c(6), ...
    r_c(9),s_c(9),r_c(10),s_c(10),m_c0(2),m_c0(3),m_c0(4),m_c0(5),m_c0(6), ...
    m_c0(9),m_c0(10),m_v0,r_c0(2),r_c0(3),r_c0(4),r_c0(5),r_c0(6),r_c0(9), ...
    r_c0(10),s_c0(2),s_c0(3),s_c0(4),s_c0(5),s_c0(6),s_c0(9),s_c0(10),r_v0, ...
    s_v0];   


end



