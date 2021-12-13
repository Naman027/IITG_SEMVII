function [node,elem,HB] = cubemesh(box,h)
%% CUBEMESH a uniform mesh of a cube
%
% [node,elem,HB] = cubemesh([x0,x1,y0,y1,z0,z1],h) generates a uniform mesh
% of the cube [x0,x1]*[y0,y1]*[z0,z1] with certain mesh size h. 
%
% [node,elem,HB] = cubemesh([x0,x1,y0,y1,z0,z1],[hx,hy,hz]) generates a
% uniform mesh of the cube [x0,x1]*[y0,y1]*[z0,z1] with mesh size
% hx in x-direction, hy in y-direction, and hz in z-direction.
%
% Example 1
%
%  [node,elem] = cubemesh([-1,1,-1,1,-1,1]);

%  showmesh3(node,elem);
%
% Example 2
%
%  [node,elem,HB] = cubemesh([0,1,0,2,0,4],1);
%  showmesh3(node,elem);
% 
% Example 3
%
%  [node,elem,HB] = cubemesh([0,1,0,1,0,1],[0.5, 0.25, 0.125]);
%  showmesh3(node,elem);
%
% The ordering of vertices is important for the uniform refinement. See
% uniformrefine3.
% 
% See also:
%    uniformrefine3
%
% Different mesh size in x-y-z directions are added by Shuhao Cao.
%
% Copyright (C) Long Chen. See COPYRIGHT.txt for details. 

x0 = box(1); x1 = box(2); 
y0 = box(3); y1 = box(4);
z0 = box(5); z1 = box(6);

%       8 --- 7
%      /|    /|
%     5 --- 6 |      z
%     | 4 --| 3      |  y
%     |/    |/       | /
%     1 --  2        o --- x

node = [x0,y0,z0; x1,y0,z0; x1,y1,z0; x0,y1,z0; ...
        x0,y0,z1; x1,y0,z1; x1,y1,z1; x0,y1,z1];
elem = [1 2 3 7; 1 4 3 7; 1 5 6 7; 1 5 8 7; 1 2 6 7; 1 4 8 7];
% The order of vertices is important for the uniform refinement.

if (nargin >= 2) 
    if length(h) == 1       
        [x,y,z] = ndgrid(x0:h:x1,y0:h:y1,z0:h:z1);
    elseif length(h) == 3
        hx = (x1- x0)/floor(abs((x1- x0)/h(1)));
        hy = (x1- x0)/floor(abs((x1- x0)/h(2)));
        hz = (x1- x0)/floor(abs((x1- x0)/h(3)));
        [x,y,z] = ndgrid(x0:hx:x1,y0:hy:y1,z0:hz:z1);
    end  
    node = [x(:),y(:),z(:)];
    [nx,ny,nz] = size(x);
    elem = zeros(6*(nx-1)*(ny-1)*(nz-1),4);
    indexMap = reshape(1:nx*ny*nz,nx,ny,nz);
    localIndex = zeros(8,1);
    idx = 1;
    for k = 1:nz-1
        for j = 1:ny-1
            for i = 1:nx-1
                localIndex(1) = indexMap(i,j,k);
                localIndex(2) = indexMap(i+1,j,k);
                localIndex(3) = indexMap(i+1,j+1,k);
                localIndex(4) = indexMap(i,j+1,k);
                localIndex(5) = indexMap(i,j,k+1);
                localIndex(6) = indexMap(i+1,j,k+1);
                localIndex(7) = indexMap(i+1,j+1,k+1);
                localIndex(8) = indexMap(i,j+1,k+1);
                elem(idx:idx+5,:) = localIndex([1 2 3 7; 1 4 3 7; 1 5 6 7;...
                                                1 5 8 7; 1 2 6 7; 1 4 8 7]);
                idx = idx + 6;
            end
        end
    end
end

% Set this as an initial grid
N0 = size(node,1);
HB = zeros(N0,4);
HB(1:N0,1:3) = repmat((1:N0)',1,3);