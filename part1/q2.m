folder='assignment4/dataset';
AllFiles=dir(folder);
allname={AllFiles(3:522).name}.';
paths=strcat(folder,'/',allname);
faces=uint8(ones(256,256,3,520));
for i = 1:520
    a=imread(paths{i});
    faces(:,:,:,i)=a;
end