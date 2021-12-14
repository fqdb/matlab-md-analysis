function [names, pos, supercell] = known_materials(material)
% The positions of diffusing atoms, and their names, in different materials
    if strcmp(material, 'argyrodite')
       supercell = [1 1 1]; 
       fprintf('Material is: %s \n', material)         
       fprintf('Assuming a %d x %d x %d supercell \n', supercell(1), supercell(2), supercell(3))    
       [names, pos] = argyrodite(supercell);
       
    elseif strcmp(material, 'basnf4')
       supercell = [2 2 1]; 
       fprintf('Material is: %s \n', material)         
       fprintf('Assuming a %d x %d x %d supercell \n', supercell(1), supercell(2), supercell(3)) 
       [names, pos] = basnf4(supercell);
       
    elseif strcmp(material, 'bif3')
       supercell = [2 2 1];
       fprintf('Material is: %s \n', material)         
       fprintf('Assuming a %d x %d x %d supercell \n', supercell(1), supercell(2), supercell(3)) 
       [names, pos] = bif3(supercell);
       
    elseif strcmp(material, 'bif3_pnma')
       supercell = [2 1 1];
       fprintf('Material is: %s \n', material)         
       fprintf('Assuming a %d x %d x %d supercell \n', supercell(1), supercell(2), supercell(3)) 
       [names, pos] = bif3_pnma(supercell);
    
    elseif strcmp(material, 'bif3_p63')
        supercell = [2 2 2];
        fprintf('Material is: %s \n', material)         
        fprintf('Assuming a %d x %d x %d supercell \n', supercell(1), supercell(2), supercell(3)) 
        [names, pos] = bif3_p63(supercell);
       
    elseif strcmp(material, 'latp')
       supercell = [1 1 1]; 
       fprintf('Material is: %s \n', material)         
       fprintf('Assuming a %d x %d x %d supercell \n', supercell(1), supercell(2), supercell(3)) 
       [names, pos] = latp(supercell);
       
    elseif strcmp(material, 'lisnps')
       supercell = [1 1 1]; 
       fprintf('Material is: %s \n', material)         
       fprintf('Assuming a %d x %d x %d supercell \n', supercell(1), supercell(2), supercell(3))         
       [names, pos] = lisnps(supercell);
       
    elseif strcmp(material, 'li3ps4_beta')
       supercell = [1 1 2]; 
       fprintf('Material is: %s \n', material)         
       fprintf('Assuming a %d x %d x %d supercell \n', supercell(1), supercell(2), supercell(3))                 
       [names, pos] = li3ps4_beta(supercell);
       
    elseif strcmp(material, 'mno2_lambda')
       supercell = [2 2 1]; 
       fprintf('Material is: %s \n', material)         
       fprintf('Assuming a %d x %d x %d supercell \n', supercell(1), supercell(2), supercell(3))    
       [names, pos] = mno2_lambda(supercell);             
       
    elseif strcmp(material, 'lagp')
       supercell = [1 2 2]; 
       fprintf('Material is: %s \n', material)         
       fprintf('Assuming a %d x %d x %d supercell \n', supercell(1), supercell(2), supercell(3))    
       [names, pos] = lagp(supercell);  
       
    elseif strcmp(material, 'lyb')
       supercell = [1 1 1]; 
       fprintf('Material is: %s \n', material)         
       fprintf('Assuming a %d x %d x %d supercell \n', supercell(1), supercell(2), supercell(3))    
       [names, pos] = lyb(supercell);  
       
    elseif strcmp(material, 'lgps')
       supercell = [1 1 1]; 
       fprintf('Material is: %s \n', material)         
       fprintf('Assuming a %d x %d x %d supercell \n', supercell(1), supercell(2), supercell(3))    
       [names, pos] = lgps(supercell);  
       
    elseif strcmp(material, 'llzo')
       supercell = [1 1 1]; 
       fprintf('Material is: %s \n', material)         
       fprintf('Assuming a %d x %d x %d supercell \n', supercell(1), supercell(2), supercell(3))    
       [names, pos] = llzo(supercell);
       
    elseif strcmp(material, 'latp2')
       supercell = [1 1 1]; 
       fprintf('Material is: %s \n', material)         
       fprintf('Assuming a %d x %d x %d supercell \n', supercell(1), supercell(2), supercell(3))    
       [names, pos] = latp2(supercell); 
       
    else
       disp('ERROR! Material not recognised, add it to known_materials.m') 
       disp('ERROR! Also check if you have given the material name in all lower case correctly!')
    end
