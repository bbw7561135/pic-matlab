if 0
% write pic fortran data ino h5 format
data_dir = '/Volumes/Fountain/Data/PIC/df_cold_protons_n04/data/';
filePath = [data_dir 'fields.h5'];

datasize = size(E.x);
timesteps = 200:200:12000;
fields = {'Ex','Ey','Ez','Bx','By','Bz'};
for itime = 1:numel(timesteps)  
  for ifield = [1:numel(fields)]
    timestep = timesteps(itime);
    str_timestep = sprintf('%010.0f',timestep);
    h5create([data_dir 'fields.h5'],['/data/' str_timestep '/' fields{ifield}],datasize);
  end
end

%h5write([data_dir 'fields.h5'], ['/data/' str_timestep '/Ey'], E.y);
%% For comparison
filePath = '/Users/cno062/Data/SMILEI/GEMchallange/Fields0.h5';
info = h5info(filePath);

%% '/Volumes/Fountain/Data/PIC/df_cold_protons_n08/data_separated/';
data_dir_h5 = '/Volumes/Fountain/Data/PIC/df_cold_protons_n08/data_h5/';
data_dir_separated = '/Volumes/Fountain/Data/PIC/df_cold_protons_n08/data_separated/';
filePath = [data_dir_h5 'fields.h5'];
dirs = dir(data_dir_separated);
datasets = dirs(find(not(contains({dirs.name},{'.','same_for_all_times'})))); % remove some dirs
datasets = {datasets.name};

%dirs = dir([data_dir_separated datasets{1}]);
%dataset_str = dirs(find(not(ismember({dirs.name},{'.','..'})))); % remove some dirs
%dataset_str = {dataset_str.name};
timesteps = 200:200:10800;

%datasize = [6400,1600];


for itime = 9%4:numel(timesteps)  
  for ifield = 23%1:numel(datasets)
    timestep = timesteps(itime);
    str_timestep = sprintf('%010.0f',timestep);
    
    % load data
    vardir = [data_dir_separated datasets{ifield}];
    varstr_reload = sprintf('%s/%s-%05.0f.mat',vardir,datasets{ifield},timestep);
    data_tmp  = load(varstr_reload,datasets{ifield}); 
    data_tmp = eval(sprintf('data_tmp.%s',datasets{ifield}));
    % check for components, i saved them as structures, with field components
    if isa(data_tmp,'numeric') % no field components
      disp(['/data/' str_timestep '/' datasets{ifield}])
      h5create([data_dir_h5 'fields.h5'],['/data/' str_timestep '/' datasets{ifield}], size(data_tmp));
      h5write([data_dir_h5 'fields.h5'], ['/data/' str_timestep '/' datasets{ifield}], data_tmp);
    elseif isa(data_tmp,'struct')
      components = fieldnames(data_tmp);
      for icomp = 1:numel(components)
        disp(['/data/' str_timestep '/' datasets{ifield} components{icomp}])
        datasize = size(subsref(data_tmp,substruct('.',components{icomp})));
        h5create([data_dir_h5 'fields.h5'],['/data/' str_timestep '/' datasets{ifield} components{icomp}], datasize);
        h5write([data_dir_h5 'fields.h5'], ['/data/' str_timestep '/' datasets{ifield} components{icomp}], subsref(data_tmp,substruct('.',components{icomp})));        
      end
    else      
      error('Unknown data type.')
    %  h5write([data_dir_h5 'fields.h5'], ['/data/' str_timestep '/' datasets{ifield}], data_tmp);
    end
  end
end

%h5write([data_dir 'fields.h5'], ['/data/' str_timestep '/Ey'], E.y);
end
%% '/Volumes/Fountain/Data/PIC/df_cold_protons_n04/data/';
% Better to save original data, and only necessary quantities
data_dir    = '/Volumes/Fountain/Data/PIC/df_cold_protons_n04/data/';
data_dir_h5 = '/Volumes/Fountain/Data/PIC/df_cold_protons_n04/data_h5/';
filePath = [data_dir_h5 'fields.h5'];
nSpecies = 6;
descSpecies = {'hot ion harris sheet plus uniform background',...
  'hot electron harris sheet plus uniform background',...
  'cold ions from south',...
  'cold electrons from south',...
  'cold ions from north',...
  'cold electrons from north'};
