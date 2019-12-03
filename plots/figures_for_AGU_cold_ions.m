df04 = PIC('/Volumes/Fountain/Data/PIC/df_cold_protons_n04/data_h5/fields.h5');
df08 = PIC('/Volumes/Fountain/Data/PIC/df_cold_protons_n08/data_h5/fields.h5');
ds04 = PICDist('/Volumes/Fountain/Data/PIC/df_cold_protons_n04/data_h5/dists.h5');
savedir  = ['/Users/' localuser '/GoogleDrive/DF_Cold_ions_figures_for_AGU/'];

%% Reconnection rate, two panels, absolute and massloading compensated
h = setup_subplots(1,2);
isub = 1;
if 1 % R(twci)
  hca = h(isub); isub = isub + 1;
  t04 = df04.twci; R04 = df04.RA; 
  t08 = df08.twci; R08 = df08.RA; 
  
  plot(hca,t04(5:end),R04(5:end),t08(4:end),R08(4:end))
  hca.YLabel.String = 'R   (B_0v_{A0})';
  hca.XLabel.String = 't (\omega_{ci}^{-1})';
  legend(hca,{'n_c = 0.4n_0','n_c = 0.8n_0'},'location','northwest','box','off')
end
if 1 % R(twci), scaled to density
  hca = h(isub); isub = isub + 1;
  fun_massloading = @(nh,nc) sqrt(1+nc/nh);
  t04 = df04.twci; R04 = df04.RA*fun_massloading(0.2,0.4); 
  t08 = df08.twci; R08 = df08.RA*fun_massloading(0.2,0.8);
  
  plot(hca,t04(5:end),R04(5:end),t08(4:end),R08(4:end))
  hca.YLabel.String = 'R (1+n_c/n_h)^{1/2}   (B_0v_A{0})';
  hca.XLabel.String = 't (\omega_{ci}^{-1})';
  legend(hca,{'n_c = 0.4n_0','n_c = 0.8n_0'},'location','northwest','box','off')
end
h(1).Title.String = 'Reconnection rate';
h(2).Title.String = {'Reconnection rate','rescaled for mass loading'};
c_eval('h(?).Position(2) = 0.20; h(?).Position(4) = 0.65;',1:2)
c_eval('h(?).YLim(2) = 0.19;',1:2)
c_eval('h(?).FontSize = 14;',1:2)
c_eval('h(?).XGrid = ''on''; h(?).YGrid = ''on'';',1:2)

%% Reconnection rate, one panel, absolute and massloading compensated
h = setup_subplots(1,1);
isub = 1;
if 1 % R(twci)
  hca = h(isub); isub = isub + 1;
  t04 = df04.twci; R04 = df04.RA; 
  t08 = df08.twci; R08 = df08.RA; 
  fun_massloading = @(nh,nc) sqrt(1+nc/nh);
  t04 = df04.twci; R04_ml = df04.RA*fun_massloading(0.2,0.4); 
  t08 = df08.twci; R08_ml = df08.RA*fun_massloading(0.2,0.8);
  
  colors = pic_colors('matlab');
  hlines = plot(hca,t04(5:end),R04(5:end),t08(4:end),R08(4:end),...
                    t04(5:end),R04_ml(5:end),t08(4:end),R08_ml(4:end));
  hlines(1).Color = colors(1,:); hlines(1).LineStyle = '-';
  hlines(3).Color = colors(1,:); hlines(3).LineStyle = '--';
  hlines(2).Color = colors(2,:); hlines(2).LineStyle = '-';
  hlines(4).Color = colors(2,:); hlines(4).LineStyle = '--';
  hca.YLabel.String = 'R   (B_0v_{A0})';
  hca.XLabel.String = 't (\omega_{ci}^{-1})';
  legend(hca,{'n_c = 0.4n_0','n_c = 0.8n_0','n_c = 0.4n_0: R(1+n_c/n_h)','n_c = 0.8n_0: R(1+n_c/n_h)'},'location','eastoutside','box','off')
