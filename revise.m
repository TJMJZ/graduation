  global dataFolder exeFolder codeFolder


codeFolder = 'D:\毕业\0207\graduate';
exeFolder = 'D:\flacfolder\FLAC700\Exe32';
dataFolder = 'D:\毕业\0207\graduate\data';

rainfall_amt_cvt=1;
rainfall_hour=2;
ini_suction_kpa=5;

meanPara = xmean;
tobeCalibrated =[];

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
		
		[gcali,rstcali] = callflac_fos(calibrating,FosCalibration);

		rstlist = [rstlist;rstcali];
	end
	rstbackup = [rstbackup;rstlist];

end