end

%% BaSnF4
function [names,pos] = basnf4(supercell)
% Spacegroup 227, Fd-3m, origin choice 2s
    disp('ORIGIN CHOICE 2')
%The symmetries applicable to each site:
sym = [0 0 0];
    % 4f F-site
    z = 0.2167;
    pos_4f = [3/4,1/4,z; 1/4,3/4,z;	1/4,3/4,-z;	3/4,1/4,-z];
    names_4f = {'4f', '4f', '4f', '4f'}; 
    % 2c F-site
    z = 0.3136;
    pos_2c = [1/4,1/4,z; 3/4,3/4,-z];
    names_2c = {'2c', '2c'}; 
    % 2b F-site
    z = 0.5;
    pos_2b = [3/4,1/4,1/2; 1/4,3/4,1/2];
    names_2b = {'2b', '2b'}; 
   
  %All the positions in this material             
    pos_sym = [pos_4f(:,:); pos_2c(:,:); pos_2b(:,:)];
    names_sym = {names_4f{:}, names_2c{:}, names_2b{:}};   
  % Construct all:  
   [names, pos] = construct(sym', pos_sym', names_sym, supercell);
end

%% BiF3
% OLD
function [names,pos] = bif3(supercell)
% Spacegroup 62, P63/nmm , origin choice 2s
    disp('ORIGIN CHOICE 2')
%The symmetries applicable to each site:
sym = [0 0 0];
    % 4f F-site
    pos_4f = [1/3,2/3,0.57896400; 1/3, 2/3, 0.92103600; 2/3, 1/3, 0.07896400; 2/3, 1/3, 0.42103600];
    names_4f = {'4f','4f','4f','4f'}; 
    
    % 2b F-site
    pos_2b = [0,0,0.25; 0,0,0.75];
    names_2b = {'2b','2b'};
    
  %All the positions in this material             
    pos_sym = [pos_4f(:,:);pos_2b(:,:)];
    names_sym = {names_4f{:},names_2b{:}};   
  % Construct all:  
   [names, pos] = construct(sym', pos_sym', names_sym, supercell);
end

function [names, pos] = bif3_pnma(supercell)
% Space group no. 62 (Pnma)
sym = [0 0 0];
    % 8d-sites
    x = 0.16071799;
    y = 0.06034500;
    z = 0.351552;
    
    pos_8d_t = [x,y,z; -x+1/2,-y,z+1/2; -x,y+1/2,-z; x+1/2,-y+1/2,-z+1/2; 
        -x,-y,-z; x+1/2,y,-z+1/2; x,-y+1/2,z; -x+1/2,y+1/2,z+1/2;];
    pos_8d = [pos_8d_t(:,3), pos_8d_t(:,1), pos_8d_t(:,2)];
    names_8d = {'8d','8d','8d','8d','8d','8d','8d','8d'};
    
    x = 0.04054000;
    y = 0.25000000;
    z = 0.86299199;
    
    pos_4c_t = [x,1/4,z; -x+1/2,3/4,1/2; -x,3/4,-z; x+1/2,1/4,-z+1/2];
    pos_4c = [pos_4c_t(:,3), pos_4c_t(:,1), pos_4c_t(:,2)];
    names_4c = {'4c','4c','4c','4c'};
   
    pos_sym = [pos_8d(:,:);pos_4c(:,:)];
    names_sym = {names_8d{:},names_4c{:}};

    %Construct all sites:
    [names, pos] = construct(sym', pos_sym', names_sym, supercell);
end

