addpath('./mksqlite-2.5-mac');

dbid = mksqlite('open', '/Users/mhlee/Downloads/yelp_hair_reviews.db');
result = mksqlite(dbid, 'select * from reviews');


star = {result.star};
comments = {result.comments};
shop_url = {result.shop_url};


result2 = mksqlite(dbid, 'select * from shops');
city = {result2.city};
shop_url2 = {result2.url};


m = containers.Map; 
for i = 1 : length(result2)
    m(shop_url2{i}) = city{i};
end


m(shop_url{5000})
m(shop_url{500011})



    

