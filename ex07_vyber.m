% funkce zobrazi vstupni obraz IMG a vyzve uzivatele k vybrani rohu
% pro vyber obrazu. Po kontrole spravnosti zadani rohu vybere pouze 
% danou cast obrazu a vrati ji v promenne CROP


function [crop] = ex07_vyber(img)

imshow(img);
[h w d] = size(img);

run = true;
while(run)
    run = false;
    title('Select LEFT TOP corner');
    p1 = round(ginput(1));
    
    if(p1(1) < 0 || p1(1) > w || p1(2) < 0 || p1(2) > h)
        run = true;
        title('Failed, please try again. Select LEFT TOP corner');
    end;
end;

run = true;
while(run)
    run = false;
    title('Select RIGHT BOTTOM corner');
    p2 = round(ginput(1));
    
    if(p2(1) < 0 || p2(1) > w || p2(2) < 0 || p2(2) > h)
        run = true;
        title('Failed, please try again. Select RIGHT BOTTOM corner');
    end;    
end;

if(p1(1) > p2(1))
    tmp =  p1(1);
    p1(1) = p2(1);
    p2(1) = tmp;
end;

if(p1(2) > p2(2))
    tmp =  p1(2);
    p1(2) = p2(2);
    p2(2) = tmp;
end;

crop = img(p1(2):p2(2),p1(1):p2(1));






