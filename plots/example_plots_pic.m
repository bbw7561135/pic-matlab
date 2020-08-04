%% plotmap
twpe = 12000;
xlim = [140 300];
xlim = [140 260];
zlim = [-20 20];
xlim = [0 400];
pic = no02m.twpelim(twpe).xlim(xlim).zlim(zlim);
%pic = no02m(no02m.nt);
varstrs = {'Ex+vixBx';'Ey+vixBy';'Ez+vixBz'};
varstrs = {'Ex+vexBx';'Ey+vexBy';'Ez+vexBz'};
varstrs = {'Epar';'ni-ne';'log10(ne)'};
varstrs = {'Bz';'Jy';'Jx';'Ey';'ni'};
varstrs = {'Epar';'log10(ne)';'ti';'te'};
%varstrs = {'Ez';'pxy([2 4 6])';'pyz([2 4 6])'};
h = pic.plot_map(varstrs,'A',1);
%h = pic.plot_map(varstrs,'A',1);
colormap(pic_colors('blue_red'))

%% plot_map/movie, simulation box sizing
twpe = [7000:200:11000];
twpe = [7000 10400];
%twpe = [200:200:6000];
xlim = [140 270];
zlim = [-15 15];
pic = nobg.twpelim(twpe).xlim(xlim).zlim(zlim);
pic = nobg.twpelim(10000,'exact').xlim(xlim).zlim(zlim);
varstrs = {' Ey';'n([4 6])';'vx(2)';'vx(4)';'vx(6)';'vz([4 6])'};
%pic = pic(pic.nt);
clims = {[-1 1];[0 0.5];[-2 2];[-2 2];[-2 2];[-0.5 0.5]}';
clims = {0.2*[-1 1];[0 0.5];[-2 2];[-2 2];[-2 2];[-0.5 0.5]}';


varstrs = {'Ey';'Jy';'n([4 6])';'vx(4)'};
varstrs = {'Epar';'log10(ne)';'ti';'te'};
clims = {[-1 1];[-2.0 0.5];[0 1];[0 0.7]}';
varstrs = {'log10(ne)';'ti';'te';'By'};
clims = {[-2.0 0.5];[0 1];[0 0.7];[-0.5 0.5];}';

cmapbr = pic_colors('blue_red');
cmapjet = colormap('jet');
cmapwa = pic_colors('waterfall');
cmaps = {cmapbr,cmapwa;cmapbr,cmapbr;cmapbr,cmapbr}';
cmaps = {cmapbr,cmapbr,cmapbr,cmapbr}';

%h = pic.plot_map(varstrs,'A',1,'clim',clims,'cmap',cmaps);

filename = [printpath '_Epar_ne_ti_te_xlim'];
pic.movie(varstrs,'A',1,'cmap',cmaps,'clim',clims,'filename',filename);

%% plot_line, horizontal
pic = no02m;
comp = 'x';
twpe = [1000:1000:12000];
twci = [20 100];
xlim = pic.xi([1 end])+[70 -70]';
zlim = 1*[-0.5 0.5];
pic = pic.xlim(xlim).zlim(zlim).twpelim(twpe,'exact');
pic = pic.xlim(xlim).zlim(zlim).twcilim(twci);
varstrs = {{'Bx'};{'Jy'};{'n(1)','n([3 5])','n([1 3 5])'};{'Ey','Ez'};{'txx(1)','txx(3)','txx(5)','txx([1 3 5])'}};
varstrs = {{'Bx'};{'Jy'};{'n([1 3 5])'};{'Ey'};{'Ez'};{'viz'};{'vez'}};
varstrs = {{'Ey'};{'Jy'};{'ne'};{'vex'};{'vix'}};
varstrs = {{'Ey'};{'Jy'};{'ne'};{'n([4 6])'};{'vex'};{'vix'}};
varstrs = {{'Ex'};{'Ey'};{'vex'};{'vix'}};
%varstrs = {{'Ey'};{'n(4)'};{'tzz(4)'}};

h = pic.plot_line(comp,varstrs,'smooth',20);

%% plotline, vertical
pic = no02m;
comp = 'z';
twpe = [3000:1000:5000];
xlim = 103+0.5*[-1 1];
zlim = [-15 15];
zlim = pic.zi([1 end]);
zlim = [-15 15];
pic = pic.xlim(xlim).zlim(zlim).twpelim(twpe,'exact');
varstrs = {{'Bx'};{'Jy'};{'n(1)','n([3 5])','n([1 3 5])'};{'Ey','Ez'};{'txx(1)','txx(3)','txx(5)','txx([1 3 5])'}};
varstrs = {{'Bx'};{'Jy'};{'n([1 3 5])'};{'Ey'};{'Ez'};{'viz'};{'vez'}};
varstrs = {{'Ey'};{'Ez'};{'vez'};{'tzz(4)'};{'txx(4)'}};
%varstrs = {{'Ey'};{'n(4)'};{'tzz(4)'}};

h = pic.plot_line(comp,varstrs);

%% plotline, vertical
pic = no02m;
comp = 'z';
twpe = [3000];
xlim = 53+0.5*[-1 1];
zlim = [0 15];
zlim = pic.zi([1 end]);
zlim = [0 15];
pic = pic.xlim(xlim).zlim(zlim).twpelim(twpe);
varstrs = {{'Bx'};{'Jy'};{'n(1)','n([3 5])','n([1 3 5])'};{'Ey','Ez'};{'txx(1)','txx(3)','txx(5)','txx([1 3 5])'}};
varstrs = {{'Bx'};{'Jy'};{'n([1 3 5])'};{'Ey'};{'Ez'};{'viz'};{'vez'}};
varstrs = {{'n(2)','n(4)','n([2 4])'};{'tzz(2)','tzz(4)','txx([2 4])'};{'txx(2)','txx(4)','txx([2 4])'}};

h = pic.plot_line(comp,varstrs);

%% plotmap
twpe = 20;
xlim = [190 220];
zlim = [-15 15];
pic = no02.twpelim(twpe).xlim(xlim).zlim(zlim);
varstrs = {'Ex','Ez';'ni','ne';'vix','vex'}';
clims = {[-1 1],[-1 1];[0 0.5],[0 0.5];[-4 4],[-4 4]}';
cmapbr = pic_colors('blue_red');
cmapwa = pic_colors('waterfall');
cmaps = {cmapbr,cmapbr;cmapwa,cmapwa;cmapbr,cmapbr}';

h = pic.plot_map(varstrs,'A',1,'clim',clims,'cmap',cmaps);

%% plotmap
twpe = 10000;
xlim = [140 210];
zlim = [0 15];
pic = nobg.twpelim(twpe).xlim(xlim).zlim(zlim);
varstrs = {'Ex';'Ez';'Jx';'Jz'};
clims = {[-1 1];[-1 1];0.4*[-1 1];0.4*[-1 1]};
cmapbr = pic_colors('blue_red');
cmapwa = pic_colors('waterfall');
cmaps = {cmapbr;cmapbr;cmapbr;cmapbr};

h = pic.plotmap(varstrs,'A',1,'clim',clims,'cmap',cmaps);

%% plotmap, magnetic curvature
twpe = 9000; xlim = [160 210]; zlim = [-10 10];

pic = nobg.twpelim(twpe,'exact').xlim(xlim).zlim(zlim);
cmapbr = pic_colors('blue_red');
cmapwa = pic_colors('waterfall');

varstrs = {'curvbx';'curvby';'curvbz';'curvbabs';'curvbrad';'rc([3 5])'};
clims = {[-1 1];[-1 1];[-1 1];[-1 1];[0 1];[0 1];[0 2]};
cmaps = {cmapbr;cmapbr;cmapbr;cmapbr;cmapbr;cmapwa};

varstrs = {'curvbabs';'curvbrad';'rc([3 5])'};
clims = {[-1 1];[0 5];[0 5];[0 2]};

varstrs = {'vtperp([3 5])';'vtpar([3 5])';'curvbabs';'log10(curvbrad)';'log10(rc([3 5]))';'log10(curvbrad./rc([3 5]))'};
cmaps = {cmapbr;cmapbr;cmapbr;cmapwa;cmapwa;cmapwa};
clims = {[0 2];[0 2];[0 5];[0 5];[-1 1];[-3 3]};
varstrs = {'log10(ni)';'vtperp([3 5])';'vtpar([3 5])';'vtperp([4 6])';'vtpar([4 6])'};
clims = {[-2 1];[0 2];[0 2];[0 7];[0 7]};
cmaps = {cmapbr;cmapbr;cmapbr;cmapbr;cmapbr;cmapwa;cmapwa};


h = pic.plot_map(varstrs,'A',1,'clim',clims,'cmap',cmaps);


%% plot_map Epar, 
twpe = 11000;
xlim = [100 200];
zlim = [-5 15];
pic = nobg.twpelim(twpe).xlim(xlim).zlim(zlim);
varstrs = {'Epar';'ni';'ne'};
clims = {[-1.5 1.5];[0 0.5];[0 0.5]};
cmapbr = pic_colors('blue_red');
cmapwa = pic_colors('waterfall');
cmaps = {cmapbr;cmapwa;cmapwa;cmapbr};

h = pic.plot_map(varstrs,'A',1,'clim',clims,'cmap',cmaps);

%% plotline, magnetic moment, equatorial plane
comp = 'x';
twpe = 6000:1000:12000;%:1000:10000;
xlim = [100 200];
zlim = 0+0.1*[-1 1];
pic = df04.twpelim(twpe,'exact').xlim(xlim).zlim(zlim);
varstrs = {{'Bz'};{'tperp([3 5])'};{'magmom([3 5])'}};

h = pic.plot_line(comp,varstrs,'smooth',5);
h(2).YLim(1) = 0;
h(3).YLim(1) = 0;

%% PIC.time_map, magnetic moment, equatorial plane
comp = 'xt';
twpe = 6000:1000:12000;%:1000:10000;
twpe = [4000 12000];
xlim = [120 200];
zlim = 0+0.1*[-1 1];
pic = df04.twpelim(twpe).xlim(xlim).zlim(zlim);
varstrs = {'Bz';'tperp([3 5])';'magmom([3 5])'};

h = pic.plot_timemap(comp,varstrs);
%h(2).CLim = [0 0.15];
%h(3).CLim = [0 1.5];
%% PIC.time_map, equatorial plane
comp = 'xt';
twpe = 6000:1000:12000;%:1000:10000;
twpe = [0001 12000];
xlim = [120 210];
zlim = 0+0.1*[-1 1];
twci = [1 400];
pic = no02.twpelim(twpe).xlim(xlim).zlim(zlim);
varstrs = {'Ex'};

h = pic.plot_timemap(comp,varstrs,'A',1);
%h(2).CLim = [0 0.15];
%h(3).CLim = [0 1.5];

%% PIC.time_map
comp = 'zt';
pic = no02;
twpe = 7000:100:10000;%:1000:10000;
twpe = [3000 4000];pic.twpe;
twci = [70:2:150];
twci = [95:1:110];
twci = [120 180];
twci = [1 300];
xlim = diff(pic.xi([1 end]))/2 + 0.5*[-1 1];
zlim = 15*[-1 1]; 
pic = pic.twcilim(twci).xlim(xlim).zlim(zlim); 
varstrs = {'Bz';'n([1 3])';'t([1 3])'};
varstrs = {'Ey';'ni';'vy(1)';'vy([3 5])';'viy'};
varstrs = {'Ey';'Jy'};
varstrs = {'Ex';'Jy'};

h = pic.plot_timemap(comp,varstrs,'A',1);

%h(1).CLim = [0 0.5];
%h(2).CLim = [0 1.5];
%h(2).CLim = [0 0.2];

%% plotline, for wenya
comp = 'x';
twpe = 7000:1000:10000;
xlim = [100 210];
%xlim = [160 260];
zlim = 0.5+0.1*[-1 1];
pic = nobg.twpelim(twpe,'exact').xlim(xlim).zlim(zlim);
varstrs = {{'Bz'};{'By'};{'Bx'};{'ni'};{'vix'};{'viy'};{'Ey'};{'Ez'};{'t([1 3 5])'}};

h = pic.plot_line(comp,varstrs);

