%%

%Instructions
%1.Run the Reflectarray phase profile calculation script and save the sizes matrix into the Mask Generation directory
%2.Specify the unit cell size as variable "distance"
%3.Specify the constant dimension of the patch as variable "constant_dim "
%4.Run the code
%5.Open the generate .txt file asn Save as DXF
%6. Open HFSS 3D Layout and import the DXF as AUTOCAD file and choose overide units


%C = {0;'SECTION';2;'ENTITIES';0;'SOLID';10;-5;20;5;11;-5;21;-5;12;5;22;5;13;5;23;-5;0;'SOLID';10;15;20;5;11;15;21;-5;12;25;22;5;13;25;23;-5;0;'ENDSEC';0;'EOF'};
% sample two element basic 
clc
clear

load sizes_1.mat
C = {0;'SECTION';2;'ENTITIES';0;'SOLID';};
pos = 7; % index that shows the row number inside the DXF file
init = 0; % used to creat the 10, 20, 11, 21, 22, 13, 23 required by the DXF format
% i=1 corresponds to (-,+) top left
% i=2 corresponds to (-,-) bottom left
% i=3 corresponds to (+,+) top right
% i=4 corresponds to (+,-) bottom right


distance = 4.7; % distance between elements(unit cell size)in mm
constant_dim = 2.7; % dimension of the patch that is kept constant(in our case this is along the x-direction) in mm

%Create the top half of the array (y>0) 
%--------------------------------------------------------------------------------------------------------
for r_count=1:length(sizes)/2       %starting from the central row create all the element across +y
for c_count=1:(1+length(sizes)/2)   % starting from the central element create all the elements c_count accross +x (with constant row ,r_count) ) 
    for i=1:4
        if i== 1
        C{pos} = init+10;
        C{pos+1} = (c_count-1)*distance - sizes(length(sizes)/2-(r_count-1),length(sizes)/2+(c_count-1))/2;
        C{pos+2} = C{pos}+10;
        C{pos+3} = (r_count-1)*distance+constant_dim/2;
        %C{7} = {10;-5;20;5;11;-5;21;-5;12;5;22;5;13;5;23;-5;0;SOLID}
        elseif i == 2
        C{pos} = init+10;
        C{pos+1} = (c_count-1)*distance - sizes(length(sizes)/2-(r_count-1),length(sizes)/2+(c_count-1))/2;
        C{pos+2} = C{pos}+10;
        C{pos+3} = (r_count-1)*distance-constant_dim/2;
        elseif i == 3
        C{pos} = init+10;
        C{pos+1} = (c_count-1)*distance + sizes(length(sizes)/2-(r_count-1),length(sizes)/2+(c_count-1))/2;
        C{pos+2} = C{pos}+10;
        C{pos+3} = (r_count-1)*distance+constant_dim/2;
        elseif i == 4
        C{pos} = init+10;
        C{pos+1} = (c_count-1)*distance + sizes(length(sizes)/2-(r_count-1),length(sizes)/2+(c_count-1))/2;
        C{pos+2} = C{pos}+10;
        C{pos+3} = (r_count-1)*distance-constant_dim/2;
        end
        pos = pos+4;
        init = init+1; 
        
    end
        
   C{pos}=0;
   C{pos+1} = 'SOLID';
   pos = pos+2;
   
   init = 0;
end
for c_count=2:length(sizes)/2    % starting from the central element -1 create all the elements c_count accross -x (with constant row ,r_count)
    for i=1:4
        if i== 1
        C{pos} = init+10;
        C{pos+1} = -(c_count-1)*distance - sizes(length(sizes)/2-(r_count-1),length(sizes)/2-(c_count-1))/2;
        C{pos+2} = C{pos}+10;
        C{pos+3} = (r_count-1)*distance+constant_dim/2;
        %C{7} = {10;-5;20;5;11;-5;21;-5;12;5;22;5;13;5;23;-5;0;SOLID}
        elseif i == 2
        C{pos} = init+10;
        C{pos+1} = -(c_count-1)*distance - sizes(length(sizes)/2-(r_count-1),length(sizes)/2-(c_count-1))/2;
        C{pos+2} = C{pos}+10;
        C{pos+3} = (r_count-1)*distance-constant_dim/2;
        elseif i == 3
        C{pos} = init+10;
        C{pos+1} = -(c_count-1)*distance + sizes(length(sizes)/2-(r_count-1),length(sizes)/2-(c_count-1))/2;
        C{pos+2} = C{pos}+10;
        C{pos+3} = (r_count-1)*distance+constant_dim/2;
        elseif i == 4
        C{pos} = init+10;
        C{pos+1} = -(c_count-1)*distance + sizes(length(sizes)/2-(r_count-1),length(sizes)/2-(c_count-1))/2;
        C{pos+2} = C{pos}+10;
        C{pos+3} = (r_count-1)*distance-constant_dim/2;
        end
        pos = pos+4;
        init = init+1; 
        
    end
        
   C{pos}=0;
   C{pos+1} = 'SOLID';
   pos = pos+2;
   init = 0;
