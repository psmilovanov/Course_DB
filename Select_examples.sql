use exoplanets; 

-- запросы

-- перечисление спектарльных класс звезд
select distinct sp_class from stars;

show columns in stars;

select * from planets group by parent_star_id order by count(*);

select * from planets where (mass < 0.3) and (mass > 0.01);

select * from planets where (name_in_system like '%CoRoT%');

select p.name_in_system, p.mass, p.semi_major_axis from planets as p;
select s.name, s.distance from stars as s where (s.sp_class = 'G2V');

-- ѕочему join этих запросов не удалс€ 

select p.name_in_system, p.mass, p.semi_major_axis from planets as p 
	join
select s.name, s.distance from stars as s where (s.sp_class = 'G2V') where p.parent_star_id = s.id;
