%% Define times
timesteps = 00200:200:09200;
ntimes = numel(timesteps);
savedir_root = '/Users/cno062/Research/PIC/df_cold_protons_1/';
data_dir = '/Volumes/Fountain/Data/PIC/df_cold_protons_1/data/';
screensize = get( groot, 'Screensize' );


%% Quantities to plot
clear subdirs_all varstrs_all clims_all cylims_all nrows_all plot_structure      
iplot = 0;
if 0 % vex, vepar
  iplot = iplot + 1;

  subdirs_all{iplot} = 'vex_vepar';
  varstrs_all{iplot} = {'ve1.x','ve2.x','ve1.par','ve2.par'};
  clims_all{iplot} = [-3 3];        
  cylims_all{iplot} = clims_all{iplot};
  nrows_all{iplot} = 2; % ncols is calculated from nrows and nvars

  plot_structure.subdir = subdirs_all{iplot};
  plot_structure.varstrs = varstrs_all{iplot};
  plot_structure.clim = clims_all{iplot};
  plot_structure.cylim = cylims_all{iplot};
  plot_structure.nrows = nrows_all{iplot};
  plot_structures_all{iplot} = plot_structure;
end
if 0 % vix, vipar
  iplot = iplot + 1;

  subdirs_all{iplot} = 'vix_vipar';
  varstrs_all{iplot} = {'vi1.x','vi2.x','vi1.par','vi2.par'};
  clims_all{iplot} = 0.5*[-1 1];        
  cylims_all{iplot} = clims_all{iplot};
  nrows_all{iplot} = 2; % ncols is calculated from nrows and nvars

  plot_structure.subdir = subdirs_all{iplot};
  plot_structure.varstrs = varstrs_all{iplot};
  plot_structure.clim = clims_all{iplot};
  plot_structure.cylim = cylims_all{iplot};
  plot_structure.nrows = nrows_all{iplot};
  plot_structures_all{iplot} = plot_structure;
end
if 0 % vex vey vez
  iplot = iplot + 1;

  subdirs_all{iplot} = 've_xyz';
  varstrs_all{iplot} = {'ve1.x','ve2.x','ve1.y','ve2.y','ve1.z','ve2.z'};
  clims_all{iplot} = [-3 3];        
  cylims_all{iplot} = clims_all{iplot};
  nrows_all{iplot} = 3; % ncols is calculated from nrows and nvars

  plot_structure.subdir = subdirs_all{iplot};
  plot_structure.varstrs = varstrs_all{iplot};
  plot_structure.clim = clims_all{iplot};
  plot_structure.cylim = cylims_all{iplot};
  plot_structure.nrows = nrows_all{iplot};
  plot_structures_all{iplot} = plot_structure;
end
if 0 % vix viy viz
  iplot = iplot + 1;

  subdirs_all{iplot} = 'vi_xyz';
  varstrs_all{iplot} = {'vi1.x','vi2.x','vi1.y','vi2.y','vi1.z','vi2.z'};
  clims_all{iplot} = 0.5*[-1 1];        
  cylims_all{iplot} = clims_all{iplot};
  nrows_all{iplot} = 3; % ncols is calculated from nrows and nvars

  plot_structure.subdir = subdirs_all{iplot};
  plot_structure.varstrs = varstrs_all{iplot};
  plot_structure.clim = clims_all{iplot};
  plot_structure.cylim = cylims_all{iplot};
  plot_structure.nrows = nrows_all{iplot};
  plot_structures_all{iplot} = plot_structure;
end  
if 0 % ni, ne
  iplot = iplot + 1;

  subdirs_all{iplot} = 'n';
  varstrs_all{iplot} = {'ne1','ne2','ni1','ni2'};
  clims_all{iplot} = [-3 3];        
  cylims_all{iplot} = [0 clims_all{iplot}(2)];
  nrows_all{iplot} = 2; % ncols is calculated from nrows and nvars

  plot_structure.subdir = subdirs_all{iplot};
  plot_structure.varstrs = varstrs_all{iplot};
  plot_structure.clim = clims_all{iplot};
  plot_structure.cylim = cylims_all{iplot};
  plot_structure.nrows = nrows_all{iplot};
  plot_structures_all{iplot} = plot_structure;
