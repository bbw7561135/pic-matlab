% Pick simulation
% make function that searches for possible data locations automatically
simulation = 'michael'; 
simulation = 'cold_protons_new_boundary';
%simulation = 'df_cold_protons_0.4';
simulation = 'circular_perturbation';
simulation = 'guide_field_05';
simulation = 'guide_field_05_cold_ions';
switch simulation
  case 'df_cold_protons_0.8'
    savedir_root = '/Users/cno062/Research/PIC/df_cold_protons_1/';
    data_dir = '/Volumes/Fountain/Data/PIC/df_cold_protons_1/data/';
    %data_dir = '/Volumes/pic/in_progress/df_cold_protons_04/data/';
    nss = 4;
  case 'df_cold_protons_0.4'
    savedir_root = '/Users/cno062/GoogleDrive/Research/PIC/df_cold_protons_04/';
    data_dir = '/Volumes/Fountain/Data/PIC/df_cold_protons_n04/data/';
    data_dir = '/Volumes/Fountain/Data/PIC/df_cold_protons_n04/data/';
    %data_dir = '/Volumes/pic/in_progress/df_cold_protons_04/data/';
    nss = 6; 
  case 'proton_baseline'
    savedir_root = '/Users/cno062/Research/PIC/df_cold_protons_04/';
    data_dir = '/Volumes/pic/finished_runs/proton_baseline/data/';
    nss = 4;
  case 'michael'
    savedir_root = '/Users/cno062/Research/PIC/michael_run/';
    savedir_root = '/Users/cno062/GoogleDrive/Research/PIC/michael_run/';
    data_dir = '/Volumes/Fountain/Data/PIC/michael_run/data/';
    %data_dir = '/Volumes/pic/finished_runs/turbulencerun/data';
    data_dir_resave = '/Volumes/pic/finished_runs/turbulencerun/data_separated/';
    nss = 4;
  case 'cold_protons_new_boundary'
    savedir_root = '/Users/cno062/Research/PIC/cold_protons_new_boundary/';
    data_dir = '/Volumes/Fountain/Data/PIC/df_cold_protons_04_new_boundary/data/';
    data_dir = '/Volumes/Fountain/Data/PIC/df_cold_protons_04_new_boundary/data/';
    %data_dir = '/Volumes/pic/in_progress/df_cold_protons_04/data/';
    data_dir = '/Users/cno062/tesla/cold_ion_new_boundary/data/';
    nss = 6;
  case 'circular_perturbation'
    savedir_root = '/Users/cecilia/Research/PIC/guide_field_05/';
    data_dir = '/Volumes/Fountain/Data/PIC/guide_field_05/data/';    
    nss = 6;
  case 'guide_field_05'
    savedir_root = '/Users/cecilia/Research/PIC/guide_field_05/';
    data_dir = '/Volumes/Fountain/Data/PIC/guide_field_05/data/';    
    nss = 6;
  case 'guide_field_05_cold_ions'
    savedir_root = '/Users/cecilia/Research/PIC/guide_field_05_cold_ions/';
    data_dir = '/Volumes/Fountain/Data/PIC/guide_field_05_cold_ions/data/';
    nss = 4;
end

%% Load data
timestep = 05000;
timestep = 05978;
timestep = 02250;
timestep = 07000;
timestep = 05000; % 26th file
timestep = 07000;
timestep = 4600;
txtfile = sprintf('%s/fields-%05.0f.dat',data_dir,timestep);


tic;
%all_data = read_fields_adaptive(txtfile,'nss',nss,'group',{[1 3],[2 4]},'grouponly');
%all_data = read_fields_adaptive(txtfile,'nss',nss,'group',{[3 5],[4 6]});
all_data = read_fields_adaptive(txtfile,'nss',nss);
ndata = size(all_data,1);
disp('Loaded: ')
for idata = 1:ndata
  eval([all_data{idata,1} ' = all_data{idata,2};' ]);
  fprintf('%s ',all_data{idata,1})
