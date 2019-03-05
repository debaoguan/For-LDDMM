clear all; close all;


node=load('D:\DBGuan\DTMRImapping\Biventricle\CanineHeart\S042604\Cannie_node.txt');
element=load('D:\DBGuan\DTMRImapping\Biventricle\CanineHeart\S042604\Cannie_element.txt');
fibre_sheet=load('D:\DBGuan\DTMRImapping\Biventricle\CanineHeart\S042604\fibre_sheet_Dir.txt');



%change node data

r=0.45;
tr=[30.5640   -0.9105   22.7000];

thet=180/180*pi;
Ry=[cos(thet) 0 sin(thet);
    0 1 0;
    -sin(thet) 0 cos(thet)];

gama=-45/180*pi;
Rz=[cos(gama) sin(gama) 0;
    -sin(gama) cos(gama) 0;
    0 0 1];

TR=Ry*Rz;


b=[];
for i = 1 : size(node,1)
    a1=[];a2=[];a3=[];
    a1=node(i,2:4)-tr;
    a2=a1*r;
    a3=TR*a2';
    
    b(i,1)=i;
    b(i,2:4)=a3';
end


c=[];
for i = 1 : size(element,1)
    f=[];s=[];
    
    f=TR*fibre_sheet(i,2:4)';
    s=TR*fibre_sheet(i,5:7)';
    
    c(i,1)=i;
    c(i,2:4)=f';
    c(i,5:7)=s';
end


fid1 = fopen('D:\DBGuan\DTMRImapping\Biventricle\CanineHeart\S042604\Cannie_node_change.txt','w');
 
for i = 1 : size(b,1)
    fprintf(fid1, '%i\t, %f\t, %f\t, %f\n', b(i,1),b(i,2),b(i,3),b(i,4));
end
fclose(fid1);


fid2 = fopen('D:\DBGuan\DTMRImapping\Biventricle\CanineHeart\S042604\Cannie_fibre_sheet_Dir_change.txt','w');
 
for i = 1 : size(c,1)
    fprintf(fid2, '%i\t %f\t %f\t %f\t %f\t %f\t %f\n', c(i,1),c(i,2),c(i,3),c(i,4),c(i,5),c(i,6),c(i,7));
end
fclose(fid2);