end
if 0 % Pe1 tensor
  iplot = iplot + 1;

  subdirs_all{iplot} = 'pe1_tensor';
  varstrs_all{iplot} = {'pe1.xx','pe1.xy','pe1.yy','pe1.xz','pe1.zz','pe1.yz'};
  clims_all{iplot} = 0.25*[-1 1];        
  cylims_all{iplot} = [0 clims_all{iplot}(2)];
  nrows_all{iplot} = 3; % ncols is calculated from nrows and nvars

  plot_structure.subdir = subdirs_all{iplot};
  plot_structure.varstrs = varstrs_all{iplot};
  plot_structure.clim = clims_all{iplot};
  plot_structure.cylim = cylims_all{iplot};
  plot_structure.nrows = nrows_all{iplot};
  plot_structures_all{iplot} = plot_structure;
end
if 0 % Pi1 tensor
  iplot = iplot + 1;

  subdirs_all{iplot} = 'pi1_tensor';
  varstrs_all{iplot} = {'pi1.xx','pi1.xy','pi1.yy','pi1.xz','pi1.zz','pi1.yz'};
  clims_all{iplot} = 1*[-1 1];        
  cylims_all{iplot} = [0 clims_all{iplot}(2)];
  nrows_all{iplot} = 3; % ncols is calculated from nrows and nvars

  plot_structure.subdir = subdirs_all{iplot};
  plot_structure.varstrs = varstrs_all{iplot};
  plot_structure.clim = clims_all{iplot};
  plot_structure.cylim = cylims_all{iplot};
  plot_structure.nrows = nrows_all{iplot};
  plot_structures_all{iplot} = plot_structure;
end
if 1 % Pe2 tensor
  iplot = iplot + 1;

  subdirs_all{iplot} = 'pe2_tensor';
  varstrs_all{iplot} = {'pe2.xx','pe2.xy','pe2.yy','pe2.xz','pe2.zz','pe2.yz'};
  clims_all{iplot} = 0.25*[-1 1];        
  cylims_all{iplot} = [0 clims_all{iplot}(2)];
  nrows_all{iplot} = 3; % ncols is calculated from nrows and nvars

  plot_structure.subdir = subdirs_all{iplot};
  plot_structure.varstrs = varstrs_all{iplot};
  plot_structure.clim = clims_all{iplot};
  plot_structure.cylim = cylims_all{iplot};
  plot_structure.nrows = nrows_all{iplot};
  plot_structures_all{iplot} = plot_structure;
end
if 1 % Pi2 tensor
  iplot = iplot + 1;

  subdirs_all{iplot} = 'pi2_tensor';
  varstrs_all{iplot} = {'pi2.xx','pi2.xy','pi2.yy','pi2.xz','pi2.zz','pi2.yz'};
  clims_all{iplot} = 1*[-1 1];        
  cylims_all{iplot} = [0 clims_all{iplot}(2)];
  nrows_all{iplot} = 3; % ncols is calculated from nrows and nvars

  plot_structure.subdir = subdirs_all{iplot};
  plot_structure.varstrs = varstrs_all{iplot};
  plot_structure.clim = clims_all{iplot};
  plot_structure.cylim = cylims_all{iplot};
  plot_structure.nrows = nrows_all{iplot};
  plot_structures_all{iplot} = plot_structure;
