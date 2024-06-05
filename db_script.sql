-- certificate definition

-- Drop table

-- DROP TABLE certificate;

CREATE TABLE certificate (
	id int8 GENERATED BY DEFAULT AS IDENTITY( INCREMENT BY 1 MINVALUE 1 MAXVALUE 9223372036854775807 START 1 CACHE 1 NO CYCLE) NOT NULL,
	description varchar(255) NULL,
	"name" varchar(255) NULL,
	CONSTRAINT certificate_pkey PRIMARY KEY (id)
);


-- client definition

-- Drop table

-- DROP TABLE client;

CREATE TABLE client (
	id int8 GENERATED BY DEFAULT AS IDENTITY( INCREMENT BY 1 MINVALUE 1 MAXVALUE 9223372036854775807 START 1 CACHE 1 NO CYCLE) NOT NULL,
	"name" varchar(255) NULL,
	CONSTRAINT client_pkey PRIMARY KEY (id)
);


-- country definition

-- Drop table

-- DROP TABLE country;

CREATE TABLE country (
	id int8 GENERATED BY DEFAULT AS IDENTITY( INCREMENT BY 1 MINVALUE 1 MAXVALUE 9223372036854775807 START 1 CACHE 1 NO CYCLE) NOT NULL,
	"name" varchar(255) NULL,
	nationality_name varchar(255) NULL,
	CONSTRAINT country_pkey PRIMARY KEY (id)
);


-- employer definition

-- Drop table

-- DROP TABLE employer;

CREATE TABLE employer (
	id int8 GENERATED BY DEFAULT AS IDENTITY( INCREMENT BY 1 MINVALUE 1 MAXVALUE 9223372036854775807 START 1 CACHE 1 NO CYCLE) NOT NULL,
	"name" varchar(255) NULL,
	CONSTRAINT employer_pkey PRIMARY KEY (id)
);


-- experience_type definition

-- Drop table

-- DROP TABLE experience_type;

CREATE TABLE experience_type (
	id int8 GENERATED BY DEFAULT AS IDENTITY( INCREMENT BY 1 MINVALUE 1 MAXVALUE 9223372036854775807 START 1 CACHE 1 NO CYCLE) NOT NULL,
	"name" varchar(255) NULL,
	CONSTRAINT experience_type_pkey PRIMARY KEY (id)
);


-- "language" definition

-- Drop table

-- DROP TABLE "language";

CREATE TABLE "language" (
	id int8 GENERATED BY DEFAULT AS IDENTITY( INCREMENT BY 1 MINVALUE 1 MAXVALUE 9223372036854775807 START 1 CACHE 1 NO CYCLE) NOT NULL,
	language_code varchar(255) NULL,
	CONSTRAINT language_pkey PRIMARY KEY (id)
);


-- project definition

-- Drop table

-- DROP TABLE project;

CREATE TABLE project (
	id int8 GENERATED BY DEFAULT AS IDENTITY( INCREMENT BY 1 MINVALUE 1 MAXVALUE 9223372036854775807 START 1 CACHE 1 NO CYCLE) NOT NULL,
	description varchar(255) NULL,
	"name" varchar(255) NULL,
	CONSTRAINT project_pkey PRIMARY KEY (id)
);


-- sector definition

-- Drop table

-- DROP TABLE sector;

CREATE TABLE sector (
	id int8 GENERATED BY DEFAULT AS IDENTITY( INCREMENT BY 1 MINVALUE 1 MAXVALUE 9223372036854775807 START 1 CACHE 1 NO CYCLE) NOT NULL,
	description varchar(255) NULL,
	"name" varchar(255) NULL,
	CONSTRAINT sector_pkey PRIMARY KEY (id)
);


-- city definition

-- Drop table

-- DROP TABLE city;

CREATE TABLE city (
	id int8 GENERATED BY DEFAULT AS IDENTITY( INCREMENT BY 1 MINVALUE 1 MAXVALUE 9223372036854775807 START 1 CACHE 1 NO CYCLE) NOT NULL,
	"name" varchar(255) NOT NULL,
	country_id int8 NULL,
	CONSTRAINT city_pkey PRIMARY KEY (id),
	CONSTRAINT fklrebnlrl8vmsv1ptjnkl3qm59 FOREIGN KEY (country_id) REFERENCES country(id)
);


-- institution definition

-- Drop table

-- DROP TABLE institution;

CREATE TABLE institution (
	id int8 GENERATED BY DEFAULT AS IDENTITY( INCREMENT BY 1 MINVALUE 1 MAXVALUE 9223372036854775807 START 1 CACHE 1 NO CYCLE) NOT NULL,
	"name" varchar(255) NULL,
	city_id int8 NULL,
	CONSTRAINT institution_pkey PRIMARY KEY (id),
	CONSTRAINT fk8k6b43px8qjym7gj1q20a09u5 FOREIGN KEY (city_id) REFERENCES city(id)
);


