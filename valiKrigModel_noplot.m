function [rM]=ValiKrigModel_noplot(dmodelx,valiX, valiZ)
dmodel=dmodelx;
for i=1:length(valiZ) 
    M1(i,1)=predictor(valiX(i,:),dmodel);
    M1(i,2)=valiZ(i,1);
end
a=M1(:,1)./M1(:,2);

rM0=corrcoef(M1(:,1),M1(:,2));

rM=rM0(1,2);