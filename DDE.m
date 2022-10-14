%=========================================================================
%                          Warm Material Model
%                     Dislocation Density Evolution
%                 Written by: SeyedAmirHossein Motaman
%                       Last modified: 09.06.2018
%=========================================================================

function [rho,del_rho] = DDE(M,delta_eps_p,c,rho)

del_rho_mgn = M * c(1)  * rho(1) / sqrt(rho(2) + rho(3));
del_rho_man = M * c(2)  * rho(1) * rho(1);
del_rho_ian = M * c(3)  * rho(2) * rho(1);
del_rho_wan = M * c(4)  * rho(3) * rho(1);
del_rho_mpn = M * c(5)  * sqrt(rho(1)) * rho(1);
del_rho_ipn = M * c(6)  * sqrt(rho(2)) * rho(2) * rho(1);
del_rho_iac = M * c(7)  * sqrt(rho(2)) * rho(1);
del_rho_wac = M * c(8)  * sqrt(rho(3)) * rho(1);
del_rho_irm = M * c(9)  * rho(2);
del_rho_wrm = M * c(10) * rho(3);

del_rho_cm = del_rho_mgn + del_rho_irm + del_rho_wrm ...
           - ((2*del_rho_man) + del_rho_ian + del_rho_wan ...
           + del_rho_mpn + del_rho_iac + del_rho_wac);
del_rho_ci = del_rho_mpn + del_rho_iac ...
           - (del_rho_ian + del_rho_irm + del_rho_ipn);
del_rho_wi = del_rho_ipn + del_rho_wac ...
           - (del_rho_wan + del_rho_wrm);

del_rho(1) = del_rho_cm;
del_rho(2) = del_rho_ci;
del_rho(3) = del_rho_wi;

rho(1) = rho(1) + delta_eps_p * del_rho_cm;
rho(2) = rho(2) + delta_eps_p * del_rho_ci;
rho(3) = rho(3) + delta_eps_p * del_rho_wi;

end