timestep = 10000;
dirData = sprintf('/Volumes/Fountain/Data/PIC/no_hot_bg_test/distributions/%05.0f/',timestep);
h5FilePath = '/Volumes/Fountain/Data/PIC/no_hot_bg_test/data_h5/dists.h5';
distIndRead = 463:667;
distIndRead = 668:918;
nSpecies = 6;
iteration = nobg.twpelim(timestep).iteration;
mass = [25 1 25 1 25 1];
charge = [1 -1 1 -1 1 -1];
tag = 'line4';
h5write_dists(dirData,h5FilePath,distIndRead,nSpecies,mass,charge,timestep,iteration,tag)