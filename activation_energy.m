function E_A = activation_energy(x,y)
% Linear fit
R = 8.31446261815324;
fit = polyfit(x,y,1);
slope = fit(1);
E_A = -slope*R; % in kJ/mol
% Factor 1000 is to compensate 1000/T plot, but can be omitted to get
% kJ/mol
