drop database if exists exoplanets;
create database exoplanets;

use exoplanets; 

drop table if exists star_systems;
create table star_systems(
	id SERIAL primary key,
	name varchar(50), -- Ќаименование
	multiplicity TINYINT unsigned	--  ратность
	-- тип кратности
	
		
);

drop table if exists stars;
create table stars (
	id SERIAL primary key,
	name VARCHAR(36) CHARACTER SET utf8, -- Ќаименование
	distance decimal (7,2), -- –ассто€ние в парсеках 
	sp_class varchar(11),-- спектральный класс
	apparent_magnitude decimal (4,2), -- видима€ звездна€ величина
	mass decimal (6,3), -- масса в массах —олнца
	-- возраст
	effective_temperature decimal (7,1), -- эффективна€ температура в  
	radius decimal (7,3), -- радиус в радиусах —олнца
	metallicity decimal (3,2), -- металличность [Fe/H]
	-- пр€мое восхождение RA 
	-- склонение  
	planet_system_num tinyint unsigned, -- количество планет в системе
	simbad_link varchar(255) -- линк на базу данных SIMBAD
	-- ,star_system_id bigint unsigned not null
	-- ,foreign key (star_system_id) references star_systems (id)
);	

drop table if exists planets;
create table planets (
	id SERIAL primary key,
	parent_star_id bigint unsigned not null,
	name_in_system char(50),	-- наименование в системе
	planet_status bool, -- подтвержденный статус/кандидат
	discovered_in year, -- год открыти€
	mass decimal (8,6), -- масса в массах ёпитера
	-- mass_sin_i
	semi_major_axis decimal (8,3), -- больша€ полусь в ае
	orbital_period decimal (10,5), -- орбитальный период в дн€х
	eccentricity decimal (3,2), -- экцентриситет
	update_date date, -- дата обновлени€
	-- detection_method enum ('radial velocity', 'transit'), -- метод обнаружени€
	-- mass_detection_method enum ('radial velocity', 'another') -- метод обнаружени€ массы
	habitable_zone bool, -- зона обитаемости да/нет
	foreign key (parent_star_id) references stars(id)
);

drop table if exists missions;
create table missions (
	id int unsigned not null auto_increment unique primary key,
	mission_name varchar(20),
	url_link varchar(255),
	start_date date, -- начало миссии
	end_date date, -- окончание миссии
	mission_method enum ('radial velocity', 'transit', 'microlensing', 'TTV', 'imaging', 'astrometry') -- метод миссии
);

drop table if exists articles;
create table articles (
	id int unsigned not null auto_increment unique primary key,
	author_list varchar(255),
	name varchar(255),
	publish_date date,
	url_link varchar(255)
);

drop table if exists planets_article;
create table planets_article(
	planet_id bigint unsigned not null,
	article_id int unsigned not null,
	
	primary key (planet_id, article_id),
	
	foreign key (planet_id) references planets(id),
	foreign key (article_id) references articles(id)
);

drop table if exists mission_planets;
create table mission_planets(

	mission_id int unsigned not null,
	planet_id bigint unsigned not null,
	
	primary key (mission_id, planet_id),
	
	foreign key (planet_id) references planets(id),
	foreign key (mission_id) references missions(id)
);

drop table if exists mission_articles;
create table mission_articles(
	mission_id int unsigned not null,
	article_id int unsigned not null,
	
	primary key (mission_id, article_id),
	
	foreign key (mission_id) references missions(id),
	foreign key (article_id) references articles(id)
);

drop table if exists atmospheric_parametrs;
create table atmospheric_parametrs(
	id serial primary key,
	molecul_type enum ('C2', 'CN', 'O2', 'OH', 'CH'),
	result_value float,
	
	foreign key (id) references planets(id)
);

drop table if exists atmospheric_parametrs_missions;
create table atmospheric_parametrs_missions(

	atmospheric_parametr_id bigint unsigned not null,
	mission_id int unsigned not null,
	
	primary key (atmospheric_parametr_id, mission_id),
	
	foreign key (atmospheric_parametr_id) references atmospheric_parametrs(id),
	foreign key (mission_id) references missions(id)
);

drop table if exists atmospheric_parametrs_articles;
create table atmospheric_parametrs_articles(
	
	atmospheric_parametr_id bigint unsigned not null,
	article_id int unsigned not null,
	
	primary key (atmospheric_parametr_id, article_id),
	
	foreign key (atmospheric_parametr_id) references atmospheric_parametrs(id),
	foreign key (article_id) references articles(id)
);


