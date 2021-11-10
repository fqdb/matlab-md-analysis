% Manually load in sites.mat and sim_data.mat first
close all
figure
delta = 0.2;
hold on
%% Plot start and end positions
a = sim_data.cart_pos(:,:,1);
c = length(a);
scatter3(a(1,1:c),a(2,1:c),a(3,1:c),60,'green','filled');
a = sim_data.cart_pos(:,:,end);
scatter3(a(1,1:c),a(2,1:c),a(3,1:c),30,'red','filled');
for i=1:length(a)
    line([sim_data.cart_pos(1,i,1),sim_data.cart_pos(1,i,end)],...
        [sim_data.cart_pos(2,i,1),sim_data.cart_pos(2,i,end)],...
        [sim_data.cart_pos(3,i,1),sim_data.cart_pos(3,i,end)])
end

%% Plot sites.mat
nr_sites = size(sites.occupancy, 1); 
for i = 1:nr_sites
    text(sites.cart_pos(1,i)+delta, sites.cart_pos(2,i)+delta, ...
                sites.cart_pos(3,i)+delta, sites.site_names(i) );
    scatter3(sites.cart_pos(1,i), sites.cart_pos(2,i), sites.cart_pos(3,i), ...
        50, 'blue', 'filled');
end
%% Plot pre-relaxation positions
poscar = read_poscar();
    scatter3(poscar(:,1), poscar(:,2), poscar(:,3), ...
        30, 'black', 'filled');

%%
axis equal;
view([-37.5 30])
hold off