end
if 1 % forces on hot electrons
  iplot = iplot + 1;

  subdirs_all{iplot} = '-ve1xB_E_sum_xyz';
  varstrs_all{iplot} = {'-ve1xB.x','-ve1xB.y','-ve1xB.z','-E.x','-E.y','-E.z','-ve1xB.x-E.x','-ve1xB.y-E.y','-ve1xB.z-E.z'};
  clims_all{iplot} = [-1 1];        
  cylims_all{iplot} = clims_all{iplot};
  nrows_all{iplot} = 3; % ncols is calculated from nrows and nvars

  plot_structure.subdir = subdirs_all{iplot};
  plot_structure.varstrs = varstrs_all{iplot};
  plot_structure.clim = clims_all{iplot};
  plot_structure.cylim = cylims_all{iplot};
  plot_structure.nrows = nrows_all{iplot};
  plot_structures_all{iplot} = plot_structure;
end
if 1 % forces on cold electrons
  iplot = iplot + 1;

  subdirs_all{iplot} = '-ve2xB_E_sum_xyz';
  varstrs_all{iplot} = {'-ve2xB.x','-ve2xB.y','-ve2xB.z','-E.x','-E.y','-E.z','-ve2xB.x-E.x','-ve2xB.y-E.y','-ve2xB.z-E.z'};
  clims_all{iplot} = [-1 1];        
  cylims_all{iplot} = clims_all{iplot};
  nrows_all{iplot} = 3; % ncols is calculated from nrows and nvars

  plot_structure.subdir = subdirs_all{iplot};
  plot_structure.varstrs = varstrs_all{iplot};
  plot_structure.clim = clims_all{iplot};
  plot_structure.cylim = cylims_all{iplot};
  plot_structure.nrows = nrows_all{iplot};
  plot_structures_all{iplot} = plot_structure;
end
if 1 % forces on hot electrons
  iplot = iplot + 1;

  subdirs_all{iplot} = 'vi1xB_E_xyz';
  varstrs_all{iplot} = {'vi1xB.x','vi1xB.y','vi1xB.z','E.x','E.y','E.z','vi1xB.x+E.x','vi1xB.y+E.y','vi1xB.z+E.z'};
  clims_all{iplot} = [-1 1];        
  cylims_all{iplot} = clims_all{iplot};
  nrows_all{iplot} = 3; % ncols is calculated from nrows and nvars

  plot_structure.subdir = subdirs_all{iplot};
  plot_structure.varstrs = varstrs_all{iplot};
  plot_structure.clim = clims_all{iplot};
  plot_structure.cylim = cylims_all{iplot};
  plot_structure.nrows = nrows_all{iplot};
  plot_structures_all{iplot} = plot_structure;
end
if 1 % forces on cold electrons
  iplot = iplot + 1;

  subdirs_all{iplot} = 'vi2xB_E_sum_xyz';
  varstrs_all{iplot} = {'vi2xB.x','vi2xB.y','vi2xB.z','E.x','E.y','E.z','vi2xB.x+E.x','vi2xB.y+E.y','vi2xB.z+E.z'};
  clims_all{iplot} = [-1 1];        
  cylims_all{iplot} = clims_all{iplot};
  nrows_all{iplot} = 3; % ncols is calculated from nrows and nvars

  plot_structure.subdir = subdirs_all{iplot};
  plot_structure.varstrs = varstrs_all{iplot};
  plot_structure.clim = clims_all{iplot};
  plot_structure.cylim = cylims_all{iplot};
  plot_structure.nrows = nrows_all{iplot};
  plot_structures_all{iplot} = plot_structure;
end
  
%% Time loop
Uke1_ts = nan(1,ntimes); 
Uke2_ts = nan(1,ntimes); 
Uki1_ts = nan(1,ntimes); 
Uki2_ts = nan(1,ntimes); 
Ute1_ts = nan(1,ntimes); 
Ute2_ts = nan(1,ntimes); 
Uti1_ts = nan(1,ntimes); 
Uti2_ts = nan(1,ntimes); 
UB_ts = nan(1,ntimes); 
UBx_ts = nan(1,ntimes); 
UBy_ts = nan(1,ntimes); 
UBz_ts = nan(1,ntimes); 
doTs = 1;
doPatch = 0;