timesteps = 000:200:12000;
% I forgot vxs,vys,vzs, time attribute, dt attribute, up until 48
for itime = 1:numel(timesteps)
  timestep = timesteps(itime);  
  txtfile = sprintf('%s/fields-%05.0f.dat',data_dir,timestep); 
  
  
  % read unnormalized data
  tic; [varstrs,vars] = read_data_no_normalization(txtfile,6); toc
  nss = numel(vars{find(contains(varstrs,'mass'))}); % number of species
  nnx = vars{find(contains(varstrs,'nnx'))}; % number of grid points in x
  nnz = vars{find(contains(varstrs,'nnz'))}; % number of grid points in z
  
  % Load some vars and remove from vars and varstrs
  iter = vars{find(contains(varstrs,'it'))};   vars(find(contains(varstrs,'it'))) = [];   varstrs(find(contains(varstrs,'it'))) = [];
  time = vars{find(contains(varstrs,'time'))}; vars(find(contains(varstrs,'time'))) = []; varstrs(find(contains(varstrs,'time'))) = [];
  dt = vars{find(contains(varstrs,'dt'))}; vars(find(contains(varstrs,'dt'))) = []; varstrs(find(contains(varstrs,'dt'))) = [];
  mass = vars{find(contains(varstrs,'mass'))}; vars(find(contains(varstrs,'mass'))) = []; varstrs(find(contains(varstrs,'mass'))) = [];
  q = vars{find(contains(varstrs,'q'))}; vars(find(contains(varstrs,'q'))) = []; varstrs(find(contains(varstrs,'q'))) = [];
  dfac = vars{find(contains(varstrs,'dfac'))}; vars(find(contains(varstrs,'dfac'))) = []; varstrs(find(contains(varstrs,'dfac'))) = [];
  str_iteration = sprintf('%010.0f',iter); % same group format as SMILEI
    
  
  % Remaining non-datasize matrices are the same for each time, so only
  % save one time
    
  % loop through variables, and save to h5 file in 'filePath'
  %%
  nvars = numel(vars);  
  for ivar = 1:nvars
    data = vars{ivar};
    
    % check data size, and see if it needs splitting up, and where to save
    if itime == 1 && not(sum(ismember(size(data),[nnx nnz]))>=2)
      %continue % implement later
      disp(['/simulation_information/' varstrs{ivar}])
      h5create([data_dir_h5 'fields.h5'],['/simulation_information/' varstrs{ivar}], size(data));
      h5write([data_dir_h5 'fields.h5'],['/simulation_information/' varstrs{ivar}], data);
      continue % jump to next variable
    end
    
    % From here, we only read data field variables
    % Check if it is a field (E,B) or species data (n,j,vv)
    if ndims(data) == 2 && all(size(data) == [nnx nnz]) % is (E,B)
      dataset_name = ['/data/' str_iteration '/' varstrs{ivar}];
      disp(dataset_name)
      h5create([data_dir_h5 'fields.h5'], dataset_name, size(data));
      h5write( [data_dir_h5 'fields.h5'], dataset_name, data);
    elseif size(data,3) == nss % is (n,vs,vv)
      for iSpecies = 1:nss
        data_tmp = data(:,:,iSpecies);
        dataset_name = ['/data/' str_iteration '/' varstrs{ivar} '/' num2str(iSpecies)];
        disp(dataset_name)
        h5create([data_dir_h5 'fields.h5'], dataset_name, size(data_tmp));
        h5write( [data_dir_h5 'fields.h5'], dataset_name, data_tmp);
        % Also write species data as attributes
        h5writeatt([data_dir_h5 'fields.h5'],dataset_name, 'mass',mass(iSpecies)) 
        h5writeatt([data_dir_h5 'fields.h5'],dataset_name, 'charge',q(iSpecies)) 
        h5writeatt([data_dir_h5 'fields.h5'],dataset_name, 'dfac',dfac(iSpecies)) 
        % info.Groups(1).Groups(ig).Datasets(id).Attributes.Name
      end
    else
      warning(sprintf('Variable: %s skipped',varstrs{ivar}))
      continue      
    end   
    % Write attributes for group (iteration)
    h5writeatt([data_dir_h5 'fields.h5'],['/data/' str_iteration '/'], 'time',time)
    h5writeatt([data_dir_h5 'fields.h5'],['/data/' str_iteration '/'], 'dt',dt)
    % info.Groups(1).Groups(ig).Attributes.Name
    
    % Calculate derived quantities and save in new group, -->> do after instead
    
  end
end

if 0 % Usage examples
  info = h5info(filePath);
  {info.Groups(2).Datasets.Name} % simulation information
  x = h5read(filePath,'/simulation_information/xe');
end

%% '/Volumes/Fountain/Data/PIC/df_cold_protons_n08/data/';
% Better to save original data, and only necessary quantities
data_dir    = '/Volumes/Fountain/Data/PIC/df_cold_protons_n08/data/';
data_dir_h5 = '/Volumes/Fountain/Data/PIC/df_cold_protons_n08/data_h5/';
filePath = [data_dir_h5 'fields.h5'];
nSpecies = 4;
descSpecies = {'hot ion harris sheet plus uniform background',...
  'hot electron harris sheet plus uniform background',...
  'cold ions',...
  'cold electrons'};