end
fprintf('\n') 
toc;
xshift = mean(x);
x = x-xshift;
dx = x(2)-x(1);
dz = z(2)-z(1);
A = vector_potential(x,z,B.x,B.z); % vector potential
[saddle_locations,saddle_values] = saddle(A);

xLineInd = saddle_locations(find(saddle_values==max(saddle_values)),:);
xLineXY = [x(xLineInd(1)) x(xLineInd(2))];

%% Load separated data, mostly for time derivatives
varstrs = {'vi12','ve12'};
loadSeparated = 1;
timesteps = timestep;
if loadSeparated    
  %%
  fileList = dir([data_dir_resave filesep varstrs{1} filesep '*' varstrs{1} '*']);
  nFiles = numel(fileList);
  timesteps_ = zeros(nFiles,1);  
  for iFile = 1:nFiles
    timesteps_(iFile) = str2num(fileList(iFile).name(numel(varstrs{1})+2+(1:5)));
  end
  timesteps_ind = find(timesteps_==timestep)+[-1:1:1];
  timesteps = timesteps_(timesteps_ind);
  disp(sprintf('Calculating time derivative using timesteps %g %g %g',timesteps(1),timesteps(2),timesteps(3)))
  for ivar = 1:numel(varstrs)
    [~,data] = fun_load_resaved_data(data_dir_resave,{varstrs{ivar}},timesteps);
    eval(sprintf('%s_ts_ = data;',varstrs{ivar}))
  end
end


dt1 = (timesteps(2)-timesteps(1))/(wpewce/(mass(2)/mass(1)));
dt2 = (timesteps(3)-timesteps(2))/(wpewce/(mass(2)/mass(1)));
clear dve12dt dvi12dt
dve12dt.x = 0.5*(squeeze(ve12_ts_(2,:,:,1)-ve12_ts_(1,:,:,1))./dt1 + squeeze(ve12_ts_(3,:,:,1)-ve12_ts_(2,:,:,1))./dt2);
dve12dt.y = 0.5*(squeeze(ve12_ts_(2,:,:,2)-ve12_ts_(1,:,:,2))./dt1 + squeeze(ve12_ts_(3,:,:,2)-ve12_ts_(2,:,:,2))./dt2);
dve12dt.z = 0.5*(squeeze(ve12_ts_(2,:,:,3)-ve12_ts_(1,:,:,3))./dt1 + squeeze(ve12_ts_(3,:,:,3)-ve12_ts_(2,:,:,3))./dt2);
dvi12dt.x = 0.5*(squeeze(vi12_ts_(2,:,:,1)-vi12_ts_(1,:,:,1))./dt1 + squeeze(vi12_ts_(3,:,:,1)-vi12_ts_(2,:,:,1))./dt2);
dvi12dt.y = 0.5*(squeeze(vi12_ts_(2,:,:,2)-vi12_ts_(1,:,:,2))./dt1 + squeeze(vi12_ts_(3,:,:,2)-vi12_ts_(2,:,:,2))./dt2);
dvi12dt.z = 0.5*(squeeze(vi12_ts_(2,:,:,3)-vi12_ts_(1,:,:,3))./dt1 + squeeze(vi12_ts_(3,:,:,3)-vi12_ts_(2,:,:,3))./dt2);

fi12_dv_temp = structfun(@(x) mass(1)/mass(1)*x,  dvi12dt ,'UniformOutput',false);
fe12_dv_temp = structfun(@(x) mass(2)/mass(1)*x,  dve12dt ,'UniformOutput',false);

