№1
select 
    cat,
    store,
    sum(price * qnt) as virucka,
    sum(cog * qnt) as sebestoim,
    (sum(price * qnt) - sum(cog * qnt)) / sum(price * qnt) as pribil
from  
(select 
    s.dates as date,
    c.category as cat,
    s.store as store,
    p.price as price,
    p.cog as cog,
    s.qnt as qnt
FROM sales as s
join cats as c on s.item = c.item
join prices as p on (s.store = p.store) and s.item = p.item
GROUP by c.category, s.store, p.item, s.dates
HAVING date > date('now', '-14 day')
)
GROUP by cat, store 

№2 
select 
    cat,
    store,
    sum(qnt) as cat_qnt,
    sum(price * qnt) AS virucka
from  (select 
    s.dates as date,
    c.category as cat,
    s.store as store,
    p.price as price,
    p.cog as cog,
    s.qnt as qnt
FROM sales as s
join cats as c on s.item = c.item
join prices as p on (s.store = p.store) and s.item = p.item
GROUP by c.category, s.store, p.item, s.dates
HAVING date > date('now', '-1 year'))
GROUP by cat
order by cat_qnt desc limit 5


№3
Если имеется ввиду дефицит всех товаров в магазине за день:
select 
    date,
    store,
    sum(qnt) as day_store_qnt,
    sum(stock) as day_store_stock,
    sum(price * qnt) as virucka
from  (select 
    s.dates as date,
    c.category as cat,
    s.store as store,
    p.price as price,
    s.qnt as qnt,
    s.stock as stock
FROM sales as s
join cats as c on s.item = c.item
join prices as p on s.store = p.store and s.item = p.item
GROUP by c.category, s.store, p.item, s.dates
HAVING date > date('1950-01-01'))
GROUP by date, store
having day_store_stock = 0
      
Если имеется ввиду дефицит конкретного товара в магазине за день:  
select 
    date,
    store,
    item,
    sum(qnt) as day_store_qnt,
    sum(stock) as day_store_stock,
    sum(price * qnt) as virucka
from  (select 
    s.dates as date,
    c.category as cat,
    s.store as store,
    s.item as item,
    p.price as price,
    s.qnt as qnt,
    s.stock as stock
FROM sales as s
join cats as c on s.item = c.item
join prices as p on s.store = p.store and s.item = p.item
GROUP by c.category, s.store, p.item, s.dates
HAVING date > date('1950-01-01'))
group by date, store, item
