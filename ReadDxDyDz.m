clear all; close all;

str='Cannie_DB'
initial=load('D:\DBGuan\DTMRImapping\Biventricle\LDDM_Cannie_DB_Heart\output\initial_node.txt');
subject=load('D:\DBGuan\DTMRImapping\Biventricle\LDDM_Cannie_DB_Heart\output\subject_node.txt');
group=load('D:\DBGuan\DTMRImapping\Biventricle\LDDM_Cannie_DB_Heart\HeartSurface_group.txt');

dxdydz=subject-initial;

k=0;
for i=1:size(group,1)
    if group(i,1)==1
        k=k+1;
        gd(i,1)=group(i,1);
        gd(i,2:4)=dxdydz(k,:);
    else
        gd(i,1)=group(i,1);
        gd(i,2:4)=[0 0 0]; 
    end
end

fid1 = fopen(['D:\DBGuan\DTMRImapping\Biventricle\LDDM_Cannie_DB_Heart\' str '_dx.txt'],'w');
 
for i = 1 : size(gd,1)
    fprintf(fid1, '%i\t%f\n', gd(i,1),gd(i,2));
end
fclose(fid1);

fid2 = fopen(['D:\DBGuan\DTMRImapping\Biventricle\LDDM_Cannie_DB_Heart\' str '_dy.txt'],'w');
 
for i = 1 : size(gd,1)
    fprintf(fid1, '%i\t%f\n', gd(i,1),gd(i,3));
end
fclose(fid2);

fid3 = fopen(['D:\DBGuan\DTMRImapping\Biventricle\LDDM_Cannie_DB_Heart\' str '_dz.txt'],'w');
 
for i = 1 : size(gd,1)
    fprintf(fid1, '%i\t%f\n', gd(i,1),gd(i,4));
end
fclose(fid3);

       