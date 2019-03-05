clear all; close all;


load('D:\DBGuan\DTMRImapping\Biventricle\CanineHeart\S042604\lv_node.txt');
load('D:\DBGuan\DTMRImapping\Biventricle\CanineHeart\S042604\rv_node.txt');
load('D:\DBGuan\DTMRImapping\Biventricle\CanineHeart\S042604\epi_node.txt');
load('D:\DBGuan\DTMRImapping\Biventricle\CanineHeart\S042604\sep_node.txt');
node=load('D:\DBGuan\DTMRImapping\Biventricle\CanineHeart\S042604\Cannie_node_change.txt');

%epi=1
k=0;
for i=1:size(epi_node,1)
    for j=1:size(epi_node,2)
        if epi_node(i,j)~=0
            k=k+1;
            data(k,1)=epi_node(i,j);
            data(k,2)=1;
            data(k,3)=1;
        end
    end
end

%lv=0
for i=1:size(lv_node,1)
    for j=1:size(lv_node,2)
        if lv_node(i,j)~=0
            k=k+1;
            data(k,1)=lv_node(i,j);
            data(k,2)=1;
            data(k,3)=0;
        end
    end
end

%sep=1
for i=1:size(sep_node,1)
    for j=1:size(sep_node,2)
        if sep_node(i,j)~=0
            k=k+1;
            data(k,1)=sep_node(i,j);
            data(k,2)=1;
            data(k,3)=1;
        end
    end
end

%rvfree=0
for i=1:size(rv_node,1)
    for j=1:size(rv_node,2)
        if rv_node(i,j)~=0 & ~ismember(rv_node(i,j),sep_node)
            k=k+1;
            data(k,1)=rv_node(i,j);
            data(k,2)=1;
            data(k,3)=0;
        end
    end
end

for i=1:size(node,1)
    if ismember(i,data(:,1))
        row=find(data(:,1)==i);
        group(i,:)=data(row,2:3);
    else
        group(i,:)=[0 0];
    end
end

        

fid2 = fopen('D:\DBGuan\DTMRImapping\Biventricle\CanineHeart\S042604\Cannie_surfacenode_poission3.txt','w');
 
for i = 1 : size(group,1)
    fprintf(fid2, '%i\t %i\n', group(i,1),group(i,2));
end
fclose(fid2);






            