end
h(1).Title.String = 'Reconnection rate';

c_eval('h(?).Position(2) = 0.20; h(?).Position(4) = 0.65;',1)
c_eval('h(?).YLim(2) = 0.19;',1)
c_eval('h(?).FontSize = 14;',1)
c_eval('h(?).XGrid = ''on''; h(?).YGrid = ''on'';',1)

%% Partitioning between drift and thermal energy for cold ions in df04 run normalized to UB(1)

nrows = 1;
ncols = 1;
npanels = nrows*ncols;
h = setup_subplots(nrows,ncols);
isub = 1;

if 1 % Partitioning between drift and thermal energy for cold ions in df04 run normalized to UB(1)
  hca = h(isub); isub = isub + 1;
  colors = pic_colors('matlab');
  hold(hca,'on');
  hca.ColorOrder = colors(1:2,:);
  hca.LineStyleOrder = {'-','--'};
  
  plot(hca,df04.twci,2*df04.UK(3)/df04(1).UB,...
           df04.twci,2*df04.UT(3)/df04(1).UB,'linewidth',1.5)
  %hold(hca,'on')
  plot(hca,df04.twci,df04.UK(35)/df04(1).UB,'--',...
           df04.twci,df04.UT(35)/df04(1).UB,'--','linewidth',1.5)
  hca.XLabel.String = 't\omega_{ci}';  
  hca.YLabel.String = 'U_i^c/U_B(t=0)';
  hleg = legend(hca,{'2U_K^{c1} - drift separate','2U_T^{c1} - thermal separate','U_K^{c1+c2} - drift combined','U_T^{c1+c2} - thermal combined'},'Box','on','location','northwest');
  hleg.Title.String = 'n_c = 0.4 n_0';
  hold(hca,'off')
  hca.Box = 'on';
  hca.XGrid = 'on';
  hca.YGrid = 'on';
  
end

c_eval('hca.FontSize = 13;',1:npanels)
c_eval('h(?).Position(2) = 0.20; h(?).Position(4) = 0.65;',1)

%% Movie of density evolution df04, gif
% [all_im, map] = MAKE_GIF(obj,fields,nrows,ncols)      
% make gif
% imwrite(im,map,'delme.gif','DelayTime',0.0,'LoopCount',0)  

% Default options, values
doAdjustCLim = 1;
clim = [0 2];
cmap = pic_colors('candy');
doA = 1;
levA = -25:1:0;

pic = df04;


% setup figure
fig = figure;
fig.Position = [100 100 920 360];
set(fig,'color','white');
nrows = 1;
ncols = 1;
h = setup_subplots(nrows,ncols); % external function, must include in SMILEI.m
isub = 1;
disp('Adjust figure size, then hit any key to continue.')
pause

