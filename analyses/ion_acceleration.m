df04 = PIC('/Volumes/Fountain/Data/PIC/df_cold_protons_n04/data_h5/fields.h5');
ds04 = PICDist('/Volumes/Fountain/Data/PIC/df_cold_protons_n04/data_h5/dists.h5');
tr04 = PICTraj('/Volumes/Fountain/Data/PIC/df_cold_protons_n04/data_h5/trajectories.h5');


%%


%% vdotE
twci0 = 120;
tr = tr04.pass('mass',[0.5 1.5]).pass('x0',[0 220]).pass('t0',twci0+[-1 1]);

W = zeros(tr.ntr,1); 
Wx = zeros(tr.ntr,1); 
Wy = zeros(tr.ntr,1);
Wz = zeros(tr.ntr,1);
vEx = zeros(tr.ntr,1); 
vEy = zeros(tr.ntr,1);
vEz = zeros(tr.ntr,1);
sumEx = zeros(tr.ntr,1);
sumEy = zeros(tr.ntr,1);
sumEz = zeros(tr.ntr,1);
for itr = 1:numel(tr)
  % only include backwards in time from t0
  itime = find(tr(itr).t < tr(itr).t0);
  itime = find(tr(itr).t > 0);
  nind(itr) = numel(itime);
  
  vEx(itr) = nansum(tr(itr).vx(itime).*tr(itr).Ex(itime));
  vEy(itr) = nansum(tr(itr).vy(itime).*tr(itr).Ey(itime));
  vEz(itr) = nansum(tr(itr).vz(itime).*tr(itr).Ez(itime));
  W_ = tr(itr).W; W(itr) = nansum(W_(itime));
  Wx_ = tr(itr).Wx; Wx(itr) = nansum(Wx_(itime));
  Wy_ = tr(itr).Wy; Wy(itr) = nansum(Wy_(itime));
  Wz_ = tr(itr).Wz; Wz(itr) = nansum(Wz_(itime));
  sumEx(itr) = nansum(tr(itr).Ex(itime));
  sumEy(itr) = nansum(tr(itr).Ey(itime));
  sumEz(itr) = nansum(tr(itr).Ez(itime));
end

ncrosses = tr.ncross;
ikeep = find(not(vEx==0));
tr = tr(ikeep);
vEx = vEx(ikeep);
vEy = vEy(ikeep);
vEz = vEz(ikeep);
vE = vEx + vEy + vEz;
% scale to total
vEx = vEx./vE;
vEy = vEy./vE;
vEz = vEz./vE;
%vE(vE==0) = [];
sc = 1e1;
sW = 2e1;

nrows = 8;
ncols = 1;
npanels = nrows*ncols;
h = setup_subplots(nrows,ncols);
isub = 1;

isW = [];
if 1 % number of bounces
  hca = h(isub); isub = isub + 1;  
  x0 = [tr.x0];
  vz0 = [tr.vz0];
  scatter(hca,x0,vz0,ncrosses+10,ncrosses,'o')  
  hcb = colorbar('peer',hca);
  hcb.YLabel.String = 'N z=0 crossings';
  hca.CLim = [0 10];
  hca.YLabel.String = 'v_{z} (t=t_0)';
end
if 0 % number of bounces
  hca = h(isub); isub = isub + 1;
  ic1 = find(ncrosses == 1);
  x0 = [tr.x0];
  vz0 = [tr.z0];
  scatter(hca,x0(ic1),vz0(ic1),ncrosses(ic1)+10,ncrosses(ic1),'o')
  hold(hca,'on')
  ic1 = find(ncrosses > 1);
  x0 = [tr.x0];
  vz0 = [tr.z0];
  scatter(hca,x0(ic1),vz0(ic1),ncrosses(ic1)+10,ncrosses(ic1),'^')
  hold(hca,'off')
  hcb = colorbar('peer',hca);
  hcb.YLabel.String = 'N z=0 crossings';
  hca.CLim = [0 10];
  hca.YLabel.String = 'v_{z} (t=t_0)';
end
if 0 % vxEx + vyEy + vzEz
  hca = h(isub); isub = isub + 1;
  scatter(hca,[tr.x0],[tr.vz0],abs(vE)*sc,vE)
  hcb = colorbar('peer',hca);
  hcb.YLabel.String = 'vE (t<t_0)';
  hca.CLim = prctile(vE,95)*[0 1];
  hca.YLabel.String = 'v_{z} (t=t_0)';
end
if 0 % vxEx + vyEy + vzEz
  hca = h(isub); isub = isub + 1;
  scatter(hca,[tr.x0],[tr.vy0],abs(vE)*sc,vE)
  hcb = colorbar('peer',hca);
  hcb.YLabel.String = 'vE (t<t_0)';
  hca.CLim = prctile(vE,95)*[0 1];
  hca.YLabel.String = 'v_{y} (t=t_0)';
