clear all; close all;

str='D:\DBGuan\DTMRImapping\Biventricle\CanineHeart\HearSurface\HeartSurface'
node=load([str '_node_change.txt']);
element=load([str '_element.txt']);

S1=load([str '_S1.txt']);
S2=load([str '_S2.txt']);
S3=load([str '_S3.txt']);
S4=load([str '_S4.txt']);

k=0;
[m1,n1]=size(S1);
for i=1:m1
    for j=1:n1
        if S1(i,j)~=0
            k=k+1;
            Tedele(k,1)=element(S1(i,j),2);
            Tedele(k,2)=element(S1(i,j),3);
            Tedele(k,3)=element(S1(i,j),4);
        end
    end
end

[m2,n2]=size(S2);
for i=1:m2
    for j=1:n2
        if S2(i,j)~=0
            k=k+1;
            Tedele(k,1)=element(S2(i,j),2);
            Tedele(k,2)=element(S2(i,j),5);
            Tedele(k,3)=element(S2(i,j),3);
        end
    end
end

[m3,n3]=size(S3);
for i=1:m3
    for j=1:n3
        if S3(i,j)~=0
            k=k+1;
            Tedele(k,1)=element(S3(i,j),3);
            Tedele(k,2)=element(S3(i,j),5);
            Tedele(k,3)=element(S3(i,j),4);
        end
    end
end

[m4,n4]=size(S4);
for i=1:m4
    for j=1:n4
        if S4(i,j)~=0
            k=k+1;
            Tedele(k,1)=element(S4(i,j),4);
            Tedele(k,2)=element(S4(i,j),5);
            Tedele(k,3)=element(S4(i,j),2);
        end
    end
end

a=Tedele(:,1);b=Tedele(:,2);c=Tedele(:,3);d=[a;b;c];
nodeno=unique(d);

for i=1:length(nodeno)
    node_suf(i,1)=node(nodeno(i),2);
    node_suf(i,2)=node(nodeno(i),3);
    node_suf(i,3)=node(nodeno(i),4);
    
    if nodeno(i)~=i
        row=[];col=[];
        [row,col]=find(Tedele==nodeno(i));
        for j=1:length(row)
            Tedele(row(j),col(j))=i;
        end
    end
end


for i=1:length(node)
    if ismember(i,nodeno)
        group(i,1)=1;
        group(i,2)=0;
    else
        group(i,1)=0;
        group(i,2)=0;
    end
end

    

fid1 = fopen([str '_node_surface.txt'],'w');
 
for i = 1 : size(node_suf,1)
    fprintf(fid1, '%i,\t%.10f, \t%.10f, \t%.10f\n', i,node_suf(i,1),node_suf(i,2),node_suf(i,3));
end
fclose(fid1);

fid2 = fopen([str '_element_surface.txt'],'w');
 
for i = 1 : size(Tedele,1)
    fprintf(fid2, '\t%i, \t%i, \t%i,\t%i\n', i,Tedele(i,1),Tedele(i,2),Tedele(i,3));
end
fclose(fid2);

fid3 = fopen([ str '_group.txt'],'w');
 
for i = 1 : size(group,1)
    fprintf(fid3, '%i\t %i\n', group(i,1),group(i,2));
end
fclose(fid3);







          
            