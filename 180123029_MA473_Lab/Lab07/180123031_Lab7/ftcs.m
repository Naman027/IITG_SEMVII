function U=ftcs(T,K,r,sig,R,Time,h,k,f,fa,fb,fc,flag)
    e=1;
    m=length(R);
    n=length(Time);
    A=eye(m,m);B=A;
    for i=2:m-1
        A(i,i)=1/k-2*fa(R(i),sig);
        A(i,i-1)=(fa(R(i),sig)-fb(r,R(i)));
        A(i,i+1)=(fa(R(i),sig)+fb(r,R(i)));
        B(i,i)=1/k;
    end
    A(2:end-1,:)=A(2:end-1,:)*k;
    B(2:end-1,:)=B(2:end-1,:)*k;
    B(1,1)=1+3*k/(2*h);
    B(1,2)=-2*k/h;
    B(1,3)=k/(2*h);
    U=zeros(m,n);
    U(:,n)=max(1-R/T,0);
    U(m,:)=0;
    for i=n-1:-1:1
        bb=A*U(:,i+1);
        U(:,i)=B\(bb);
    end
    U=U'
end