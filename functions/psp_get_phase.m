function phi = psp_get_phase(Img_total, m, n)
    for i=1:m
        numerator=0;
        denominator=0;
        for j=1:n
            numerator=numerator+Img_total{i,j}*sin(2*(j-1)*pi/n);
            denominator=denominator+Img_total{i,j}*cos(2*(j-1)*pi/n);
        end
        phi(:,:,i)=-atan2(numerator,denominator);
    end
end