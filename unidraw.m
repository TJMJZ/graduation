BULKNUM = 7;
paradim = 5;
generated = diag(ones(1,paradim));

for i = 2:BULKNUM
	[m,n] = size(generated);
	addbulk = [];
	for j = 1:paradim
		zerobulk = zeros(1,paradim);
		zerobulk(1,j) = 1;
		zerobulk = repmat(zerobulk,m,1);
		addbulk = [addbulk;zerobulk];
	end
	generated = repmat(generated,paradim,1);
	generated = generated+addbulk;
end

generated = unique(generated,'rows');


for i = 1:length(generated)
	genbeta(i,1) = norm(generated(i,:));
end

for i=1:length(genbeta)
gentemp(i,:)=generated(i,:)/genbeta(i);
end
R=gentemp*transpose(gentemp);
backupR = R;
mean(mean(R))

for i = 1:length(genbeta)
	R(i,i) = 0;
	maxcos = max(R);
end

average_maxcos = mean(maxcos)