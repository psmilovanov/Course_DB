use exoplanets; 

-- скрипт заполнения таблиц stars и planets

show columns from planets_full;
select * from planets_full;

select distinct star_name, star_distance, star_mass, star_sp_type, star_metallicity from planets_full;
select * from stars;

insert into stars (name, distance, mass, sp_class, metallicity) select star_name, star_distance, star_mass, star_sp_type, star_metallicity from planets_full ;

select * from stars order by name desc;

-- JOIN таблиц stars и planets_full

select s.id, pf.name, pf.mass, pf.discovered, pf.semi_major_axis, pf.orbital_period, pf.eccentricity, pf.updated
	from stars as s join planets_full as pf where s.name = pf.star_name; 

show columns from planets;

insert into planets(parent_star_id, name_in_system, mass, discovered_in, semi_major_axis, eccentricity, update_date )
	select s.id, pf.name, pf.mass, pf.discovered, pf.semi_major_axis, pf.eccentricity, pf.updated from stars as s join planets_full as pf where s.name = pf.star_name;