%% plotline, Ohm's law
comp = 'x';
twpe = [1000:1000:9000];
twpe = 3000;
xlim = [120 200];
zlim = 0.0+0.5*[-1 1];
pic = no02.twpelim(twpe,'exact').xlim(xlim).zlim(zlim);
varstrs = {{'Bx','By','Bz'};{'Ex','Ey','Ez'};{'ni'};{'divpx([1 3 5])','divpx([1])','divpx([3 5])','divpx(1+[1 3 5])'};{'dvxdt([1])','vdvx(1)'};{'vex','vix','vExBx'};{'t([1 3 5])'}};
varstrs = {{'Bx','By','Bz'};{'Ex','Ey','Ez'};{'divpx([1 3 5])','vxBx([1 3 5])','Ex','-divpx([1 3 5])+vxBx([1 3 5])'};{'dvxdt([1])','vdvx(1)'}};
varstrs = {{'Bx','By','Bz'};{'Ex','Ey','Ez'};{'divpx([1 3 5])','vxBx([1 3 5])','Ex','-divpx([1 3 5])+vxBx([1 3 5])'};{'t([1 3 5])'}};
varstrs = {{'Bz','Ey','Jy'};   {'pi','pe'};{'JxBx','JxBy','JxBz'};{'Ex','vixBx','divpex','JxBx./ni','JxBx./ni-vixBx+divpex'};{'Ex','vixBx','divpix','-vixBx+divpix'};{'Ex','-vexBx','-divpex','-vexBx-divpex'};{'Ex+vixBx','Ex+vxBx(1)','Ex+vxBx([3 5])','Ex+vexBx'}};
varstrs = {{'Bz','Ey','Jy','pi','pe'};{'jiy','jey'};{'Ex','vixBx','divpex','JxBx./ni','JxBx./ni-vixBx+divpex'};{'Ex','vixBx','divpix','-vixBx+divpix'};{'Ex','-vexBx','-divpex','-vexBx-divpex'};{'Ex+vixBx','Ex+vexBx'}};
%varstrs = {{'Bz','Ey','Jy','pi','pe'};{'Ex','vixBx','divpex','JxBx./ni','JxBx./ni-vixBx+divpex'};{'Ex','vixBx','divpix','dvixdt','vdvix','-vixBx+divpix+dvixdt+vdvix'};{'Ex','-vexBx','-divpex','dvexdt','vdvex','-vexBx-divpex'}};     
%varstrs = {{'Bz','Ey','Jy'};{'Jx','Jy','Jz'};{'JxBx','JxBy','JxBz'};{'Ey','vixBy','divpey','JxBy','JxBy-vixBy+divpey'};{'Ey','divpiy','vixBy','-vixBy+divpiy'};{'Ey','-vexBy','-divpey','-vexBy-divpey'};{'Ey+vixBy','Ey+vexBy'}};
%varstrs = {{'Bz','Ey','Jy'};   {'JxBx','JxBy','JxBz'};{'Ey','vixBy','divpey','JxBy','JxBy-vixBy+divpey'};{'Ey','divpiy','vixBy','-vixBy+divpiy'};{'Ey','-vexBy','-divpey','-vexBy-divpey'};{'Ey+vixBy','Ey+vexBy'}};
%varstrs = {{'Bz','Ey'};{'Jz','Jy','Jz'};{'JxBx','JxBy','JxBz'};{'Ex','JxBx','vxBx([1 3])','divpx(1+[1 3])','JxBx-vxBx([1 3])+divpx(1+[1 3])'};{'Ex','divpx([1 3])','vxBx([1 3])','-vxBx([1 3])+divpx([1 3])'};{'Ex','-vxBx(1+[1 3])','-divpx(1+[1 3])','-vxBx(1+[1 3])-divpx(1+[1 3])'}};
%varstrs = {{'Bz'};{'t([1 3 5])'}};

h = pic.plot_line(comp,varstrs,'smooth',20);

%% plotline, typical df
comp = 'x';
twpe = 2800;
xlim = [120 210];
zlim = 0+0.05*[-1 1];
pic = no02.twpelim(twpe).xlim(xlim).zlim(zlim);
varstrs = {{'Bz'};{'Ey'};{'vix','vex','vExBx'};{'ni','n([1])','n([3 5])'};{'txx([2 4 6])','tyy([2 4 6])','tzz([2 4 6])'};{'txx([1 3 5])','tyy([1 3 5])','tzz([1 3 5])'}};
%varstrs = {{'Bz'};{'Ey'};{'vix','vex','vExBx'};{'ni','n([1])','n([3])'};{'txx([2 4])','tyy([2 4])','tzz([2 4])'};{'txx([1 3])','tyy([1 3])','tzz([1 3])'}};

h = pic.plot_line(comp,varstrs);

%% plotline, several timesteps
comp = 'x';
twpe = 4000:1000:12000;
xlim = [20 210];
zlim = 0+0.05*[-1 1];
pic = df04.twpelim(twpe,'exact').xlim(xlim).zlim(zlim);
varstrs = {{'Bz'};{'Ey'};{'ni'};{'txx([2 4 6])'};{'tyy([2 4 6])'};{'tzz([2 4 6])'};{'txx([1 3 5])'};{'tyy([1 3 5])'};{'tzz([1 3 5])'}};
varstrs = {{'t([1 3 5])'};{'t([2 4 6])'}};

h = pic.plot_line(comp,varstrs);

%% plotline, vertical, Ez balance
comp = 'z';
twpe = [9000];
xlim = 204+1*[-1 1];
zlim = [-3 3];
pic = df04.twpelim(twpe,'exact').xlim(xlim).zlim(zlim);

% twpe = 10000;
% xlim = 160+1*[-1 1];

% pic = nobg.twpelim(twpe).xlim(xlim).zlim(zlim);

varstrs = {{'Bx','Bz','Ey'};{'Ez','-vxBz([1 3 5])','divpz([1 3 5])','dvzdt([1 3 5])'};{'Ez','-vxBz([2 4 6])','-divpz([2 4 6])'};{'Ey','-vxBy([2 4 6])','divpy([2 4 6])','divpy([1 3 5])'};{'pxx([1 3 5])','pyy([1 3 5])','pzz([1 3 5])','pxy([1 3 5])','pxz([1 3 5])','pyz([1 3 5])'}};

h = pic.plot_line(comp,varstrs,'smooth',10);

%% plotline
comp = 'x';
twpe = 8000;
xlim = [160 207];
zlim = 0+0.1*[-1 1];
pic = df04.twpelim(twpe).xlim(xlim).zlim(zlim);
varstrs = {{'ni','ne'};{'Ex'};{'Ez'};{'txx([4 6])','tyy([4 6])','tzz([4 6])'};{'txx([3 5])','tyy([3 5])','tzz([3 5])'}};
varstrs = {{'ni','ne','n([1])','n([3 5])','n([4 6])','n([4 6])'};{'Ey'};{'Ez'};{'txx([2 4 6])','tyy([2 4 6])','tzz([2 4 6])'};{'txx([1 3 5])','tyy([1 3 5])','tzz([1 3 5])'}};
varstrs = {{'Bz','By'};{'vix','vex','vExBx'};{'Jx','Jz'};{'Ex','Ez'}};
varstrs = {{'Bz','By'};{'vix','vex','vExBx'};{'Jx','Jz'};{'Ex','Ez'}};

h = pic.plot_line(comp,varstrs);

%% plot_line
comp = 'x';
twpe = [8000];
xlim = [130 207];
zlim = 0+0.5*[-1 1];

pic = df04.twpelim(twpe,'exact').xlim(xlim).zlim(zlim);
varstrs = {{'Bz','Jx'};{'vix','vex','vExBx'};{'Ey','-vexBy','-vixBy'};{'divpy([1 3 5])','divpy([2 4 6])'};{'divpx([1 3 5])','divpx([2 4 6])'};{'PB','pDxx([1 3 5])','pDxx([2 4 6])','pxx([1 3 5])','pxx([2 4 6])'}};
%ylim = {[-1 1]*0.99;[-2 0]*0.99;[-0.1 0.5]*0.99;[-0.1 0.1]*0.99;[-0.1 0.1]*0.99;[0 0.4]*0.99};

varstrs = {{'Bz','Jx'};{'vix','vex','vExBx'};{'Ey','-vixBy','divpy([1 3 5])'};{'Ey','-vexBy','-divpy([2 4 6])'};{'pxy([1 3 5])','pyz([1 3 5])','pxy([2 4 6])','pyz([2 4 6])'}};
%ylim = {[-1 1]*0.99;[-2 0]*0.99;[-0.1 0.4]*0.99;[-0.05 0.4]*0.99;[-0.1 0.1]*0.99};


h = pic.plot_line(comp,varstrs,'smooth',20);

%% plot_map
twpe = 8000;
xlim = [150 205];
zlim = [-10 10];
pic = df04.twpelim(twpe).xlim(xlim).zlim(zlim);
varstrs = {'Jx';'Ez';'pxy([3 5])';'pyz([3 5])';'pxy([2 4 6])';'pyz([2 4 6])';'ni'};
clims = {0.7*[-1 1];[-1 1];0.2*[-1 1];0.2*[-1 1];0.1*[-1 1];0.1*[-1 1];[0 2]};
cmapbr = pic_colors('blue_red');
cmapwa = pic_colors('waterfall');
cmaps = {cmapbr;cmapbr;cmapbr;cmapbr;cmapbr;cmapbr;cmapwa};
inds = [3 4];
cmaps = cmaps([3 4]);
clims = clims([3 4]);
varstrs = varstrs([3 4]);

h = pic.plot_map(varstrs,'A',1,'clim',clims,'cmap',cmaps);

%% plottimeseries
comp = 'x';
twpe = df04.twpe;
xlim = 195 + 0.1*[-1 1];
zlim = 0.05 + 0.05*[-1 1];
pic = df04.twpelim(twpe,'exact').xlim(xlim).zlim(zlim);
varstrs = {{'Bx','By','Bz'};{'Ex','Ey','Ez'}};

h = pic.plottimeseries(varstrs);

%% movie_line
comp = 'x';
twpe = [3000 12000];
xlim = [130 207];
zlim = 0+0.1*[-1 1];

pic = df04.twpelim(twpe).xlim(xlim).zlim(zlim);
varstrs = {{'ni','ne'};{'Ex'};{'Ez'};{'txx([4 6])','tyy([4 6])','tzz([4 6])'};{'txx([3 5])','tyy([3 5])','tzz([3 5])'}};
varstrs = {{'ni','ne','n([1])','n([3 5])','n([4 6])','n([4 6])'};{'Ey'};{'Ez'};{'txx([2 4 6])','tyy([2 4 6])','tzz([2 4 6])'};{'txx([1 3 5])','tyy([1 3 5])','tzz([1 3 5])'}};
varstrs = {{'Bz','By'};{'vix','vex','vExBx'};{'Jx','Jz'};{'Ex','Ez'}};
varstrs = {{'Bz','By'};{'vix','vex','vExBx'};{'Jx','Jz'};{'viy','vey'}};
ylim = {[-0.5 0.1]*0.99;[-2 0]*0.99;[-1 1]*0.99;[-3 3]*0.99};

h = pic.movie_line(comp,varstrs,'ylim',ylim,'filename',[printpath 'BzBy_vixvexvExBx_JxJz_viyvey_z=0']);

%% movie_line
comp = 'x';
twpe = [4000 12000];
xlim = [130 207];
zlim = 0+1*[-1 1];

pic = df04.twpelim(twpe).xlim(xlim).zlim(zlim);
varstrs = {{'Bz','Jx'};{'vix','vex','vExBx'};{'Ey','-vexBy','-vixBy'};{'divpy([1 3 5])','divpy([2 4 6])'};{'divpx([1 3 5])','divpx([2 4 6])'};{'PB','pDxx([1 3 5])','pDxx([2 4 6])','pxx([1 3 5])','pxx([2 4 6])'}};
ylim = {[-1 1]*0.99;[-2 0]*0.99;[-0.1 0.5]*0.99;[-0.1 0.1]*0.99;[-0.1 0.1]*0.99;[0 0.4]*0.99};

varstrs = {{'Bz','Jx'};{'vix','vex','vExBx'};{'Ey','-vixBy','divpy([1 3 5])'};{'Ey','-vexBy','-divpy([2 4 6])'};{'pxy([1 3 5])','pyz([1 3 5])','pxy([2 4 6])','pyz([2 4 6])'}};
ylim = {[-1 1]*0.99;[-2 0]*0.99;[-0.1 0.4]*0.99;[-0.1 0.4]*0.99;[-0.1 0.1]*0.99;[0 0.4]*0.99};


h = pic.movie_line(comp,varstrs,'ylim',ylim,'smooth',7,'filename',[printpath 'Ey_z=0_smoothpm7']);

%% movie
twpe = 2000:1000:12000;
xlim = [90 210];
zlim = [0 20];
pic = df04.twpelim(twpe,'exact').xlim(xlim).zlim(zlim);
varstrs = {'Ex';'Ez';'Jx';'Jz'};
clims = {[-1 1];[-1 1];0.4*[-1 1];0.4*[-1 1]};
cmapbr = pic_colors('blue_red');
cmapwa = pic_colors('waterfall');
cmaps = {cmapbr;cmapbr;cmapbr;cmapbr};
filename = [printpath 'df04_ExEzJxJz_03000-12000'];
pic.movie(varstrs,'A',1,'cmap',cmaps,'clim',clims,'filename',filename);

