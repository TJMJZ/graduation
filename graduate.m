
clear
clc

initialize_env

orgPara_notscreened = lhsu(xmin,xmax,totalNum);


% program settings
TEMPRSTNAME = 'fosList.dat';
PAUSE_FLAC = 1;
TEMPLOC = [exeFolder '\temp.txt'];
INILOC = [exeFolder '\flac.ini'];
FLACCMD = 'call ';
FLACF_NAME = ['rainfallfos1.dat';'rainfallfos2.dat';'rainfallfos3.dat';'rainfallfos4.dat'];
%FLACF_NAME = ['rainfall1.dat';'rainfall2.dat';'rainfall3.dat';'rainfall4.dat'];
RSTF_NAME = ['result1.txt';'result2.txt';'result3.txt';'result4.txt'];
FLAG = 4;
% program settings


% sstv structure
% rainfall amount: unit 1e-4
% rainfall time: unit hour
% initial suction: unit kpa ; positive
sstv = [1 1 5
        1 4 20];
[sstvm,sstvn] = size(sstv);

for sstv_id = 1:sstvm
    
  % testl = 0;
  % testu = 3.5;
  %orgPara = betascreen(orgPara_notscreened,testl,testu);
  %size(orgPara)
  orgPara = orgPara_notscreened;
  
  % program parameters
  circlePara = addNum(orgPara);
  % program parameters

  % check_flacenv
  flacscript


end