drop table if exists planets_full;
CREATE TABLE planets_full (
	
    `name` VARCHAR(38) CHARACTER SET utf8,
    `planet_status` VARCHAR(9) CHARACTER SET utf8,
    `mass` NUMERIC(17, 14),
    `mass_error_min` NUMERIC(17, 14),
    `mass_error_max` NUMERIC(17, 14),
    `mass_sini` NUMERIC(15, 13),
    `mass_sini_error_min` NUMERIC(12, 10),
    `mass_sini_error_max` NUMERIC(11, 9),
    `radius` NUMERIC(17, 14),
    `radius_error_min` NUMERIC(15, 14),
    `radius_error_max` NUMERIC(15, 14),
    `orbital_period` NUMERIC(17, 11),
    `orbital_period_error_min` NUMERIC(17, 11),
    `orbital_period_error_max` NUMERIC(17, 11),
    `semi_major_axis` NUMERIC(13, 9),
    `semi_major_axis_error_min` NUMERIC(10, 7),
    `semi_major_axis_error_max` NUMERIC(10, 7),
    `eccentricity` NUMERIC(6, 5),
    `eccentricity_error_min` NUMERIC(8, 5),
    `eccentricity_error_max` NUMERIC(8, 5),
    `inclination` NUMERIC(12, 9),
    `inclination_error_min` NUMERIC(7, 4),
    `inclination_error_max` NUMERIC(6, 4),
    `angular_distance` NUMERIC(9, 6),
    `discovered` INT,
    `updated` DATETIME,
    `omega` NUMERIC(7, 4),
    `omega_error_min` NUMERIC(7, 4),
    `omega_error_max` NUMERIC(7, 4),
    `tperi` NUMERIC(14, 7),
    `tperi_error_min` NUMERIC(10, 6),
    `tperi_error_max` NUMERIC(10, 6),
    `tconj` NUMERIC(12, 5),
    `tconj_error_min` NUMERIC(7, 5),
    `tconj_error_max` NUMERIC(7, 5),
    `tzero_tr` NUMERIC(14, 7),
    `tzero_tr_error_min` NUMERIC(14, 7),
    `tzero_tr_error_max` NUMERIC(14, 7),
    `tzero_tr_sec` NUMERIC(12, 5),
    `tzero_tr_sec_error_min` NUMERIC(6, 5),
    `tzero_tr_sec_error_max` NUMERIC(6, 5),
    `lambda_angle` NUMERIC(6, 3),
    `lambda_angle_error_min` NUMERIC(5, 3),
    `lambda_angle_error_max` NUMERIC(5, 3),
    `impact_parameter` NUMERIC(5, 4),
    `impact_parameter_error_min` NUMERIC(5, 4),
    `impact_parameter_error_max` NUMERIC(6, 4),
    `tzero_vr` NUMERIC(12, 4),
    `tzero_vr_error_min` NUMERIC(6, 4),
    `tzero_vr_error_max` NUMERIC(6, 4),
    `k` NUMERIC(11, 5),
    `k_error_min` NUMERIC(11, 5),
    `k_error_max` NUMERIC(11, 5),
    `temp_calculated` NUMERIC(6, 2),
    `temp_calculated_error_min` NUMERIC(5, 1),
    `temp_calculated_error_max` NUMERIC(4, 1),
    `temp_measured` NUMERIC(5, 1),
    `hot_point_lon` NUMERIC(4, 1),
    `geometric_albedo` NUMERIC(4, 3),
    `geometric_albedo_error_min` NUMERIC(4, 3),
    `geometric_albedo_error_max` NUMERIC(4, 3),
    `log_g` NUMERIC(4, 3),
    `publication` VARCHAR(38) CHARACTER SET utf8,
    `detection_type` VARCHAR(20) CHARACTER SET utf8,
    `mass_detection_type` VARCHAR(15) CHARACTER SET utf8,
    `radius_detection_type` VARCHAR(15) CHARACTER SET utf8,
    `alternate_names` VARCHAR(113) CHARACTER SET utf8,
    `molecules` VARCHAR(79) CHARACTER SET utf8,
    `star_name` VARCHAR(36) CHARACTER SET utf8,
    `ra` NUMERIC(16, 13),
    `dec` NUMERIC(16, 14),
    `mag_v` NUMERIC(6, 4),
    `mag_i` NUMERIC(5, 3),
    `mag_j` NUMERIC(5, 3),
    `mag_h` NUMERIC(5, 3),
    `mag_k` NUMERIC(5, 3),
    `star_distance` NUMERIC(9, 4),
    `star_distance_error_min` NUMERIC(9, 5),
    `star_distance_error_max` NUMERIC(9, 5),
    `star_metallicity` NUMERIC(5, 4),
    `star_metallicity_error_min` NUMERIC(4, 3),
    `star_metallicity_error_max` NUMERIC(4, 3),
    `star_mass` NUMERIC(7, 5),
    `star_mass_error_min` NUMERIC(6, 4),
    `star_mass_error_max` NUMERIC(6, 4),
    `star_radius` NUMERIC(6, 4),
    `star_radius_error_min` NUMERIC(6, 4),
    `star_radius_error_max` NUMERIC(7, 4),
    `star_sp_type` VARCHAR(11) CHARACTER SET utf8,
    `star_age` NUMERIC(6, 4),
    `star_age_error_min` NUMERIC(6, 4),
    `star_age_error_max` NUMERIC(6, 4),
    `star_teff` NUMERIC(7, 2),
    `star_teff_error_min` NUMERIC(6, 2),
    `star_teff_error_max` NUMERIC(6, 2),
    `star_detected_disc` VARCHAR(9) CHARACTER SET utf8,
    `star_magnetic_field` VARCHAR(3) CHARACTER SET utf8,
    `star_alternate_names` VARCHAR(72) CHARACTER SET utf8
);