function [names, pos] = bif3_p63(supercell)
% Space group no. 173 (P63)
sym = [0 0 0];
    % 2a-sites
    z = 0.25;
    pos_2a = [0,0,z;0,0,z+0.5];
    names_2a = {'2a','2a'};
    
    % 2b-sites
    x = 0;
    y = 0;
    z = 0.42104;
    pos_2b = [1/3,2/3,z; 2/3,1/3,z+0.5];
    names_2b = {'2b', '2b'};
    
    pos_sym = [pos_2a(:,:); pos_2b(:,:)];
    names_sym = {names_2a{:}, names_2b{:} };

    %Construct all sites:
    [names, pos] = construct(sym', pos_sym', names_sym, supercell);
end

%% LAGP
function [names, pos] = lagp(supercell)
% Space group no. 167 (R-3c) h-axes
%The symmetries applicable to each site:
	sym = [0 0 0; 2/3 1/3 1/3; 1/3 2/3 2/3];
% 36f-sites
    x = 0.025;
    y = 0.025;
    z = 0.0;
    pos_36f = [ x,y,z;	-y,x-y,z;	-x+y,-x,z;	y,x,-z+1/2; ...
        x-y,-y,-z+1/2;	-x,-x+y,-z+1/2;	-x,-y,-z;	y,-x+y,-z; ...
    x-y,x,-z;	-y,-x,z+1/2;	-x+y,y,z+1/2;	x,x-y,z+1/2 ];
    names_36f = {'36f', '36f', '36f','36f', '36f', '36f','36f', '36f', '36f','36f', '36f', '36f'};
    
    % 6b-sites
    x = 0;
    y = 0;
    z = 0.5;
    pos_6b = [ 0,0,0; 0,0,0.5 ];
    names_6b = {'6b', '6b'};
    
    pos_sym = [pos_36f(:,:); pos_6b(:,:)];
    names_sym = {names_36f{:}, names_6b{:} };

    %Construct all sites:
    [names, pos] = construct(sym', pos_36f', names_36f, supercell);
end

%% NaMnO2_lambda
function [names,pos] = mno2_lambda(supercell)
% Spacegroup 227, Fd-3m, origin choice 2s
    disp('ORIGIN CHOICE 2 for NaMnO2 lambda')
%The symmetries applicable to each site:
    sym = [0 0 0; 0 0.5 0.5; 0.5 0 0.5; 0.5 0.5 0];
    % 16c Na-site
    pos_16c = [0 0 0; 0.75 0.25 0.5; 0.25 0.5 0.75; 0.5 0.75 0.25];
    names_16c = {'16c', '16c', '16c', '16c'}; 
    % 8a Na-site
    pos_8a = [0.125 0.125 0.125; 0.875 0.375 0.375];
    names_8a = {'8a', '8a'};    
   
  %All the positions in this material             
    pos_sym = [pos_16c(:,:); pos_8a(:,:)];
    names_sym = {names_16c{:}, names_8a{:} };   
  % Construct all:  
   [names, pos] = construct(sym', pos_sym', names_sym, supercell);
end

%% Li10SnP2S12
function [names,pos] = lisnps(supercell)
% Spacegroup 137, P4_2/nmc
    disp('ORIGIN CHOICE 2 for Li10SnP2S12!')