-- address definition

-- Drop table

-- DROP TABLE address;

CREATE TABLE address (
	id int8 GENERATED BY DEFAULT AS IDENTITY( INCREMENT BY 1 MINVALUE 1 MAXVALUE 9223372036854775807 START 1 CACHE 1 NO CYCLE) NOT NULL,
	address_description varchar(255) NULL,
	postal_code int4 NULL,
	city_id int8 NULL,
	CONSTRAINT address_pkey PRIMARY KEY (id),
	CONSTRAINT fkegbwyn4v2jm3jby0iakvds8sk FOREIGN KEY (city_id) REFERENCES city(id)
);


-- "degree" definition

-- Drop table

-- DROP TABLE "degree";

CREATE TABLE "degree" (
	id int8 GENERATED BY DEFAULT AS IDENTITY( INCREMENT BY 1 MINVALUE 1 MAXVALUE 9223372036854775807 START 1 CACHE 1 NO CYCLE) NOT NULL,
	title varchar(255) NULL,
	institution_id int8 NULL,
	CONSTRAINT degree_pkey PRIMARY KEY (id),
	CONSTRAINT fk2pva1bwm5v6rc76p7b64ssrhl FOREIGN KEY (institution_id) REFERENCES institution(id)
);


-- education definition

-- Drop table

-- DROP TABLE education;

CREATE TABLE education (
	id int8 GENERATED BY DEFAULT AS IDENTITY( INCREMENT BY 1 MINVALUE 1 MAXVALUE 9223372036854775807 START 1 CACHE 1 NO CYCLE) NOT NULL,
	end_date date NULL,
	start_date date NULL,
	degree_id int8 NULL,
	sector_id int8 NULL,
	CONSTRAINT education_pkey PRIMARY KEY (id),
	CONSTRAINT ukiga1gx49nt7p7f7tmphbohhjp UNIQUE (degree_id),
	CONSTRAINT fkhibkd2y0vf01jpdj3db0t27tk FOREIGN KEY (degree_id) REFERENCES "degree"(id),
	CONSTRAINT fkq6ntu83qyv7gcuy4a5byus0x5 FOREIGN KEY (sector_id) REFERENCES sector(id)
);


-- resume definition

-- Drop table

-- DROP TABLE resume;

CREATE TABLE resume (
	id int8 GENERATED BY DEFAULT AS IDENTITY( INCREMENT BY 1 MINVALUE 1 MAXVALUE 9223372036854775807 START 1 CACHE 1 NO CYCLE) NOT NULL,
	it_career_start_date date NULL,
	birth_date date NULL,
	email varchar(255) NULL,
	family_name varchar(255) NULL,
	formatted_name varchar(255) NULL,
	given_name varchar(255) NULL,
	phone_number varchar(255) NULL,
	summary varchar(255) NULL,
	address_id int8 NULL,
	nationality_id int8 NULL,
	primary_language_id int8 NULL,
	CONSTRAINT resume_pkey PRIMARY KEY (id),
	CONSTRAINT fk2cdqh2iru9c9hk8vuk0sl14ct FOREIGN KEY (address_id) REFERENCES address(id),
	CONSTRAINT fk30dt7s7f6t7861vd3r01o48lt FOREIGN KEY (nationality_id) REFERENCES country(id),
	CONSTRAINT fk8ehnr8ev4u9wdc3wfinjsp143 FOREIGN KEY (primary_language_id) REFERENCES "language"(id)
);


-- resume_certificate definition

-- Drop table

-- DROP TABLE resume_certificate;

CREATE TABLE resume_certificate (
	resume_id int8 NOT NULL,
	certificates_id int8 NOT NULL,
	CONSTRAINT resume_certificate_pkey PRIMARY KEY (resume_id, certificates_id),
	CONSTRAINT fkgsbpj1kij3yooekhl0kamc8lg FOREIGN KEY (certificates_id) REFERENCES certificate(id),
	CONSTRAINT fkjcfr5nfgtyrt99n0en1qwhqt8 FOREIGN KEY (resume_id) REFERENCES resume(id)
);


-- resume_educations definition

-- Drop table

-- DROP TABLE resume_educations;

CREATE TABLE resume_educations (
	resume_id int8 NOT NULL,
	educations_id int8 NOT NULL,
	CONSTRAINT resume_educations_pkey PRIMARY KEY (resume_id, educations_id),
	CONSTRAINT fkhk3u41f26rg7w38py72e4xcic FOREIGN KEY (educations_id) REFERENCES education(id),
	CONSTRAINT fkrvl8yoymmps9p9f47jvrtkljo FOREIGN KEY (resume_id) REFERENCES resume(id)
);


