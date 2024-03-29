function [dir]=create_dir(dir)
    if ~exist(dir,'dir')
        mkdir(dir)
    end
end