%=========================================================================
%                          Warm Material Model
%             Importing Experimental Data from Excel Sheets
%                 Written by: SeyedAmirHossein Motaman
%                                   modified by
%                              Goodness Udochukwu Okoh
%                       Last modified: 09.06.2021
%=========================================================================

tic

ef_file = 'Experimental_FlowCurve.xlsx';
[status,sheets] = xlsfinfo(ef_file);
n_fc = numel(sheets);
for i = 1:n_fc
    fc(i).sigmay_exp = xlsread(ef_file,i,'A:A');
    fc(i).eps_exp    = xlsread(ef_file,i,'B:B');
    fc(i).delta_exp  = xlsread(ef_file,i,'C:C');
    fc(i).T          = xlsread(ef_file,i,'E1');
    fc(i).e          = xlsread(ef_file,i,'F1');
   %fc(i).w          = xlsread(ef_file,i,'E2');
    fc(i).n          = size(fc(i).sigmay_exp,1);
end

toc
