% demo rotate

% rotate ve to field alinged coordinates (fac)
% set up new coordinate system
r1 = b; % magnetic field unit vector
r2 = cross_product(r1.x,r1.y,r1.z,0,1,0);
r2.abs = sqrt(r2.x.^2 + r2.y.^2 + r2.z.^2);
r2.x = r2.x./r2.abs;
r2.y = r2.y./r2.abs;
r2.z = r2.z./r2.abs;
r2.abs = sqrt(r2.x.^2 + r2.y.^2 + r2.z.^2);
r2 = cross_product(r2.x,r2.y,r2.z,r1.x,r1.y,r1.z);
r3 = cross_product(r1.x,r1.y,r1.z,r2.x,r2.y,r2.z);
r3.abs = sqrt(r3.x.^2 + r3.y.^2 + r3.z.^2);

ve1_fac = rotate_vec(ve1,r1,r2,r3);
te1_fac = rotate_tens(te1,r1,r2,r3);

%% plot rotate_tens
tic;te1_fac = rotate_tens(te1,r1,r2,r3); toc
tic;te2_fac = rotate_tens(te2,r1,r2,r3); toc
te1_perp = 0.5*(te1.yy + te1.zz);
te1_par = te1.xx;
te2_perp = 0.5*(te2.yy + te2.zz);
te2_par = te2.xx;

%%


h = setup_subplots(2,4,'horizontal');
isub = 1;
varstrs = {'te1.scalar','te1.xx','te1.yy','te1.zz',...
           '(te1_par+2*te1_perp)/3','te1_par','te1_perp','log2(te1_par./te1_perp)'};
varstrs = {'te2.scalar','te2.xx','te2.yy','te2.zz',...
           '(te2_par+2*te2_perp)/3','te2_par','te2_perp'};
nvars = numel(varstrs);
CMax = zeros(nvars,1);
for ivar = 1:nvars
  variable = eval(varstrs{ivar});
  CMax(ivar) = max(variable(:));
  hca = h(isub); isub = isub + 1;
  imagesc(hca,x,z,variable')
  hcb = colorbar('peer',hca);    
  hca.Title.String = varstrs{ivar};
  hca.Title.Interpreter = 'none';
  hca.CLim(1) = 0;%-hca.CLim(2);
  %hcb.YLim = hca.CLim(2)*[-1 1];
end
colormap(pic_colors('candy'))

hlink = linkprop(h,{'XLim','YLim'});
hlink_clim = linkprop(h(1:(end-1)),{'CLim'});
%hlink_clim.Targets(1).CLim = max(CMax(1:end-1))*[0 1];
hlink_clim.Targets(1).CLim = 0.5*[0 1];
%hlink = linkprop(h(1:(end-1)),{'CLim','XLim','YLim'});

%%
if 1 % te1.scalar
  hca = h(isub); isub = isub + 1;
  imagesc(hca,x,z,te1.scalar')
  hcb = colorbar('peer',hca);  
  %hca.CLim = max(abs(hca.Children.CData(:)))*[-1 1];
end
if 1 % te1.xx
  hca = h(isub); isub = isub + 1;
  imagesc(hca,x,z,te1.xx')
  hcb = colorbar('peer',hca);
  %hca.CLim = max(abs(hca.Children.CData(:)))*[-1 1];
end
if 1 % te1_par
  hca = h(isub); isub = isub + 1;
  imagesc(hca,x,z,te1_par')
  hcb = colorbar('peer',hca);
  %hca.CLim = max(abs(hca.Children.CData(:)))*[-1 1];
end
if 1 % te1.perp
  hca = h(isub); isub = isub + 1;
  imagesc(hca,x,z,te1_perp')
  hcb = colorbar('peer',hca);
  %hca.CLim = max(abs(hca.Children.CData(:)))*[-1 1];
end
if 1 % te1.perp
  hca = h(isub); isub = isub + 1;
  imagesc(hca,x,z,te1_perp'+te1_par')
  hcb = colorbar('peer',hca);
  %hca.CLim = max(abs(hca.Children.CData(:)))*[-1 1];
end

%% plot rotate_vec
h = setup_subplots(3,3,'vertical');
isub = 1;
if 1 % ve1.par
  hca = h(isub); isub = isub + 1;
  imagesc(hca,x,z,ve1.par')
  hcb = colorbar('peer',hca);
  hca.CLim = max(abs(hca.Children.CData(:)))*[-1 1];
end
if 1 % ve1_fac.x
  hca = h(isub); isub = isub + 1;
  imagesc(hca,x,z,ve1_fac.x')
  hcb = colorbar('peer',hca);
  hca.CLim = max(abs(hca.Children.CData(:)))*[-1 1];
end
if 1 % ve1.par - ve1_fac.x
  hca = h(isub); isub = isub + 1;
  imagesc(hca,x,z,ve1.par'-ve1_fac.x')
  hcb = colorbar('peer',hca);
  %hca.CLim = max(abs(hca.Children.CData(:)))*[-1 1];
end
if 1 % ve1.y
  hca = h(isub); isub = isub + 1;
  imagesc(hca,x,z,ve1.y')
  hcb = colorbar('peer',hca);
  hca.CLim = max(abs(hca.Children.CData(:)))*[-1 1];
end
if 1 % ve1_fac.y
  hca = h(isub); isub = isub + 1;
  imagesc(hca,x,z,ve1_fac.y')
  hcb = colorbar('peer',hca);
  hca.CLim = max(abs(hca.Children.CData(:)))*[-1 1];
end
if 1 % ve1.y - ve1_fac.y
  hca = h(isub); isub = isub + 1;
  imagesc(hca,x,z,ve1.y'-ve1_fac.y')
  hcb = colorbar('peer',hca);
  %hca.CLim = max(abs(hca.Children.CData(:)))*[-1 1];
end
if 1 % ve1.z
  hca = h(isub); isub = isub + 1;
  imagesc(hca,x,z,ve1.z')
  hcb = colorbar('peer',hca);
  hca.CLim = max(abs(hca.Children.CData(:)))*[-1 1];
end
if 1 % ve1_fac.z
  hca = h(isub); isub = isub + 1;
  imagesc(hca,x,z,ve1_fac.z')
  hcb = colorbar('peer',hca);
  hca.CLim = max(abs(hca.Children.CData(:)))*[-1 1];
end
if 1 % ve1.par - ve1_fac.x
  hca = h(isub); isub = isub + 1;
  imagesc(hca,x,z,ve1.z'-ve1_fac.z')
  hcb = colorbar('peer',hca);
  %hca.CLim = max(abs(hca.Children.CData(:)))*[-1 1];
end
colormap(pic_colors('blue_red'))