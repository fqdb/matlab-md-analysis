function [tracer_diff, tracer_diff_error, tracer_conduc, tracer_conduc_error, particle_density, mol_per_liter] = ... 
    tracer_properties(sim_data)
% Calculate the diffusion and conductivity based on the displacement
% For calculating the diffusion:
    ang2m = 1E-10; %converts Angstroms to meters
    dimensions = sim_data.diffusion_dim;
    z_ion = sim_data.ion_charge;
    
    disp('-------------------------------------------')
    disp('Calculating tracer diffusion and conductivity based on:')
    fprintf('%f dimensional diffusion, and an ion with a charge of %f \n', dimensions, z_ion)

    % The particle density (in particles/m^3)    
    particle_density = sim_data.nr_diffusing/sim_data.volume; %in particles/(m^3)
    % Concentration of diffusing atom in mol/L (1000 converts from m^3 to liters)
    mol_per_liter = particle_density/(1000*sim_data.avogadro);
    
    % Mean Squared Displacement:        
    displacement = sim_data.displacement(sim_data.start_diff_elem:sim_data.end_diff_elem, sim_data.nr_steps);
    msd = mean(displacement.^2); % In Angstrom^2

    % Diffusivity = MSD/(2*dimensions*time)
    tracer_diff = (msd * ang2m^2)/(2*dimensions*sim_data.total_time); % In m^2/sec

    % Conductivity = elementary_charge^2 * charge_ion^2 * diffusivity * particle_density / (k_B * T)
    tracer_conduc = ((sim_data.e_charge^2) * (z_ion^2) * tracer_diff * particle_density)/ ...
        (sim_data.k_boltzmann*sim_data.temperature); % In Siemens/meter

    fprintf('Tracer diffusivity determined to be (in meter^2/sec): %d \n', tracer_diff)
    fprintf('Tracer conductivity determined to be (in Siemens/meter): %d \n', tracer_conduc)
    disp('-------------------------------------------')
    
    % Calculate standard deviation for 10 parts
    length_data = length(sim_data.displacement);
    for i = 1:10
        index = round(linspace(1,length_data,11));
        disp_part = sim_data.displacement(:,index(i):index(i+1));
        % Set 0 displacement from start of each part
        disp_part = disp_part - disp_part(:,1);
        std(sim_data.displacement,0,2)
        msd = mean(mean(disp_part.^2));
        tracer_diff_part(i) = (msd * ang2m^2)/(2*dimensions*sim_data.total_time);
        tracer_conduc_part(i) = ((sim_data.e_charge^2) * (z_ion^2) * tracer_diff * particle_density)/ ...
        (sim_data.k_boltzmann*sim_data.temperature);
    end
    tracer_diff_error = std(tracer_diff_part);
    tracer_conduc_error = std(tracer_conduc_part);
end