end
end


%Create the bottom half of the array (y<0) 
%--------------------------------------------------------------------------------------------------------
for r_count=2:(1+length(sizes)/2)   %starting from the central row -1 create all the element across -y
for c_count=1:(1+length(sizes)/2)      % starting from the central element create all the elements c_count accross +x (with constant row ,r_count) )
    for i=1:4
        if i== 1
        C{pos} = init+10;
        C{pos+1} = (c_count-1)*distance - sizes(length(sizes)/2+(r_count-1),length(sizes)/2+(c_count-1))/2;
        C{pos+2} = C{pos}+10;
        C{pos+3} = -(r_count-1)*distance+constant_dim/2;
        %C{7} = {10;-5;20;5;11;-5;21;-5;12;5;22;5;13;5;23;-5;0;SOLID}
        elseif i == 2
        C{pos} = init+10;
        C{pos+1} = (c_count-1)*distance - sizes(length(sizes)/2+(r_count-1),length(sizes)/2+(c_count-1))/2;
        C{pos+2} = C{pos}+10;
        C{pos+3} = -(r_count-1)*distance-constant_dim/2;
        elseif i == 3
        C{pos} = init+10;
        C{pos+1} = (c_count-1)*distance + sizes(length(sizes)/2+(r_count-1),length(sizes)/2+(c_count-1))/2;
        C{pos+2} = C{pos}+10;
        C{pos+3} = -(r_count-1)*distance+constant_dim/2;
        elseif i == 4
        C{pos} = init+10;
        C{pos+1} = (c_count-1)*distance + sizes(length(sizes)/2+(r_count-1),length(sizes)/2+(c_count-1))/2;
        C{pos+2} = C{pos}+10;
        C{pos+3} = -(r_count-1)*distance-constant_dim/2;
        end
        pos = pos+4;
        init = init+1; 
        
    end
        
   C{pos}=0;
   C{pos+1} = 'SOLID';
   pos = pos+2;
   
   init = 0;
end
for c_count=2:length(sizes)/2    % starting from the central element -1 create all the elements c_count accross -x (with constant row ,r_count)
    for i=1:4
        if i== 1
        C{pos} = init+10;
        C{pos+1} = -(c_count-1)*distance - sizes(length(sizes)/2+(r_count-1),length(sizes)/2-(c_count-1))/2;
        C{pos+2} = C{pos}+10;
        C{pos+3} = -(r_count-1)*distance+constant_dim/2;
        %C{7} = {10;-5;20;5;11;-5;21;-5;12;5;22;5;13;5;23;-5;0;SOLID}
        elseif i == 2
        C{pos} = init+10;
        C{pos+1} = -(c_count-1)*distance - sizes(length(sizes)/2+(r_count-1),length(sizes)/2-(c_count-1))/2;
        C{pos+2} = C{pos}+10;
        C{pos+3} = -(r_count-1)*distance-constant_dim/2;
        elseif i == 3
        C{pos} = init+10;
        C{pos+1} = -(c_count-1)*distance + sizes(length(sizes)/2+(r_count-1),length(sizes)/2-(c_count-1))/2;
        C{pos+2} = C{pos}+10;
        C{pos+3} = -(r_count-1)*distance+constant_dim/2;
        elseif i == 4
        C{pos} = init+10;
        C{pos+1} = -(c_count-1)*distance + sizes(length(sizes)/2+(r_count-1),length(sizes)/2-(c_count-1))/2;
        C{pos+2} = C{pos}+10;
        C{pos+3} = -(r_count-1)*distance-constant_dim/2;
        end
        pos = pos+4;
        init = init+1; 
        
    end
        
   C{pos}=0;
   C{pos+1} = 'SOLID';
   pos = pos+2;
   init = 0;
end
end


%add the last 3 rows of the DXF by overwriting the last SOLID entry  
 C{pos-1} = 'ENDSEC';
 C{pos} = 0;
 C{pos+1} = 'EOF';
   
%C 
% write array into DXF file
writecell(C,'C_tab.txt','Delimiter','tab')
type 'C_tab.txt'