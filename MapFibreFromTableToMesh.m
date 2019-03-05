clear all; close all;

element1=load('D:\DBGuan\DTMRImapping\Biventricle\CanineHeart\S042604\Cannie_element.txt');
node1=load('D:\DBGuan\DTMRImapping\Biventricle\CanineHeart\S042604\Cannie_node.txt');
fibre=load('D:\DBGuan\DTMRImapping\Biventricle\CanineHeart\S042604\NIH_042604_fgeo');
sheet=load('D:\DBGuan\DTMRImapping\Biventricle\CanineHeart\S042604\NIH_042604_sgeo');
load('D:\DBGuan\DTMRImapping\Biventricle\CanineHeart\DT042604\e1');
load('D:\DBGuan\DTMRImapping\Biventricle\CanineHeart\DT042604\e2');
load('D:\DBGuan\DTMRImapping\Biventricle\CanineHeart\DT042604\e3');
load('D:\DBGuan\DTMRImapping\Biventricle\CanineHeart\DT042604\v11');
load('D:\DBGuan\DTMRImapping\Biventricle\CanineHeart\DT042604\v12');
load('D:\DBGuan\DTMRImapping\Biventricle\CanineHeart\DT042604\v13');
load('D:\DBGuan\DTMRImapping\Biventricle\CanineHeart\DT042604\v21');
load('D:\DBGuan\DTMRImapping\Biventricle\CanineHeart\DT042604\v22');
load('D:\DBGuan\DTMRImapping\Biventricle\CanineHeart\DT042604\v23');
load('D:\DBGuan\DTMRImapping\Biventricle\CanineHeart\DT042604\v31');
load('D:\DBGuan\DTMRImapping\Biventricle\CanineHeart\DT042604\v32');
load('D:\DBGuan\DTMRImapping\Biventricle\CanineHeart\DT042604\v33');

dx=(63+17)/255; dy=(50+30)/255; dz=(73+19)/115;
mad=[];
for i=1:size(element1,1)
    center=[];
    for j=1:4
        xyztet1(1,j)=node1(element1(i,j+1),2);
        xyztet1(2,j)=node1(element1(i,j+1),3);
        xyztet1(3,j)=node1(element1(i,j+1),4);
    end
    center=mean(xyztet1,2);
    
    x=round((63-center(1))/dx+1);
    y=round((50-center(2))/dy+1);
    z=round((73-center(3))/dz+1);
    
    a=fibre.fgeo(x,y,z);
    b=sheet.sgeo(x,y,z);
    
    kr=0;kc=0;kz=0;
    
    if isnan(a) | isnan(b)
        kk=0; row=[];col=[];zol=[];dis=[];
        for kr=-10:10
            if kr+x >256
                kr=256-x;
            elseif kr+x<=0
                kr=1-x;
            end 
            for kc=-10:10
                if kc+y >256
                    kc=256-y;
                elseif kc+y<=0
                    kc=1-y;
                end 
                for kz=-5:5
                    if kz+z >256
                        kz=256-z;
                    elseif kz+z<=0
                        kz=1-z;
                    end 
                    a=fibre.fgeo(x+kr,y+kc,z+kz);
                    b=sheet.sgeo(x+kr,y+kc,z+kz);
                    if ~isnan(a) & ~isnan(b)
                        kk=kk+1;
                        row(kk)=kr; col(kk)=kc; zol(kk)=kz;
                    end
                end
            end
        end
            
        for ki=1:length(row)
            dis(ki)=norm([row(ki)-x col(ki)-y zol(ki)-z]);
        end
        
        if length(row)==0
            mad=[mad;i];
            kr=0;kc=0;kz=0;
        else
        
            rmin=find(dis==min(dis));
            kr=row(rmin(1));
            kc=col(rmin(1));
            kz=zol(rmin(1));
        end
    end
                
    a=fibre.fgeo(x+kr,y+kc,z+kz);
    b=sheet.sgeo(x+kr,y+kc,z+kz);
    
    fibre_sheet(i,1)=a;
    fibre_sheet(i,2)=b;
    fibre_sheet(i,3)=e1(x+kr,y+kc,z+kz);
    fibre_sheet(i,4)=e2(x+kr,y+kc,z+kz);
    fibre_sheet(i,5)=e3(x+kr,y+kc,z+kz);
    fibre_sheet(i,6:8)=[v11(x+kr,y+kc,z+kz) v12(x+kr,y+kc,z+kz) v13(x+kr,y+kc,z+kz)];
    fibre_sheet(i,9:11)=[v21(x+kr,y+kc,z+kz) v22(x+kr,y+kc,z+kz) v23(x+kr,y+kc,z+kz)];
    fibre_sheet(i,12:14)=[v31(x+kr,y+kc,z+kz) v32(x+kr,y+kc,z+kz) v33(x+kr,y+kc,z+kz)];
