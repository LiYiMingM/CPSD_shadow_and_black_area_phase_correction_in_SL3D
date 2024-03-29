function phi_unwrapped = psp_unwrap(phi,m,HIGHrLOW)
    phl = phi(:,:,1) + pi;            % 初始相位使其为0，需要对其修正
    for i=1:m-1 
        phh = phi(:,:,i+1) + pi;      % 初始相位使其为0，需要对其修正
        kh = round((HIGHrLOW(i)*phl-phh)/(2*pi));
        khlist(:,:,i) = kh;
        phl = phh + kh*2*pi;
        phllist(:,:,i) = phl;
    end
    phi_unwrapped = phl; 
end