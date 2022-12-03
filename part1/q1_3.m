im=imread('assignment4/LAKE.TIF');
Q =[16 11 10 16 24 40 51 61; 
    12 12 14 19 26 58 60 55;
    14 13 16 24 40 57 69 56; 
    14 17 22 29 51 87 80 62;
    18 22 37 56 68 109 103 77;
    24 35 55 64 81 104 113 92;
    49 64 78 87 103 121 120 101;
    72 92 95 98 112 100 103 99];
im=double(im);
blocks=im2col(im,[8 8],'distinct');
blocks=double(blocks);
all_blocks=blocks-127;

all_blocks=reshape(blocks,[8,8,4096]);
all_blocks_dct=all_blocks;
for i = 1:size(all_blocks,3)
    all_blocks_dct(:,:,i)=dct2(all_blocks(:,:,i));
    all_blocks_dct(:,:,i)=round(all_blocks_dct(:,:,i)./Q);
end
all_blocks_dct=reshape(all_blocks_dct,[64 4096]);
all_blocks_dct=col2im(all_blocks_dct,[8 8],[512 512],'distinct');

imshowpair(uint8(im),uint8(all_blocks_dct),'montage');

function [Near] = near(val)
    Near = floor(2*val) - floor(val);
end