timesteps = 200:200:11000;
% I forgot vxs,vys,vzs, time attribute, dt attribute, up until 48
for itime = 2:numel(timesteps)
  timestep = timesteps(itime);  
  txtfile = sprintf('%s/fields-%05.0f.dat',data_dir,timestep); 
  
  
  % read unnormalized data
  tic; [varstrs,vars] = read_data_no_normalization(txtfile,nSpecies); toc
  nss = numel(vars{find(contains(varstrs,'mass'))}); % number of species
  nnx = vars{find(contains(varstrs,'nnx'))}; % number of grid points in x
  nnz = vars{find(contains(varstrs,'nnz'))}; % number of grid points in z
  
  % Load some vars and remove from vars and varstrs
  iter = vars{find(contains(varstrs,'it'))};   vars(find(contains(varstrs,'it'))) = [];   varstrs(find(contains(varstrs,'it'))) = [];
  time = vars{find(contains(varstrs,'time'))}; vars(find(contains(varstrs,'time'))) = []; varstrs(find(contains(varstrs,'time'))) = [];
  dt   = vars{find(contains(varstrs,'dt'))};   vars(find(contains(varstrs,'dt'))) = [];   varstrs(find(contains(varstrs,'dt'))) = [];
  mass = vars{find(contains(varstrs,'mass'))}; vars(find(contains(varstrs,'mass'))) = []; varstrs(find(contains(varstrs,'mass'))) = [];
  q    = vars{find(contains(varstrs,'q'))};    vars(find(contains(varstrs,'q'))) = [];    varstrs(find(contains(varstrs,'q'))) = [];
  dfac = vars{find(contains(varstrs,'dfac'))}; vars(find(contains(varstrs,'dfac'))) = []; varstrs(find(contains(varstrs,'dfac'))) = [];
  str_iteration = sprintf('%010.0f',iter); % same group format as SMILEI
    
  
  % Remaining non-datasize matrices are the same for each time, so only
  % save one time
    
  % loop through variables, and save to h5 file in 'filePath'
  %%
  nvars = numel(vars);  
  for ivar = 1:nvars
    data = vars{ivar};
    
    % check data size, and see if it needs splitting up, and where to save
    if itime == 1 && not(sum(ismember(size(data),[nnx nnz]))>=2)
      %continue % implement later
      disp(['/simulation_information/' varstrs{ivar}])
      h5create([data_dir_h5 'fields.h5'],['/simulation_information/' varstrs{ivar}], size(data));
      h5write([data_dir_h5 'fields.h5'],['/simulation_information/' varstrs{ivar}], data);
      continue % jump to next variable
    end
    
    % From here, we only read data field variables
    % Check if it is a field (E,B) or species data (n,j,vv)
    if ndims(data) == 2 && all(size(data) == [nnx nnz]) % is (E,B)
      dataset_name = ['/data/' str_iteration '/' varstrs{ivar}];
      disp(dataset_name)
      h5create([data_dir_h5 'fields.h5'], dataset_name, size(data));
      h5write( [data_dir_h5 'fields.h5'], dataset_name, data);
    elseif size(data,3) == nss % is (n,vs,vv)
      for iSpecies = 1:nss
        data_tmp = data(:,:,iSpecies);
        dataset_name = ['/data/' str_iteration '/' varstrs{ivar} '/' num2str(iSpecies)];
        disp(dataset_name)
        h5create([data_dir_h5 'fields.h5'], dataset_name, size(data_tmp));
        h5write( [data_dir_h5 'fields.h5'], dataset_name, data_tmp);
        % Also write species data as attributes
        h5writeatt([data_dir_h5 'fields.h5'],dataset_name, 'mass',mass(iSpecies)) 
        h5writeatt([data_dir_h5 'fields.h5'],dataset_name, 'charge',q(iSpecies)) 
        h5writeatt([data_dir_h5 'fields.h5'],dataset_name, 'dfac',dfac(iSpecies)) 
        % info.Groups(1).Groups(ig).Datasets(id).Attributes.Name
      end
    else
      warning(sprintf('Variable: %s skipped',varstrs{ivar}))
      continue      
    end   
    % Write attributes for group (iteration)
    h5writeatt([data_dir_h5 'fields.h5'],['/data/' str_iteration '/'], 'time',time)
    h5writeatt([data_dir_h5 'fields.h5'],['/data/' str_iteration '/'], 'dt',dt)
    % info.Groups(1).Groups(ig).Attributes.Name
  end
end

if 0 % Usage examples
  info = h5info(filePath);
  {info.Groups(2).Datasets.Name} % simulation information
  x = h5read(filePath,'/simulation_information/xe');
end

%% '/Volumes/Fountain/Data/PIC/tubrulencerun/data/';
% Better to save original data, and only necessary quantities
data_dir    = '/Volumes/Fountain/Data/PIC/turbulencerun/data/';
data_dir_h5 = '/Volumes/Fountain/Data/PIC/turbulencerun/data_h5/';
filePath = [data_dir_h5 'fields.h5'];
nSpecies = 4;
descSpecies = {'hot ion harris sheet plus uniform background',...
  'hot electron harris sheet plus uniform background',...
  'cold ions',...
  'cold electrons'};


%timesteps = 200:200:11000;

fileList = dir([data_dir '*fields*']);
nFiles = numel(fileList);
timesteps = zeros(nFiles,1);
for iFile = 1:nFiles
  timesteps(iFile) = str2num(fileList(iFile).name(8:12)); % wpe
end

% turb = PIC('/Volumes/Fountain/Data/PIC/turbulencerun/data_h5/fields.h5');
% remaining_timesteps = setdiff(timesteps,turb.twpe);