%The symmetries applicable to each site:
    sym = [0 0 0];
    % Li1-sites, 16h
    x = 0.514; y = 0.01; z = 0.072;
    pos_li1 = [x, y, z; (-x)+0.5, (-y)+0.5, z; (-y)+0.5, x, z+0.5; y, (-x)+0.5, z+0.5; ... 
        -x, y+0.5, -z; x+0.5, -y, -z; y+0.5, x+0.5, (-z)+0.5; -y, -x, (-z)+0.5; ...
        -x, -y, -z; x+0.5, y+0.5, -z; y+0.5, -x, (-z)+0.5; -y, x+0.5, (-z)+0.5; ...
        x, (-y)+0.5, z; (-x)+0.5, y, z; (-y)+0.5, (-x)+0.5, z+0.5; y, x, z+0.5];
    names_li1 = {'Li1', 'Li1', 'Li1', 'Li1', 'Li1', 'Li1', 'Li1', 'Li1', ...
        'Li1', 'Li1', 'Li1', 'Li1', 'Li1', 'Li1', 'Li1', 'Li1'}; 
    % Li2-sites, 16h
    x = 0.027; y = 0.007; z = 0.215;
    pos_li2 = [x, y, z; (-x)+0.5, (-y)+0.5, z; (-y)+0.5, x, z+0.5; y, (-x)+0.5, z+0.5; ... 
        -x, y+0.5, -z; x+0.5, -y, -z; y+0.5, x+0.5, (-z)+0.5; -y, -x, (-z)+0.5; ...
        -x, -y, -z; x+0.5, y+0.5, -z; y+0.5, -x, (-z)+0.5; -y, x+0.5, (-z)+0.5; ...
        x, (-y)+0.5, z; (-x)+0.5, y, z; (-y)+0.5, (-x)+0.5, z+0.5; y, x, z+0.5];
    names_li2 = {'Li2', 'Li2', 'Li2', 'Li2', 'Li2', 'Li2', 'Li2', 'Li2', ...
        'Li2', 'Li2', 'Li2', 'Li2', 'Li2', 'Li2', 'Li2', 'Li2'};    
    % Li3-sites, 4d
    z = 0.1937;
    pos_li3 = [0.25, 0.25, z; 0.25, 0.25, z+0.5; 0.75, 0.75, -z; 0.75, 0.75, (-z)+0.5];
    names_li3 = {'Li3', 'Li3', 'Li3', 'Li3'};     
    % Li4-sites, 4c
    z = 0.0042;
    pos_li4 = [0.75, 0.25, z; 0.25, 0.75, z+0.5; 0.25, 0.75, -z; 0.75, 0.25, (-z)+0.5];
    names_li4 = {'Li4', 'Li4', 'Li4', 'Li4'}; 
  %All the positions in this material             
    pos_sym = [pos_li1(:,:); pos_li2(:,:); pos_li3(:,:); pos_li4(:,:)];
    names_sym = {names_li1{:}, names_li2{:}, names_li3{:}, names_li4{:} };   
  % Construct all:  
   [names, pos] = construct(sym', pos_sym', names_sym, supercell);
end

%% Argyrodites:
function [names, pos] = argyrodite(supercell)
%The symmetries applicable to each site:
    sym = [0 0 0; 0 1/2 1/2; 1/2 0 1/2; 1/2 1/2 0];
%Only 48h positions:
    x = 0.183; 
    %y = x; 
    z = 0.024;
    pos_sym = [x x z; -x -x z; -x x -z; x -x -z; z x x; z -x -x; -z -x x; -z x -x; ... 
        x z x; -x z -x; x -z -x; -x -z x];
    names_sym = {'48h', '48h', '48h', '48h', '48h', '48h', '48h', '48h', '48h', ...
         '48h', '48h', '48h'};
    %Construct all sites:
    [names, pos] = construct(sym', pos_sym', names_sym, supercell);
end

%% LATP
function [names, pos] = latp(supercell)
%The symmetries applicable to each site, spacegroup 167 (R-3c)
    sym = [0 0 0; 2/3 1/3 1/3; 1/3 2/3 2/3];
%6b positions
    pos_6b = [0 0 0; 0 0 0.5];
    names_6b = {'6b', '6b'};
%18e positions (in between 36f's, roughly estimated, might need to be optimised)
    x = 0.66;
    pos_18e = [x, 0, 0.25; 0, x, 0.25; -x, -x, 0.25; -x, 0, 0.75; 0, -x, 0.75; x, x, 0.75];
    names_18e = {'18e', '18e', '18e', '18e', '18e', '18e'};
%36f positions, but it seems unrealistic to have them so close (within 0.5 Angstrom) together
%    x = 0.07; y = 0.34; z = 0.07;
%    pos_36f = [x, y, z; -y, x-y, z; (-x)+y, -x, z; 
%           y, x, (-z)+1/2; x-y, -y, (-z)+1/2; -x, (-x)+y, (-z)+1/2;
%           -x, -y, -z; y, (-x)+y, -z; x-y, x, -z; 
%           -y, -x, z+1/2; (-x)+y, y, z+1/2; x, x-y, z+1/2];
%    names_36f = {'36f', '36f', '36f', '36f', '36f', '36f', '36f', '36f', ...
%        '36f', '36f', '36f', '36f'};
  %All the positions in this material     
    pos_sym = [pos_6b(:,:); pos_18e(:,:)]; %pos_36f(:,:)];
    names_sym = {names_6b{:}, names_18e{:}}; %names_36f{:}};   
  % Construct all:  
   [names, pos] = construct(sym', pos_sym', names_sym, supercell);
