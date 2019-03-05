clear all; close all;

str='D:\DBGuan\DTMRImapping\Biventricle\LDDM_Cannie_DB_Heart\Cannie';
node=load([str '_node.txt']);
element=load([str '_element.txt']);
node_dxdydz=load('D:\DBGuan\DTMRImapping\Biventricle\LDDM_Cannie_DB_Heart\dxdydz\node_dxdydz.txt');
fibre=load('D:\DBGuan\DTMRImapping\Biventricle\LDDM_Cannie_DB_Heart\Cannie_f_s_n.txt');
%sheet=load('D:\DBGuan\DTMRImapping\Biventricle\HG_Heart\sheetDir.txt');

for i=1:size(element,1)
    xyztet=[];
    for j=1:4
        xyztet(1,j)=node(element(i,j),1);
        xyztet(2,j)=node(element(i,j),2);
        xyztet(3,j)=node(element(i,j),3);
        
        dxdydz(1,j)=node_dxdydz(element(i,j),1);
        dxdydz(2,j)=node_dxdydz(element(i,j),2);
        dxdydz(3,j)=node_dxdydz(element(i,j),3);
    end
    
    [abc, Vcol]=IsoTet4ShapeFunDer(xyztet);
    
    F=[];
    F=eye(3)+(dxdydz*abc)/6/Vcol;
    
    fibre_sheet(i,1:3)=(F*fibre(i,1:3)')';
    %fibre_sheet(i,4:6)=(F*sheet(i,2:4)')';
    
    DeformationGrad(i,:,:)=F;
end

fid1 = fopen('D:\DBGuan\DTMRImapping\Biventricle\LDDM_Cannie_DB_Heart\fibre_CannietoDB_deformed.txt','w');
 
for i = 1 : size(fibre_sheet,1)
    fprintf(fid1, '%f\t %f\t %f\n', fibre_sheet(i,1),fibre_sheet(i,2),fibre_sheet(i,3));
end
fclose(fid1);

for i=1:size(node,1)
    node_deform(i,:)=node(i,:)+node_dxdydz(i,:);
end

fid2 = fopen('D:\DBGuan\DTMRImapping\Biventricle\LDDM_Cannie_DB_Heart\Cannie_node_deformed.txt','w');
 
for i = 1 : size(node_deform,1)
    fprintf(fid2, '%f\t %f\t %f\n', node_deform(i,1),node_deform(i,2),node_deform(i,3));
end
fclose(fid2);





