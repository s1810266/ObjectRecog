function f_question1()
    misoSoup = 'dir2imgList_result_misoSoup.mat';
    number = 'dir2imgList_result_number.mat';
    noodle = 'dir2imgList_result_noodle.mat';
    yakisoba = 'dir2imgList_result_yakisoba.mat';
    
    fprintf("比較的簡単に区別がつくもの： 味噌汁とカップ焼きそば\n");
    f_1(misoSoup, yakisoba);
    f_2(misoSoup, yakisoba);
    f_3(misoSoup, yakisoba);
    
    fprintf("比較的区別の難しいもの： カップヌードルとカップ焼きそば\n");
    f_1(noodle, yakisoba);
    f_2(noodle, yakisoba);
    f_3(noodle, yakisoba);
    
    fprintf("おまけ： 味噌汁と番号\n");
    % 元ネタ：https://cdn-ak.f.st-hatena.com/images/fotolife/m/momijitan/20181022/20181022003631.jpg
    f_1(misoSoup, number);
    f_2(misoSoup, number);
    f_3(misoSoup, number);
    
end