end
if 1 % W
  isW(end+1) = isub;
  hca = h(isub); isub = isub + 1;
  scatter(hca,[tr.x0],[tr.vz0],sW,W)
  hcb = colorbar('peer',hca);
  hcb.YLabel.String = 'W (t<t_0)';
  hca.CLim = prctile(W,95)*[-1 1];
  hca.YLabel.String = 'v_{z} (t=t_0)';
end
if 1 % Wx
  isW(end+1) = isub;
  hca = h(isub); isub = isub + 1;
  scatter(hca,[tr.x0],[tr.vz0],sW,Wx)
  hcb = colorbar('peer',hca);
  hcb.YLabel.String = 'W_x (t<t_0)';
  hca.CLim = prctile(Wx,95)*[-1 1];
  hca.YLabel.String = 'v_{z} (t=t_0)';
end
if 1 % Wy
  isW(end+1) = isub;
  hca = h(isub); isub = isub + 1;
  scatter(hca,[tr.x0],[tr.vz0],sW,Wy)
  hcb = colorbar('peer',hca);
  hcb.YLabel.String = 'W_y (t<t_0)';
  hca.CLim = prctile(Wy,95)*[-1 1];
  hca.YLabel.String = 'v_{z} (t=t_0)';
end
if 1 % Wz
  isW(end+1) = isub;
  hca = h(isub); isub = isub + 1;
  scatter(hca,[tr.x0],[tr.vz0],sW,Wz)
  hcb = colorbar('peer',hca);
  hcb.YLabel.String = 'W_z (t<t_0)';
  hca.CLim = prctile(Wx,95)*[-1 1];
  hca.YLabel.String = 'v_{z} (t=t_0)';
end
if 1 % Wx/Wy
  hca = h(isub); isub = isub + 1;
  scatter(hca,[tr.x0],[tr.vz0],sW,log10(Wx./Wy))
  hcb = colorbar('peer',hca);
  hcb.YLabel.String = 'log_{10}(W_x/W_y) (t<t_0)';
  hca.CLim = [-1 1];
  hca.YLabel.String = 'v_{z0} (t=t_0)';
end
if 1 % Wz/Wy
  hca = h(isub); isub = isub + 1;
  scatter(hca,[tr.x0],[tr.vz0],sW,log10(Wz./Wy))
  hcb = colorbar('peer',hca);
  hcb.YLabel.String = 'log_{10}(W_z/W_y) (t<t_0)';
  hca.CLim = [-1 1];
  hca.YLabel.String = 'v_{z0} (t=t_0)';
end
if 1 % Wz/Wx
  hca = h(isub); isub = isub + 1;
  scatter(hca,[tr.x0],[tr.vz0],sW,log10(Wz./Wx))
  hcb = colorbar('peer',hca);
  hcb.YLabel.String = 'log_{10}(W_z/W_x) (t<t_0)';
  hca.CLim = [-1 1];
  hca.YLabel.String = 'v_{z0} (t=t_0)';
end
if 0
  hca = h(isub); isub = isub + 1;
  scatter(hca,[tr.x0],[tr.vz0],abs(vEx)*sc,vEx)
  hcb = colorbar('peer',hca);
  hcb.YLabel.String = 'v_xE_x (t<t_0)';
  hca.CLim = prctile(vEx,95)*[-1 1];
  hca.YLabel.String = 'v_{z} (t=t_0)';
end
if 0
  hca = h(isub); isub = isub + 1;
  scatter(hca,[tr.x0],[tr.vz0],abs(vEy)*sc,vEy)
  hcb = colorbar('peer',hca);
  hcb.YLabel.String = 'v_yE_y (t<t_0)';
  hca.CLim = prctile(vEy,95)*[-1 1];
  hca.YLabel.String = 'v_{z} (t=t_0)';
end
if 0
  hca = h(isub); isub = isub + 1;
  scatter(hca,[tr.x0],[tr.vz0],abs(vEz)*sc,vEz)
  hcb = colorbar('peer',hca);
  hcb.YLabel.String = 'v_zE_z (t<t_0)';
  hca.CLim = prctile(vEz,95)*[-1 1];
  hca.YLabel.String = 'v_{z} (t=t_0)';
end
if 0 % vEz/vEy
  hca = h(isub); isub = isub + 1;
  scatter(hca,[tr.x0],[tr.vz0],abs(vEz)*sc,log10(vEz./vEy))
  hcb = colorbar('peer',hca);
  hcb.YLabel.String = 'log_{10}(v_zE_z/v_yE_y) (t<t_0)';
  hca.CLim = [-1 1];
  hca.YLabel.String = 'v_{z0} (t=t_0)';
end

for ip = 1:npanels
  h(ip).Box = 'on';
  h(ip).XGrid = 'on';
  h(ip).YGrid = 'on';
  h(ip).YLim = [-1 1];
end
hlinks = linkprop(h,{'XLim','YLim'});
hlinksW = linkprop(h(isW),{'CLim'});
%hlinks_c = linkprop(h(2:4),{'CLim'});
drawnow
colormap(pic_colors('waterfall'))
compact_panels(0.01)