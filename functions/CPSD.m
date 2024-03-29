function mask = CPSD(mask_p,Img_total, thresh, erode)
    overwrite = 1;
    if exist(mask_p, 'file') && (~overwrite)
        mask = imread(mask_p);
    else
        steps = size(Img_total,2);
        mask = zeros(size(Img_total{1,1}));
        for d=1:floor((steps+1)/2)
             for j=1:steps
               mask=max(mask,abs(Img_total{1,d}-Img_total{1,j})); %(4,12)
             end
        end
        mask = imbinarize(mask, thresh);
        if erode == 1
            se = strel('disk',3);
            mask = imerode(mask,se);
        end
        
        imwrite(mask,mask_p);  
    end
end