%% movie
twpe = [7000 10000];
xlim = [150 210];
zlim = [-10 10];
pic = nobg.twpelim(twpe).xlim(xlim).zlim(zlim);
varstrs = {'vx(4)';'vx(6)'};
clims = {10*[-1 1];10*[-1 1]};
cmapbr = pic_colors('blue_red');
cmapwa = pic_colors('waterfall');
cmapc2 = pic_colors('candy2');
cmapma = pic_colors('matlab');
cmaps = {cmapma;cmapma;cmapbr;cmapbr;cmapbr};
filename = [printpath 'nobg_vx3_vx5_matlab'];
pic.movie(varstrs,'A',1,'cmap',cmaps,'clim',clims,'filename',filename);

%% movie, cold and hot pressure
twpe = 2000:1000:12000;
xlim = [90 210];
zlim = [0 20];
pic = df04.twpelim(twpe,'exact').xlim(xlim).zlim(zlim);
varstrs = {'p(1)';'p([3 5])'};
clims = {[0 0.25];[0 0.25];0.4*[-1 1];0.4*[-1 1]};
cmapbr = pic_colors('blue_red');
cmapwa = pic_colors('waterfall');
cmaps = {cmapwa;cmapwa;cmapbr;cmapbr};
filename = [printpath 'df04_p1_p35_02000-12000'];
pic.movie(varstrs,'A',1,'cmap',cmaps,'clim',clims,'filename',filename);

%% movie, ni, Epar
pic = no02;
twpe = [7000 12000];
twpe = [2999 4000];

xlim = pic.xi([1 end])+[100 -100];
xlim = [160 180];
zlim = [0 10];
pic = pic.twpelim(twpe).xlim(xlim).zlim(zlim);
varstrs = {'ni';'Epar'};
clims = {[0 0.8];0.5*[-1 1]};
cmapc2 = pic_colors('candy2');
cmapbr = pic_colors('blue_red');
cmapwa = pic_colors('waterfall');
cmaps = {cmapwa;cmapbr;cmapbr;cmapbr};
filename = [printpath 'no02_niEpar'];
pic.movie(varstrs,'A',1,'cmap',cmaps,'clim',clims,'filename',filename);

%% movie, Bz
pic = no02.twpelim([1 10000]);
twpe = pic.twpe;
x0 = (pic.xi(end)-pic.xi(1))/2;
xlim = x0 + 100*[-1 1];
%xlim = pic.xi([1 end]);
zlim = [-25 25];
pic = pic.twpelim(twpe,'exact').xlim(xlim).zlim(zlim);
varstrs = {'Bz';'Ey'};
clims = {0.5*[-1 1];0.5*[-1 1]};
cmapbr = pic_colors('blue_red');
cmapwa = pic_colors('waterfall');
cmaps = {cmapbr;cmapbr;cmapbr;cmapbr};
filename = [printpath 'no02_BzEy'];
pic.movie(varstrs,'A',1,'cmap',cmaps,'clim',clims,'filename',filename);

%% movie, p, n
twpe = 12000;[5000 13000];
x0 = (nobg.xi(end)-nobg.xi(1))/2;
xlim = x0 + 130*[-1 1];
zlim = [-17 17];
pic = nobg.twpelim(twpe).xlim(xlim).zlim(zlim);
varstrs = {'n([1 3 5])';'p([1 3 5])';'t([1 3 5])'};
clims = {[0 0.4],[0 0.2],[0 1]};
cmapbr = pic_colors('blue_red');
cmapwa = pic_colors('waterfall');
cmaps = {cmapwa;cmapwa;cmapwa;cmapbr};
filename = [printpath 'nobg_n135_p135_t135'];
pic.movie(varstrs,'A',1,'cmap',cmaps,'clim',clims,'filename',filename);

