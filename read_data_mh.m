addpath('./mksqlite-2.5-mac');

dbid = mksqlite('open', '/Users/mhlee/Downloads/yelp_hair_reviews.db');
result = mksqlite(dbid, 'select * from reviews');


star = {result.star};
comments = {result.comments};
shop_url = {result.shop_url};


result2 = mksqlite(dbid, 'select * from shops');
city = {result2.city};
shop_url2 = {result2.url};



shop_url_high = {};
comments_high = {};
shop_url_low = {};
comments_low = {};

for index = 1:length(result)
    rate_int = str2num(star{index}(1));
    if rate_int == 5 || rate_int == 4
        comments_high{end+1} = comments{index};
        shop_url_high{end+1} = shop_url{index};
    else
        comments_low{end+1} = comments{index};
        shop_url_low{end+1} = shop_url{index};
    end
end




m = containers.Map; 
for i = 1 : length(result2)
    m(shop_url2{i}) = city{i};
end



% index=2000;
w_freq = containers.Map; 
for index = 1:2000
    if mod(index,100)==0
        fprintf('%d/%d\n', index, 2000)
    end
    city = m(shop_url{index});
    comment = comments_low{index};
    comment2=regexprep(lower(comment),'[^a-z ]','');
    C = regexp(strip(comment2),' ','split');

    [val,idxC, idxV] = unique(C);
    n = accumarray(idxV,1);


    sorted_before = [n idxC];
    sorted_after = sort(sorted_before, 1, 'descend');
    n = sorted_after(:,1);
    idxC = sorted_after(:,2);
    
    
    for i = 1:length(n)
        word = cell2mat(C(idxC(i)));
        if w_freq.isKey(word) == 0
            w_freq(word) = 0;
        end
        w_freq(word) = w_freq(word) + n(i);
    end

end


keys = w_freq.keys;
values = cell2mat(w_freq.values);
[sortedValues, sortIdx] = sort( values, 'descend' );
sortedKeys = keys( sortIdx );

for i = 1:100%length(sortIdx)
    fprintf('%d, %s\n', sortedValues(i), sortedKeys{i})
end



   

