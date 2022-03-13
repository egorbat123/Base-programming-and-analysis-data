Этот запрос выдаёт неверный ответ. Я намеренно уделил мало времени для SQL, чтобы для начала получить хотя бы базовое представление о нём.
Поэтому, пока что, у меня не достаточно опыта для решения подобных задач.

№1
select 
	cat,
    store,
    price,
    qnt,
	price * qnt as viruc_by_item
from  (select 
	s.dates as date,
	c.category as cat,
    s.store as store,
    p.price as price,
    s.qnt as qnt
FROM sales as s
join cats as c on s.item = c.item
join prices as p on (s.store = p.store) and s.item = p.item
GROUP by c.category, s.store, p.item, s.dates
HAVING date > date('now', '-14 day'))

