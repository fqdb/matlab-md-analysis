%%
% Read all subfolders in 'folder':
% Add '\' if not present
cd 'E:\Nextcloud\20212022\Master Thesis'
folder = pwd;
files = dir(folder);
dirs = [files.isdir];
temps = files(dirs);  
% remove '.' and '..'
subfolder = temps(3:end);
for i = 1:length(subfolder)
    j(i) = startsWith(subfolder(i).name,'B');
end
subfolder = subfolder(logical(j));
%%
counter = 0;
for i = 1:length(subfolder)
    cd 'E:\Nextcloud\20212022\Master Thesis'
    cd(subfolder(i).name)
    files2 = dir(pwd);
    dirs = [files2.isdir];
    temps2 = files2(dirs);
    temps2 = temps2(3:end);
    for j = 1:length(temps2)
        if ~startsWith(temps2(j).name,'.')
            cd(temps2(j).name)
        end
        if exist([pwd, '/simulation_data.mat'], 'file')
            load('simulation_data.mat');
            if ~isfield(sim_data,'tracer_diffusion_error')
                a = pwd;
                cd('E:\Nextcloud\20212022\Master Thesis\matlab-md-analysis')
                [sim_data.tracer_diffusion, sim_data.tracer_diffusion_error, ...
                sim_data.tracer_conductivity, sim_data.tracer_conductivity_error, ...
                sim_data.particle_density, sim_data.mol_per_liter] ...
                = tracer_properties(sim_data);
                cd(a)
                display(pwd)
                save('simulation_data','sim_data');
                counter = counter + 1;
            end
        end
        cd ../
    end
end
cd 'E:\Nextcloud\20212022\Master Thesis\matlab-md-analysis'
fprintf('\nProcessesed %d folders\n',counter')
