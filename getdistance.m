%% getdistance: get distance matrix
function [D] = getdistance(iall)

[m,n] = size(iall);

for i =1:m
	for j = i:m
		if (i==j)
			D(i,j) = 0;
		else
			temp1 = [iall(i,:);iall(j,:)];
			D(i,j) = pdist(temp1);
			D(j,i) = D(i,j);
		end
	end
end