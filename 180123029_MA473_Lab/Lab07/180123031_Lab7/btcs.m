function U=btcs(T,K,r,sig,R,Time,h,k,f,fa,fb,fc,flag)
    M=length(R);
	N=length(Time);
    U=zeros(N,M);
    if flag
        k=-k;
    end

    U(1,:)=f(R,T);
    for i=2:N
        A=zeros(M,M);
        b=zeros(M,1);
        
        aa=fa(sig,R);
        bb=fb(r,R);
        cc=fc(r);
        A(1:M+1:end)=1-2*aa*k/h^2+cc*k;
		A(2:M+1:end)=aa(2:M)*k/h^2-bb(2:M)*k/(2*h);
		A(M+1:M+1:end)=aa(1:M-1)*k/h^2+bb(1:M-1)*k/(2*h);

		A(1,1)=1-(3*k)/(2*h);
		A(1,2)=(4*k)/(2*h);
		A(1,3)=(-k)/(2*h);
		A(M,M)=1;
		A(M,M-1)=0;

		b(2:M-1)=U(i-1,2:M-1);
		b(1)=U(i-1,1);
		b(end)=0;

        U(i,:)=(A\b)';
    end
    if flag
		U=flipud(U);
    end
    
end