end
  
%% Li3PS4-beta
function [names, pos] = li3ps4_beta(supercell)
%The symmetries applicable to each site:
    sym = [0 0 0];
    % 8d positions
    % Homma et al. (2011): 
    %x = 0.3562; y = 0.013; z = 0.439; 
    % Mercier et al. (1982): 
    %x = 0.332; y = 0.0335; z = 0.3865;
    % Yan Chen et al. (2015), Appl. Phys. Lett.
    x = 0.341; y = 0.031; z = 0.384; %(413 K)
    
    pos_8d = [ x y z; (-x)+0.5 -y z+0.25; -x y+0.5 -z; x+0.5 (-y)+0.5 (-z)+0.25; 
        -x -y -z; x+0.5 y (-z)+0.25; x (-y)+0.5 z; (-x)+0.5 y+0.5 z+0.25 ];
    names_8d = {'8d', '8d', '8d', '8d', '8d', '8d', '8d', '8d'};
    
    %4b positions
    pos_4b = [ 0 0 0.5; 0.5 0 0; 0 0.5 0.5; 0.5 0.5 0 ];
    names_4b = {'4b' '4b' '4b' '4b'};
    
    %4c positions
    % Homma et al. (2011): 
    %x = 0.999; z = 0.889; 
    % Mercier et al. (1982): 
    %x = -0.074; z = -0.306; 
    % Yan Chen et al. (2015), Appl. Phys. Lett.
    x = -0.017;  z = -0.263; %annealed at 413 K
    %x = -0.056; z = -0.361; %annealed at 673 K
    pos_4c = [x 0.25 z; (-x)+0.5 0.75 z+0.25; -x 0.75 -z; x+0.5 0.25 (-z)+0.25 ];
    names_4c = {'4c' '4c' '4c' '4c'};

 % All the positions in this material     
    pos_sym = [pos_8d(:,:); pos_4b(:,:); pos_4c(:,:)];
    names_sym = {names_8d{:}, names_4b{:}, names_4c{:}};   
  % Construct all:  
    [names, pos] = construct(sym', pos_sym', names_sym, supercell);
   
   disp('Giving different names to detect intersheet jumps')
   for i = 1:size(pos,2)
        if pos(1,i) > 0.25 && pos(1,i) < 0.75
            names{i} = [names{i}, 'sheet1'];
        else
            names{i} = [names{i}, 'sheet2'];
        end
   end
   
end

%% LYB
function [names, pos] = lyb(supercell)
%The symmetries applicable to each site:
    sym = [0 0 0];
    %
    pos_4h = [0 0.155 0.5; 0.5 0.655 0.5; 0 0.845 0.5; 0.5 0.345 0.5];
    names_4h = {'4h', '4h', '4h', '4h'}; 
    %
    pos_4g = [0 0.3349 0; 0.5 0.8349 0; 0 0.6651 0; 0.5 0.1651 0 ];
    names_4g = {'4g', '4g', '4g','4g'};    
   
  %All the positions in this material             
    pos_sym = [pos_4h(:,:); pos_4g(:,:)];
    names_sym = {names_4h{:}, names_4g{:} };   
  % Construct all:  
   [names, pos] = construct(sym', pos_sym', names_sym, supercell);
end
%

