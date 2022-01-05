function compare_sims(folder)
% Compare the results (per property) from several different foldes and temperatures
% Combine upfolder, subs and temps to loop over all folders
% The results are saved in 'compare_file', from which the plots are made
    
    close all

    % Read all subfolders in 'folder':
    % Add '\' if not present
    if folder(end)~= '\'
        folder = strcat(folder,'\');
    end
    files = dir(folder);
    dirs = [files.isdir];
    temps = files(dirs);  
    % remove '.' and '..'
    subfolder = temps(3:end);
   
    compare_file = [folder, '/sims_compare.mat'];
    % Load or construct the comparison file:
    if ~exist(compare_file, 'file')
        disp('sims_compare.mat not found, reading the data from other files')
        sims_comp = read_in_sims(folder, subfolder);
        save(compare_file, 'sims_comp')
    else
        disp('sims_compare found')
        load(compare_file);
    end
  
    %Plot the results in the compare_file:
    plot_comparison(sims_comp,folder) 
end

function plot_comparison(sims_comp,folder)
% Plots all the properties from props_to_plot vs. temperature for the
% simulations given in sims_comp

    %Properties with 1 value per simulation:
    props_to_plot = {'vibration_amp', 'attempt_freq',  ...
        'tracer_diffusion', 'tracer_conductivity', ...  
        'total_occup', 'frac_collective' , 'jump_diffusion', 'correlation_factor'};
    titles_of_plots = {'Vibration amplitude (Angstrom)', 'Attempt frequency (Hz)',  ...
       'Tracer diffusivity (m^2/sec)', 'Tracer conductivity (S/m)',...   
       'Known site occupation (%)', 'Collective jumps (%)', ...
       'Jump diffusivity (m^2/sec)', 'Correlation factor'};
    ylabels_of_plots = titles_of_plots;
    ylabels_of_plots{3} = 'ln(Tracer diffusivity) (m^2/sec)';
    ylabels_of_plots{4} = 'ln(\sigma) (S/cm)';
   % Properties with a value per type of jump: 
    multi_props_to_plot  = {'e_act', 'rates'};
    multi_titles_of_plots = {'Activation energy (eV)', 'Jump rate (Hz)'};
   
%     linestyles = {'-o', '-^', '-*', '-p', '-+', '-d', '-v', '-<', '->'};
    linestyles = {'o', '^', '*', 'p', '+', 'd', 'v', '<', '>'};
    pointstyles = {'+', 'o', '*', '+', 'o', '*', '+', 'o', '*', '+', 'o', '*', '+', 'o', '*', '+', 'o', '*', '+', 'o', '*', '+', 'o', '*', '+', 'o', '*', '+', 'o', '*', '+', 'o', '*', '+', 'o', '*', '+', 'o', '*', '+'};
%     Gather sim names and clean them up for plotting
%   Recommended format: e.g. /BiF3/BiF3_T0700K/simulation_data.mat
    sims = fieldnames(sims_comp);
    all_names = sims;
    % To find the same names to plot them with a line between them:
    for i = 1:numel(all_names)
        temp_name = split(all_names{i},'_T');
        names(i) = string(temp_name{1});
        names(i) = strrep(names(i),'sim_','');
        display_names(i) = format_names(names(i));
    end
    names2 = unique(names);
    display_names = unique(display_names);
    %% Plot properties with 1 value per simulation versus Temperature
    for a = 1:numel(props_to_plot)
        plot_window{a} = figure();
        hold on
        % Labels:
        xlabel('1/Temperature (1000/K)')
        ylabel(ylabels_of_plots{a})
%         title(append(strrep(sims_comp.(sims{1}).material,'_',' '),': ',titles_of_plots{a}))
        for i = 1:numel(names2)
            counter = 1;
            temp_x = 0;
            temp_y = 0;
            temp_z = 0;
            for j = 1:numel(all_names)
                if strcmp(names2(i), names{j}) %check for same names
                    temp_x(counter) = 1000./sims_comp.(sims{j}).temperature;
                    temp_y(counter) = sims_comp.(sims{j}).(props_to_plot{a});
                    if strcmp(props_to_plot{a},'tracer_diffusion')
                        temp_z(counter) = sims_comp.(sims{j}).tracer_diffusion_error;
                    end
                    if strcmp(props_to_plot{a},'tracer_conductivity')
                        temp_y(counter) = sims_comp.(sims{j}).(props_to_plot{a})/100;
                        temp_z(counter) = sims_comp.(sims{j}).tracer_conductivity_error;
                    end
                    counter = counter + 1;
                end
            end
            if strcmp(props_to_plot{a},'tracer_conductivity')
                R = 8.31446261815324;
                E_A(i) = activation_energy(temp_x,log(temp_y));
                fit{i} = polyfit(temp_x,log(temp_y),1);
                model = fitlm(temp_x,log(temp_y));
                fit_error(i) = model.RMSE/4;
%                 fit_error(i) = sum(log(temp_z)./2)*(2/length(temp_z));
                x_values{i} = temp_x;
                errorbar(temp_x, log(temp_y), log(temp_z)./2, linestyles{i}, 'LineWidth', 1.0, 'MarkerSize', 10.0)
            elseif strcmp(props_to_plot{a},'tracer_diffusion')             
                errorbar(temp_x, log(temp_y), log(temp_z)./2, linestyles{i}, 'LineWidth', 1.0, 'MarkerSize', 10.0)
            else
                plot(temp_x, temp_y, linestyles{i}, 'LineWidth', 2.0, 'MarkerSize', 10.0)
            end
        end       
        legend(display_names,'Location','eastoutside')
        % Log-scale is better in some cases:
        if strcmp(props_to_plot{a}, 'jump_diffusion')    
            set(gca, 'YScale', 'log')
        end
        grid on
        box on
        hold off
    end
    % Plot activation energy and save
    figure(plot_window{4})
    hold on
    % Reset colors to plot fitlines in same color
    set(gca,'ColorOrderIndex',1)
    for i = 1:numel(unique(names))
%         x_values{i} = [x_values{i} 1000/293]; % Optionally fit to RT
        plot(x_values{i},fit{i}(1).*x_values{i} + fit{i}(2),'LineWidth',2)
        legend([strings(1,length(display_names)),display_names])
        sigma_at_RT(i) = exp(fit{i}(1).*(1000/298) + fit{i}(2));
    end
    sigma_at_RT = {unique(names);sigma_at_RT};
    writetable(cell2table(sigma_at_RT),'Conductivity_at_RT.csv')
    box on
    hold off
    % Save figure as PDF
    foldername = split(folder,'\');
    save_as_pdf(foldername{end-1},800,400);
    figure
    hold on
    clr = get(gca,'colororder');
    clr = clr(1:length(E_A),:);
    E_A = E_A/96.4869; % Convert to from kJ/mol to eV
    b = bar(categorical(unique(display_names)),E_A,'facecolor', 'flat');
    b.CData = clr;
    ylabel('Activation energy (eV)');
    er = errorbar(categorical(unique(display_names)),E_A,fit_error);
    er.Color = [0 0 0];                            
    er.LineStyle = 'none';  
    hold off
    E_A = {unique(names),E_A};
    E_A_file = [folder, '\activation_energy.mat'];
    save(E_A_file, 'E_A');
    save_as_pdf(strcat(foldername{end-1},'_activation_energy'),400,350);
    %% Properties with a value per type of jump, plot versus jump name 
    for a = 1:numel(multi_props_to_plot)
        clear temp
        figure()
        ax = gca;
        hold on
        ylabel(multi_titles_of_plots{a})
%         title(sims_comp.(sims{1}).material);
        x2 = {};
        for i = 1:numel(sims)
            x = split(all_names{i},'_T');
            if strcmp(x{end},'1500K')
                x2{end+1} = all_names{i};
                temp_x = [1:1:numel(sims_comp.(sims{i}).jump_names)];
                temp_y = sims_comp.(sims{i}).(multi_props_to_plot{a})(:,1)';
                temp_y(temp_y == 0) = NaN;
                plot(temp_x, temp_y, pointstyles{i}, 'LineWidth', 2.0, 'MarkerSize', 10.0)
            end
        end       
        %legend(subs.name)
        ax.XTick = temp_x; 
        % !! Assuming the same jump names in all simulations being compared !!
        ax.XTickLabels = strrep(sims_comp.(sims{1}).jump_names,'_',' ');
        ax.XTickLabelRotation = 90;
        for i = 1:numel(x2)
            temp{i} = x2{i};
            temp{i} = format_names(temp{i});
        end
        legend(temp,'Location','eastoutside')
        grid('on')
        % Log scale is better in some cases:
        if strcmp(multi_props_to_plot{a}, 'rates')
%             set(gca, 'YScale', 'log')
        end
        save_as_pdf(strcat(foldername{end-1},'_',multi_props_to_plot{a}),800,350);
        hold off
    end
end
    
function sims_comp = read_in_sims(upfolder, subs)
% Combine upfolder, subs and temps to loop over all folders
% and read in certain data of all the given simulations to compare them
% easily using plot_comparisons
    for i = 1:size(subs,1)
        folder = [upfolder, '', subs(i).name];
        sim_data_file = [folder, '\simulation_data.mat'];
        sites_file = [folder, '\sites.mat'];            
        if exist(sim_data_file, 'file') &&  exist(sites_file, 'file')
            fprintf('Loading simulation_data.mat and sites.mat from %s \n', folder)
            load(sim_data_file) 
            load(sites_file)
            % read folder name
            sim_name = split(folder,'\');
            % First folder up
            material = sim_name{end-1,1};
            % The info from this simulation:
            info = read_sim_info(sim_data, sites, material);
            % The 'name' of the simulation:
            sim_name = sim_name{end,1};
            % Replace invalid ' ' character
            sim_name = strrep(sim_name,' ','_');
            % Add name at start bc field name can't start with number
            sim_name = strcat('sim_',sim_name);
            sims_comp.(sim_name) = info;
        elseif exist(sim_data_file, 'file')
            fprintf('sites.mat NOT found in given folder: %s \n', folder)                   
        else
            fprintf('sim_data.mat and sites_sites.mat NOT found in given folder: %s \n', folder)
        end
    end
    
end

function info = read_sim_info(sim_data, sites, material)
% The information to be compared for the simulations:
% All the info wanted from sim_data:
    info.temperature = sim_data.temperature;
    info.attempt_freq = sim_data.attempt_freq;
    info.attempt_freq_std = sim_data.std_attempt_freq;
    info.vibration_amp = sim_data.vibration_amp;
    info.tracer_diffusion = sim_data.tracer_diffusion;
    info.tracer_diffusion_error = sim_data.tracer_diffusion_error;
    info.tracer_conductivity = sim_data.tracer_conductivity;
    info.tracer_conductivity_error = sim_data.tracer_conductivity_error;
    info.material = material;
% All the info wanted from sites:    
    %Fraction of time the atom is at known locations:
    info.total_occup = 100*sum(sites.occupancy)/numel(sites.atoms); 
    info.site_occup = 100.*sites.sites_occup;
    info.atom_locations = 100.*sites.atom_locations;
    info.site_names = sites.stable_names;
    % Jump names: 
    info.jump_names = sites.jump_names;
    % Activation energy
    info.e_act = sites.e_act;
    % Jump rates:
    info.rates = sites.rates;   
    info.jump_diffusion = sites.jump_diffusivity;
    info.correlation_factor = sites.correlation_factor;
    % Fraction of collective jumps
    info.frac_collective = 100*(1.0-sites.solo_frac);
end

function E_A = activation_energy(x,y)
    % Linear fit
    R = 8.31446261815324;
    fit = polyfit(x,y,1);
    slope = fit(1);
    E_A = -slope*R; % in kJ/mol
    % Factor 1000 is to compensate 1000/T plot, but can be omitted to get
    % kJ/mol
end

function save_as_pdf(title,w,h)
    box on
    name = sprintf(strcat(title));
    set(gcf, 'Color', 'w');
    set(gcf,'position',[0,0,w,h])
    set(gcf,'Units','Inches');
    pos = get(gcf,'Position');
    set(gcf,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
    saveas(gcf, name, 'pdf') %Save figure
end

function formatted_name = format_names(name)
    name = strrep(name,'sim_','');
    name = strrep(name,'_',' ');
    name = strrep(name,'0700','700');
    name = strrep(name,'MD','');
    name = regexprep(name,'([0-9]+)','_{$1}');
    name = regexprep(name,'_{([0-9])} vac','{$1} vac');
    formatted_name = strrep(name,'T_',' ');
end