function phase_compensate = CPC(phi_unwrapped_v, mask_v)
    %% Load data
    % load phase
    if size(phi_unwrapped_v, 1) == 1 % if input is mask path
        tmp =  load(phi_unwrapped_v);
        phi_unwrapped = tmp.phase_unwrapped;
    else % if input is mask
        phi_unwrapped = phi_unwrapped_v; 
    end

    % add mask
    if size(mask_v, 1) == 1
        mask_bi = imread(mask_v);
        mask_bi = logical(mask_bi);
    else
        mask_bi = mask_v;
    end
    
    %% fit surface with white regions only 
    order = 3;
    [XT, ZT] = gen_poly(phi_unwrapped, order); 
    % add mask
    indices = find(mask_bi); 
    XT_fit = XT(indices, :);
    Z = ZT(indices, :);
    % regress
    [b,~,~,~,~] = regress(Z(:),XT_fit);% regress surface with white regions only
    Ixiu=XT*b; % full parameters to get the whole plane
    phase_fit_reduced = reshape(Ixiu, size(phi_unwrapped));

    phase_compensate = phase_fit_reduced;
end


function [XT, Z] = gen_poly(phi_unwrapped, order)
    [I_row, I_col] = size(phi_unwrapped);
    [x, y] = meshgrid(1:I_row, 1:I_col);
    u = x(:);v = y(:);
    Z = phi_unwrapped(:);

    if order == 1
        XT = [ ones(size( Z(:))) v   u ];
    elseif order == 2
        u2 = u.^2;
        v2=v.^2; 
        XT = [ ones(size( Z(:))) v v2   u u.*v    u2];
    elseif order == 3
        u2 = u.^2; u3 = u.*u2 ;
        v2=v.^2; v3=v.*v2 ;
        XT = [ ones(size( Z(:))) v v2 v3   u u.*v u.*v2   u2 u2.*v u3];
    elseif order == 4
        u2 = u.^2; u3 = u.*u2 ;u4 =u.*u3;
        v2=v.^2; v3=v.*v2 ;v4 = v.*v3; 
        XT = [ ones(size( Z(:))) v v2 v3 v4    u u.*v u.*v2 u.*v3      u2 u2.*v u2.*v2      u3 u3.*v    u4 ];
    elseif order == 5
        u2 = u.^2; u3 = u.*u2 ;u4 =u.*u3; u5=u.*u4;
        v2=v.^2; v3=v.*v2 ;v4 = v.*v3; v5=v.*v4;
        XT = [ ones(size( Z(:))) v v2 v3 v4 v5    u u.*v u.*v2 u.*v3 u.*v4     u2 u2.*v u2.*v2 u2.*v3     u3 u3.*v u3.*v2   u4 u4.*v u5];
    else
        fprintf('order %s not implemented yet! Be careful of Runge effect', num2str(order));
    end    
end