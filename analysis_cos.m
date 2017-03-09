clear 
clc
load('data_krig_fuck.mat');


for global_loop_i = 1:(size(data_flac_nopile,1))
  

  initialize_env

  % program interface
  cosdp_thresh = 0.5;


  FAILNUM = 10000;

  % program interface
  fP100Set_all = data_flac_nopile{global_loop_i,6}.failpoints;

  for j = 1:5
    cosdp_thresh = 0.5+0.05*j;
    [xrep100Set1,beta100Set1,cor100Set1] = findMajorModes(fP100Set_all(1:FAILNUM,:),cosdp_thresh);
    B100(1,:) = calPfFun(xrep100Set1);
    result.xrep = xrep100Set1;
    result.xrepbeta = beta100Set1;
    result.xrepcorr = cor100Set1;
    result.fpbound = B100;
    result.paracos = cosdp_thresh;

    data_flac_nopile{global_loop_i,(6+j)} = result;

  end

end

save data_krig_cos.mat data_flac_nopile