%% Calculate auxillary quantities
iss = 1;
%[fi1_dv_temp,fi1_dv_conv,fi1_E,fi1_vxB,fi1_div_p] = fun_calc_force_terms([],x,z,mass(iss),q(iss),ni1,vi1,pi1,E,B,'nlim',0.02);
%[fi2_dv_temp,fi2_dv_conv,fi2_E,fi2_vxB,fi2_div_p] = fun_calc_force_terms([],x,z,mass(iss),q(iss),ni2,vi2,pi2,E,B,'nlim',0.02);
%[fi12_dv_temp,fi12_dv_conv,fi12_E,fi12_vxB,fi12_div_p] = fun_calc_force_terms([],x,z,mass(iss),q(iss),ni12,vi12,pi12,E,B,'nlim',0.02);
E_ = E;
E_.y = E.y-0.12;
[fi12_dv_temp,fi12_dv_conv,fi12_E,fi12_vxB,fi12_div_p] = fun_calc_force_terms([],x,z,mass(iss),q(iss),ni12,vi12,pi12,E,B,'nlim',0.01,'comp',1);
iss = 2;
%[fe1_dv_temp,fe1_dv_conv,fe1_E,de1_vxB,fe1_div_p] = fun_calc_force_terms([],x,z,mass(iss),q(iss),ne1,ve1,pe1,E,B,'nlim',0.02);
%[fe2_dv_temp,fe2_dv_conv,fe2_E,fe2_vxB,fe2_div_p] = fun_calc_force_terms([],x,z,mass(iss),q(iss),ne2,ve2,pe2,E,B,'nlim',0.02);
%[fe12_dv_temp,fe12_dv_conv,fe12_E,fe12_vxB,fe12_div_p] = fun_calc_force_terms([],x,z,mass(iss),q(iss),ne12,ve12,pe12,E,B,'nlim',0.02);
[fe12_dv_temp,fe12_dv_conv,fe12_E,fe12_vxB,fe12_div_p] = fun_calc_force_terms([],x,z,mass(iss),q(iss),ne12,ve12,pe12,E,B,'nlim',0.01,'comp',1);

fe12_dv_conv = vector_par_perp(fe12_dv_conv,B,'add');
fi12_dv_conv = vector_par_perp(fi12_dv_conv,B,'add');
%%
%A = vector_potential(x,z,B.x,B.z); % vector potential
%phi = scalar_potential(x,z,E.x,E.z,ni,ne); % vector potential
phi = scalar_potential(x,z,E.x,E.z,ni1+ni2,ne1+ne2); % scalar potential
grad_phi = grad_scalar(x,z,phi); % backward check, compare to E
%[saddle_locations,saddle_values] = saddle(A);
%[A_volume,A_map] = fluxtube_volume(A,-30:1:1);
%[saddle_locations,saddle_values] = fluxtube_volume(A);

%pic_calc_script
%%

[r1,r2,r3] = new_csys(B,[0 1 0]);
tic;te12_fac = rotate_tens(te12,r1,r2,r3); toc
tic;ti12_fac = rotate_tens(ti12,r1,r2,r3); toc

tic;te12_fac = rotate_tens(te12,r1,r2,r3); toc
tic;ti12_fac = rotate_tens(ti12,r1,r2,r3); toc


B.abs = sqrt(B.x.^2 + B.y.^2 + B.z.^2);
b.x = B.x./B.abs;
b.y = B.y./B.abs;
b.z = B.z./B.abs;

% Parallel and perpendicular electric field
E.abs = sqrt(E.x.^2 + E.y.^2 + E.z.^2);
E.par = (E.x.*b.x + E.y.*b.y + E.z.*b.z);
E.perp.x = E.x - E.par.*b.x;
E.perp.y = E.y - E.par.*b.y;
E.perp.z = E.z - E.par.*b.z;
ve12xB = cross_product(ve12.x,ve12.y,ve12.z,B.x,B.y,B.z);
vi12xB = cross_product(vi12.x,vi12.y,vi12.z,B.x,B.y,B.z);

