clear 
clc
load('data_krig.mat');


for global_loop_i = 1:(size(data_flac_nopile,1))
  

  initialize_env

  % program interface
  cosdp_thresh = 0.5;
  calkrig_limit = 1500;
  valikrig_percent = 0.1;
  calkrig_percent = 1- valikrig_percent;
  fpRange = 0.85;
  N = 500000;

  FAILNUM = 6000;
  FAILNUMLIMIT = 6500;
  % program interface
  fP100Set_all = data_flac_nopile{global_loop_i,6}.failpoints;

  [xrep100Set1,beta100Set1,cor100Set1] = findMajorModes(fP100Set_all(1:FAILNUM,:),cosdp_thresh);
  B100(1,:) = calPfFun(xrep100Set1)

  result.calpara = flaccal_envpara;
  result.xrep = xrep100Set1;
  result.xrepbeta = beta100Set1;
  result.xrepcorr = cor100Set1;
  result.fpbound = B100;
  result.paracos = cosdp_thresh;

  data_flac_nopile{global_loop_i,7} = result;
  clearvars -except data_flac_nopile

end

save data_krig_cos.mat data_flac_nopile

