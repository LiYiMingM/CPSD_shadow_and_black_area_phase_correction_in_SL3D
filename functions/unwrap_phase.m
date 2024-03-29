%% This file saves phase of calibration images
% 1. Create Mask By Prewitt
% 2. Solve Phases

function [] = unwrap_phase(obj_id, num_step,HIGHrLOW,CPSD_thresh,phase_root, phase_name, extension)
    %% Load Phase Imgs(Real Dataset:The image is cropped for quicker results)
    data_root = create_dir([phase_root,'\PSPImg\']);
    bg_i_root = create_dir([phase_root,'\Img\']);
    save_root = create_dir([phase_root,'\Phases\']);
    
    use_CPSD = true;
    erode = 1;
    use_CPC = 0;
    if CPSD_thresh < 0
        use_CPSD = false;
    end
    if contains(phase_root, 'Recon')
        erode = 0;
    else
        use_CPC = 1;
    end
   
    m=length(HIGHrLOW)+1;n=num_step;  %fre+steps 
    Img_total=cell(m,n);

    %% Unwrap with PSA & MF-TPU & CPSD(optional)
    for k=obj_id
        for i=1:m
            for j=1:n
                path=[data_root, num2str(k), '_', num2str(i), '_', num2str(j), extension];
                Img_total{i,j}= read_gray_im(path);
            end
        end

        % N-PS
        phi = psp_get_phase(Img_total, m, n);  % 包裹相位 
        phase_unwrapped = psp_unwrap(phi,m,HIGHrLOW);   % 绝对相位
        if use_CPSD
            mask_path = fullfile(bg_i_root,sprintf('mask_%d%s',k, extension));
            mask = CPSD(mask_path,Img_total, CPSD_thresh, erode);
            if use_CPC
                phase = CPC(phase_unwrapped, mask);
            else
                phase = phase_unwrapped .* mask;
            end
        else
            phase = phase_unwrapped;
        end
        save(fullfile(save_root, sprintf('%s_%d.mat',phase_name, k)), 'phase');   
        imwrite(mat2gray(phase),fullfile(save_root,sprintf('i_%s_%d%s',phase_name, k,extension)));    

    end

end



