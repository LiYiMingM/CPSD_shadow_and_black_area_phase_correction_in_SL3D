clc
clear all

%CPSD_thresh  %Represents the threshold of the CPSD method;
%obj_id% Represents the number of the object is 1;

%the parameters need to be adjusted
obj_id=17;%the object --1,the calibration plane-- 17
phase_root='test_data_calibration_plane';%  grating data and file saving path  ;
                                         %  the object--%the object  the     %  calibration plane---'test_data_calibration_plane'


%%%choose run the CPSD or CPC
use_CPSD = 1;% if False, run the traditional multiply frequency temporal phase unwrapping method

use_CPC = 1;%if use_CPSD = 1 and use_CPC = 0, means that only use the CPSD, rather than CPC. Note that CPC is used for calibration
            %%if use_CPSD = 1 and use_CPC = 1, means that use the  CPC.
%%%%set parameters

num_step=12;% Represents the step of phase shifts is 12;
HIGHrLOW=[4,4,4];% Represents the frequency ratio between adjacent frequencies in Multi-frequency temporal phase unwrapping algorithm ;

phase_name='phase';%Phase name corrected by the CPSD method
extension='.bmp';


%%%add the path of function subfolder 
subfolder_path = fullfile(pwd,'functions');
addpath(subfolder_path)

%%%%path

     data_root = create_dir([phase_root,'\PSPImg\']);

    mask_save_toot = create_dir([phase_root,'\mask_Img\']);
    save_root = create_dir([phase_root,'\Phases\']);



    
%phase unwrapping
    m=length(HIGHrLOW)+1;n=num_step;  %fre+steps 
    Img_total=cell(m,n);

%Unwrap with PSA & MF-TPU & CPSD(optional)
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
 %%%save the traditional method's phase before correction
        save(fullfile(save_root, sprintf('%s_before_%d.mat',phase_name, k)), 'phase_unwrapped');   
        imwrite(mat2gray(phase_unwrapped),fullfile(save_root,sprintf('%s_before_%d%s',phase_name,k,extension)));     
%         phase_ori=phase_unwrapped;
        if use_CPSD
            mask_path = fullfile(mask_save_toot,sprintf('mask_%d%s',k, extension));

            if use_CPC
               
                CPSD_thresh=0.3;
                mask = CPSD(mask_path,Img_total, CPSD_thresh, 1);%    erode = 1 means that the erosion operation is enabled.
                phase = CPC(phase_unwrapped, mask);
%                 phase_CPC=phase;
            else
               
                CPSD_thresh=0.12;
                mask = CPSD(mask_path,Img_total, CPSD_thresh, 0);%     erode = 0 means that the erosion operation is banned.
                phase = phase_unwrapped .* mask;
%                 phase_CPSD=phase;
            end
        else
            phase = phase_unwrapped;

        end
        save(fullfile(save_root, sprintf('%s_after_correction_%d.mat',phase_name, k)), 'phase');   
        imwrite(mat2gray(phase),fullfile(save_root,sprintf('%s_after_correction_%d%s',phase_name, k,extension)));    

    end