end


mad2=[];
for i=1:size(mad,1)
    center=[];
    for j=1:4
        xyztet1(1,j)=node1(element1(mad(i),j+1),2);
        xyztet1(2,j)=node1(element1(mad(i),j+1),3);
        xyztet1(3,j)=node1(element1(mad(i),j+1),4);
    end
    center=mean(xyztet1,2);
    
    x=round((63-center(1))/dx+1);
    y=round((50-center(2))/dy+1);
    z=round((73-center(3))/dz+1);
    
    a=fibre.fgeo(x,y,z);
    b=sheet.sgeo(x,y,z);
    
    kr=0;kc=0;kz=0;
    
    if isnan(a) | isnan(b)
        kk=0; row=[];col=[];zol=[];dis=[];
        for kr=1:2:256
            for kc=1:2:256
                for kz=1:2:116
                    a=fibre.fgeo(kr,kc,kz);
                    b=sheet.sgeo(kr,kc,kz);
                    if ~isnan(a) & ~isnan(b)
                        kk=kk+1;
                        row(kk)=kr; col(kk)=kc; zol(kk)=kz;
                    end
                end
            end
        end
            
        for ki=1:length(row)
            dis(ki)=norm([row(ki)-x col(ki)-y zol(ki)-z]);
        end
        
        if length(row)==0
            mad2=[mad2;mad(i)];
            kr=0;kc=0;kz=0;
        else
        
            rmin=find(dis==min(dis));
            kr=row(rmin(1));
            kc=col(rmin(1));
            kz=zol(rmin(1));
        end
    end
                
    a=fibre.fgeo(kr,kc,kz);
    b=sheet.sgeo(kr,kc,kz);
    
    fibre_sheet(mad(i),1)=a;
    fibre_sheet(mad(i),2)=b;
    fibre_sheet(i,3)=e1(kr,kc,kz);
    fibre_sheet(i,4)=e2(kr,kc,kz);
    fibre_sheet(i,5)=e3(kr,kc,kz);
    fibre_sheet(i,6:8)=[v11(kr,kc,kz) v12(kr,kc,kz) v13(kr,kc,kz)];
    fibre_sheet(i,9:11)=[v21(kr,kc,kz) v22(kr,kc,kz) v23(kr,kc,kz)];
    fibre_sheet(i,12:14)=[v31(kr,kc,kz) v32(kr,kc,kz) v33(kr,kc,kz)];
  
end

fid1 = fopen('D:\DBGuan\DTMRImapping\Biventricle\SurfaceData\fibre_sheet_cannieheart_angle_direction.txt','w');
 
for i = 1 : size(fibre_sheet,1)
    fprintf(fid1, '%i\t %f\t %f\t %f\t %f\t %f\t %f\t %f\t %f\t %f\t %f\t %f\t %f\t %f\t %f\n',...
        i, fibre_sheet(i,1),fibre_sheet(i,2),fibre_sheet(i,3),fibre_sheet(i,4),fibre_sheet(i,5),...
        fibre_sheet(i,6),fibre_sheet(i,7),fibre_sheet(i,8),fibre_sheet(i,9),fibre_sheet(i,10),...
        fibre_sheet(i,11),fibre_sheet(i,12),fibre_sheet(i,13),fibre_sheet(i,14));
end
fclose(fid1);

    any=isnan(fibre_sheet);
    find(any==1);