% Thermal velocities
c_eval('vte?.par = 2*sqrt(te?_fac.xx/(mass(2)/mass(1))); vte?.par = real(vte?.par);',12) % obs, fix temperature instead
c_eval('vte?.perp = 2*sqrt(0.5*(te?_fac.yy+te?_fac.zz)/(mass(2)/mass(1))); vte?.perp = real(vte?.perp);',12) % obs, fix temperature instead
c_eval('vti?.par = 2*sqrt(ti?_fac.xx/(mass(2)/mass(1))); vti?.par = real(vti?.par);',12) % obs, fix temperature instead
c_eval('vti?.perp = 2*sqrt(0.5*(ti?_fac.yy+ti?_fac.zz)/(mass(2)/mass(1))); vti?.perp = real(vti?.perp);',12) % obs, fix temperature instead


% Frequencies
c_eval('wce? = B.abs/(mass(2)/mass(1));',12)
c_eval('wci? = B.abs/(mass(1)/mass(1));',12)

% Length scales
c_eval('re? = vte?.perp./wce?;',12)
c_eval('ri? = vti?.perp./wci?;',12)
%%
% r1 = b; % magnetic field unit vector
% r2 = cross_product(r1.x,r1.y,r1.z,0,1,0);
% r2.abs = sqrt(r2.x.^2 + r2.y.^2 + r2.z.^2);
% r2.x = r2.x./r2.abs;
% r2.y = r2.y./r2.abs;
% r2.z = r2.z./r2.abs;
% r2.abs = sqrt(r2.x.^2 + r2.y.^2 + r2.z.^2);
% r2 = cross_product(r2.x,r2.y,r2.z,r1.x,r1.y,r1.z);
% r3 = cross_product(r1.x,r1.y,r1.z,r2.x,r2.y,r2.z);
% r3.abs = sqrt(r3.x.^2 + r3.y.^2 + r3.z.^2);

[r1,r2,r3] = new_csys(B,[0 1 0]);

tic;te12_fac = rotate_tens(te1,r1,r2,r3); toc
tic;te2_fac = rotate_tens(te2,r1,r2,r3); toc
tic;ti1_fac = rotate_tens(ti1,r1,r2,r3); toc
tic;ti2_fac = rotate_tens(ti2,r1,r2,r3); toc
te1_perp = 0.5*(te1_fac.yy + te1_fac.zz);
te1_par = te1_fac.xx;
te2_perp = 0.5*(te2_fac.yy + te2_fac.zz);
te2_par = te2_fac.xx;
ti1_perp = 0.5*(ti1_fac.yy + ti1_fac.zz);
ti1_par = ti1_fac.xx;
ti2_perp = 0.5*(ti2_fac.yy + ti2_fac.zz);
ti2_par = ti2_fac.xx;

tic;te2_fac = rotate_tens(te2,r1,r2,r3); toc
tic;te23_fac = rotate_tens(te23,r1,r2,r3); toc
tic;ti2_fac = rotate_tens(ti2,r1,r2,r3); toc
tic;ti23_fac = rotate_tens(ti23,r1,r2,r3); toc
te2_perp = 0.5*(te2_fac.yy + te2_fac.zz);
te2_par = te2_fac.xx;
te23_perp = 0.5*(te23_fac.yy + te23_fac.zz);
te23_par = te23.xx;
ti2_perp = 0.5*(ti2_fac.yy + ti2_fac.zz);
ti2_par = ti2_fac.xx;
ti23_perp = 0.5*(ti23_fac.yy + ti23_fac.zz);
ti23_par = ti23_fac.xx;

% Stream functions
c_eval('Se?.xz = vector_potential(x,z,ve?.x,ve?.z);',1:2) % stream function
c_eval('Si?.xz = vector_potential(x,z,vi?.x,vi?.z);',1:2) % stream function

jtot.x = ji1.x + ji2.x - je1.x - je2.x;
jtot.y = ji1.y + ji2.y - je1.y - je2.y;
jtot.z = ji1.z + ji2.z - je1.z - je2.z;
