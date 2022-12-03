a = create_mat_dct();
b = dctmtx(8);
Q =[16 11 10 16 24 40 51 61; 
    12 12 14 19 26 58 60 55;
    14 13 16 24 40 57 69 56; 
    14 17 22 29 51 87 80 62;
    18 22 37 56 68 109 103 77;
    24 35 55 64 81 104 113 92;
    49 64 78 87 103 121 120 101;
    72 92 95 98 112 100 103 99];
difference=sum(sum(abs(a-b)))
im=imread('assignment4/LAKE.TIF');
im=double(im);
imdct=myDCT(im(1:8,1:8),b)
imidct=myIDCT(imdct,b)
imdctq=myDCT_quantization(imdct,Q,2)
imdctdq=myDCT_dequantization(imdctq,Q,2)
rmse=RMSE(im(1:8,1:8),im(9:16,9:16))
entropy=My_entropy(im)

function [dct_matrix] = create_mat_dct()
    [u,v]=meshgrid(0:7,0:7);
    u=2*u+1;
    dct_matrix=v.*u;
    dct_matrix=pi*dct_matrix/16;
    dct_matrix=cos(dct_matrix);
    dct_matrix=dct_matrix./2;
    dct_matrix(1,:)=dct_matrix(1,:)./sqrt(2);
end

function [DCT] = myDCT(im,F)
    DCT=F*im*F';
end

function [IDCT] = myIDCT(im,F)
    IDCT=F'*im*F;
end

function [DCTQ] =myDCT_quantization(imDCT, qm, c)
    DCTQ=round(imDCT./(qm*c));
end

function [DCTQ] =myDCT_dequantization(imDCT, qm, c)
    DCTQ=round(imDCT.*(qm*c));
end

function [rmse] = RMSE(im1,im2)
    rmse=im1-im2;
    rmse=rmse.*rmse;
    rmse=rmse/(size(rmse,1)*size(rmse,2));
    rmse=sum(sum(rmse));
    rmse=sqrt(rmse);
end

function [x] = My_entropy(im);
    x=imhist(im);
    ifzero=x==0;
    x(ifzero)=[];
    x=x.*log2(x);
    x=-sum(x);
end