clear all; close all;

f=load('D:\DBGuan\DTMRImapping\Biventricle\LDDMMtoAHA17\fibreLDDMM.txt');
s=load('D:\DBGuan\DTMRImapping\Biventricle\DB_DATA\DB_sheet.txt');

fibre=f(:,2:4);
sheet=s;

for i=1:size(f,1)
    a=fibre(i,:);
    b=sheet(i,:);
    c=cross(a,b);
    d=cross(c,a);
    
    
    normal=c/norm(c);
    sheetnew=d/norm(d);
    
    f_s_n(i,1:3)=a;
    f_s_n(i,4:6)=sheetnew;
    f_s_n(i,7:9)=normal;
    
end

fid2 = fopen('D:\DBGuan\DTMRImapping\Biventricle\LDDMMtoAHA17\LDDMM40_f_s_n.txt','w');
 
for i = 1 : size(f_s_n,1)
    fprintf(fid2, '%f\t %f\t %f\t %f\t %f\t %f\t %f\t %f\t %f\n', f_s_n(i,1), f_s_n(i,2), f_s_n(i,3)...
        , f_s_n(i,4), f_s_n(i,5), f_s_n(i,6), f_s_n(i,7), f_s_n(i,8), f_s_n(i,9));
end
fclose(fid2);