for itime = 1:ntimes
  % Load data
  timestep = timesteps(itime);
  txtfile = sprintf('%s/fields-%05.0f.dat',data_dir,timestep); % michael's perturbation
  tic; [x,z,E,B,...
        ni1,ne1,ni2,ne2,...
        vi1,ve1,vi2,ve2,...
        ji1,je1,ji2,je2,...
        pi1,pe1,pi2,pe2,...
        ti1,te1,ti2,te2,...
        dfac,teti,nnx,nnz,wpewce,mass,it,time,dt,xmax,zmax,q]... 
        = read_fields(txtfile); toc

  % Calculate auxillary quantities
  tic; A = vector_potential(x,z,B.x,B.z); toc % vector potential
  pb = B.abs.^2/2; % magnetic pressure
  bcurv = magnetic_field_curvature(x,z,B.x,B.y,B.z); % magnetic curvature
  c_eval('ve?xB = cross_product(ve?.x,ve?.y,ve?.z,B.x,B.y,B.z);',1:2) % electron motional electric field
  c_eval('vi?xB = cross_product(vi?.x,vi?.y,vi?.z,B.x,B.y,B.z);',1:2) % ion motional electric field
  ExB = cross_product(E.x,E.y,E.z,B.x,B.y,B.z); % Poynting flux
  c_eval('E_ve?xB.x = E.x + ve?xB.x; E_ve?xB.y = E.y + ve?xB.y; E_ve?xB.z = E.z + ve?xB.z;',1:2) % electron motional electric field
  c_eval('E_vi?xB.x = E.x + vi?xB.x; E_vi?xB.y = E.y + vi?xB.y; E_vi?xB.z = E.z + vi?xB.z;',1:2) % electron motional electric field
  c_eval('je?E = je?.x.*E.x + je?.y.*E.y + je?.y.*E.z;',1:2)
  c_eval('ji?E = ji?.x.*E.x + ji?.y.*E.y + ji?.y.*E.z;',1:2)
  UB.x = 0.5*B.x.^2;
  UB.y = 0.5*B.y.^2;
  UB.z = 0.5*B.z.^2;
  UB.tot = 0.5*B.abs.^2; 
  c_eval('Uke? = mass(2)/mass(1)*0.5*ne?.*(ve?.x.^2 + ve?.y.^2 + ve?.z.^2);',1:2)
  c_eval('Uki? = mass(1)/mass(1)*0.5*ni?.*(vi?.x.^2 + vi?.y.^2 + vi?.z.^2);',1:2)
  c_eval('Ute? = pe?.scalar;',1:2)
  c_eval('Uti? = pi?.scalar;',1:2)
  Uke = Uke1 + Uke2;
  Uki = Uki1 + Uki2;
  Uktot = Uke + Uki;
  Ute = Ute1 + Ute2;
  Uti = Uti1 + Uti2;
  Uttot = Ute + Uti;
  jtot.x = ji1.x + ji2.x - je1.x - je2.x;
  jtot.y = ji1.y + ji2.y - je1.y - je2.y;
  jtot.z = ji1.z + ji2.z - je1.z - je2.z;
  
  % Collect time series
  Uke1_ts(1,itime) = sum(Uke1(:));
  Uke2_ts(1,itime) = sum(Uke2(:));
  Uki1_ts(1,itime) = sum(Uki1(:));
  Uki2_ts(1,itime) = sum(Uki2(:));
  Ute1_ts(1,itime) = sum(Ute1(:));
  Ute2_ts(1,itime) = sum(Ute2(:));
  Uti1_ts(1,itime) = sum(Uti1(:));
  Uti2_ts(1,itime) = sum(Uti2(:));
  UBx_ts(1,itime) = sum(UB.x(:));
  UBy_ts(1,itime) = sum(UB.y(:));
  UBz_ts(1,itime) = sum(UB.z(:));
  UB_ts(1,itime) = sum(UB.tot(:));
  
  % Plots
  if 1 % Plot, energy densities
    %% Save and print info
    subdir = 'energy_density_1';
    savedir = [savedir_root,subdir];
    mkdir(savedir)
    savestr = sprintf('%s_t%05.0f',subdir,timestep);
    % Define what variables to plot
    %varstrs = {'ve1.x','ve2.x','ve1.z','ve2.z','ve1.par','ve2.par','-ve1xB.x','-ve2xB.x','-ve1xB.z','-ve2xB.z','E.x','E.z'};
    varstrs = {'UB.tot','Uke1','Uke2','Uki1','Uki2','Ute1','Ute2','Uti1','Uti2'};
    clim = [-1 1];    
    nvars = numel(varstrs);

    % Initialize figure
    fig = figure(101);
    fig.Position = [screensize(1) screensize(2) screensize(3)*0.4 screensize(4)*0.7];
    npanels = nvars + doTs;
    nrows = 5;
    ncols = ceil(npanels/nrows);
    npanels = nrows*ncols;
    isub = 1; 
    for ipanel = 1:npanels  
      h(isub) = subplot(nrows,ncols,ipanel); isub = isub + 1;  
    end
    clear hb;

    doA = 0;
    if doA    
      cA = [0.8 0.8 0.8];
      nA = 20;
      nA = [0:-2:min(A(:))];
    end
    
    % Plot part of data
    xlim = [x(1) x(end)] + [100 -100];
    zlim = [-10 10];
    ix1 = find(x>xlim(1),1,'first');
    ix2 = find(x<xlim(2),1,'last');
    iz1 = find(z>zlim(1),1,'first');
    iz2 = find(z<zlim(2),1,'last');
    ipx = ix1:2:ix2;
    ipz = iz1:2:iz2;
    
    % Panels
    isub = 1;
    if doTs % ts plot of energy
      hca = h(isub); isub = isub + 1;
      ts_varstrs = {'UB','Uke1','Uke2','Uki1','Uki2','Ute1','Ute2','Uti1','Uti2'};
      variables = nan(numel(ts_varstrs),ntimes);
      for ivar = 1:numel(ts_varstrs)
        variables(ivar,:) = eval([ts_varstrs{ivar} '_ts']);
      end         
      hlines = plot(hca,timesteps/wpewce/mass(1),[UB_ts; Uke1_ts; Uke2_ts; Uki1_ts; Uki2_ts; Ute1_ts; Ute2_ts; Uti1_ts; Uti2_ts]);      
      for iline = 1:numel(hlines)
        hlines(iline).Marker = '.';
      end
      legend(hca,ts_varstrs,'location','eastoutside')
