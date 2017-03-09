maindir = 'D:\graduate\DATA4graduation\ch3';
currdir  = dir( maindir );
k = 1;
for i = 1 : length( currdir )
    if( isequal( currdir( i ).name, '.' )||...
        isequal( currdir( i ).name, '..')||...
        ~currdir( i ).isdir) 
        continue;
    end
    subdir = dir(fullfile(maindir,currdir(i).name));

    for j =1:length(subdir)
        if( isequal( subdir( j ).name, '.' )||...
            isequal( subdir( j ).name, '..')||...
            ~subdir( j ).isdir)
            continue;
        end
        subdirpath = fullfile( maindir,currdir(i).name, subdir( j ).name, '*.dat' );
        dat = dir(subdirpath)
        datpath =  fullfile( maindir,currdir(i).name, subdir( j ).name,dat(1).name);
        temp{k,1} = subdir( j ).name;
        temp{k,2} = load(datpath);
        
        k = k+1;
    end
             
end
k = 1;
for i = 1:length(temp)
    for j = (i+1):length(temp)
        if(isequal(temp{i,1},temp{j,1}))
            data_flac_nopile{k,1} = temp{i,1};
            data_flac_nopile{k,2} = temp{i,2};
            data_flac_nopile{k,3} = temp{j,2};
            data_flac_nopile{k,4} = regexp(temp{i,1},'_','split');
            k = k+1;
        end
    end
end

%save data_flac_nopile.mat data_flac_nopile