for itime = 1:numel(timesteps)
  timestep = timesteps(itime);  
  if find(timestep==turb.twpe)
    disp(sprintf('twpe = %g already exist, skipping.',timestep))
    continue
  end
  txtfile = sprintf('%s/fields-%05.0f.dat',data_dir,timestep); 
  
  
  % read unnormalized data
  tic; [varstrs,vars] = read_data_no_normalization(txtfile,nSpecies); toc
  nss = numel(vars{find(contains(varstrs,'mass'))}); % number of species
  nnx = vars{find(contains(varstrs,'nnx'))}; % number of grid points in x
  nnz = vars{find(contains(varstrs,'nnz'))}; % number of grid points in z
  
  % Load some vars and remove from vars and varstrs
  iter = vars{find(contains(varstrs,'it'))};   vars(find(contains(varstrs,'it'))) = [];   varstrs(find(contains(varstrs,'it'))) = [];
  time = vars{find(contains(varstrs,'time'))}; vars(find(contains(varstrs,'time'))) = []; varstrs(find(contains(varstrs,'time'))) = [];
  dt   = vars{find(contains(varstrs,'dt'))};   vars(find(contains(varstrs,'dt'))) = [];   varstrs(find(contains(varstrs,'dt'))) = [];
  mass = vars{find(contains(varstrs,'mass'))}; vars(find(contains(varstrs,'mass'))) = []; varstrs(find(contains(varstrs,'mass'))) = [];
  q    = vars{find(contains(varstrs,'q'))};    vars(find(contains(varstrs,'q'))) = [];    varstrs(find(contains(varstrs,'q'))) = [];
  dfac = vars{find(contains(varstrs,'dfac'))}; vars(find(contains(varstrs,'dfac'))) = []; varstrs(find(contains(varstrs,'dfac'))) = [];
  str_iteration = sprintf('%010.0f',iter); % same group format as SMILEI
    
  
  % Remaining non-datasize matrices are the same for each time, so only
  % save one time
    
  % loop through variables, and save to h5 file in 'filePath'
  %%
  nvars = numel(vars);  
  for ivar = 1:nvars
    data = vars{ivar};
    
    % check data size, and see if it needs splitting up, and where to save
    if itime == 1 && not(sum(ismember(size(data),[nnx nnz]))>=2)
      %continue % implement later
      disp(['/simulation_information/' varstrs{ivar}])
      h5create([data_dir_h5 'fields.h5'],['/simulation_information/' varstrs{ivar}], size(data));
      h5write([data_dir_h5 'fields.h5'],['/simulation_information/' varstrs{ivar}], data);
      continue % jump to next variable
    end
    
    % From here, we only read data field variables
    % Check if it is a field (E,B) or species data (n,j,vv)
    if ndims(data) == 2 && all(size(data) == [nnx nnz]) % is (E,B)
      dataset_name = ['/data/' str_iteration '/' varstrs{ivar}];
      disp(dataset_name)
      h5create([data_dir_h5 'fields.h5'], dataset_name, size(data));
      h5write( [data_dir_h5 'fields.h5'], dataset_name, data);
    elseif size(data,3) == nss % is (n,vs,vv)
      for iSpecies = 1:nss
        data_tmp = data(:,:,iSpecies);
        dataset_name = ['/data/' str_iteration '/' varstrs{ivar} '/' num2str(iSpecies)];
        disp(dataset_name)
        h5create([data_dir_h5 'fields.h5'], dataset_name, size(data_tmp));
        h5write( [data_dir_h5 'fields.h5'], dataset_name, data_tmp);
        % Also write species data as attributes
        h5writeatt([data_dir_h5 'fields.h5'],dataset_name, 'mass',mass(iSpecies)) 
        h5writeatt([data_dir_h5 'fields.h5'],dataset_name, 'charge',q(iSpecies)) 
        h5writeatt([data_dir_h5 'fields.h5'],dataset_name, 'dfac',dfac(iSpecies)) 
        % info.Groups(1).Groups(ig).Datasets(id).Attributes.Name
      end
    else
      warning(sprintf('Variable: %s skipped',varstrs{ivar}))
      continue      
    end   
    % Write attributes for group (iteration)
    h5writeatt([data_dir_h5 'fields.h5'],['/data/' str_iteration '/'], 'time',time)
    h5writeatt([data_dir_h5 'fields.h5'],['/data/' str_iteration '/'], 'dt',dt)
    % info.Groups(1).Groups(ig).Attributes.Name
  end
end

disp('Done.')

%% Add some extra derived quantities to h5 file, such as:
% reconnection rate, done
% X line locations, 
% maybe A
% total magnetic energy, done

