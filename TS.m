%=========================================================================
%                          Warm Material Model
%            Temperature Dependence of Material Parameters
%                 Written by: Goodness Udochukwu Okoh
%                             based on the original work 
%                                       by
%                               SeyedAmirHossein Motaman
%                       Last modified: 21.06.2021
%=========================================================================

function [c,mu_alpha,sigma_v,m_v] = TS(T,T_0,T_abs0,eps,c_0,mu_0,alpha_0,sigma_v00, ...
                                   r_c,s_c,r_ma,s_ma,r_v,s_v,m_c0,m_v0,r_c0, ...
                                   s_c0,r_v0,s_v0)

T_hat = (T - T_0) / (T_0 - T_abs0);

e_p = eps/0.0001;

m_c = m_c0 .* (1 + r_c0 .* (T_hat.^s_c0));

m_v = m_v0 .* (1 + r_v0 .* (T_hat.^s_v0));

c = c_0 .* (1.0 + r_c .* (T_hat.^s_c)) .* (e_p.^m_c);

mu_alpha = mu_0 * alpha_0 .* (1.0 - r_ma .* (T_hat.^s_ma));

sigma_v = sigma_v00 * (1.0 - r_v * T_hat^s_v) .* (e_p.^m_v);

end