function bestalpha=SOR(Q,f,t,C,smallvalue)

[m,n]=size(Q);
alpha0=(C/10)*ones(m,1);

i=0;
L=tril(Q);
E=diag(Q);
twinalpha=alpha0;
for j=1:n
    i=i+1;
    tmp_alpha=alpha0(j,1)-(t/E(j,1))*(Q(j,:)*twinalpha(:,1)-f(i)+L(j,:)*(twinalpha(:,1)-alpha0));
    if tmp_alpha<0
        tmp_alpha=0;
    elseif tmp_alpha>C
        tmp_alpha=C;
    end
    twinalpha(j,1)=tmp_alpha;
end
alpha=[alpha0,twinalpha];
while norm(alpha(:,2)-alpha(:,1))>smallvalue 
    for j=1:n
        tmp_alpha=alpha(j,2)-(t/E(j,1))*(Q(j,:)*twinalpha(:,1)-f(i)+L(j,:)*(twinalpha(:,1)-alpha(:,2)));
        if tmp_alpha<0
            tmp_alpha=0;
        elseif tmp_alpha>C
            tmp_alpha=C;
        end
        twinalpha(j,1)=tmp_alpha;
    end
    alpha(:,1)=[];
    alpha=[alpha,twinalpha];
    twinalpha=alpha(:,2);    
end
bestalpha=alpha(:,2);