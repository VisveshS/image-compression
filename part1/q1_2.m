im=imread('assignment4/LAKE.TIF');
Q =[16 11 10 16 24 40 51 61; 
    12 12 14 19 26 58 60 55;
    14 13 16 24 40 57 69 56; 
    14 17 22 29 51 87 80 62;
    18 22 37 56 68 109 103 77;
    24 35 55 64 81 104 113 92;
    49 64 78 87 103 121 120 101;
    72 92 95 98 112 100 103 99];

c=2;% compression factor
square=ones(8,8,3);

square(1:8,1:8,1)=uint8(im(420:427,45:52));
square(1:8,1:8,2)=uint8(im(427:434,298:305));
square(1:8,1:8,3)=uint8(im(30:37,230:237));

DCT=square-127;
DCTQ=square-127;
DCTR=square-127;

for i = 1:3
    DCT(:,:,i)=dct2(DCT(:,:,i));
    DCTQ(:,:,i)=near(DCT(:,:,i)./(Q*c));
    DCTQ(:,:,i)=DCTQ(:,:,i).*(Q*c);
    DCTR(:,:,i)=idct2(DCTQ(:,:,i))+127;
end

square=uint8(square);
DCTR=uint8(DCTR);

subplot(3,2,1), imshow(square(:,:,1));      subplot(3,2,2), imshow(DCTR(:,:,1));
subplot(3,2,3), imshow(square(:,:,2));      subplot(3,2,4), imshow(DCTR(:,:,2));
subplot(3,2,5), imshow(square(:,:,3));      subplot(3,2,6), imshow(DCTR(:,:,3));

function [Near] = near(val)
    Near = floor(2*val) - floor(val);
end