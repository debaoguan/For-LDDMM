


%% open the file dx
clear all; close all;
fid1 = fopen('D:\DBGuan\DTMRImapping\Biventricle\LDDM_Cannie_DB_Heart\dxdydz\CaninetoDB_dx000000.vtu', 'r');
xmlstrs={};
% close file when we're done
CC = onCleanup (@() fclose(fid1));

xmlstrs = {fgetl(fid1)};

find = 1;

while ischar (xmlstrs{find})

    find = find + 1;

    xmlstrs{find,1} = fgetl(fid1);

    if ~isempty(strfind (xmlstrs{find,1}, 'AppendedData'))

        xmlstrs = [ xmlstrs; {'</AppendedData>'; '</VTKFile>'} ];

        % could get file position like this? how many bytes?
        datapos = ftell (fid1) + 4;

        break;
    end

end

S1 = regexp(xmlstrs{14}, '\s+', 'split');

for i=5:length(S1)-2
    str=S1{i};
    data_x(i-4,1)=str2num(str);
end

fclose(fid1);

fid1 = fopen('D:\DBGuan\DTMRImapping\Biventricle\LDDM_Cannie_DB_Heart\dxdydz\node_dx.txt','w');
 
for i = 1 : size(data_x,1)
    fprintf(fid1, '%f\n', data_x(i));
end
fclose(fid1);


%% open the file dy
clear all;close all;
xmlstrs={};
fid2 = fopen('D:\DBGuan\DTMRImapping\Biventricle\LDDM_Cannie_DB_Heart\dxdydz\CaninetoDB_dy000000.vtu', 'r');

% close file when we're done
CC = onCleanup (@() fclose(fid2));

xmlstrs = {fgetl(fid2)};

find = 1;

while ischar (xmlstrs{find})

    find = find + 1;

    xmlstrs{find,1} = fgetl(fid2);

    if ~isempty(strfind (xmlstrs{find,1}, 'AppendedData'))

        xmlstrs = [ xmlstrs; {'</AppendedData>'; '</VTKFile>'} ];

        % could get file position like this? how many bytes?
        datapos = ftell (fid2) + 4;

        break;
    end

end

S1 = regexp(xmlstrs{14}, '\s+', 'split');

for i=5:length(S1)-2
    str=S1{i};
    data_y(i-4,1)=str2num(str);
end

fclose(fid2);

fid2 = fopen('D:\DBGuan\DTMRImapping\Biventricle\LDDM_Cannie_DB_Heart\dxdydz\node_dy.txt','w');
 
for i = 1 : size(data_y,1)
    fprintf(fid2, '%f\n', data_y(i));
end
fclose(fid2);



%% open the file dz
clear all;close all;
fid3 = fopen('D:\DBGuan\DTMRImapping\Biventricle\LDDM_Cannie_DB_Heart\dxdydz\CaninetoDB_dz000000.vtu', 'r');
xmlstrs={};
% close file when we're done
CC = onCleanup (@() fclose(fid3));

xmlstrs = {fgetl(fid3)};

find = 1;

while ischar (xmlstrs{find})

    find = find + 1;

    xmlstrs{find,1} = fgetl(fid3);

    if ~isempty(strfind (xmlstrs{find,1}, 'AppendedData'))

        xmlstrs = [ xmlstrs; {'</AppendedData>'; '</VTKFile>'} ];

        % could get file position like this? how many bytes?
        datapos = ftell (fid3) + 4;

        break;
    end

end

S1 = regexp(xmlstrs{14}, '\s+', 'split');

for i=5:length(S1)-2
    str=S1{i};
    data_z(i-4,1)=str2num(str);
end

fclose(fid3);

fid3 = fopen('D:\DBGuan\DTMRImapping\Biventricle\LDDM_Cannie_DB_Heart\dxdydz\node_dz.txt','w');
 
for i = 1 : size(data_z,1)
    fprintf(fid3, '%f\n', data_z(i));
end
fclose(fid3);



%% combine dx dy dz together
dx=load('D:\DBGuan\DTMRImapping\Biventricle\LDDM_Cannie_DB_Heart\dxdydz\node_dx.txt');
dy=load('D:\DBGuan\DTMRImapping\Biventricle\LDDM_Cannie_DB_Heart\dxdydz\node_dy.txt');
dz=load('D:\DBGuan\DTMRImapping\Biventricle\LDDM_Cannie_DB_Heart\dxdydz\node_dz.txt');

dxdydz=[dx dy dz];

fid4 = fopen('D:\DBGuan\DTMRImapping\Biventricle\LDDM_Cannie_DB_Heart\node_dxdydz.txt','w');
 
for i = 1 : size(dxdydz,1)
    fprintf(fid4, '%f\t %f\t %f\n', dxdydz(i,1),dxdydz(i,2),dxdydz(i,3));
end
fclose(fid4);
%%


clear all;close all;
%% gradient
%% open the file gradient
fid1 = fopen('D:\DBGuan\DTMRImapping\Biventricle\DB_DATA\DB_poisson_gradu000000.vtu', 'r');
xmlstrs={};
% close file when we're done
CC = onCleanup (@() fclose(fid1));

xmlstrs = {fgetl(fid1)};

find = 1;

while ischar (xmlstrs{find})

    find = find + 1;

    xmlstrs{find,1} = fgetl(fid1);

    if ~isempty(strfind (xmlstrs{find,1}, 'AppendedData'))

        xmlstrs = [ xmlstrs; {'</AppendedData>'; '</VTKFile>'} ];

        % could get file position like this? how many bytes?
        datapos = ftell (fid1) + 4;

        break;
    end

end

S1 = regexp(xmlstrs{14}, '\s+', 'split');

for i=6:length(S1)-2
    str=S1{i};
    data_x(i-5,1)=str2num(str);
end

fclose(fid1);

k=0;
for i=1:3:size(data_x,1)
    a=[data_x(i) data_x(i+1) data_x(i+2)];
    k=k+1;
    na=norm(a);
    if na~=0
        vec_gra(k,:)=a/na;
    else
        vec_gra(k,:)=a;
    end
end

element=load('D:\DBGuan\DTMRImapping\Biventricle\DB_DATA\DB_element.txt');

for i=1:size(element,1)
    v1=[vec_gra(element(i,1),:); vec_gra(element(i,2),:);vec_gra(element(i,3),:);vec_gra(element(i,4),:)];
    vector(i,:)=mean(v1)/norm(mean(v1));
end
    
    

fid1 = fopen('D:\DBGuan\DTMRImapping\Biventricle\DB_DATA\DB_sheet.txt','w');
 
for i = 1:size(vector,1)
    fprintf(fid1, '%f\t %f\t %f\n', vector(i,1),vector(i,2),vector(i,3));
end
fclose(fid1);



