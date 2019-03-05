clear all; close all;

fibre_linear=load('D:\DBGuan\DTMRImapping\Biventricle\LDDMMtoAHA17\fibreLINEAR.txt');
fibre=load('D:\DBGuan\DTMRImapping\Biventricle\LDDM_Cannie_DB_Heart\fibre_combine_Dir.txt');
setrv=load('D:\DBGuan\DTMRImapping\Biventricle\AHA17_DB_Heart\element_rv.txt');

for i=1:size(fibre,1)

    if ismember(i,setrv)
        fibre_sheet(i,1:3)=fibre_linear(i,2:4);
    else
        fibre_sheet(i,1:3)=fibre(i,1:3);
    end
end

fid1 = fopen('D:\DBGuan\DTMRImapping\Biventricle\LDDMMtoAHA17\fibre_combine_Dir40DU.txt','w');
 
for i = 1 : size(fibre,1)
    fprintf(fid1, '%i,\t%f, \t%f, \t%f\n', i,fibre_sheet(i,1),fibre_sheet(i,2),fibre_sheet(i,3));
end
fclose(fid1);