function [tar_img] = read_gray_im(path)
    src_img = imread(path);
    if ndims(src_img) == 3
        src_img = rgb2gray(src_img);
    end
    tar_img = im2double(src_img);
end