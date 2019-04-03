addpath('./mksqlite-2.5-mac');

dbid = mksqlite('open', '/Users/mhlee/Downloads/yelp_hair_reviews.db');
result = mksqlite(dbid, 'select * from reviews');


star = {result.star};
comments = {result.comments};