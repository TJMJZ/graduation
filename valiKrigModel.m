function [M1,rM]=ValiKrigModel(dmodelx,valiX, valiZ,plot_p)
dmodel=dmodelx;
for i=1:length(valiZ) 
    M1(i,1)=predictor(valiX(i,:),dmodel);
    M1(i,2)=valiZ(i,1);
end
a=M1(:,1)./M1(:,2);

if plot_p
	plot(M1(:,1),M1(:,2),'.')
	%axis([-0.3 0 -0.3 0])
	xlabel('Predicted')
	ylabel('Actual')
	hold off
	M1
end

rM0=corrcoef(M1(:,1),M1(:,2))
rM=rM0(1,2);