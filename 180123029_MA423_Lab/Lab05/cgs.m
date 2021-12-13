function [Q,R]=cgs(V)
    m = size(V,2);
    R=zeros(size(V,1),m);
    for i=1:m
        R(1:i-1,i)= V(:,1:i-1)'*V(:,i); % Inner product <Vk,Vi>
        for j=1:i-1
            V(:,i) = V(:,i)-V(:,j)*R(j,i);
        end
        R(i,i) = norm(V(:,i),2);
        if (R(i,i)==0)
            exit('v1,.....,vk are dependent');
        end
        V(:,i)=V(:,i)/R(i,i);
    end
    Q=V;
end