sim = df04;
for it = 1:sim.length
  %it
  %tic
  Bx = sim(it).Bx; %toc
  Bz = sim(it).Bz; %toc
  A = vector_potential(sim.xi,sim.zi,squeeze(Bx),squeeze(Bz)); %toc
  [saddle_locations,saddle_values] = saddle(A,'sort'); %toc
  Ax(it) = saddle_values(1);
  %Eyx(it) = 
  contour(sim.xi(1:10:end),sim.zi(1:10:end),A(1:10:end,1:10:end)',[-25:0.5:8],'k');  %toc
  title(sprintf('t=%g',sim.twci(it))); drawnow;  
end

%% Particle distributions, df04
timestep = 7000; 

% Better to save original data, and only necessary quantities
data_dir    = '/Volumes/Fountain/Data/PIC/df_cold_protons_n04/data/';
data_dir_h5 = '/Volumes/Fountain/Data/PIC/df_cold_protons_n04/data_h5/';
data_dir    = sprintf('/Users/cno062/tesla/cno062/df_cold_protons_n04/distributions/%05.0f/',timestep);
filePath = [data_dir_h5 'dists.h5'];
nSpecies = 6;
descSpecies = {...
  'hot ion harris sheet plus uniform background',...
  'hot electron harris sheet plus uniform background',...
  'cold ions from south',...
  'cold electrons from south',...
  'cold ions from north',...
  'cold electrons from north'};

iter = timestep*2; % This is only true with constant timestep 0.5
dists = 1:4000;%367;%300;
nDists = numel(dists);
nss = 6;

for idist = 1466%:1667%1991%:1165%:390%255:367%:210%1:nDists  
  %idist = 10;
  distnumber = dists(idist);
  txtfile = sprintf('/Users/cno062/tesla/cno062/df_cold_protons_n04/distributions/%05.0f/%04.0f.dat',timestep,distnumber); % df04
  
  str_iteration = sprintf('%010.0f',iter);
  
  % Read distributions  
  [axes,xlo,xhi,zlo,zhi,ic,fxyz,fxy,fxz,fyz,vxa,vya,vza] = read_distributions(txtfile,nss);
      %break
  % Write data to file
  %for isp = 1:nss
    %dataset_name = ['/data/' str_iteration '/' num2str(distnumber),'/'];
    %h5create(filePath, dataset_name, size(fxyz));
    %h5write(filePath, dataset_name, fxyz);

    dataset_name = ['/data/' str_iteration '/' num2str(distnumber,'%05.0f'),'/fxyz'];
    try
      h5create(filePath, dataset_name, size(fxyz));
    catch
      warning('h5 structure %s already exists',dataset_name)      
    end
    h5write(filePath, dataset_name, fxyz);
    h5writeatt(filePath, dataset_name,'x', [xlo xhi]);
    h5writeatt(filePath, dataset_name,'z', [zlo zhi]);
    h5writeatt(filePath, dataset_name,'ic', ic);
    h5writeatt(filePath, dataset_name,'vxa', vxa);
    h5writeatt(filePath, dataset_name,'vya', vya);
    h5writeatt(filePath, dataset_name,'vza', vza);
    h5writeatt(filePath, dataset_name,'axes', axes);
    
    h5disp(filePath,dataset_name(1:(end-4)))
    %dataset_name = ['/data/' str_iteration '/' num2str(distnumber),'/fxy'];
    %h5create(filePath, dataset_name, size(fxy));
    %h5write(filePath, dataset_name, fxy);

    %dataset_name = ['/data/' str_iteration '/' num2str(distnumber),'/fxz'];
    %h5create(filePath, dataset_name, size(fxz));
    %h5write(filePath, dataset_name, fxz);

    %dataset_name = ['/data/' str_iteration '/' num2str(distnumber),'/fyz'];
    %h5create(filePath, dataset_name, size(fyz));
    %h5write(filePath, dataset_name, fyz);
  %end
  
      
  doPlot = 0;
  if doPlot
    %%
    isp = 1;
    dx = axes(2,isp)-axes(1,isp);
    dy = dx;
    dz = dx;
    h = setup_subplots(3,3);
    isub = 1;
    if 1
      hca = h(isub); isub = isub + 1;
      imagesc(hca,fxy(:,:,isp))
    end
    if 1
      hca = h(isub); isub = isub + 1;
      imagesc(hca,fxz(:,:,isp))
    end
    if 1
      hca = h(isub); isub = isub + 1;
      imagesc(hca,fyz(:,:,isp))
    end
    if 1
      hca = h(isub); isub = isub + 1;
      imagesc(hca,squeeze(sum(fxyz(:,:,:,isp),3))*16.5)
    end
    if 1
      hca = h(isub); isub = isub + 1;
      imagesc(hca,squeeze(sum(fxyz(:,:,:,isp),2)))
    end
    if 1
      hca = h(isub); isub = isub + 1;
      imagesc(hca,squeeze(sum(fxyz(:,:,:,isp),1)))
    end
    if 1
      hca = h(isub); isub = isub + 1;
      imagesc(hca,fxy(:,:,isp)-squeeze(sum(fxyz(:,:,:,isp),3))*17)
    end
    if 1
      hca = h(isub); isub = isub + 1;
      imagesc(hca,fxz(:,:,isp)-squeeze(sum(fxyz(:,:,:,isp),2)))
    end
    if 1
      hca = h(isub); isub = isub + 1;
      imagesc(hca,fyz(:,:,isp)-squeeze(sum(fxyz(:,:,:,isp),1)))
    end
    c_eval('colorbar(''peer'',h(?))',1:9)
    hlinks = linkprop(h,{'Clim'});
  end
    
end

%% Particle distributions, df04, from old h5 to new h5

% Better to save original data, and only necessary quantities
data_dir    = '/Volumes/Fountain/Data/PIC/df_cold_protons_n04/data/';
data_dir_h5 = '/Volumes/Fountain/Data/PIC/df_cold_protons_n04/data_h5/';
filePath = [data_dir_h5 'dists.h5'];
filePathOld = [data_dir_h5 'dists_old.h5'];
nSpecies = 6;

timestep = 8000; % 254
%timestep = 5000; % 259
iter = timestep*2; % timestep is 0.5
dists = 1:300;%300;
nDists = numel(dists);
nss = 6;
%old_format = '%05.0f'; new_format = '%05.0f'; old_iter = 10000; new_iter = 16000;
old_format = '%5.0f'; new_format = '%05.0f'; old_iter = 10000; new_iter = 10000;

for idist = 1:259%:210%1:nDists  
  %idist = 10;
  distnumber = dists(idist);
  %txtfile = sprintf('/Users/cno062/tesla/cno062/df_cold_protons_n04/distributions/%05.0f/%.0f.dat',timestep,distnumber); % df04
  
  str_iteration_new = sprintf('%010.0f',new_iter);
  str_iteration_old = sprintf('%010.0f',old_iter);
  
  % Read distributions  
  %[axes,xlo,xhi,zlo,zhi,ic,fxyz,fxy,fxz,fyz,vxa,vya,vza] = read_distributions(txtfile,nss);
      
  % Write data to file
  %for isp = 1:nss 
    %dataset_name = ['/data/' str_iteration '/' num2str(distnumber),'/'];
    %h5create(filePath, dataset_name, size(fxyz));
    %h5write(filePath, dataset_name, fxyz);

    dataset_name_old = ['/data/' str_iteration_old '/' num2str(distnumber,old_format),'/fxyz'];
    dataset_name = ['/data/' str_iteration_new '/' num2str(distnumber,new_format),'/fxyz'];
    %dataset_name = ['/data/' str_iteration '/' num2str(distnumber,'%.0f'),'/fxyz'];
    fxyz = h5read(filePathOld,dataset_name_old);
    try
      h5create(filePath, dataset_name, size(fxyz));
    catch
      warning('h5 structure %s already exists',dataset_name)      
    end    
    h5write(filePath, dataset_name, fxyz);
    
    h5writeatt(filePath, dataset_name,'x', h5readatt(filePathOld, dataset_name_old,'x'));
    h5writeatt(filePath, dataset_name,'z', h5readatt(filePathOld, dataset_name_old,'z'));
    h5writeatt(filePath, dataset_name,'ic', h5readatt(filePathOld, dataset_name_old,'ic'));
    h5writeatt(filePath, dataset_name,'vxa', h5readatt(filePathOld, dataset_name_old,'vxa'));
    h5writeatt(filePath, dataset_name,'vya', h5readatt(filePathOld, dataset_name_old,'vya'));
    h5writeatt(filePath, dataset_name,'vza', h5readatt(filePathOld, dataset_name_old,'vza'));
    h5writeatt(filePath, dataset_name,'axes', h5readatt(filePathOld, dataset_name_old,'axes'));
    
    h5disp(filePath,dataset_name(1:(end-4)))          
end

%% Particle distributions, df08
timestep = 6000; 
wpewce = 2;
mime = 25;

% Better to save original data, and only necessary quantities
data_dir    = '/Volumes/Fountain/Data/PIC/df_cold_protons_n08/data/';
data_dir_h5 = '/Volumes/Fountain/Data/PIC/df_cold_protons_n08/data_h5/';
data_dir    = sprintf('/Users/cno062/tesla/cno062/df_cold_protons_n08/distributions/%05.0f/',timestep);
filePath = [data_dir_h5 'dists.h5'];
nSpecies = 4;
descSpecies = {...
  'hot ion harris sheet plus uniform background',...
  'hot electron harris sheet plus uniform background',...
  'cold ions from south',...
  'cold electrons from south',...
  'cold ions from north',...
  'cold electrons from north'};

iter = timestep*2; % This is only true with constant timestep 0.5
str_iteration = sprintf('%010.0f',iter);
dists = 1:2000;%367;%300;
nDists = numel(dists);
nss = 4;

h5writeatt(filePath,['/data/' str_iteration],'twpe', timestep);
h5writeatt(filePath,['/data/' str_iteration],'twci', timestep/(wpewce*mime));

for idist = 662:900%:390%255:367%:210%1:nDists  
  %idist = 10;
  distnumber = dists(idist);
  txtfile = sprintf('%s/%04.0f.dat',data_dir,distnumber); % df04
  
  
  % Read distributions  
  [axes,xlo,xhi,zlo,zhi,ic,fxyz,fxy,fxz,fyz,vxa,vya,vza] = read_distributions(txtfile,nss);
      
  % Write data to file
  %for isp = 1:nss
    %dataset_name = ['/data/' str_iteration '/' num2str(distnumber),'/'];
    %h5create(filePath, dataset_name, size(fxyz));
    %h5write(filePath, dataset_name, fxyz);

    dataset_name = ['/data/' str_iteration '/' num2str(distnumber,'%05.0f'),'/fxyz'];
    try
      h5create(filePath, dataset_name, size(fxyz));
    catch
      warning('h5 structure %s already exists',dataset_name)      
    end
    h5write(filePath, dataset_name, fxyz);
    h5writeatt(filePath, dataset_name,'x', [xlo xhi]);
    h5writeatt(filePath, dataset_name,'z', [zlo zhi]);
    h5writeatt(filePath, dataset_name,'ic', ic);
    h5writeatt(filePath, dataset_name,'vxa', vxa);
    h5writeatt(filePath, dataset_name,'vya', vya);
    h5writeatt(filePath, dataset_name,'vza', vza);
    h5writeatt(filePath, dataset_name,'axes', axes);
    
    h5disp(filePath,dataset_name(1:(end-4)))
    %dataset_name = ['/data/' str_iteration '/' num2str(distnumber),'/fxy'];
    %h5create(filePath, dataset_name, size(fxy));
    %h5write(filePath, dataset_name, fxy);

    %dataset_name = ['/data/' str_iteration '/' num2str(distnumber),'/fxz'];
    %h5create(filePath, dataset_name, size(fxz));
    %h5write(filePath, dataset_name, fxz);

    %dataset_name = ['/data/' str_iteration '/' num2str(distnumber),'/fyz'];
    %h5create(filePath, dataset_name, size(fyz));
    %h5write(filePath, dataset_name, fyz);
  %end
  
      
  doPlot = 0;
  if doPlot
    %%
    isp = 1;
    dx = axes(2,isp)-axes(1,isp);
    dy = dx;
    dz = dx;
    h = setup_subplots(3,3);
    isub = 1;
    if 1
      hca = h(isub); isub = isub + 1;
      imagesc(hca,fxy(:,:,isp))
    end
    if 1
      hca = h(isub); isub = isub + 1;
      imagesc(hca,fxz(:,:,isp))
    end
    if 1
      hca = h(isub); isub = isub + 1;
      imagesc(hca,fyz(:,:,isp))
    end
    if 1
      hca = h(isub); isub = isub + 1;
      imagesc(hca,squeeze(sum(fxyz(:,:,:,isp),3))*16.5)
    end
    if 1
      hca = h(isub); isub = isub + 1;
      imagesc(hca,squeeze(sum(fxyz(:,:,:,isp),2)))
    end
    if 1
      hca = h(isub); isub = isub + 1;
      imagesc(hca,squeeze(sum(fxyz(:,:,:,isp),1)))
    end
    if 1
      hca = h(isub); isub = isub + 1;
      imagesc(hca,fxy(:,:,isp)-squeeze(sum(fxyz(:,:,:,isp),3))*17)
    end
    if 1
      hca = h(isub); isub = isub + 1;
      imagesc(hca,fxz(:,:,isp)-squeeze(sum(fxyz(:,:,:,isp),2)))
    end
    if 1
      hca = h(isub); isub = isub + 1;
      imagesc(hca,fyz(:,:,isp)-squeeze(sum(fxyz(:,:,:,isp),1)))
    end
    c_eval('colorbar(''peer'',h(?))',1:9)
    hlinks = linkprop(h,{'Clim'});
  end
    
end

%% Particle distributions, gf05
timestep = 5000; 
wpewce = 2;
mime = 25;

% Better to save original data, and only necessary quantities
data_dir    =         '/Volumes/Fountain/Data/PIC/guide_field_05_cold_ions/data/';
data_dir_h5 =         '/Volumes/Fountain/Data/PIC/guide_field_05_cold_ions/data_h5/';
data_dir    = sprintf('/Volumes/Fountain/Data/PIC/guide_field_05_cold_ions/distributions/%05.0f/',timestep);
filePath = [data_dir_h5 'dists.h5'];
nSpecies = 4;
descSpecies = {...
  'hot ion harris sheet plus uniform background',...
  'hot electron harris sheet plus uniform background',...
  'cold ions from north',...
  'cold electrons from north'};

iter = timestep*2; % This is only true with constant timestep 0.5
str_iteration = sprintf('%010.0f',iter);
dists = 1:2000;%367;%300;
nDists = numel(dists);
nss = 4;
nv = 121;

%h5writeatt(filePath,['/data/' str_iteration],'twpe', timestep);
%h5writeatt(filePath,['/data/' str_iteration],'twci', timestep/(wpewce*mime));

for idist = 6:663%601:605%663%:390%255:367%:210%1:nDists  
  %idist = 10;
  distnumber = dists(idist);
  txtfile = sprintf('%s/%04.0f.dat',data_dir,distnumber); % df04
  
  
  % Read distributions  
  [axes,xlo,xhi,zlo,zhi,ic,fxyz,fxy,fxz,fyz,vxa,vya,vza] = read_distributions(txtfile,nss,nv);
      
  % Write data to file
  %for isp = 1:nss
    %dataset_name = ['/data/' str_iteration '/' num2str(distnumber),'/'];
    %h5create(filePath, dataset_name, size(fxyz));
    %h5write(filePath, dataset_name, fxyz);

    dataset_name = ['/data/' str_iteration '/' num2str(distnumber,'%05.0f'),'/fxyz'];
    try
      h5create(filePath, dataset_name, size(fxyz));
    catch
      warning('h5 structure %s already exists',dataset_name)      
    end
    h5write(filePath, dataset_name, fxyz);
    h5writeatt(filePath, dataset_name,'x', [xlo xhi]);
    h5writeatt(filePath, dataset_name,'z', [zlo zhi]);
    h5writeatt(filePath, dataset_name,'ic', ic);
    h5writeatt(filePath, dataset_name,'vxa', vxa);
    h5writeatt(filePath, dataset_name,'vya', vya);
    h5writeatt(filePath, dataset_name,'vza', vza);
    h5writeatt(filePath, dataset_name,'axes', axes);
    
    h5disp(filePath,dataset_name(1:(end-4)))
    %dataset_name = ['/data/' str_iteration '/' num2str(distnumber),'/fxy'];
    %h5create(filePath, dataset_name, size(fxy));
    %h5write(filePath, dataset_name, fxy);

    %dataset_name = ['/data/' str_iteration '/' num2str(distnumber),'/fxz'];
    %h5create(filePath, dataset_name, size(fxz));
    %h5write(filePath, dataset_name, fxz);

    %dataset_name = ['/data/' str_iteration '/' num2str(distnumber),'/fyz'];
    %h5create(filePath, dataset_name, size(fyz));
    %h5write(filePath, dataset_name, fyz);
  %end
  
      
  doPlot = 0;
  if doPlot
    %%
    isp = 1;
    dx = axes(2,isp)-axes(1,isp);
    dy = dx;
    dz = dx;
    h = setup_subplots(3,3);
    isub = 1;
    if 1
      hca = h(isub); isub = isub + 1;
      imagesc(hca,fxy(:,:,isp))
    end
    if 1
      hca = h(isub); isub = isub + 1;
      imagesc(hca,fxz(:,:,isp))
    end
    if 1
      hca = h(isub); isub = isub + 1;
      imagesc(hca,fyz(:,:,isp))
    end
    if 1
      hca = h(isub); isub = isub + 1;
      imagesc(hca,squeeze(sum(fxyz(:,:,:,isp),3))*16.5)
    end
    if 1
      hca = h(isub); isub = isub + 1;
      imagesc(hca,squeeze(sum(fxyz(:,:,:,isp),2)))
    end
    if 1
      hca = h(isub); isub = isub + 1;
      imagesc(hca,squeeze(sum(fxyz(:,:,:,isp),1)))
    end
    if 1
      hca = h(isub); isub = isub + 1;
      imagesc(hca,fxy(:,:,isp)-squeeze(sum(fxyz(:,:,:,isp),3))*17)
    end
    if 1
      hca = h(isub); isub = isub + 1;
      imagesc(hca,fxz(:,:,isp)-squeeze(sum(fxyz(:,:,:,isp),2)))
    end
    if 1
      hca = h(isub); isub = isub + 1;
      imagesc(hca,fyz(:,:,isp)-squeeze(sum(fxyz(:,:,:,isp),1)))
    end
    c_eval('colorbar(''peer'',h(?))',1:9)
    hlinks = linkprop(h,{'Clim'});
  end
    
end

%% Trajectories
data_dir_h5 = '/Volumes/Fountain/Data/PIC/df_cold_protons_n04/data_h5/';
filePath = [data_dir_h5 'trajectories.h5'];
doAppend = 1; % for future
tr_arr = traj;
nPeaks = size(tr_arr,1);
spacingPeaks = 4;
iSpecies = 3; % I think, can be double checked and overwritten later
m = 1/25;
q = -1;
pic = df04;
dist = ds04(2);
tr04 = PICTraj('/Volumes/Fountain/Data/PIC/df_cold_protons_n04/data_h5/trajectories.h5');
iTr0 = tr04.ntr; % add number to append correctly.
for iTr = 1:numel(tr_arr)
  % To implement: check if the trajectory is already there
  
  [iPeak,iDist] = ind2sub(size(tr_arr),iTr);
  % Get trajectory structure from array
  tr = tr_arr(iTr);
  
  % Get fields at location
  if 0
    [Ex,Ey,Ez,Bx,By,Bz] = pic.interp_EB3(tr.x,tr.z,tr.t);  % interpolate
  else
    Ex = tr.Ex;
    Ey = tr.Ey;
    Ez = tr.Ez;
    Bx = tr.Bx;
    By = tr.By;
    Bz = tr.Bz;
  end
  %vxB = cross_product(tr.vx,tr.vy,tr.vz,Bx,By,Bz,'components',1); % calculate force
  
  % Information about how initial r0, v0 were chosen
  ds = dist.xlim(tr.x0+[-0.1 0.1]).zlim(tr.z0+[-0.1 0.1]);
  fpeaks_info.t = ds.iteration/2; % need to fix time for distributions class
  fpeaks_info.x = ds.xi{1}{1};
  fpeaks_info.z = ds.zi{1}{1};
  fpeaks_info.spacingPeaks = spacingPeaks;
  fpeaks_info.nPeaks = nPeaks;  
  fpeaks_info.iPeak = iPeak;
  fpeaks_info.iSpecies = iSpecies;
  
  %tags = {'outflow','agu'};
  fpeaks_ind = -1;
  
  iTr_str = sprintf('%06.0f',iTr+iTr0);
  group_name = ['/traj/' iTr_str '/'];
  
  %continue
  %
  
  h5create(filePath, [group_name 't'], size(tr.t));
  %catch
  %warning('h5 structure %s already exists',[group_name 't'])      
  %end
  
  
  h5create(filePath, [group_name 'x'], size(tr.t));  
  h5create(filePath, [group_name 'y'], size(tr.t));
  h5create(filePath, [group_name 'z'], size(tr.t));
  h5create(filePath, [group_name 'vx'], size(tr.t));
  h5create(filePath, [group_name 'vy'], size(tr.t));
  h5create(filePath, [group_name 'vz'], size(tr.t));
  h5create(filePath, [group_name 'Ex'], size(tr.t));  
  h5create(filePath, [group_name 'Ey'], size(tr.t));
  h5create(filePath, [group_name 'Ez'], size(tr.t));
  h5create(filePath, [group_name 'Bx'], size(tr.t));
  h5create(filePath, [group_name 'By'], size(tr.t));
  h5create(filePath, [group_name 'Bz'], size(tr.t));
  
  h5write(filePath, [group_name 't'], tr.t);
  h5write(filePath, [group_name 'x'], tr.x);
  h5write(filePath, [group_name 'y'], tr.y);
  h5write(filePath, [group_name 'z'], tr.z);
  h5write(filePath, [group_name 'vx'], tr.vx);
  h5write(filePath, [group_name 'vy'], tr.vy);
  h5write(filePath, [group_name 'vz'], tr.vz);
  h5write(filePath, [group_name 'Ex'], Ex);
  h5write(filePath, [group_name 'Ey'], Ey);
  h5write(filePath, [group_name 'Ez'], Ez);
  h5write(filePath, [group_name 'Bx'], Bx);
  h5write(filePath, [group_name 'By'], By);
  h5write(filePath, [group_name 'Bz'], Bz);
    
  h5writeatt(filePath, group_name,'t0', 160); % tr.t0
  h5writeatt(filePath, group_name,'x0', tr.x0);
  h5writeatt(filePath, group_name,'y0', tr.y0);
  h5writeatt(filePath, group_name,'z0', tr.z0);
  h5writeatt(filePath, group_name,'vx0', tr.vx0);
  h5writeatt(filePath, group_name,'vy0', tr.vy0);
  h5writeatt(filePath, group_name,'vz0', tr.vz0);  
  h5writeatt(filePath, group_name,'m', m);
  h5writeatt(filePath, group_name,'q', q);
  %h5writeatt(filePath, group_name,'tags', tags);
  h5writeatt(filePath, group_name,'fpeaks_x', fpeaks_info.x);
  h5writeatt(filePath, group_name,'fpeaks_z', fpeaks_info.z);
  h5writeatt(filePath, group_name,'fpeaks_spacingPeaks', fpeaks_info.spacingPeaks);
  h5writeatt(filePath, group_name,'fpeaks_nPeaks', fpeaks_info.nPeaks);
  h5writeatt(filePath, group_name,'fpeaks_iPeak', fpeaks_info.iPeak);
  h5writeatt(filePath, group_name,'fpeaks_t', fpeaks_info.t);
  h5writeatt(filePath, group_name,'RelTol', tr.options.RelTol);
  h5writeatt(filePath, group_name,'AbsTol', tr.options.AbsTol);

  h5disp(filePath,group_name)
    
end

%% Trajectories, add attribute(s)
data_dir_h5 = '/Volumes/Fountain/Data/PIC/df_cold_protons_n04/data_h5/';
filePath = [data_dir_h5 'trajectories.h5'];

for iTr = 1:425%201:numel(tr_arr)
  % To implement: check if the trajectory is already there
   
  iTr_str = sprintf('%06.0f',iTr);
  group_name = ['/traj/' iTr_str '/'];
  
    
  h5writeatt(filePath, group_name,'AbsTol', 1e-14);      
  h5writeatt(filePath, group_name,'RelTol', []);
end

%% Trajectories, add correct electric field 
data_dir_h5 = '/Volumes/Fountain/Data/PIC/df_cold_protons_n04/data_h5/';
filePath = [data_dir_h5 'trajectories.h5'];
tr_arr = tr04;
pic = df04;

for iTr = [trif.id] %201:numel(tr_arr)
  % To implement: check if the trajectory is already there
  tr = tr_arr(iTr);
  if not(nansum(tr.Ex-tr.Ez)==0)
    continue
  end
  tic
  Eztmp = pic.interp(tr.x,tr.z,tr.t,'Ez');
  toc
  
  iTr_str = sprintf('%06.0f',iTr);
  group_name = ['/traj/' iTr_str '/'];
  
    
  h5write(filePath,[group_name 'Ez'],Eztmp);      
  
end