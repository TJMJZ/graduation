% environment variables
% global variables: xmean,xcov,xsd,corrMatrix=xr,folders
% other variables: Cx,kexi,lamda,lbdir,ubdir,xmin,xmax,PARADIM

% interface
totalNum = 600;
lowerBound = -3;
upperBound = 0.25;
KSATCVT = 1.03e-3;
PARADIR = [1 1 -1 1 -1];
% interface

global xmean xcov xsd corrMatrix xr
global dataFolder exeFolder codeFolder

dataFolder = 'F:\graduate2\data';
exeFolder = 'E:\biye\FLAC700_002\Exe32';
codeFolder = 'F:\graduate2';
xmean = [8000 38 0.2863 4641 2.00E-05*KSATCVT];  
xsd = [3000 4 0.065 8808 1.55E-05*KSATCVT];
xcov = xsd./xmean;
corrMatrix=[1,0,0,0,0
    0,1,0,0,0
    0,0,1,0,0
    0,0,0,1,0
    0,0,0,0,1];
xr = corrMatrix;
Cx=(xsd'*xsd).*corrMatrix;

for i=1:length(xmean)
           kexi(i)=sqrt(log(1+(xsd(i)/xmean(i))^2)) ;
           lamda(i)=log(xmean(i))-0.5*kexi(i)^2;
end

lbdir = lowerBound*PARADIR;
ubdir = upperBound*PARADIR;

for i = 1:length(PARADIR)
  xmin(i)=exp(lamda(i)+lbdir(i)*kexi(i));
  xmax(i)=exp(lamda(i)+ubdir(i)*kexi(i));
end

PARADIM = length(PARADIR);