%      labels = arrayfun(@(x,y) {[num2str(x) ' > Q_{||} > ' num2str(y)]}, edgesQ(end:-1:2),edgesQ(end-1:-1:1));
      hca.XLim = [0 (timesteps(end)+200)/wpewce/mass(1)];
      hca.XLabel.String = 'time (omega_{ci})';
      hca.YLabel.String = 'Energy density (...)';
    end
    for ivar = 1:nvars  
      hca = h(isub); isub = isub + 1;
      varstr = varstrs{ivar};
      variable = eval(varstr);  
      himag = imagesc(hca,x(ipx),z(ipz),variable(ipx,ipz)');
      hca.XLabel.String = 'x (d_i)';
      hca.YLabel.String = 'z (d_i)';
      %hca.Title.String = sprintf('%s, sum(%s) = %g',varstr,varstr,sum(variable(:))); 
      hca.Title.String = sprintf('%s',varstr); 
      hca.CLim = max(abs(himag.CData(:)))*[-1 1];  
      hcb = colorbar('peer',hca);
      hb(ivar) = hcb;
      %hcb.YLim = hca.CLim(2)*[-1 1];
      colormap(hca,pic_colors('blue_red'));

      if doA
        hold(hca,'on')
        hcont = contour(hca,x(ipx),z(ipz),A(ipx,ipz)',nA,'color',cA,'linewidth',1.0);  
        hold(hca,'off')  
      end
    end
    for ipanel = 2:npanels
      h(ipanel).YDir = 'normal';
      h(ipanel).XLim = xlim;
      h(ipanel).YLim = zlim;
      h(ipanel).CLim = clim;
      hb(ipanel-1).Limits(1) = 0;
    end
    
    print('-dpng','-r200',[savedir '/' savestr '.png']);
  end
  
  % Common for all figures
  xlim = [x(1) x(end)] + [100 -100];
  zlim = [-10 10];
  
  nplots = iplot;
  
  for iplot = 1:nplots % Plot, adaptive
    %% Save and print info
    % subdirs_all varstrs_all clims_all cylims_all nrows_all plot_structure     
    subdir = subdirs_all{iplot};
    varstrs = varstrs_all{iplot};
    clim = clims_all{iplot};
    cylim = cylims_all{iplot};
    nrows = nrows_all{iplot};
    
    nvars = numel(varstrs);
    npanels = nvars;        
    ncols = ceil(npanels/nrows);
    % set figure position
    screensize = get(groot,'Screensize');
    figure_position(1) = 1;
    figure_position(2) = 1;
    figure_position(3) = screensize(3)/4*ncols;
    figure_position(4) = figure_position(3)*nrows/ncols*0.5;
    
    savedir = [savedir_root,subdir];
    mkdir(savedir)
    savestr = sprintf('%s_t%05.0f',subdir,timestep);            

    % Initialize figure
    fig = figure(102);
    fig.Position = figure_position;

    isub = 1; 
    for ipanel = 1:npanels  
      h(isub) = subplot(nrows,ncols,ipanel); isub = isub + 1;  
    end
    clear hb;

    doA = 1;
    if doA    
      cA = [0.8 0.8 0.8];
      nA = 20;
      nA = [0:-2:min(A(:))];
      ipxA = ipx1:20:ipx2;
      ipzA = ipz1:20:ipz2;
    end
    
    % Plot part of data    
    ix1 = find(x>xlim(1),1,'first');
    ix2 = find(x<xlim(2),1,'last');
    iz1 = find(z>zlim(1),1,'first');
    iz2 = find(z<zlim(2),1,'last');
    ipx = ix1:2:ix2;
    ipz = iz1:2:iz2;
    
    % Panels
    isub = 1;
    for ivar = 1:nvars
      hca = h(isub); isub = isub + 1;
      varstr = varstrs{ivar};
      variable = eval(varstr);  
      himag = imagesc(hca,x(ipx),z(ipz),variable(ipx,ipz)');
      hca.XLabel.String = 'x (d_i)';
      hca.YLabel.String = 'z (d_i)';
      %hca.Title.String = sprintf('%s, sum(%s) = %g',varstr,varstr,sum(variable(:))); 
      hca.Title.String = sprintf('%s',varstr); 
      hca.CLim = max(abs(himag.CData(:)))*[-1 1];  
      hcb = colorbar('peer',hca);
      hb(ivar) = hcb;
      %hcb.YLim = hca.CLim(2)*[-1 1];
      colormap(hca,pic_colors('blue_red'));

      if doA
        hold(hca,'on')
        hcont = contour(hca,x(ipxA),z(ipzA),A(ipxA,ipzA)',nA,'color',cA,'linewidth',1.0);  
        hold(hca,'off')  
      end
    end
    for ipanel = 1:npanels
      h(ipanel).YDir = 'normal';
      h(ipanel).XLim = xlim;
      h(ipanel).YLim = zlim;
      h(ipanel).CLim = clim;      
    end
    
    print('-dpng','-r200',[savedir '/' savestr '.png']);
  end
end