%% LGPS
function [names, pos] = lgps(supercell)
%The symmetries applicable to each site:
    sym = [0 0 0];
    %
    pos_16h = [0.257000 0.269900 0.186900; 0.743000 0.730100 0.186900; 0.230100 0.757000 0.686900; 0.769900 0.243000 0.68690;...
        0.243000 0.769900 0.313100; 0.757000 0.230100 0.313100; 0.269900 0.257000 0.813100;0.730100 0.743000 0.813100;...
        0.243000 0.230100 0.313100; 0.757000 0.769900 0.313100; 0.269900 0.743000 0.813100; 0.730100 0.257000 0.813100;...
        0.257000 0.730100 0.186900; 0.743000 0.269900 0.186900; 0.230100 0.243000 0.686900; 0.769900 0.757000 0.686900];
    names_16h = {'16h', '16h', '16h', '16h','16h', '16h', '16h', '16h','16h', '16h', '16h', '16h','16h', '16h', '16h', '16h'}; 
    %
    pos_4d = [0 0.5 0.9469; 0 0.5 0.4469; 0.5 0 0.5531; 0.5 0 0.0531];
    names_4d = {'4d', '4d', '4d','4d'};
    %
    pos_8f = [	0.2471 0.2471 0; 0.7529 0.7529 0; 0.2529 0.7471 0.5; 0.7471 0.2529 0.5;
                0.2529 0.2529 0.5; 0.7471 0.7471 0.5; 0.2471 0.7471 0; 0.7529 0.2471 0];
    names_8f = {'8f', '8f', '8f', '8f','8f', '8f', '8f', '8f'}; 
    %
    pos_4c = [	0 0 0.251; 0.5 0.5 0.751; 0.5 0.5 0.249; 0 0 0.749];
    names_4c = {'4c', '4c', '4c','4c'};    
    
    pos_sym = [pos_16h(:,:); pos_4d(:,:); pos_8f(:,:); pos_4c(:,:)];
    names_sym = {names_16h{:}, names_4d{:}, names_8f{:}, names_4c{:} }; 
   
   [names, pos] = construct(sym', pos_sym', names_sym, supercell);
end

%

%% LLZO
function [names, pos] = llzo(supercell)
%The symmetries applicable to each site:
    sym = [0 0 0];
    %
    pos_32g = [0.420400 0.086300 0.190100; 0.920400 0.586300 0.690100; 0.079600 0.913700 0.690100;0.579600 0.413700 0.190100;...
        0.163700 0.170400 0.440100; 0.663700 0.670400 0.940100; 0.336300 0.829600 0.940100; 0.836300 0.329600 0.440100;
        0.079600 0.086300 0.809900; 0.579600 0.586300 0.309900; 0.420400 0.913700 0.309900; 0.920400 0.413700 0.809900;...
        0.336300 0.170400 0.559900; 0.836300 0.670400 0.059900; 0.163700 0.829600 0.059900; 0.663700 0.329600 0.559900;...
        0.579600 0.913700 0.809900; 0.079600 0.413700 0.309900; 0.920400 0.086300 0.309900; 0.420400 0.586300 0.809900;...
        0.836300 0.829600 0.559900; 0.336300 0.329600 0.059900; 0.663700 0.170400 0.059900; 0.163700 0.670400 0.559900;...
        0.920400 0.913700 0.190100; 0.420400 0.413700 0.690100; 0.579600 0.086300 0.690100; 0.079600 0.586300 0.190100;
        0.663700 0.829600 0.440100; 0.163700 0.329600 0.940100; 0.836300 0.170400 0.940100; 0.336300 0.670400 0.440100];
    names_32g = {'32g', '32g', '32g', '32g','32g', '32g', '32g', '32g','32g', '32g', '32g', '32g','32g', '32g', '32g', '32g',...
        '32g', '32g', '32g', '32g','32g', '32g', '32g', '32g','32g', '32g', '32g', '32g','32g', '32g', '32g', '32g'}; 
    %
    pos_16f = [0.181300 0.431300 0.125000; 0.681300 0.931300 0.625000; 0.318700 0.568700 0.625000; 0.818700 0.931300 0.375000;...
        0.681300 0.068700 0.875000; 0.318700 0.431300 0.875000; 0.181300 0.568700 0.375000; 0.818700 0.068700 0.125000;...
        0.818700 0.568700 0.875000; 0.318700 0.068700 0.375000; 0.681300 0.431300 0.375000; 0.181300 0.931300 0.875000 ;...
        0.181300 0.068700 0.625000; 0.318700 0.931300 0.125000; 0.681300 0.568700 0.125000; 0.818700 0.431300 0.625000];
    names_16f = {'16f', '16f', '16f', '16f','16f', '16f', '16f', '16f','16f', '16f', '16f', '16f','16f', '16f', '16f', '16f'}; 
    %
    pos_8a = [	0.000000 0.250000 0.375000; 0.500000 0.750000 0.875000; 0.000000 0.750000 0.625000; 0.500000 0.250000 0.125000;
                0.500000 0.250000 0.625000; 0.000000 0.750000 0.125000; 0.500000 0.750000 0.375000; 0.000000 0.250000 0.875000];
    names_8a = {'8a', '8a', '8a', '8a','8a', '8a', '8a', '8a'};  
    
    pos_sym = [pos_32g(:,:); pos_16f(:,:); pos_8a(:,:)];
    names_sym = {names_32g{:}, names_16f{:}, names_8a{:}}; 
   
   [names, pos] = construct(sym', pos_sym', names_sym, supercell);
