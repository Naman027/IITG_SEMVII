function U=crank_nicolson(T,K,r,sig,R,Time,h,k,f,fa,fb,fc,flag)
    if flag
        k=-k;
    end
    M=length(R);
	N=length(Time);
    U=zeros(N,M);
    U(1,:)=f(R,T);
    for i=2:N
        A=zeros(M,M);
        b=zeros(M,1);
        at=fa(sig,R);
        bt=fb(r,R);
        ct=fc(r);
        A(1:M+1:end)=2-2*at*k/h^2+ct*k;
		A(2:M+1:end)=at(2:M)*k/h^2-bt(2:M)*k/(2*h);
		A(M+1:M+1:end)=at(1:M-1)*k/h^2+bt(1:M-1)*k/(2*h);
		A(1,1)=1-(3*k)/(2*h);
		A(1,2)=(4*k)/(2*h);
		A(1,3)=(-k)/(2*h);
		A(M,M)=1;
		A(M,M-1)=0;
        b(2:M-1)=(-at(2:M-1)*k/h^2+bt(2:M-1)*k/(2*h)).*U(i-1,1:M-2)+(2+2*at(2:M-1)*k/h^2-ct*k).*U(i-1,2:M-1)+(-at(2:M-1)*k/h^2-bt(2:M-1)*k/(2*h)).*U(i-1,3:M);
		b(1)=U(i-1,1);
		b(end)=0;
		U(i,:)=(A\b)';
    end
    if flag
        U=flipud(U);
    end
end