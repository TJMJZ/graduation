% 
%% callflac_fos: function description
function [g,rst] = callflac_fos(circlePara,rainfall_amt_cvt,rainfall_hour,ini_suction_kpa)

  global dataFolder exeFolder codeFolder

  
  rainfall_amt = rainfall_amt_cvt*(1e-4);
  rainfall_time = rainfall_hour*3600;
  ini_suction = ini_suction_kpa*1000;
  this_set = [rainfall_amt rainfall_time ini_suction];
  circlePara = [circlePara this_set];
  circlePara = addNum(circlePara);

  rstidfstr = strcat(num2str(rainfall_amt_cvt),'_',num2str(rainfall_hour),'_',num2str(ini_suction));

  cd(exeFolder);
  delete('result1.fsv');

  dlmwrite('temp.txt',circlePara,'delimiter','\t','newline','pc');

  fosListFile = fopen('flac.ini','w');
  try
      fprintf(fosListFile,['call rainfallfos1.dat']);
  catch
      disp('fuck!!!!!!!!!!!!!!!!');
  end
  fclose(fosListFile);
  pause(1)
  open flac700.exe
  pause(1)
  
  while 1

    pause(2);
    [sysrsp,rspstr] = system('tasklist /FO "CSV"|findstr flac');%0.25
    
    if(length(strfind(rspstr,'flac700'))<1)
      rst = load('result1.txt');
      break;
    end

  end

  cd(dataFolder);
  dlmwrite('revise.dat',[rst this_set],'-append','delimiter','\t','newline','pc');
  g = (rst(length(rst))-1);
  cd(codeFolder);


end