end

%% latp2

function [names, pos] = latp2(supercell)
%The symmetries applicable to each site:
    sym = [0 0 0];
    %
    pos_6a = [	0.000000 0.000000 0.000000; 0.666667 0.333333 0.333333; 0.333333 0.666667 0.666667; ...
                0.000000 0.000000 0.500000; 0.666667 0.333333 0.833333; 0.333333 0.666667 0.166667];
    names_6a = {'6a', '6a', '6a', '6a','6a', '6a'}; 
    %
    pos_6b = [	0.000000 0.000000 0.250000; 0.666667 0.333333 0.583333; 0.333333 0.666667 0.916667;...
                0.000000 0.000000 0.750000; 0.666667 0.333333 0.083333; 0.333333 0.666667 0.416667];
    names_6b = {'6b', '6b', '6b', '6b','6b', '6b'};  
    
    pos_sym = [pos_6a(:,:); pos_6b(:,:)];
    names_sym = {names_6a{:}, names_6b{:}}; 
   
   [names, pos] = construct(sym', pos_sym', names_sym, supercell);
end

%% 

function [names, pos] = construct(sym, pos_sym, names_sym, supercell)
% Constructs all the (fractional) positions based on the symmetries and coordinates,
% and combines it with the given names.

%% Check whether names_sym and pos_sym have the same length:
    if size(pos_sym,2) ~= size(names_sym)
        disp('ERROR! Positions and names given not the same size!')
        size(pos_sym,2)
        size(names_sym,2)
        %names_sym
    end
    
% The number of final positions:
    nr_sym = size(sym,2);
    pos_given = size(pos_sym,2);
    nr_cells = prod(supercell);
    pos = zeros(3, nr_cells*nr_sym*pos_given);
    names = cell(nr_cells*nr_sym*pos_given,1);
    counter = 0;
    
%% Start constructing the unit cell based on the given symmetry operations and coordinates:
    for i = 1:pos_given
        for j = 1:nr_sym %the symmetries           
            counter = counter + 1;
            names{counter} = names_sym{i};
            for k = 1:3 %the a,b,c coor  
                pos(k, counter) = pos_sym(k,i) + sym(k,j);
                if pos(k, counter) >= 1 % Periodic Boundary Conditions:
                    pos(k, counter) = pos(k, counter) -1;
                elseif pos(k, counter) < 0
                    pos(k, counter) = pos(k, counter) + 1;
                end
                % Take coordinate shift of fractional coordinates due to supercell into account
                if supercell(k) > 1
                    pos(k, counter) = pos(k, counter)/supercell(k);
                end
            end
        end
    end
    
%% Construct the supercells:
    if nr_cells > 1
        for a = 1:supercell(1)
            for b = 1:supercell(2)
                for c = 1:supercell(3)                
                    if a ~= 1 || b ~= 1 || c ~= 1 
                    % The [1 1 1] cell has already been constructed, now do only do the rest   
                        for i = 1:nr_sym*pos_given
                            counter = counter + 1;
                            names{counter} = names{i};
                            pos(1,counter) = pos(1,i) + (a-1.0)/supercell(1);
                            pos(2,counter) = pos(2,i) + (b-1.0)/supercell(2);
                            pos(3,counter) = pos(3,i) + (c-1.0)/supercell(3);
                        end

                   end
                end %c 
           end
       end
    end
   % Test: scatter3(pos(1,:), pos(2,:), pos(3,:))
    
end