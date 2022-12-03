D=dir('dataset');
X=uint8(zeros(520,16*16*3));
for k=3:length(D)
   temp=imread("dataset/"+D(k).name);
   temp=imresize(temp,1/16);
   X(k-2,:)=temp(:);
end
X=double(X);
A=X'*X;
[V,D]=eig(A);
[V,D]=SortEigen(V,D);
Y=X*V(:,1:35);
V1=V(:,1:35);
V1=pinv(V1);
Z=Y*V1;

Xi=reshape(X(153,:),16,16,3);
Xo=reshape(Z(153,:),16,16,3);
Xo=uint8(Xo);
Xi=uint8(Xi);
imshowpair(Xo,Xi,'montage');

function [P2,D2]=SortEigen(P,D)
    D2=diag(sort(diag(D),'descend'));
    [c, ind]=sort(diag(D),'descend');
    P2=P(:,ind);
end