times = 2:pic.nt;
ntimes = numel(times);
iframe = 0;
for itime = times
  pic = df04(itime).zlim([-15 15]);
  hca = h(isub); 
  data = pic.ni;  
  imagesc(hca,pic.xi,pic.zi,data')
  hb = colorbar('peer',hca);
  hb.YLabel.String = 'n_i/n_0';
  hca.Title.String = sprintf('twci = %3.0f',pic.twci);
  if doAdjustCLim
    hca.CLim = clim;
    %colormap(hca,cmap)
  end
  if doA
    hold(hca,'on')
    iAx = 1:4:pic.nx;
    iAz = 1:4:pic.nz;
    A = pic.A;
    contour(hca,pic.xi(iAx),pic.zi(iAz),A(iAx,iAz)',levA,'k');
    hold(hca,'off')
  end
    hca.YDir = 'normal';
    hca.XLabel.String = 'x/d_i';
    hca.YLabel.String = 'z/d_i';
    %toc  
  if iframe == 0
    colormap(cmap)
  end
  pause(0.1)
  if 1 % collect frames, for making gif
    iframe = iframe + 1;    
    nframes = ntimes;
    currentBackgroundColor = get(gcf,'color');
    set(gcf,'color',[1 1 1]);
    drawnow      
    tmp_frame = getframe(gcf);
    %cell_movies{imovie}(itime) = tmp_frame;
    if iframe == 1 % initialize animated gif matrix
      [im_tmp,map] = rgb2ind(tmp_frame.cdata,256,'nodither');
      %map(end+1,:) = get(gcf,'color');
      im_tmp(1,1,1,nframes) = 0;                                                
      all_im = im_tmp;
    else
      all_im(:,:,1,iframe) = rgb2ind(tmp_frame.cdata,map,'nodither');
    end       
  end
end
%out = {all_im,map};

% collect frames

%% Movie of density evolution df04, try with VideoWriter
% [all_im, map] = MAKE_GIF(obj,fields,nrows,ncols)      
% make gif
% imwrite(im,map,'delme.gif','DelayTime',0.0,'LoopCount',0)  

vidObj = VideoWriter([savedir 'ni_df04.mp4'],'MPEG-4');
open(vidObj);

% Default options, values
doAdjustCLim = 1;
clim = [0 2];
cmap = pic_colors('candy');
doA = 1;
levA = -25:1:0;

pic = df04;


% setup figure
fig = figure;
nrows = 1;
ncols = 1;
h = setup_subplots(nrows,ncols); % external function, must include in SMILEI.m
isub = 1;
disp('Adjust figure size, then hit any key to continue.')
pause

times = 2:pic.nt;
ntimes = numel(times);
iframe = 0;
for itime = times
  pic = df04(itime).zlim([-15 15]);
  hca = h(isub); 
  data = pic.ni;  
  imagesc(hca,pic.xi,pic.zi,data')
  hb = colorbar('peer',hca);
  hb.YLabel.String = 'n_i';
  hca.Title.String = sprintf('twci = %3.0f',pic.twci);
  hca.FontSize = 14;
  if doAdjustCLim
    hca.CLim = clim;
    %colormap(hca,cmap)
  end
  if doA
    hold(hca,'on')
    iAx = 1:4:pic.nx;
    iAz = 1:4:pic.nz;
    A = pic.A;
    contour(hca,pic.xi(iAx),pic.zi(iAz),A(iAx,iAz)',levA,'k');
    hold(hca,'off')
  end
    hca.YDir = 'normal';
    hca.XLabel.String = 'x/d_i';
    hca.YLabel.String = 'z/d_i';
    %toc  
  if iframe == 0
    colormap(cmap)
  end
  pause(0.1)
  currFrame = getframe(gcf);
  writeVideo(vidObj,currFrame);
end
%out = {all_im,map};
close(vidObj);
% collect frames

%% Movie of temperature evolution df04, try with VideoWriter
% [all_im, map] = MAKE_GIF(obj,fields,nrows,ncols)      
% make gif
% imwrite(im,map,'delme.gif','DelayTime',0.0,'LoopCount',0)  

vidObj = VideoWriter([savedir 'vy5_df04_viquivers.mp4'],'MPEG-4');
open(vidObj);


% Default options, values
doAdjustCLim = 1;
clim = [-1 1];
cmap = pic_colors('candy2');
cmap = pic_colors('blue_red');
doA = 1;
levA = -25:1:0;

doQ = 1;
maxQ = 5;

pic = df04;


% setup figure
fig = figure;
nrows = 1;
ncols = 1;
h = setup_subplots(nrows,ncols); % external function, must include in SMILEI.m
isub = 1;
disp('Adjust figure size, then hit any key to continue.')
%pause
hcf = gcf;
hcf.Position = [301   190   896   500];
set(hcf,'color','white');

iSpecies = 5;
times = 2:pic.nt;
ntimes = numel(times);
iframe = 0;
for itime = times
  itime
  pic = df04(itime).zlim([-15 15]);
  hca = h(isub); 
  %[n,jx,jy,jz,pxx,pxy,pxz,pyy,pyz,pzz] = pic.njp(iSpecies);
  %p = (pxx+pyy+pzz)/3; 
  %t = p./n;
  
   if doQ % Quivers        
    colorQ = pic_colors('matlab');
    colorQ = [0 0 0; 0.5 0.5 0.5];
    maxQs = [2,2];
    scalesQ_a = 10*[1 1 1]; % rescaling to input data
    scalesQ_b = 0*[1 1 1]; % rescaling option for the quiver function
        
    nQx = 50;
    nQz = 25;
    [X,Z] = ndgrid(pic.xi,pic.zi);
    ipxQ = fix(linspace(1,pic.nx,nQx));
    ipzQ = fix(linspace(1,pic.nz,nQz));
    %[X,Z] = meshgrid(ipxQ,ipzQ);
    %ipXQ = dataQx; ipZQ = dataQz;      
  end 

  data = pic.vy(5);
  imagesc(hca,pic.xi,pic.zi,data')
  hb = colorbar('peer',hca);
  hb.YLabel.String = 'v_y (cold protons from the south)';
  hca.Title.String = sprintf('twci = %3.0f',pic.twci);
  hca.FontSize = 14;
  if doAdjustCLim
    hca.CLim = clim;
    %colormap(hca,cmap)
  end
  if doA
    hold(hca,'on')
    iAx = 1:4:pic.nx;
    iAz = 1:4:pic.nz;
    A = pic.A;
    contour(hca,pic.xi(iAx),pic.zi(iAz),A(iAx,iAz)',levA,'k');
    hold(hca,'off')
  end
  if doQ    
      hold(hca,'on')
      dataQx = pic.vx(5); dataQx(n<0.01) = NaN;
      dataQz = pic.vz(5); dataQz(n<0.01) = NaN;
      dataQ.x = dataQx;
      dataQ.z = dataQz;
      maxQ = maxQs(1);     
      iQ = 1;
      displayname = 'v_{ix}';
      hquiv = quiver(hca,X(ipxQ,ipzQ),Z(ipxQ,ipzQ),dataQ.x(ipxQ,ipzQ)*scalesQ_a(iQ),dataQ.z(ipxQ,ipzQ)*scalesQ_a(iQ),scalesQ_b(iQ),...
        'color',colorQ(iQ,:),'linewidth',1.0,'displayname',displayname,...
        'ShowArrowHead','off','Marker','o','MarkerSize',2);
      %hquiv = quiver(hca,X(ipxQ,ipzQ),Z(ipxQ,ipzQ),dataQ.x(ipxQ,ipzQ)*scalesQ_a(iQ),dataQ.z(ipxQ,ipzQ)*scalesQ_a(iQ),scalesQ_b(iQ),...
      %  'color',colorQ(iQ,:),'linewidth',1.0,'displayname',displayname,...
      %  'ShowArrowHead','off','Marker','o','MarkerSize',1);
      %return
        %hquiv.ShowArrowHead = 'off';
        %hquiv.Marker = '.';
        hold(hca,'off')  
  end    
    hca.YDir = 'normal';
    hca.XLabel.String = 'x/d_i';
    hca.YLabel.String = 'z/d_i';
    %toc  
  if iframe == 0
    colormap(cmap)
  end
  pause(0.1)
  currFrame = getframe(gcf);
  writeVideo(vidObj,currFrame);
end
%out = {all_im,map};
close(vidObj);
% collect frames

%% Map of distributions
zlim = [0 6];
xlim = [160 180];
sumdim = 3;
iSpecies = [3 5];
hmap = ds04(2).xlim(xlim).zlim(zlim).plot_map(iSpecies,sumdim);

all_axes = findobj(gcf,'type','axes');
compact_panels(0.00,0.00)
drawnow
%%
cn.print(sprintf('fxy_35_t08000_z%.0f-%.0f_x%.0f-%.0f',xlim(1),xlim(2),zlim(1),zlim(2)),'path',savedir)

doSquare = 1;
for ipanel = 1:numel(all_axes)
  if doSquare, axis(all_axes(ipanel),'square'); end
end
cn.print(sprintf('fxy_35_t08000_z%.0f-%.0f_x%.0f-%.0f_square',xlim(1),xlim(2),zlim(1),zlim(2)),'path',savedir)

set(gcf,'Position',pp)
drawnow
cn.print(sprintf('fxy_35_t08000_z%.0f-%.0f_x%.0f-%.0f_square_tight',xlim(1),xlim(2),zlim(1),zlim(2)),'path',savedir)
%% Movie looping through distributions at z = 0, and x, seeing the subsequently entering "trees"

%% Plot smaller subset of distributions, for smaller figures embedded in text, one z row
doVideo = 1;
zlim = 0+[-0.1 0.1];
xlim = [160 205];
sumdim = 3;
iSpecies = [3];
ds = ds04(2).xlim(xlim).zlim(zlim);
cmap = pic_colors('candy');
ticks = -15:1:15;
doColorbar = 0;
clim = [0 0.5e-2]; doCLim = 1;
it = 1;


if doVideo
  vidObj = VideoWriter([savedir 'fvyz_xy_xz_z=0_x=160-200_clim.mp4'],'MPEG-4');
  open(vidObj);
end
% Set up figure
h = setup_subplots(1,3);

for id = ds.nd{it}:-1:1
  f = ds.f(1,id,iSpecies);
  isub = 1;
  if 1 % fzy
    hca = h(isub); isub = isub + 1;
    imagesc(hca,f.v,f.v,f.fyz')
    hca.XLabel.String = 'v_y';
    hca.YLabel.String = 'v_z';
  if 1 % fxy
    hca = h(isub); isub = isub + 1;
    imagesc(hca,f.v,f.v,f.fxy')
    hca.XLabel.String = 'v_x';
    hca.YLabel.String = 'v_y';
  end
  if 1 % fxz
    hca = h(isub); isub = isub + 1;
    imagesc(hca,f.v,f.v,f.fxz')
    hca.XLabel.String = 'v_x';
    hca.YLabel.String = 'v_z';
  end
  end
  colormap(gcf,cmap)
  for ip = 1:3
    h(ip).YDir = 'normal';
    h(ip).XTick = ticks;
    h(ip).YTick = ticks;
    h(ip).XGrid = 'on';
    h(ip).YGrid = 'on';    
    h(ip).FontSize = 14;
    axis(h(ip),'square')
    if doCLim, h(ip).CLim = clim; end
  end
  h(2).Title.String = sprintf('x = %.1f, z = %.1f',(f.x(1)+f.x(2))/2,(f.z(1)+f.z(2))/2);
  
  hlinks = linkprop(h,{'CLim'});
  if doColorbar
    h3pos = h(3).Position;
    hcb = colorbar('peer',h(3));
    h(3).Position = h3pos;
    hcb.Position(1) = h(3).Position(1)+h(3).Position(3)+0.01;
  end
  pause(0.1)
  if doVideo
    set(gcf,'color','white');
    currFrame = getframe(gcf);
    writeVideo(vidObj,currFrame);
  end
end
if doVideo, close(vidObj); end

%% Plot smaller subset of distributions, for smaller figures embedded in text, two z rows
doVideo = 1;
zlim1 = 0+[-0.1 0.1];
zlim2 = 1+[-0.1 0.1];
xlim = [166 200];
xs = 205:-1:166;
sumdim = 3;
iSpecies = [5];
%ds1 = ds04(2).xlim(xlim).zlim(zlim1);
%ds2 = ds04(2).xlim(xlim).zlim(zlim2);
cmap = pic_colors('candy');
ticks = -15:1:15;
doColorbar = 0;
clim = [0 0.5e-2]; doCLim = 1;
it = 1;


if doVideo
  vidObj = VideoWriter([savedir 'fvyz_xy_xz_z=0-1_x=160-200_clim_5.mp4'],'MPEG-4');
  open(vidObj);
end
% Set up figure
h = setup_subplots(2,3);

for ix = 1:numel(xs)
  %ix
  id = 1;
  ds1 = ds04(2).xlim(xs(ix)+[-0.1 0.1]).zlim(zlim1);
  ds2 = ds04(2).xlim(xs(ix)+[-0.1 0.1]).zlim(zlim2);
  if isempty(ds1.xi{:}) && isempty(ds2.xi{:})
    continue
  elseif isempty(ds1.xi{:})
    f2 = ds2.f(1,id,iSpecies);
    f1 = f2;
    f1.f = f1.f*0;
    f1.fxy = f1.fxy*0;
    f1.fyz = f1.fyz*0;
    f1.fxz = f1.fxz*0;
  elseif isempty(ds2.xi{:})
    f1 = ds1.f(1,id,iSpecies);
    f2 = f1;
    f2.f = f2.f*0;
    f2.fxy = f2.fxy*0;
    f2.fyz = f2.fyz*0;
    f2.fxz = f2.fxz*0;
  else
    f1 = ds1.f(1,id,iSpecies);
    f2 = ds2.f(1,id,iSpecies);
  end
   
      
  isub = 1;
  f = f2;
  if 1 % fzy
    hca = h(isub); isub = isub + 1;
    imagesc(hca,f.v,f.v,f.fyz')
    hca.XLabel.String = 'v_y';
    hca.YLabel.String = 'v_z';
  end
  if 1 % fxy
    hca = h(isub); isub = isub + 1;
    imagesc(hca,f.v,f.v,f.fxy')
    hca.XLabel.String = 'v_x';
    hca.YLabel.String = 'v_y';
  end
  if 1 % fxz
    hca = h(isub); isub = isub + 1;
    imagesc(hca,f.v,f.v,f.fxz')
    hca.XLabel.String = 'v_x';
    hca.YLabel.String = 'v_z';
  end 
  f1 = ds1.f(1,id,iSpecies);
  f = f1;
  if 1 % fzy
    hca = h(isub); isub = isub + 1;
    imagesc(hca,f.v,f.v,f.fyz')
    hca.XLabel.String = 'v_y';
    hca.YLabel.String = 'v_z';
  end
  if 1 % fxy
    hca = h(isub); isub = isub + 1;
    imagesc(hca,f.v,f.v,f.fxy')
    hca.XLabel.String = 'v_x';
    hca.YLabel.String = 'v_y';
  end
  if 1 % fxz
    hca = h(isub); isub = isub + 1;
    imagesc(hca,f.v,f.v,f.fxz')
    hca.XLabel.String = 'v_x';
    hca.YLabel.String = 'v_z';
  end   
  
  colormap(gcf,cmap)
  for ip = 1:6
    h(ip).YDir = 'normal';
    h(ip).XTick = ticks;
    h(ip).YTick = ticks;
    h(ip).XGrid = 'on';
    h(ip).YGrid = 'on';    
    h(ip).FontSize = 14;
    axis(h(ip),'square')
    if doCLim, h(ip).CLim = clim; end
  end
  h(5).Title.String = sprintf('x = %.1f, z = %.1f',(f1.x(1)+f1.x(2))/2,(f1.z(1)+f1.z(2))/2);
  h(2).Title.String = sprintf('x = %.1f, z = %.1f',(f2.x(1)+f2.x(2))/2,(f2.z(1)+f2.z(2))/2);
  
  hlinks = linkprop(h,{'CLim'});
  if doColorbar
    h3pos = h(3).Position;
    hcb = colorbar('peer',h(3));
    h(3).Position = h3pos;
    hcb.Position(1) = h(3).Position(1)+h(3).Position(3)+0.01;
  end
  pause(0.1)
  if doVideo
    set(gcf,'color','white');
    currFrame = getframe(gcf);
    writeVideo(vidObj,currFrame);
  end
end
if doVideo, close(vidObj); end