-- skill definition

-- Drop table

-- DROP TABLE skill;

CREATE TABLE skill (
	id int8 GENERATED BY DEFAULT AS IDENTITY( INCREMENT BY 1 MINVALUE 1 MAXVALUE 9223372036854775807 START 1 CACHE 1 NO CYCLE) NOT NULL,
	description varchar(255) NULL,
	resume_id int8 NULL,
	CONSTRAINT skill_pkey PRIMARY KEY (id),
	CONSTRAINT fkhcgmj76olyrh7o6oji6o88jwb FOREIGN KEY (resume_id) REFERENCES resume(id)
);


-- experience definition

-- Drop table

-- DROP TABLE experience;

CREATE TABLE experience (
	id int8 GENERATED BY DEFAULT AS IDENTITY( INCREMENT BY 1 MINVALUE 1 MAXVALUE 9223372036854775807 START 1 CACHE 1 NO CYCLE) NOT NULL,
	description varchar(255) NULL,
	end_date date NULL,
	start_date date NULL,
	title varchar(255) NULL,
	city_id int8 NULL,
	client_id int8 NULL,
	employer_id int8 NULL,
	experience_type_id int8 NULL,
	project_id int8 NULL,
	resume_id int8 NULL,
	CONSTRAINT experience_pkey PRIMARY KEY (id),
	CONSTRAINT fk86fdydlg8mapxm1ktnkjjlwbc FOREIGN KEY (city_id) REFERENCES city(id),
	CONSTRAINT fka6mcweg0298qwoic02l8yef9b FOREIGN KEY (resume_id) REFERENCES resume(id),
	CONSTRAINT fkdi84veexk3tls050myvhfduxi FOREIGN KEY (employer_id) REFERENCES employer(id),
	CONSTRAINT fkhfdor24m1nk87ixefhvk4vxm7 FOREIGN KEY (project_id) REFERENCES project(id),
	CONSTRAINT fkjv8aqd586c0sqay3mwsmq9cv FOREIGN KEY (experience_type_id) REFERENCES experience_type(id),
	CONSTRAINT fkn8rrm6ip3pvxj4f04d34y1u4o FOREIGN KEY (client_id) REFERENCES client(id)
);


-- language_proficiency definition

-- Drop table

-- DROP TABLE language_proficiency;

CREATE TABLE language_proficiency (
	id int8 GENERATED BY DEFAULT AS IDENTITY( INCREMENT BY 1 MINVALUE 1 MAXVALUE 9223372036854775807 START 1 CACHE 1 NO CYCLE) NOT NULL,
	interaction_level varchar(255) NULL,
	production_level varchar(255) NULL,
	listening_level varchar(255) NULL,
	reading_level varchar(255) NULL,
	writing_level varchar(255) NULL,
	language_id int8 NULL,
	resume_id int8 NULL,
	CONSTRAINT language_proficiency_interaction_level_check CHECK (((interaction_level)::text = ANY ((ARRAY['A1'::character varying, 'A2'::character varying, 'B1'::character varying, 'B2'::character varying, 'C1'::character varying, 'C2'::character varying])::text[]))),
	CONSTRAINT language_proficiency_listening_level_check CHECK (((listening_level)::text = ANY ((ARRAY['A1'::character varying, 'A2'::character varying, 'B1'::character varying, 'B2'::character varying, 'C1'::character varying, 'C2'::character varying])::text[]))),
	CONSTRAINT language_proficiency_pkey PRIMARY KEY (id),
	CONSTRAINT language_proficiency_production_level_check CHECK (((production_level)::text = ANY ((ARRAY['A1'::character varying, 'A2'::character varying, 'B1'::character varying, 'B2'::character varying, 'C1'::character varying, 'C2'::character varying])::text[]))),
	CONSTRAINT language_proficiency_reading_level_check CHECK (((reading_level)::text = ANY ((ARRAY['A1'::character varying, 'A2'::character varying, 'B1'::character varying, 'B2'::character varying, 'C1'::character varying, 'C2'::character varying])::text[]))),
	CONSTRAINT language_proficiency_writing_level_check CHECK (((writing_level)::text = ANY ((ARRAY['A1'::character varying, 'A2'::character varying, 'B1'::character varying, 'B2'::character varying, 'C1'::character varying, 'C2'::character varying])::text[]))),
	CONSTRAINT fk9d2m6f8tkpf8opx42qjxdqfjr FOREIGN KEY (language_id) REFERENCES "language"(id),
	CONSTRAINT fkg6opsn19yh3l7v8wtwa8iap63 FOREIGN KEY (resume_id) REFERENCES resume(id)
);