clear all; close all;

% read the element and node from deformed template 
'Step 1: Read data'
element1=load('D:\DBGuan\DTMRImapping\Biventricle\LDDM_Cannie_DB_Heart\DB_element.txt');
node1=load('D:\DBGuan\DTMRImapping\Biventricle\LDDM_Cannie_DB_Heart\DB_node.txt');
fibre_sheet=load('D:\DBGuan\DTMRImapping\Biventricle\LDDM_Cannie_DB_Heart\LDDMM_f_s_n.txt');
%node_dxdydz=load('D:\DBGuan\DTMRImapping\Biventricle\LDDM_Cannie_DB_Heart\node_dxdydz.txt');
%mindxdydz=1.5*min(node_dxdydz);
%maxdxdydz=1.5*max(node_dxdydz);

for i=1:size(element1,1)
    center=[];
    for j=1:4
        xyztet1(1,j)=node1(element1(i,j+1),2);
        xyztet1(2,j)=node1(element1(i,j+1),3);
        xyztet1(3,j)=node1(element1(i,j+1),4);
    end
    center=mean(xyztet1,2);
    map1(i,1)=i;
    map1(i,2:4)=center';
    map1(i,5:10)=fibre_sheet(i,1:6);
end

% read the element and node from target mesh
'Step 2: Read data'
element2=load('D:\DBGuan\livingHeartProject\PorcineHeart\Biventricle\DBcoarse_element.txt');
node2=load('D:\DBGuan\livingHeartProject\PorcineHeart\Biventricle\DBcoarse_node.txt');

for i=1:size(element2,1)
    center=[];
    for j=1:4
        xyztet2(1,j)=node2(element2(i,j+1),2);
        xyztet2(2,j)=node2(element2(i,j+1),3);
        xyztet2(3,j)=node2(element2(i,j+1),4);
    end
    
    center=mean(xyztet2,2);
    dis0=1000; mrow=0;%initail value
    
    for k=1:size(map1,1)
        cen=[];dis=[];
        cen=map1(k,2:4);
        dom=center'-cen;
        if abs(dom(1))<3 & abs(dom(3))<3 & abs(dom(3))<3
            dis1=norm(dom);
            if dis1<dis0
                mrow=k;
                dis0=dis1;
            end
        end
    end
   % mr=find(dis(:,2)==min(dis(:,2)));
   % mrow=dis(mr,1);
    
   %map2(i,1)=i;
   % map1(i,2:4)=center';
   % map1(i,5:10)=fibre_sheet(mrow,:);
    fibre_sheet_traget(i,:)=fibre_sheet(mrow,1:6);
    
    if mod(i,10000)==0
       num2str(i)
    end
end

fid1 = fopen('D:\DBGuan\livingHeartProject\PorcineHeart\Biventricle\fibre_sheet_coarse.txt','w');
 
for i = 1 : size(fibre_sheet_traget,1)
    fprintf(fid1, 'i,\t%f, \t%f, \t%f, \t%f, \t%f, \t%f\n', i, fibre_sheet_traget(i,1),fibre_sheet_traget(i,2),fibre_sheet_traget(i,3),...
        fibre_sheet_traget(i,4),fibre_sheet_traget(i,5),fibre_sheet_traget(i,6));
end
fclose(fid1);


