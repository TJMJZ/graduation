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

  xlower = min(xmin,xmax);
  xupper = max(xmin,xmax);
  for i = 1:PARADIM
    if PARADIR(i) == 1
      xupper(1,i) = xmean(1,i);
    elseif PARADIR(i) == -1
      xlower(1,i) = xmean(1,i);
    else
      disp('bound calculation error');
    end
  end

  flaccal_envpara = data_flac_nopile{global_loop_i,1};
  iocal = data_flac_nopile{global_loop_i,3};
  iocal = unique(iocal,'rows','stable');
  ioval = data_flac_nopile{global_loop_i,2};
  ioval = unique(ioval,'rows','stable');
  iocal(:,1) = [];
  ioval(:,1) = [];

  ical = iocal(:,1:PARADIM);
  ival = ioval(:,1:PARADIM);
  ocal = iocal(:,(PARADIM+1));
  oval = ioval(:,(PARADIM+1));

  iall = [ical;ival];
  oall = [ocal;oval];
  ioall = [iocal;ioval];
  [m,n] = size(iall);

  kM000100 = data_flac_nopile{i,5}.krigmodel

  temp = 0;
  fP100Set_all = [];
  while temp<FAILNUM
    
    % generate samples
    Sample100Set1 = MvLogNRand( xmean , xsd , N , corrMatrix );

    % screen samples
    parfor l= 1:N
      if prod((Sample100Set1(l,:)>xlower).*(Sample100Set1(l,:)<xupper))
        temp100Set1(l,:) = Sample100Set1(l,:);
      end
    end
    Sample100Set1 = temp100Set1(find(temp100Set1(:,1)),:);

    % find failure points
    sampleListLength = max(size(Sample100Set1));
    parfor i = 1:sampleListLength
      if (predictor(Sample100Set1(i,:),kM000100)<1)&&(predictor(Sample100Set1(i,:),kM000100)>fpRange)
        fP100Set1(i,:) = Sample100Set1(i,:);
      end
    end
    fP100Set1 = fP100Set1(find(fP100Set1(:,1)),:);

    fP100Set_all = [fP100Set_all;fP100Set1];
    temp = max(size(fP100Set_all));
    clear fP100Set1 temp100Set1 Sample100Set1

  end

  [xrep100Set1,beta100Set1,cor100Set1] = findMajorModes(fP100Set_all(1:FAILNUM,:),cosdp_thresh);
  B100(1,:) = calPfFun(xrep100Set1)

  result.calpara = flaccal_envpara;
  result.xrep = xrep100Set1;
  result.xrepbeta = beta100Set1;
  result.xrepcorr = cor100Set1;
  result.fpbound = B100;
  result.krigmodel = kM000100;
  result.krigvali = max_vali;
  result.krigvalirst = valikrig_rst;
  result.samplesc = iocal;
  result.samplesv = ioval;
  result.failpoints = fP100Set_all;
  result.paracos = cosdp_thresh;
  result.parafprange = fpRange;

  data_flac_nopile{global_loop_i,5} = result;
  clearvars -except data_flac_nopile

end

save data_krig_fuck.mat data_flac_nopile