%% PICTraj.plot_single
tr = trs.find([trs.t0]==160,[trs.vy0]<-0.25,[trs.x0]>185);
tr([tr.id]==181).tlim([100 240]).plot_single({'xz','ty,tz','tvx,tvy,tvz','tEx,tEy,tEz','tBx,tBy,tBz','tvx,tvy,tvz','tvzBx'}')

tr = trs.find([trs.t0]==160,[trs.vy0]<-0.1,[trs.x0]>195);
tr(1).tlim([100 240]).plot_single({'xz','ty,tz','tvx,tvy,tvz','tEx,tEy,tEz','tBx,tBy,tBz','tvx,tvy,tvz','tvzBx,tEy,tEz'}')

%% PICDist.plot_map
twpe = 10000;
ds = ds04.dxlim([0.3 1]).twpelim(twpe).zfind(0:1:4).xfind(165:1:176);
%twpe = 7000;
%ds = ds04.dxlim([0 0.3]).twpelim(twpe).zfind(0:1:4).xfind(173:190);
%twpe = 8000;
%ds = ds04.dxlim([0.3 1]).twpelim(twpe).zfind(0:2:4).xfind(165:2:176);

%ds = ds04.dxlim([0.3 1]).twpelim([8000]).zfind(2).xfind(170);
clim = [-2 2];
xlim = 0.99*[-1.5 .5];
ylim = 0.99*[-1 1];
sumdim = 2;
fontsie = 16;
h3 = ds.plot_map([3],sumdim,'bline',df04,'v',df04,'log');
%h3 = ds.plot_map([3],sumdim,'bline',df04,'v',df04,'diff');
%h3 = ds.plot_map([3],sumdim,'ratio',[3 5]);
h3links = linkprop(h3.ax,{'XLim','YLim','CLim'});
compact_panels(0.00,0.00)
[hax,hlab] = label_panels(h3.ax);
h3.ax(1).CLim = clim;
h3.ax(1).XLim = xlim;
h3.ax(1).YLim = ylim;
c_eval('hlab(?).FontSize = 14;',1:18)
c_eval('h3.ax(?).FontSize = 16;',1:numel(h3.ax))
c_eval('h3.leg(?).FontSize = 16;',1:numel(h3.leg))

%%
h5 = ds.plot_map([5],sumdim,'bline',df04,'v',df04,'log');
h5links = linkprop(h5.ax,{'XLim','YLim','CLim'});
compact_panels(0.00,0.00)
[hax,hlab] = label_panels(h5.ax);
%h5.ax(1).CLim = [0 200];
h5.ax(1).CLim = clim;
h5.ax(1).XLim = xlim;
h5.ax(1).YLim = ylim;
c_eval('hlab(?).FontSize = 16;',1:18)
c_eval('h5.ax(?).FontSize = 16;',1:numel(h5.ax))
c_eval('h5.leg(?).FontSize = 16;',1:numel(h5.leg))
%%
h35 = ds.plot_map([3 5],sumdim,'bline',df04,'v',df04,'log');
h35links = linkprop(h35.ax,{'XLim','YLim','CLim'});
compact_panels(0.00,0.00)
%h35.ax(1).CLim = [0 2];
h35.ax(1).CLim = clim;
h35.ax(1).XLim = xlim;
h35.ax(1).YLim = ylim;
c_eval('hlab(?).FontSize = 16;',1:18)
c_eval('h35.ax(?).FontSize = 16;',1:numel(h35.ax))
c_eval('h35.leg(?).FontSize = 16;',1:numel(h35.leg))
%%
h135 = ds.plot_map([1 3 5],sumdim,'bline',df04,'v',df04,'log');
h135links = linkprop(h135.ax,{'XLim','YLim','CLim'});
compact_panels(0.00,0.00)
%h35.ax(1).CLim = [0 2];
h135.ax(1).CLim = clim;
h135.ax(1).XLim = [-2.5 2.5];
h135.ax(1).YLim = [-2.5 2.5];

%% PICDist.plot_map
twpe = 10000;
%ds = ds01.twpelim(twpe).zfind([0 1 2 3]).xfind(140:3:210);
ds = ds01.twpelim(twpe).zfind([-3 -2 -1 0]).xfind([196 200 204]);

sumdim = 1;
%ds = ds04.dxlim([0.3 1]).twpelim([8000]).zfind(2).xfind(170);
clim = [-3 1.5];
xlim = 2*0.99*[-1 1];
ylim = 2*0.99*[-1 1];
fontsie = 16;
%h = ds.plot_map([3],sumdim,'bline',nobg,'v',nobg,'frac',[3 5]); % ,'log'
%h = ds.plot_map([3],sumdim,'bline',nobg,'v',nobg,'diff',[5]); % ,'log'
%h = ds.plot_map([3 5],sumdim,'bline',df04n,'v',df04n); % ,'log'
%h = ds.plot_map([3],sumdim,'bline',nobg,'v',nobg,'diff',[5],'log'); %
%h = ds.plot_map([3],sumdim,'bline',nobg,'v',nobg,'frac',[5],'log'); % 
hlinks = linkprop(h.ax,{'XLim','YLim','CLim','XTick','YTick'});
compact_panels(0.00,0.00)
[hax,hlab] = label_panels(h.ax);
%h.ax(1).CLim = clim;
%h.ax(1).XLim = xlim;
%h.ax(1).YLim = ylim;
%c_eval('hlab(?).FontSize = 12;',1:18)
%c_eval('h.ax(?).FontSize = 14;',1:numel(h.ax))
%c_eval('h.leg(?).FontSize = 12;',1:numel(h.leg))
%colormap([1 1 1; pic_colors('blue_red')])
colormap([1 1 1; pic_colors('blue_red'); 1 1 1])

%% PICDist.plot_map
twpe = 09000;
ds = ds01.twpelim(twpe).zfind(0:1:4).xfind(150:3:210);
ds = ds01.twpelim(twpe).zfind(0:1:4).xfind(170:1:182);
ds = ds01.twpelim(twpe).zfind(0:1:4).xfind(170:1:182);
%ds = ds01.twpelim(twpe).zfind(0:1:4).xfind(194:1:206);
%twpe = 7000;
%ds = ds04.dxlim([0 0.3]).twpelim(twpe).zfind(0:1:4).xfind(173:190);
%twpe = 8000;
%ds = ds04.dxlim([0.3 1]).twpelim(twpe).zfind(0:2:4).xfind(165:2:176);

%ds = ds04.dxlim([0.3 1]).twpelim([8000]).zfind(2).xfind(170);
clim = [-2 2];
xlim = 0.99*[-1.5 .5];
ylim = 0.99*[-1 1];
sumdim = 2;
fontsie = 16;
%h = ds.plot_map([3 5],sumdim,'bline',nobg,'v',nobg,'log');
%h = ds.plot_map([3],sumdim,'bline',df04,'v',df04,'diff');
%h = ds.plot_map([3],sumdim,'ratio',[3 5]);
h = ds.plot_map([1],sumdim,'forces','EvBy',nobg,'bline',nobg,'v',nobg,'log');
%h = ds.plot_map([3],sumdim,'bline',nobg,'v',nobg,'diff',[5],'log');
%
hlinks = linkprop(h.ax,{'XLim','YLim','CLim'});
compact_panels(0.00,0.00)
[hax,hlab] = label_panels(h.ax);
%h3.ax(1).CLim = clim;
%h3.ax(1).XLim = xlim;
%h3.ax(1).YLim = ylim;
c_eval('hlab(?).FontSize = 14;',1:18)
c_eval('h.ax(?).FontSize = 16;',1:numel(h.ax))
c_eval('h.leg(?).FontSize = 12;',1:numel(h.leg))

cdata = get(findobj(h.ax(1).Children,'type','Image'),'CData');
%h.ax(1).CLim = prctile(abs(cdata(:)),99)*[-1 1];

%% PICDist.reduce_1d, along a line
%ds = ds01.zfind(3);
%fred = ds.reduce_1d_new('x',[5],[]);
twpe = 10000;
xlim = [130 210];
zlim = [-15 15];
ds = ds01.twpelim(twpe).zlim(zlim).xlim(xlim);
ds = ds01.twpelim(twpe);
id_line1 = 1:274;
id_line2 = 275:462;
id_line3 = 463:667;
id_line4 = 668:918;
id_line = id_line3;
ds = ds.update_inds({id_line});

xdist = (ds.xi1{1}+ds.xi2{1})/2;
zdist = (ds.zi1{1}+ds.zi2{1})/2;
% arclength = [0 cumsum(sqrt(diff(xdist).^2 + diff(zdist).^2))];

pic_lim = nobg.xlim(xlim).zlim(zlim).twpelim(twpe);
pic = nobg.twpelim(twpe);
Bx_ = pic.Bx;
By_ = pic.By;
Bz_ = pic.Bz;

Bx = interpfield(pic.xi,pic.zi,Bx_,xdist,zdist); 
By = interpfield(pic.xi,pic.zi,By_,xdist,zdist); 
Bz = interpfield(pic.xi,pic.zi,Bz_,xdist,zdist); 

if 1 % saved reduced distributions
  load('/Volumes/Fountain/Data/PIC/no_hot_bg_test/matlab/fred_2.mat')  
  load('/Volumes/Fountain/Data/PIC/no_hot_bg_test/matlab/fred_3.mat')
  load('/Volumes/Fountain/Data/PIC/no_hot_bg_test/matlab/fred_4.mat')
  %save('/Volumes/Fountain/Data/PIC/no_hot_bg_test/matlab/fred_4.mat','fred35_4')
else % make reduced distributions
  %fred1_2 = ds.reduce_1d_new('x',[1],[],'vpar',{Bx,By,Bz});
  %fred3_2 = ds.reduce_1d_new('x',[3],[],'vpar',{Bx,By,Bz});
  %fred4_2 = ds.reduce_1d_new('x',[4],[],'vpar',{Bx,By,Bz});
  %fred5_2 = ds.reduce_1d_new('x',[5],[],'vpar',{Bx,By,Bz});
  %fred6_2 = ds.reduce_1d_new('x',[6],[],'vpar',{Bx,By,Bz});
  %fred35_2 = ds.reduce_1d_new('x',[3 5],[],'vpar',{Bx,By,Bz});
  %fred46_2 = ds.reduce_1d_new('x',[4 6],[],'vpar',{Bx,By,Bz});
  fred35_3 = ds.reduce_1d_new('x',[3 5],[],'vpar',{Bx,By,Bz});
  fred46_3 = ds.reduce_1d_new('x',[4 6],[],'vpar',{Bx,By,Bz});
  %fred1_4 = ds.reduce_1d_new('x',[1],[],'vpar',{Bx,By,Bz});
  %fred3_4 = ds.reduce_1d_new('x',[3],[],'vpar',{Bx,By,Bz});
  %fred4_4 = ds.reduce_1d_new('x',[4],[],'vpar',{Bx,By,Bz});
  %fred5_4 = ds.reduce_1d_new('x',[5],[],'vpar',{Bx,By,Bz});
  %fred6_4 = ds.reduce_1d_new('x',[6],[],'vpar',{Bx,By,Bz});
  %fred35_4 = ds.reduce_1d_new('x',[3 5],[],'vpar',{Bx,By,Bz});
  %fred46_4 = ds.reduce_1d_new('x',[4 6],[],'vpar',{Bx,By,Bz});
end
%% Plot
fredi_str = '35'; iSpecies = [3 5];
frede_str = '46'; eSpecies = [4 6];
fredi = eval(['fred' fredi_str '_3']);
frede = eval(['fred' frede_str '_3']);
fred = fredi;
arclength = [0; cumsum(sqrt(diff(fredi.x).^2 + diff(fredi.z).^2))];
if 1; arclength = arclength - arclength(find(abs(fredi.z)==min(abs(fredi.z)))); end
ni = interpfield(pic.xi,pic.zi,pic.ni,fredi.x,fredi.z); 
ne = interpfield(pic.xi,pic.zi,pic.ne,fredi.x,fredi.z); 
vipar = interpfield(pic.xi,pic.zi,pic.vpar(iSpecies),fredi.x,fredi.z); 
vepar = interpfield(pic.xi,pic.zi,pic.vpar(eSpecies),fredi.x,fredi.z); 
vix = interpfield(pic.xi,pic.zi,pic.vx(iSpecies),fredi.x,fredi.z); 
viy = interpfield(pic.xi,pic.zi,pic.vy(iSpecies),fredi.x,fredi.z); 
viz = interpfield(pic.xi,pic.zi,pic.vz(iSpecies),fredi.x,fredi.z); 
vex = interpfield(pic.xi,pic.zi,pic.vx(eSpecies),fredi.x,fredi.z); 
vey = interpfield(pic.xi,pic.zi,pic.vy(eSpecies),fredi.x,fredi.z); 
vez = interpfield(pic.xi,pic.zi,pic.vz(eSpecies),fredi.x,fredi.z); 
vepar = interpfield(pic.xi,pic.zi,pic.vpar(eSpecies),fredi.x,fredi.z); 
Epar = interpfield(pic.xi,pic.zi,pic.Epar,fredi.x,fredi.z); 
Eparx = interpfield(pic.xi,pic.zi,pic.Eparx,fredi.x,fredi.z); 
Epary = interpfield(pic.xi,pic.zi,pic.Epary,fredi.x,fredi.z); 
Eparz = interpfield(pic.xi,pic.zi,pic.Eparz,fredi.x,fredi.z); 
Ex = interpfield(pic.xi,pic.zi,pic.Ex,fredi.x,fredi.z); 
Ey = interpfield(pic.xi,pic.zi,pic.Ey,fredi.x,fredi.z); 
Ez = interpfield(pic.xi,pic.zi,pic.Ez,fredi.x,fredi.z);
vExBx = interpfield(pic.xi,pic.zi,pic.vExBx,fredi.x,fredi.z); 
vExBy = interpfield(pic.xi,pic.zi,pic.vExBy,fredi.x,fredi.z); 
vExBz = interpfield(pic.xi,pic.zi,pic.vExBz,fredi.x,fredi.z);
vExBabs = sqrt(vExBx.^2 + vExBy.^2 + vExBz.^2);
EExB = vExBabs.^2/2;
Bx = interpfield(pic.xi,pic.zi,pic.Bx,fredi.x,fredi.z); 
By = interpfield(pic.xi,pic.zi,pic.By,fredi.x,fredi.z); 
Bz = interpfield(pic.xi,pic.zi,pic.Bz,fredi.x,fredi.z); 

fi_clim = [0 0.013];
fe_clim = [0 7.99e-3];

nrows = 6;
ncols = 1;
h = setup_subplots(nrows,ncols);
isub = 1;
doE = 1; colorE = [0 0.8 0.8];
doV = 1; colorV = 0*[1 1 1];
doN = 1; colorN = [0 0 0];
doExB = 1; colorExB = 0*[1 1 1]+0.5;
isMap = [];

if 1 % line position on map, vy
  isMap(end+1) = isub; 
  hca = h(isub); isub = isub + 1;
  imagesc(hca,pic_lim.xi,pic_lim.zi,pic_lim.vy(iSpecies)');
  colormap(hca,pic_colors('blue_red'));
  hcb = colorbar('peer',hca);
  hca.CLim = max(max(get(findobj(hca.Children,'type','Image'),'CData')))*[-1 1];
  hcb.YLabel.String = sprintf('v_{y,%s}',fredi_str);
  hca.XLabel.String = 'x (d_i)';
  hca.YLabel.String = 'z (d_i)';
  hca.YDir = 'normal';
  hca.XGrid = 'on';
  hca.YGrid = 'on';
  if 1 % plot_boxes
    hold(hca,'on')
    ds.plot_boxes(hca)
    hold(hca,'off')
  end
end
if 1 % line position on map, Ez
  isMap(end+1) = isub; 
  hca = h(isub); isub = isub + 1;
  imagesc(hca,pic_lim.xi,pic_lim.zi,pic_lim.Ez');
  colormap(hca,pic_colors('blue_red'));
  hcb = colorbar('peer',hca);
  hca.CLim = max(max(get(findobj(hca.Children,'type','Image'),'CData')))*[-1 1];
  hcb.YLabel.String = 'E_z';
  hca.XLabel.String = 'x (d_i)';
  hca.YLabel.String = 'z (d_i)';
  hca.YDir = 'normal';
  hca.XGrid = 'on';
  hca.YGrid = 'on';
  if 1 % plot_boxes
    hold(hca,'on')
    ds.plot_boxes(hca)
    hold(hca,'off')
  end
end
if 0 % line position
  hca = h(isub); isub = isub + 1;
  [ax,h1,h2] = plotyy(hca,arclength,fredi.x,arclength,fredi.z);
  hca.XLabel.String = 'arclength (d_i)';
  ax(1).YLabel.String = 'x';
  ax(2).YLabel.String = 'z';
  legend(hca,{'x','z'},'location','best')
  hca.XGrid = 'on';
  hca.YGrid = 'on';
end
if 0 % B
  hca = h(isub); isub = isub + 1;
  plot(hca,arclength,Bx,arclength,By,arclength,Bz)
  hca.XLabel.String = 'arclength (d_i)';
  hca.YLabel.String = 'B';
  legend(hca,{'B_x','B_y','B_z'},'location','eastoutside')
  hca.XGrid = 'on';
  hca.YGrid = 'on';
end
if 0 % n
  hca = h(isub); isub = isub + 1;
  plot(hca,arclength,ni,arclength,ne)
  hca.XLabel.String = 'arclength (d_i)';
  hca.YLabel.String = 'n';
  legend(hca,{'n_i','n_e'},'location','eastoutside')
  hca.XGrid = 'on';
  hca.YGrid = 'on';
end
if 0 % v
  hca = h(isub); isub = isub + 1;
  plot(hca,arclength,vix,arclength,viy,arclength,viz,arclength,vex,arclength,vey,arclength,vez)
  hca.XLabel.String = 'arclength (d_i)';
  hca.YLabel.String = 'B';
  legend(hca,{'v_{ix}','v_{iy}','v_{iz}','v_{ex}','v_{ey}','v_{ez}'},'location','eastoutside')
  hca.XGrid = 'on';
  hca.YGrid = 'on';
end
if 0 % v
  hca = h(isub); isub = isub + 1;
  plot(hca,arclength,vExBx,arclength,vExBy,arclength,vExBz,arclength,vExBabs)
  hca.XLabel.String = 'arclength (d_i)';
  hca.YLabel.String = 'v_{ExB}';
  legend(hca,{'v_{x}','v_{y}','v_{z}','|v|'},'location','eastoutside')
  hca.XGrid = 'on';
  hca.YGrid = 'on';
end
if 0 % E
  hca = h(isub); isub = isub + 1;
  plot(hca,arclength,Ex,arclength,Ey,arclength,Ez)
  hca.XLabel.String = 'arclength (d_i)';
  hca.YLabel.String = 'E';
  legend(hca,{'E_{x}','E_{y}','E_{z}'},'location','eastoutside')
  hca.XGrid = 'on';
  hca.YGrid = 'on';
end
if 0 % Epar, int(Epar)dl
  hca = h(isub); isub = isub + 1;
  plot(hca,arclength,Epar,arclength,-cumtrapz(arclength,Epar))  
  legend(hca,{'E_{||}','-\int E_{||}dl_{||}'},'location','eastoutside') 
  if 0
  hold(hca,'on')
  plot(hca,arclength,Eparx,arclength,Epary,arclength,Eparz)  
  hold(hca,'off')
  legend(hca,{'E_{||}','-\int E_{||}dl_{||}','E_{||,x}','E_{||,y}','E_{||,z}'},'location','eastoutside') 
  end
  hca.YLabel.String = 'E_{||}, \int E_{||}dl_{||}'; 
  
  hca.XLabel.String = 'arclength (d_i)';  
  hca.XGrid = 'on';
  hca.YGrid = 'on';
end
if 1 % fi(vx)
  hca = h(isub); isub = isub + 1;
  pcolor(hca,arclength,fredi.v,fredi.fvx')
  shading(hca,'flat')
  hca.XLabel.String = 'arclength (d_i)';
  hca.YLabel.String = 'v_{x}';
  colormap(hca,pic_colors('candy'))  
  hcb = colorbar('peer',hca);
  hcb.YLabel.String = ['f_{i,' fredi_str '}(l_{||},v_{x})'];
  hca.CLim(2) = prctile(fredi.fvx(:),99);
  hca.XGrid = 'on';
  hca.YGrid = 'on';
  hca.Layer = 'top';
  if doE
    hold(hca,'on')
    plot(hca,arclength,Ex*max(abs(hca.YLim))/max(abs(Ex)),'color',colorE)
    hold(hca,'off')
  end
  if doV
    hold(hca,'on')
    plot(hca,arclength,vix,'color',colorV,'linewidth',1.5)
    hold(hca,'off')
  end
  if doExB
    hold(hca,'on')
    plot(hca,arclength,vExBx,'color',colorExB,'linewidth',1.5)
    hold(hca,'off')
  end
end
if 0 % fe(vx)
  hca = h(isub); isub = isub + 1;
  pcolor(hca,arclength,frede.v,frede.fvx')
  shading(hca,'flat')
  hca.XLabel.String = 'arclength (d_i)';
  hca.YLabel.String = 'v_{x}';
  colormap(hca,pic_colors('candy'))  
  hcb = colorbar('peer',hca);
  hcb.YLabel.String = ['f_{e,' frede_str '}(l_{||},v_{x})'];
  hca.CLim(2) = prctile(frede.fvx(:),99);
  hca.XGrid = 'on';
  hca.YGrid = 'on';
  hca.Layer = 'top';
  if doE
    hold(hca,'on')
    plot(hca,arclength,Ex*max(abs(hca.YLim))/max(abs(Ex)),'color',colorE)
    hold(hca,'off')
  end
  if doV
    hold(hca,'on')
    plot(hca,arclength,vix,'color',colorV,'linewidth',1.5)
    hold(hca,'off')
  end
  if doExB
    hold(hca,'on')
    plot(hca,arclength,vExBx,'color',colorExB,'linewidth',1.5)
    hold(hca,'off')
  end
end
if 1 % fi(vy)
  hca = h(isub); isub = isub + 1;
  pcolor(hca,arclength,fredi.v,fredi.fvy')
  shading(hca,'flat')
  hca.XLabel.String = 'arclength (d_i)';
  hca.YLabel.String = 'v_{y}';
  colormap(hca,pic_colors('candy'))  
  hcb = colorbar('peer',hca);  
  hcb.YLabel.String = ['f_{i,' fredi_str '}(l_{||},v_{y})'];
  hca.CLim(2) = prctile(fredi.fvy(:),99);
  hca.XGrid = 'on';
  hca.YGrid = 'on';
  hca.Layer = 'top';
  if doE
    hold(hca,'on')
    plot(hca,arclength,Ey*max(abs(hca.YLim))/max(abs(Ey)),'color',colorE)
    hold(hca,'off')
  end
  if doV
    hold(hca,'on')
    plot(hca,arclength,viy,'color',colorV,'linewidth',1.5)
    hold(hca,'off')
  end
  if doExB
    hold(hca,'on')
    plot(hca,arclength,vExBy,'color',colorExB,'linewidth',1.5)
    hold(hca,'off')
  end
end
if 1 % fi(vz)
  hca = h(isub); isub = isub + 1;
  pcolor(hca,arclength,fredi.v,fredi.fvz')
  shading(hca,'flat')
  hca.XLabel.String = 'arclength (d_i)';
  hca.YLabel.String = 'v_{z}';
  colormap(hca,pic_colors('candy'))  
  hcb = colorbar('peer',hca);
  hcb.YLabel.String = ['f_{i,' fredi_str '}(l_{||},v_{z})'];
  hca.CLim(2) = prctile(fredi.fvz(:),99);
  hca.XGrid = 'on';
  hca.YGrid = 'on';
  hca.Layer = 'top';
  if doE
    hold(hca,'on')
    plot(hca,arclength,Ez*max(abs(hca.YLim))/max(abs(Ez)),'color',colorE)
    hold(hca,'off')
  end
  if doV
    hold(hca,'on')
    plot(hca,arclength,viz,'color',colorV,'linewidth',1.5)
    hold(hca,'off')
  end
  if doExB
    hold(hca,'on')
    plot(hca,arclength,vExBz,'color',colorExB,'linewidth',1.5)
    hold(hca,'off')
  end
end
if 0 % fi(vpar)
  hca = h(isub); isub = isub + 1;
  pcolor(hca,arclength,fredi.vpar_center,fredi.fvpar')
  shading(hca,'flat')
  hca.XLabel.String = 'arclength (d_i)';
  hca.YLabel.String = 'v_{||}';
  colormap(hca,pic_colors('candy'))  
  hcb = colorbar('peer',hca);
  hcb.YLabel.String = ['f_{i,' fredi_str '}(l_{||},v_{||})'];
  hca.CLim(2) = prctile(fredi.fvpar(:),99);
  hca.CLim = fi_clim;
  hca.XGrid = 'on';
  hca.YGrid = 'on';
  hca.Layer = 'top';
  if doE
    hold(hca,'on')
    plot(hca,arclength,Epar*max(abs(hca.YLim))/max(abs(Epar)),'color',colorE)
    hold(hca,'off')
  end
  if doV
    hold(hca,'on')
    plot(hca,arclength,vipar,'color',colorV,'linewidth',1.5)
    hold(hca,'off')
  end
end
if 0 % fe(vpar)
  hca = h(isub); isub = isub + 1;
  pcolor(hca,arclength,frede.vpar_center,frede.fvpar')
  shading(hca,'flat')
  hca.XLabel.String = 'arclength (d_i)';
  hca.YLabel.String = 'v_{||}';
  colormap(hca,pic_colors('candy'))  
  hcb = colorbar('peer',hca);
  hcb.YLabel.String = ['f_{e,' frede_str '}(l_{||},v_{||})'];
  hca.CLim(2) = prctile(frede.fvpar(:),99);
  hca.CLim = fi_clim;
  hca.XGrid = 'on';
  hca.YGrid = 'on';
  hca.Layer = 'top';
  if doE
    hold(hca,'on')
    plot(hca,arclength,Epar*max(abs(hca.YLim))/max(abs(Epar)),'color',colorE)
    hold(hca,'off')
  end
  if doV
    hold(hca,'on')
    plot(hca,arclength,vepar,'color',colorV,'linewidth',1.5)
    hold(hca,'off')
  end
end
if 0 % fi(vabs)
  hca = h(isub); isub = isub + 1;
  pcolor(hca,arclength,fredi.vabs_center,fredi.fvabs')
  shading(hca,'flat')
  hca.XLabel.String = 'arclength (d_i)';
  hca.YLabel.String = 'v_{||}';
  colormap(hca,pic_colors('candy'))  
  hcb = colorbar('peer',hca);
  hcb.YLabel.String = ['f_{i,' fredi_str '}(l_{||},|v|)'];
  hca.CLim(2) = prctile(fredi.fvabs(:),99);
  %hca.CLim = fi_clim;
  hca.XGrid = 'on';
  hca.YGrid = 'on';
  hca.Layer = 'top';
  if 0%doE
    hold(hca,'on')
    plot(hca,arclength,Epar*max(abs(hca.YLim))/max(abs(Epar)),'color',colorE)
    hold(hca,'off')
  end
  if 0%doV
    hold(hca,'on')
    plot(hca,arclength,vipar,'color',colorV,'linewidth',1.5)
    hold(hca,'off')
  end
end
if 1 % defi35(m*abs^2/2)
  %%
  %isub = 6;
  hca = h(isub); isub = isub + 1;
  darc = arclength(2)-arclength(1);
  arclength_edges = [arclength-darc/2; arclength(end)+darc/2];
  [ARC,EN] = meshgrid(arclength_edges,fredi.vabs_edges.^2/2);
  surf(hca,ARC,EN,ARC*0,log10(fredi.fdefE'))
  shading(hca,'flat')
  view(hca,[0 0 1])
  %pcolor(hca,arclength,fredi.vabs_center.^2/2,log10(fredi.fdefE'))
  shading(hca,'flat')
  hca.XLabel.String = 'arclength (d_i)';
  hca.YLabel.String = 'mv^2/2';
  colormap(hca,pic_colors('candy'))
  colormap(hca,[ 1 1 1; pic_colors('waterfall')])
  hcb = colorbar('peer',hca);
  hcb.YLabel.String = ['dpf_{i,' fredi_str '}(l_{||},mv^2/2)'];
  hca.CLim = [prctile(log10(fredi.fdefE(fredi.fdefE>0)),1) prctile(log10(fredi.fdefE(fredi.fdefE>0)),99)];
  %hca.CLim = fi_clim;
  hca.XGrid = 'on';
  hca.YGrid = 'on';
  hca.Layer = 'top';
  hca.YScale = 'log';
  hca.YTick = 10.^(-10:1:10);
  hca.YLim(1) = 10^(-2);
  if doExB
    hold(hca,'on')
    plot(hca,arclength,EExB,'color',colorExB,'linewidth',1.5)
    hold(hca,'off')
  end
  if 0%doE
    hold(hca,'on')
    plot(hca,arclength,Epar*max(abs(hca.YLim))/max(abs(Epar)),'color',colorE)
    hold(hca,'off')
  end
  if 0%doV
    hold(hca,'on')
    plot(hca,arclength,vipar,'color',colorV,'linewidth',1.5)
    hold(hca,'off')
  end
end
if 0 % defe35(m*vabs^2/2)
  %%
  %isub = 6;
  hca = h(isub); isub = isub + 1;
  darc = arclength(2)-arclength(1);
  arclength_edges = [arclength-darc/2; arclength(end)+darc/2];
  [ARC,EN] = meshgrid(arclength_edges,frede.vabs_edges.^2/2/25);
  surf(hca,ARC,EN,ARC*0,log10(frede.fdefE'))
  shading(hca,'flat')
  view(hca,[0 0 1])
  %pcolor(hca,arclength,fredi.vabs_center.^2/2,log10(fredi.fdefE'))
  shading(hca,'flat')
  hca.XLabel.String = 'arclength (d_i)';
  hca.YLabel.String = 'mv^2/2';
  colormap(hca,pic_colors('candy'))
  colormap(hca,[ 1 1 1; pic_colors('waterfall')])
  hcb = colorbar('peer',hca);
  hcb.YLabel.String = ['dpf_{e,' frede_str '}(l_{||},mv^2/2)'];
  hca.CLim = [prctile(log10(frede.fdefE(frede.fdefE>0)),1) prctile(log10(frede.fdefE(frede.fdefE>0)),99)];
  %hca.CLim = fi_clim;
  hca.XGrid = 'on';
  hca.YGrid = 'on';
  hca.Layer = 'top';
  hca.YScale = 'log';
  hca.YTick = 10.^(-10:1:10);
  hca.YLim(1) = 10^(-2);
  if doExB
    hold(hca,'on')
    plot(hca,arclength,EExB/25,'color',colorExB,'linewidth',1.5)
    hold(hca,'off')
  end
  if 0%doE
    hold(hca,'on')
    plot(hca,arclength,Epar*max(abs(hca.YLim))/max(abs(Epar)),'color',colorE)
    hold(hca,'off')
  end
  if 0%doV
    hold(hca,'on')
    plot(hca,arclength,vipar,'color',colorV,'linewidth',1.5)
    hold(hca,'off')
  end
end
if 0 % f46(vpar)
  hca = h(isub); isub = isub + 1;
  pcolor(hca,arclength,frede.vpar_center,frede.fvpar')
  hca.YLim = [-7 7];
  shading(hca,'flat')
  hca.XLabel.String = 'arclength (d_i)';
  hca.YLabel.String = 'v_{||}';
  colormap(hca,pic_colors('candy'))
  hcb = colorbar('peer',hca);
  hca.CLim = fe_clim;
  hcb.YLabel.String = ['f_{e,' frede_str '}(l_{||},v_{||})'];  
  hca.XGrid = 'on';
  hca.YGrid = 'on';
  hca.Layer = 'top';
  if doE
    hold(hca,'on')
    plot(hca,arclength,Epar*max(abs(hca.YLim))/max(abs(Epar)),'color',colorE)
    hold(hca,'off')
  end
  if doV
    hold(hca,'on')
    plot(hca,arclength,vepar,'color',colorV,'linewidth',1.5)
    hold(hca,'off')
  end
  
end
if 0 % def35(vabs^2)
  hca = h(isub); isub = isub + 1;
  darc = arclength(2)-arclength(1);
  arclength_edges = [arclength-darc/2 arclength(end)+darc/2];
  surf(hca,arclength_edges,frede.vabs_edges.^2/2/25,log10(frede.fdefE'))
  view([0 1 0])
  shading(hca,'flat')
  hca.XLabel.String = 'arclength (d_i)';
  hca.YLabel.String = 'mv^2/2';
  colormap(hca,pic_colors('candy'))  
  hcb = colorbar('peer',hca);
  hcb.YLabel.String = ['dpf_{i,' frede_str '}(l_{||},mv^2/2)'];
  hca.CLim = [prctile(log10(frede.fdefE(:)),5) prctile(log10(frede.fdefE(:)),95)];
  %hca.CLim = fi_clim;
  hca.XGrid = 'on';
  hca.YGrid = 'on';
  hca.Layer = 'top';
  hca.YScale = 'log';
  hca.YTick = 10.^(-10:1:10);
  hca.YLim(1) = 10^(-2);
  if doExB
    hold(hca,'on')
    plot(hca,arclength,EExB/25,'color',colorExB)
    hold(hca,'off')
  end
  if 0%doE
    hold(hca,'on')
    plot(hca,arclength,Epar*max(abs(hca.YLim))/max(abs(Epar)),'color',colorE)
    hold(hca,'off')
  end
  if 0%doV
    hold(hca,'on')
    plot(hca,arclength,vipar,'color',colorV,'linewidth',1.5)
    hold(hca,'off')
  end
end
%
compact_panels(h(setdiff(1:nrows*ncols,isMap)),0.01)
compact_panels(h(isMap),0.01)
h(1).Title.String = ['nobg, t\omega_{pe} = ' num2str(twpe,'%05.0f')];
%fig = gcf; h_ = findobj(fig.Children,'type','axes');
hlinks = linkprop(h(setdiff(1:nrows*ncols,isMap)),{'XLim'});
hlinks = linkprop(h(isMap),{'XLim','YLim'});

%hlinks.Targets(1).XLim = arclength([1 end]);
%irf_plot_axis_align
for ip = 1:nrows*ncols
  axwidth(ip) = h(ip).Position(3);
end
for ip = 1:nrows*ncols
  h(ip).Position(3) = min(axwidth);
end



%ax(2).YAxisLocation = 'right';
if 0
  %%
  nrows = 3;
  ncols = 1;
  h = setup_subplots(nrows,ncols);
  isub = 1;  
  
  if 1 % line position
    hca = h(isub); isub = isub + 1;
    [ax,h1,h2] = plotyy(hca,arclength,fredi.x,arclength,fredi.z);
    hca.XLabel.String = 'arclength (d_i)';
    ax(1).YLabel.String = 'x';
    ax(2).YLabel.String = 'z';
    legend(hca,{'x','z'},'location','eastoutside')
    hca.XGrid = 'on';
    hca.YGrid = 'on';
  end
  if 1 % Epar
    hca = h(isub); isub = isub + 1;
    plot(hca,arclength,Eparx,arclength,Epary,arclength,Eparz,arclength,Epar)          
    legend(hca,{'E_{||}','-\int E_{||}dl_{||}','E_{||,x}','E_{||,y}','E_{||,z}'},'location','eastoutside') 
    legend(hca,{'E_{||,x}','E_{||,y}','E_{||,z}','E_{||}'},'location','eastoutside') 
    hca.YLabel.String = 'E_{||}'; 

    hca.XLabel.String = 'arclength (d_i)';  
    hca.XGrid = 'on';
    hca.YGrid = 'on';
  end
  if 1 % int Epar
    hca = h(isub); isub = isub + 1;
    plot(hca,arclength,-cumtrapz(arclength,Eparx),arclength,-cumtrapz(arclength,Epary),arclength,-cumtrapz(arclength,Eparz),arclength,-cumtrapz(arclength,Epar))
    %legend(hca,{'E_{||}','-\int E_{||}dl_{||}','E_{||,x}','E_{||,y}','E_{||,z}'},'location','eastoutside') 
    legend(hca,{'E_{||,x}','E_{||,y}','E_{||,z}','E_{||}'},'location','eastoutside') 
    hca.YLabel.String = '-\int E_{||}dl_{||}'; 

    hca.XLabel.String = 'arclength (d_i)';  
    hca.XGrid = 'on';
    hca.YGrid = 'on';
  end
  compact_panels(0.01)
  h = findobj(get(gcf,'children'),'type','axes'); hall = hall(end:-1:1);
  hlink = linkprop(h,{'XLim'});
  h(1).XLim = arclength([1 end]);
  for ip = 1:nrows*ncols
    axwidth(ip) = h(ip).Position(3);
  end
  for ip = 1:nrows*ncols
    h(ip).Position(3) = min(axwidth);
  end
end
  
%% PICDist.reduce_1d, vertical cut
twpe = 5000;
xlim = [190 210];
zlim = [-10 10];
xpick = 204;
ds = ds04n.twpelim(twpe).xfind(xpick);

xdist = (ds.xi1{1}+ds.xi2{1})/2;
zdist = (ds.zi1{1}+ds.zi2{1})/2;
% arclength = [0 cumsum(sqrt(diff(xdist).^2 + diff(zdist).^2))];

pic = df04n.xlim(xlim).zlim(zlim).twpelim(twpe);
pic = df04n.xlim(xlim).zlim(zlim).twpelim(5000);
pic_sm = df04n.xlim([min(ds.xi1{1}) max(ds.xi2{1})]).zlim([min(ds.zi1{1}) max(ds.zi2{1})]).twpelim(5000);
%pic = df04n.twpelim(twpe);
Bx_ = pic.Bx;
By_ = pic.By;
Bz_ = pic.Bz;

Bx = interpfield(pic.xi,pic.zi,Bx_,xdist,zdist); 
By = interpfield(pic.xi,pic.zi,By_,xdist,zdist); 
Bz = interpfield(pic.xi,pic.zi,Bz_,xdist,zdist); 

if 0 % saved reduced distributions
  load('/Volumes/Fountain/Data/PIC/no_hot_bg_test/matlab/fred_2.mat')  
  load('/Volumes/Fountain/Data/PIC/no_hot_bg_test/matlab/fred_3.mat')
  load('/Volumes/Fountain/Data/PIC/no_hot_bg_test/matlab/fred_4.mat')
  %save('/Volumes/Fountain/Data/PIC/no_hot_bg_test/matlab/fred_4.mat','fred35_4')
else % make reduced distributions
  %fred1_2 = ds.reduce_1d_new('x',[1],[],'vpar',{Bx,By,Bz});
  %fred3_2 = ds.reduce_1d_new('x',[3],[],'vpar',{Bx,By,Bz});
  %fred4_2 = ds.reduce_1d_new('x',[4],[],'vpar',{Bx,By,Bz});
  %fred5_2 = ds.reduce_1d_new('x',[5],[],'vpar',{Bx,By,Bz});
  %fred6_2 = ds.reduce_1d_new('x',[6],[],'vpar',{Bx,By,Bz});
  %fred35_2 = ds.reduce_1d_new('x',[3 5],[],'vpar',{Bx,By,Bz});
  %fred46_2 = ds.reduce_1d_new('x',[4 6],[],'vpar',{Bx,By,Bz});
  fred35_204 = ds.reduce_1d_new('x',[3 5],[],'vpar',{Bx,By,Bz});
  fred46_204 = ds.reduce_1d_new('x',[4 6],[],'vpar',{Bx,By,Bz});
  fred1_204 = ds.reduce_1d_new('x',[1],[],'vpar',{Bx,By,Bz});
  fred2_204 = ds.reduce_1d_new('x',[2],[],'vpar',{Bx,By,Bz});
%   fred35_196 = ds.reduce_1d_new('z',[3 5],[],'vpar',{Bx,By,Bz});
%   fred46_196 = ds.reduce_1d_new('z',[4 6],[],'vpar',{Bx,By,Bz});
%   fred1_196 = ds.reduce_1d_new('z',[1],[],'vpar',{Bx,By,Bz});
%   fred2_196 = ds.reduce_1d_new('z',[2],[],'vpar',{Bx,By,Bz});
%   fred35_200 = ds.reduce_1d_new('x',[3 5],[],'vpar',{Bx,By,Bz});
%   fred46_200 = ds.reduce_1d_new('x',[4 6],[],'vpar',{Bx,By,Bz});
%   fred1_200 = ds.reduce_1d_new('x',[1],[],'vpar',{Bx,By,Bz});
%   fred2_200 = ds.reduce_1d_new('x',[2],[],'vpar',{Bx,By,Bz});
  %fred1_4 = ds.reduce_1d_new('x',[1],[],'vpar',{Bx,By,Bz});
  %fred3_4 = ds.reduce_1d_new('x',[3],[],'vpar',{Bx,By,Bz});
  %fred4_4 = ds.reduce_1d_new('x',[4],[],'vpar',{Bx,By,Bz});
  %fred5_4 = ds.reduce_1d_new('x',[5],[],'vpar',{Bx,By,Bz});
  %fred6_4 = ds.reduce_1d_new('x',[6],[],'vpar',{Bx,By,Bz});
  %fred35_4 = ds.reduce_1d_new('x',[3 5],[],'vpar',{Bx,By,Bz});
  %fred46_4 = ds.reduce_1d_new('x',[4 6],[],'vpar',{Bx,By,Bz});
end
%% Plot
fredi_str = '35'; iSpecies = [3 5];
frede_str = '2'; eSpecies = [2];
fredi = eval(['fred' fredi_str '_204']);
frede = eval(['fred' frede_str '_204']);
fred = frede;
arclength = [0; cumsum(sqrt(diff(fredi.x).^2 + diff(fredi.z).^2))];
if 1; arclength = arclength - arclength(find(abs(fredi.z)==min(abs(fredi.z)))); end
ni = interpfield(pic.xi,pic.zi,pic.n(iSpecies),fredi.x,fredi.z); 
ne = interpfield(pic.xi,pic.zi,pic.n(eSpecies),fredi.x,fredi.z); 
vipar = interpfield(pic.xi,pic.zi,pic.vpar(iSpecies),fredi.x,fredi.z); 
vepar = interpfield(pic.xi,pic.zi,pic.vpar(eSpecies),fredi.x,fredi.z); 
vix = interpfield(pic.xi,pic.zi,pic.vx(iSpecies),fredi.x,fredi.z); 
viy = interpfield(pic.xi,pic.zi,pic.vy(iSpecies),fredi.x,fredi.z); 
viz = interpfield(pic.xi,pic.zi,pic.vz(iSpecies),fredi.x,fredi.z); 
vex = interpfield(pic.xi,pic.zi,pic.vx(eSpecies),fredi.x,fredi.z); 
vey = interpfield(pic.xi,pic.zi,pic.vy(eSpecies),fredi.x,fredi.z); 
vez = interpfield(pic.xi,pic.zi,pic.vz(eSpecies),fredi.x,fredi.z); 
vepar = interpfield(pic.xi,pic.zi,pic.vpar(eSpecies),fredi.x,fredi.z); 
Epar = interpfield(pic.xi,pic.zi,pic.Epar,fredi.x,fredi.z); 
Eparx = interpfield(pic.xi,pic.zi,pic.Eparx,fredi.x,fredi.z); 
Epary = interpfield(pic.xi,pic.zi,pic.Epary,fredi.x,fredi.z); 
Eparz = interpfield(pic.xi,pic.zi,pic.Eparz,fredi.x,fredi.z); 
Ex = interpfield(pic.xi,pic.zi,pic.Ex,fredi.x,fredi.z); 
Ey = interpfield(pic.xi,pic.zi,pic.Ey,fredi.x,fredi.z); 
Ez = interpfield(pic.xi,pic.zi,pic.Ez,fredi.x,fredi.z);
vExBx = interpfield(pic.xi,pic.zi,pic.vExBx,fredi.x,fredi.z); 
vExBy = interpfield(pic.xi,pic.zi,pic.vExBy,fredi.x,fredi.z); 
vExBz = interpfield(pic.xi,pic.zi,pic.vExBz,fredi.x,fredi.z);
vExBabs = sqrt(vExBx.^2 + vExBy.^2 + vExBz.^2);
EExB = vExBabs.^2/2;
Bx = interpfield(pic.xi,pic.zi,pic.Bx,fredi.x,fredi.z); 
By = interpfield(pic.xi,pic.zi,pic.By,fredi.x,fredi.z); 
Bz = interpfield(pic.xi,pic.zi,pic.Bz,fredi.x,fredi.z); 

fi_clim = [0 0.013];
fe_clim = [0 7.99e-3];

nrows = 4;
ncols = 1;
h = setup_subplots(nrows,ncols);
isub = 1;
doE = 1; colorE = [0 0.8 0.8];
doV = 1; colorV = 0*[1 1 1];
doN = 1; colorN = [0 0 0];
doExB = 1; colorExB = 0*[1 1 1]+0.5;

if 0 % line position
  hca = h(isub); isub = isub + 1;
  [ax,h1,h2] = plotyy(hca,arclength,fredi.x,arclength,fredi.z);
  hca.XLabel.String = 'arclength (d_i)';
  ax(1).YLabel.String = 'x';
  ax(2).YLabel.String = 'z';
  legend(hca,{'x','z'},'location','best')
  hca.XGrid = 'on';
  hca.YGrid = 'on';
end
if 0 % B
  hca = h(isub); isub = isub + 1;
  plot(hca,arclength,Bx,arclength,By,arclength,Bz)
  hca.XLabel.String = 'arclength (d_i)';
  hca.YLabel.String = 'B';
  legend(hca,{'B_x','B_y','B_z'},'location','eastoutside')
  hca.XGrid = 'on';
  hca.YGrid = 'on';
end
if 1 % n
  hca = h(isub); isub = isub + 1;
  plot(hca,arclength,ni,arclength,ne)
  hca.XLabel.String = 'arclength (d_i)';
  hca.YLabel.String = 'n';
  legend(hca,{'n_i','n_e'},'location','eastoutside')
  hca.XGrid = 'on';
  hca.YGrid = 'on';
end
if 0 % v
  hca = h(isub); isub = isub + 1;
  plot(hca,arclength,vix,arclength,viy,arclength,viz,arclength,vex,arclength,vey,arclength,vez)
  hca.XLabel.String = 'arclength (d_i)';
  hca.YLabel.String = 'B';
  legend(hca,{'v_{ix}','v_{iy}','v_{iz}','v_{ex}','v_{ey}','v_{ez}'},'location','eastoutside')
  hca.XGrid = 'on';
  hca.YGrid = 'on';
end
if 0 % v
  hca = h(isub); isub = isub + 1;
  plot(hca,arclength,vExBx,arclength,vExBy,arclength,vExBz,arclength,vExBabs)
  hca.XLabel.String = 'arclength (d_i)';
  hca.YLabel.String = 'v_{ExB}';
  legend(hca,{'v_{x}','v_{y}','v_{z}','|v|'},'location','eastoutside')
  hca.XGrid = 'on';
  hca.YGrid = 'on';
end
if 0 % E
  hca = h(isub); isub = isub + 1;
  plot(hca,arclength,Ex,arclength,Ey,arclength,Ez)
  hca.XLabel.String = 'arclength (d_i)';
  hca.YLabel.String = 'E';
  legend(hca,{'E_{x}','E_{y}','E_{z}'},'location','eastoutside')
  hca.XGrid = 'on';
  hca.YGrid = 'on';
end
if 0 % Epar, int(Epar)dl
  hca = h(isub); isub = isub + 1;
  plot(hca,arclength,Epar,arclength,-cumtrapz(arclength,Epar))  
  legend(hca,{'E_{||}','-\int E_{||}dl_{||}'},'location','eastoutside') 
  if 0
  hold(hca,'on')
  plot(hca,arclength,Eparx,arclength,Epary,arclength,Eparz)  
  hold(hca,'off')
  legend(hca,{'E_{||}','-\int E_{||}dl_{||}','E_{||,x}','E_{||,y}','E_{||,z}'},'location','eastoutside') 
  end
  hca.YLabel.String = 'E_{||}, \int E_{||}dl_{||}'; 
  
  hca.XLabel.String = 'arclength (d_i)';  
  hca.XGrid = 'on';
  hca.YGrid = 'on';
end
if 1 % fi(vx)
  hca = h(isub); isub = isub + 1;
  pcolor(hca,fredi.z,fredi.v,fredi.fvx')
  shading(hca,'flat')
  hca.XLabel.String = 'arclength (d_i)';
  hca.YLabel.String = 'v_{x}';
  colormap(hca,pic_colors('candy'))  
  hcb = colorbar('peer',hca);
  hcb.YLabel.String = ['f_{i,' fredi_str '}(l_{||},v_{x})'];
  hca.CLim(2) = prctile(fredi.fvx(:),99);
  hca.XGrid = 'on';
  hca.YGrid = 'on';
  hca.Layer = 'top';
  if doE
    hold(hca,'on')
    plot(hca,arclength,Ex*max(abs(hca.YLim))/max(abs(Ex)),'color',colorE)
    hold(hca,'off')
  end
  if doV
    hold(hca,'on')
    plot(hca,arclength,vix,'color',colorV,'linewidth',1.5)
    hold(hca,'off')
  end
  if doExB
    hold(hca,'on')
    %plot(hca,arclength,vExBx,'color',colorExB,'linewidth',1.5)
    plot(hca,pic_sm.zi,mean(pic_sm.vExBx,1),'color',colorExB,'linewidth',1.5)
    
    hold(hca,'off')
  end
end
if 0 % fe(vx)
  hca = h(isub); isub = isub + 1;
  pcolor(hca,arclength,frede.v,frede.fvx')
  shading(hca,'flat')
  hca.XLabel.String = 'arclength (d_i)';
  hca.YLabel.String = 'v_{x}';
  colormap(hca,pic_colors('candy'))  
  hcb = colorbar('peer',hca);
  hcb.YLabel.String = ['f_{e,' frede_str '}(l_{||},v_{x})'];
  hca.CLim(2) = prctile(frede.fvx(:),99);
  hca.XGrid = 'on';
  hca.YGrid = 'on';
  hca.Layer = 'top';
  if doE
    hold(hca,'on')
    plot(hca,arclength,Ex*max(abs(hca.YLim))/max(abs(Ex)),'color',colorE)
    hold(hca,'off')
  end
  if doV
    hold(hca,'on')
    plot(hca,arclength,vix,'color',colorV,'linewidth',1.5)
    hold(hca,'off')
  end
  if doExB
    hold(hca,'on')
    plot(hca,arclength,vExBx,'color',colorExB,'linewidth',1.5)
    hold(hca,'off')
  end
end
if 1 % fi(vy)
  hca = h(isub); isub = isub + 1;
  pcolor(hca,arclength,fredi.v,fredi.fvy')
  shading(hca,'flat')
  hca.XLabel.String = 'arclength (d_i)';
  hca.YLabel.String = 'v_{y}';
  colormap(hca,pic_colors('candy'))  
  hcb = colorbar('peer',hca);  
  hcb.YLabel.String = ['f_{i,' fredi_str '}(l_{||},v_{y})'];
  hca.CLim(2) = prctile(fredi.fvy(:),99);
  hca.XGrid = 'on';
  hca.YGrid = 'on';
  hca.Layer = 'top';
  if doE
    hold(hca,'on')
    plot(hca,arclength,Ey*max(abs(hca.YLim))/max(abs(Ey)),'color',colorE)
    hold(hca,'off')
  end
  if doV
    hold(hca,'on')
    plot(hca,arclength,viy,'color',colorV,'linewidth',1.5)
    hold(hca,'off')
  end
  if doExB
    hold(hca,'on')
    %plot(hca,arclength,vExBy,'color',colorExB,'linewidth',1.5)
    plot(hca,pic_sm.zi,mean(pic_sm.vExBy,1),'color',colorExB,'linewidth',1.5)
    hold(hca,'off')
  end
end
if 1 % fi(vz)
  hca = h(isub); isub = isub + 1;
  pcolor(hca,arclength,fredi.v,fredi.fvz')
  shading(hca,'flat')
  hca.XLabel.String = 'arclength (d_i)';
  hca.YLabel.String = 'v_{z}';
  colormap(hca,pic_colors('candy'))  
  hcb = colorbar('peer',hca);
  hcb.YLabel.String = ['f_{i,' fredi_str '}(l_{||},v_{z})'];
  hca.CLim(2) = prctile(fredi.fvz(:),99);
  hca.XGrid = 'on';
  hca.YGrid = 'on';
  hca.Layer = 'top';
  if doE
    hold(hca,'on')
    plot(hca,arclength,Ez*max(abs(hca.YLim))/max(abs(Ez)),'color',colorE)
    hold(hca,'off')
  end
  if doV
    hold(hca,'on')
    plot(hca,arclength,viz,'color',colorV,'linewidth',1.5)
    hold(hca,'off')
  end
  if doExB
    hold(hca,'on')
    %plot(hca,arclength,vExBz,'color',colorExB,'linewidth',1.5)
    plot(hca,pic_sm.zi,mean(pic_sm.vExBz,1),'color',colorExB,'linewidth',1.5)
    hold(hca,'off')
  end
end
if 0 % fi(vpar)
  hca = h(isub); isub = isub + 1;
  pcolor(hca,arclength,fredi.vpar_center,fredi.fvpar')
  shading(hca,'flat')
  hca.XLabel.String = 'arclength (d_i)';
  hca.YLabel.String = 'v_{||}';
  colormap(hca,pic_colors('candy'))  
  hcb = colorbar('peer',hca);
  hcb.YLabel.String = ['f_{i,' fredi_str '}(l_{||},v_{||})'];
  hca.CLim(2) = prctile(fredi.fvpar(:),99);
  hca.CLim = fi_clim;
  hca.XGrid = 'on';
  hca.YGrid = 'on';
  hca.Layer = 'top';
  if doE
    hold(hca,'on')
    plot(hca,arclength,Epar*max(abs(hca.YLim))/max(abs(Epar)),'color',colorE)
    hold(hca,'off')
  end
  if doV
    hold(hca,'on')
    plot(hca,arclength,vipar,'color',colorV,'linewidth',1.5)
    hold(hca,'off')
  end
end
if 0 % fe(vpar)
  hca = h(isub); isub = isub + 1;
  pcolor(hca,arclength,frede.vpar_center,frede.fvpar')
  shading(hca,'flat')
  hca.XLabel.String = 'arclength (d_i)';
  hca.YLabel.String = 'v_{||}';
  colormap(hca,pic_colors('candy'))  
  hcb = colorbar('peer',hca);
  hcb.YLabel.String = ['f_{e,' frede_str '}(l_{||},v_{||})'];
  hca.CLim(2) = prctile(frede.fvpar(:),99);
  hca.CLim = fi_clim;
  hca.XGrid = 'on';
  hca.YGrid = 'on';
  hca.Layer = 'top';
  if doE
    hold(hca,'on')
    plot(hca,arclength,Epar*max(abs(hca.YLim))/max(abs(Epar)),'color',colorE)
    hold(hca,'off')
  end
  if doV
    hold(hca,'on')
    plot(hca,arclength,vepar,'color',colorV,'linewidth',1.5)
    hold(hca,'off')
  end
end
if 0 % fi(vabs)
  hca = h(isub); isub = isub + 1;
  pcolor(hca,arclength,fredi.vabs_center,fredi.fvabs')
  shading(hca,'flat')
  hca.XLabel.String = 'arclength (d_i)';
  hca.YLabel.String = 'v_{||}';
  colormap(hca,pic_colors('candy'))  
  hcb = colorbar('peer',hca);
  hcb.YLabel.String = ['f_{i,' fredi_str '}(l_{||},|v|)'];
  hca.CLim(2) = prctile(fredi.fvabs(:),99);
  %hca.CLim = fi_clim;
  hca.XGrid = 'on';
  hca.YGrid = 'on';
  hca.Layer = 'top';
  if 0%doE
    hold(hca,'on')
    plot(hca,arclength,Epar*max(abs(hca.YLim))/max(abs(Epar)),'color',colorE)
    hold(hca,'off')
  end
  if 0%doV
    hold(hca,'on')
    plot(hca,arclength,vipar,'color',colorV,'linewidth',1.5)
    hold(hca,'off')
  end
end
if 0 % defi35(m*abs^2/2)
  %%
  %isub = 6;
  hca = h(isub); isub = isub + 1;
  darc = arclength(2)-arclength(1);
  arclength_edges = [arclength-darc/2; arclength(end)+darc/2];
  [ARC,EN] = meshgrid(arclength_edges,fredi.vabs_edges.^2/2);
  surf(hca,ARC,EN,ARC*0,log10(fredi.fdefE'))
  shading(hca,'flat')
  view(hca,[0 0 1])
  %pcolor(hca,arclength,fredi.vabs_center.^2/2,log10(fredi.fdefE'))
  shading(hca,'flat')
  hca.XLabel.String = 'arclength (d_i)';
  hca.YLabel.String = 'mv^2/2';
  colormap(hca,pic_colors('candy'))
  colormap(hca,[ 1 1 1; pic_colors('waterfall')])
  hcb = colorbar('peer',hca);
  hcb.YLabel.String = ['dpf_{i,' fredi_str '}(l_{||},mv^2/2)'];
  hca.CLim = [prctile(log10(fredi.fdefE(fredi.fdefE>0)),1) prctile(log10(fredi.fdefE(fredi.fdefE>0)),99)];
  %hca.CLim = fi_clim;
  hca.XGrid = 'on';
  hca.YGrid = 'on';
  hca.Layer = 'top';
  hca.YScale = 'log';
  hca.YTick = 10.^(-10:1:10);
  hca.YLim(1) = 10^(-2);
  if doExB
    hold(hca,'on')
    plot(hca,arclength,EExB,'color',colorExB,'linewidth',1.5)
    hold(hca,'off')
  end
  if 0%doE
    hold(hca,'on')
    plot(hca,arclength,Epar*max(abs(hca.YLim))/max(abs(Epar)),'color',colorE)
    hold(hca,'off')
  end
  if 0%doV
    hold(hca,'on')
    plot(hca,arclength,vipar,'color',colorV,'linewidth',1.5)
    hold(hca,'off')
  end
end
if 0 % defe35(m*vabs^2/2)
  %%
  %isub = 6;
  hca = h(isub); isub = isub + 1;
  darc = arclength(2)-arclength(1);
  arclength_edges = [arclength-darc/2; arclength(end)+darc/2];
  [ARC,EN] = meshgrid(arclength_edges,frede.vabs_edges.^2/2/25);
  surf(hca,ARC,EN,ARC*0,log10(frede.fdefE'))
  shading(hca,'flat')
  view(hca,[0 0 1])
  %pcolor(hca,arclength,fredi.vabs_center.^2/2,log10(fredi.fdefE'))
  shading(hca,'flat')
  hca.XLabel.String = 'arclength (d_i)';
  hca.YLabel.String = 'mv^2/2';
  colormap(hca,pic_colors('candy'))
  colormap(hca,[ 1 1 1; pic_colors('waterfall')])
  hcb = colorbar('peer',hca);
  hcb.YLabel.String = ['dpf_{e,' frede_str '}(l_{||},mv^2/2)'];
  hca.CLim = [prctile(log10(frede.fdefE(frede.fdefE>0)),1) prctile(log10(frede.fdefE(frede.fdefE>0)),99)];
  %hca.CLim = fi_clim;
  hca.XGrid = 'on';
  hca.YGrid = 'on';
  hca.Layer = 'top';
  hca.YScale = 'log';
  hca.YTick = 10.^(-10:1:10);
  hca.YLim(1) = 10^(-2);
  if doExB
    hold(hca,'on')
    plot(hca,arclength,EExB/25,'color',colorExB,'linewidth',1.5)
    hold(hca,'off')
  end
  if 0%doE
    hold(hca,'on')
    plot(hca,arclength,Epar*max(abs(hca.YLim))/max(abs(Epar)),'color',colorE)
    hold(hca,'off')
  end
  if 0%doV
    hold(hca,'on')
    plot(hca,arclength,vipar,'color',colorV,'linewidth',1.5)
    hold(hca,'off')
  end
end
if 0 % f46(vpar)
  hca = h(isub); isub = isub + 1;
  pcolor(hca,arclength,frede.vpar_center,frede.fvpar')
  hca.YLim = [-7 7];
  shading(hca,'flat')
  hca.XLabel.String = 'arclength (d_i)';
  hca.YLabel.String = 'v_{||}';
  colormap(hca,pic_colors('candy'))
  hcb = colorbar('peer',hca);
  hca.CLim = fe_clim;
  hcb.YLabel.String = ['f_{e,' frede_str '}(l_{||},v_{||})'];  
  hca.XGrid = 'on';
  hca.YGrid = 'on';
  hca.Layer = 'top';
  if doE
    hold(hca,'on')
    plot(hca,arclength,Epar*max(abs(hca.YLim))/max(abs(Epar)),'color',colorE)
    hold(hca,'off')
  end
  if doV
    hold(hca,'on')
    plot(hca,arclength,vepar,'color',colorV,'linewidth',1.5)
    hold(hca,'off')
  end
  
end
if 0 % def35(vabs^2)
  hca = h(isub); isub = isub + 1;
  darc = arclength(2)-arclength(1);
  arclength_edges = [arclength-darc/2 arclength(end)+darc/2];
  surf(hca,arclength_edges,frede.vabs_edges.^2/2/25,log10(frede.fdefE'))
  view([0 1 0])
  shading(hca,'flat')
  hca.XLabel.String = 'arclength (d_i)';
  hca.YLabel.String = 'mv^2/2';
  colormap(hca,pic_colors('candy'))  
  hcb = colorbar('peer',hca);
  hcb.YLabel.String = ['dpf_{i,' frede_str '}(l_{||},mv^2/2)'];
  hca.CLim = [prctile(log10(frede.fdefE(:)),5) prctile(log10(frede.fdefE(:)),95)];
  %hca.CLim = fi_clim;
  hca.XGrid = 'on';
  hca.YGrid = 'on';
  hca.Layer = 'top';
  hca.YScale = 'log';
  hca.YTick = 10.^(-10:1:10);
  hca.YLim(1) = 10^(-2);
  if doExB
    hold(hca,'on')
    plot(hca,arclength,EExB/25,'color',colorExB)
    hold(hca,'off')
  end
  if 0%doE
    hold(hca,'on')
    plot(hca,arclength,Epar*max(abs(hca.YLim))/max(abs(Epar)),'color',colorE)
    hold(hca,'off')
  end
  if 0%doV
    hold(hca,'on')
    plot(hca,arclength,vipar,'color',colorV,'linewidth',1.5)
    hold(hca,'off')
  end
end
compact_panels(0.01)
h(1).Title.String = ['nobg, t\omega_{pe} = ' num2str(twpe,'%05.0f')];
fig = gcf; h_ = findobj(fig.Children,'type','axes');
hlinks = linkprop(h_,{'XLim'});
hlinks.Targets(1).XLim = arclength([1 end]);
%irf_plot_axis_align
for ip = 1:nrows*ncols
  axwidth(ip) = h(ip).Position(3);
end
for ip = 1:nrows*ncols
  h(ip).Position(3) = min(axwidth);
end



%ax(2).YAxisLocation = 'right';
if 0
  %%
  nrows = 3;
  ncols = 1;
  h = setup_subplots(nrows,ncols);
  isub = 1;  
  
  if 1 % line position
    hca = h(isub); isub = isub + 1;
    [ax,h1,h2] = plotyy(hca,arclength,fredi.x,arclength,fredi.z);
    hca.XLabel.String = 'arclength (d_i)';
    ax(1).YLabel.String = 'x';
    ax(2).YLabel.String = 'z';
    legend(hca,{'x','z'},'location','eastoutside')
    hca.XGrid = 'on';
    hca.YGrid = 'on';
  end
  if 1 % Epar
    hca = h(isub); isub = isub + 1;
    plot(hca,arclength,Eparx,arclength,Epary,arclength,Eparz,arclength,Epar)          
    legend(hca,{'E_{||}','-\int E_{||}dl_{||}','E_{||,x}','E_{||,y}','E_{||,z}'},'location','eastoutside') 
    legend(hca,{'E_{||,x}','E_{||,y}','E_{||,z}','E_{||}'},'location','eastoutside') 
    hca.YLabel.String = 'E_{||}'; 

    hca.XLabel.String = 'arclength (d_i)';  
    hca.XGrid = 'on';
    hca.YGrid = 'on';
  end
  if 1 % int Epar
    hca = h(isub); isub = isub + 1;
    plot(hca,arclength,-cumtrapz(arclength,Eparx),arclength,-cumtrapz(arclength,Epary),arclength,-cumtrapz(arclength,Eparz),arclength,-cumtrapz(arclength,Epar))
    %legend(hca,{'E_{||}','-\int E_{||}dl_{||}','E_{||,x}','E_{||,y}','E_{||,z}'},'location','eastoutside') 
    legend(hca,{'E_{||,x}','E_{||,y}','E_{||,z}','E_{||}'},'location','eastoutside') 
    hca.YLabel.String = '-\int E_{||}dl_{||}'; 

    hca.XLabel.String = 'arclength (d_i)';  
    hca.XGrid = 'on';
    hca.YGrid = 'on';
  end
  compact_panels(0.01)
  h = findobj(get(gcf,'children'),'type','axes'); hall = hall(end:-1:1);
  hlink = linkprop(h,{'XLim'});
  h(1).XLim = arclength([1 end]);
  for ip = 1:nrows*ncols
    axwidth(ip) = h(ip).Position(3);
  end
  for ip = 1:nrows*ncols
    h(ip).Position(3) = min(axwidth);
  end
end
  

%% Plot quantities along a field line
%sep = separatrix_location(nobg);
pic = nobg.twpelim([7500 10400]).xlim([150 210]);
%sep = separatrix_location(pic);
sepEx  = pic.interpfield(sep.x,sep.z,sep.twci,'Ex');
sepEy  = pic.interpfield(sep.x,sep.z,sep.twci,'Ey');
sepEz  = pic.interpfield(sep.x,sep.z,sep.twci,'Ez');
sepvex = pic.interpfield(sep.x,sep.z,sep.twci,'vex');
sepvey = pic.interpfield(sep.x,sep.z,sep.twci,'vey');
sepvez = pic.interpfield(sep.x,sep.z,sep.twci,'vez');
sepvix = pic.interpfield(sep.x,sep.z,sep.twci,'vix');
sepviy = pic.interpfield(sep.x,sep.z,sep.twci,'viy');
sepviz = pic.interpfield(sep.x,sep.z,sep.twci,'viz');
sepni  = pic.interpfield(sep.x,sep.z,sep.twci,'ni');
%%
h = setup_subplots(5,2,'vertical');
isub = 1;
if 0 % z(x)
  hca = h(isub); isub = isub + 1;
  pcolor(hca,sep.x(:,1),sep.twci,sep.z')
  shading(hca,'flat')
  hcb = colorbar('peer',hca);
  hcb.YLabel.String = 'z';
end
if 1 % Ex
  hca = h(isub); isub = isub + 1;
  pcolor(hca,sep.x(:,1),sep.twci,sepEx')
  shading(hca,'flat')
  hcb = colorbar('peer',hca);
  hcb.YLabel.String = 'E_x';
end
if 1 % Ey
  hca = h(isub); isub = isub + 1;
  pcolor(hca,sep.x(:,1),sep.twci,sepEy')
  shading(hca,'flat')
  hcb = colorbar('peer',hca);
  hcb.YLabel.String = 'E_y';
end
if 1 % Ey
  hca = h(isub); isub = isub + 1;
  pcolor(hca,sep.x(:,1),sep.twci,sepEz')
  shading(hca,'flat')
  hcb = colorbar('peer',hca);
  hcb.YLabel.String = 'E_z';
end
if 1 % vix
  hca = h(isub); isub = isub + 1;
  pcolor(hca,sep.x(:,1),sep.twci,sepvix')
  shading(hca,'flat')
  hcb = colorbar('peer',hca);
  hcb.YLabel.String = 'v_{ix}';
end
if 1 % viy
  hca = h(isub); isub = isub + 1;
  pcolor(hca,sep.x(:,1),sep.twci,sepviy')
  shading(hca,'flat')
  hcb = colorbar('peer',hca);
  hcb.YLabel.String = 'v_{iy}';
end
if 1 % viz
  hca = h(isub); isub = isub + 1;
  pcolor(hca,sep.x(:,1),sep.twci,sepviz')
  shading(hca,'flat')
  hcb = colorbar('peer',hca);
  hcb.YLabel.String = 'v_{iz}';
end
if 1 % vex
  hca = h(isub); isub = isub + 1;
  pcolor(hca,sep.x(:,1),sep.twci,sepvex')
  shading(hca,'flat')
  hcb = colorbar('peer',hca);
  hcb.YLabel.String = 'v_{ex}';
end
if 1 % vey
  hca = h(isub); isub = isub + 1;
  pcolor(hca,sep.x(:,1),sep.twci,sepvey')
  shading(hca,'flat')
  hcb = colorbar('peer',hca);
  hcb.YLabel.String = 'v_{ey}';
end
if 1 % vez
  hca = h(isub); isub = isub + 1;
  pcolor(hca,sep.x(:,1),sep.twci,sepvez')
  shading(hca,'flat')
  hcb = colorbar('peer',hca);
  hcb.YLabel.String = 'v_{ez}';
end
if 1 % ni
  hca = h(isub); isub = isub + 1;
  pcolor(hca,sep.x(:,1),sep.twci,sepni')
  shading(hca,'flat')
  hcb = colorbar('peer',hca);
  hcb.YLabel.String = 'n_i';
end

for ip = 1:numel(h)
  hca = h(ip);
  if 1 % z(x) contours
    hold(hca,'on')
    clim = hca.CLim;
    %contour(hca,sep.x(:,1),sep.twci,sep.z',0:1:20,'k')
    contour(hca,sep.x(:,1),sep.twci,smooth2(sepviy,2)',-3:0.1:3,'k')
    hca.CLim = clim;
    hold(hca,'off')    
  end
end

hlinks = linkprop(h,{'XLim','YLim'});
compact_panels(0.01)
h(1).CLim = [-1 1];
h(1).CLim = 0.5*[-1 1];
h(2).CLim = 0.5*[-1 1];
h(3).CLim = 0.5*[-1 1];
h(4).CLim = 0.5*[-1 1];
h(4).CLim = 0.7*[-1 1];
h(4).CLim = 0.5*[-1 1];
h(5).CLim = 0.5*[-1 1];
h(5).CLim = 1*[-1 1];
h(6).CLim = 0.5*[-1 1];
h(7).CLim = 5*[-1 1];
h(8).CLim = 5*[-1 1];
h(9).CLim = 5*[-1 1];
h(10).CLim = [0 0.1];