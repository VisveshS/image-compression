im=imread('assignment4/LAKE.TIF');
Q =[16 11 10 16 24 40 51 61; 
    12 12 14 19 26 58 60 55;
    14 13 16 24 40 57 69 56; 
    14 17 22 29 51 87 80 62;
    18 22 37 56 68 109 103 77;
    24 35 55 64 81 104 113 92;
    49 64 78 87 103 121 120 101;
    72 92 95 98 112 100 103 99];
RMSE=[]
ENTROPY=[]
for c =1:10
    im=double(im);
    blocks=im2col(im,[8 8],'distinct');
    blocks=double(blocks);
    
    blocks=reshape(blocks,[8,8,4096]);
    all_blocks_dct=blocks;
    for i = 1:size(blocks,3)
        all_blocks_dct(:,:,i)=dct2(blocks(:,:,i));
        all_blocks_dct(:,:,i)=near(all_blocks_dct(:,:,i)./(Q*c)).*Q*c;
        all_blocks_dct(:,:,i)=idct2(all_blocks_dct(:,:,i));
    end
    all_blocks_dct=all_blocks_dct;
    all_blocks_dct=reshape(all_blocks_dct,[64 4096]);
    all_blocks_dct=col2im(all_blocks_dct,[8 8],[512 512],'distinct');
    
    rmse=all_blocks_dct-im;
    rmse=rmse.*rmse;
    rmse=sum(rmse);rmse=sum(rmse);
    rmse/(512*512);
    RMSE(c)=sqrt(rmse);
    ENTROPY(c)=My_entropy(all_blocks_dct);
end
subplot(2,1,1);
title('RMSE vs compression factor');
plot(RMSE);
subplot(2,1,2);
title('ENTROPY vs compression factor');
plot(ENTROPY);
function [x] = My_entropy(im);
    x=imhist(im);
    ifzero=x==0;
    x(ifzero)=[];
    x=x.*log2(x);
    x=-sum(x);
end
function [Near] = near(val)
    Near = floor(2*val) - floor(val);
end