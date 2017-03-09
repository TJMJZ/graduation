clear 
clc

global dataFolder exeFolder codeFolder
codeFolder = 'H:\graduation';
exeFolder = 'E:\biye\FLAC700_002\Exe32';
dataFolder = 'H:\data';
KSATCVT = 1.03e-3;
meanPara = [8000 38 0.2863 4641 2.00E-05*KSATCVT];

load data_krig_cos.mat


for global_loop_i = 1:(size(data_flac_nopile,1))

	tobeCalibrated =data_flac_nopile{global_loop_i,9}.xrep
	rainfall_amt_cvt=str2num(data_flac_nopile{global_loop_i,4}{1})*(1e4)
	rainfall_hour=str2num(data_flac_nopile{global_loop_i,4}{2})
	ini_suction_kpa=str2num(data_flac_nopile{global_loop_i,4}{3})/1000

	[gmean,rstmean] = callflac_fos(meanPara,rainfall_amt_cvt,rainfall_hour,ini_suction_kpa);
	rstbackup = [];
	for i = 1 : (size(tobeCalibrated,1))
		rstlist = rstmean;
		currpoint = tobeCalibrated(i,:);
		[gcurr,rstcurr] = callflac_fos(currpoint,rainfall_amt_cvt,rainfall_hour,ini_suction_kpa);
		g = 1;
		rstlist = [rstlist;rstcurr];

		while (abs(g)>=0.02)

			[m,n] = size(rstlist);

			calibrating = rstlist(m,2:(n-1))-(rstlist(m,n)-1)*(rstlist(m,2:(n-1))-rstlist((m-1),2:(n-1)))/(rstlist(m,n)-rstlist(m-1,n));
			
			[gcali,rstcali] = callflac_fos(calibrating,0);

			rstlist = [rstlist;rstcali];
		end
		rstbackup = [rstbackup;rstlist];
	end
	
	data_flac_nopile{global_loop_i,12} = rstbackup;

end







