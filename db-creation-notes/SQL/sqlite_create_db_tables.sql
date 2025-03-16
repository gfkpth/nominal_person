--- Create tables

--- Table of languages in the DB
CREATE TABLE IF NOT EXISTS languages (
	language_id INTEGER NOT NULL PRIMARY KEY,
	lang_name varchar NOT NULL,
	glottocode varchar UNIQUE,
	walscode varchar,
	iso639_3 varchar,
	lat REAL,
	lon REAL,
	coord_notes text,
	area_wals varchar,
	area_glottolog varchar,
	sort_affiliation varchar,
    genus_wals varchar,
    family_genus varchar
);


--- Table of nominal person-related source references
CREATE TABLE IF NOT EXISTS datasources (
	language_id INTEGER NOT NULL,
	ref_short text,
	ref_pages text,
	FOREIGN KEY (language_id) REFERENCES languages (language_id) ON DELETE CASCADE
);

--- core syntactic properties related to language_id as foreign key (allows easier remodelling of languages_dim to encode genetic relationships in more elaborate way if need arises)
CREATE TABLE IF NOT EXISTS core_properties (
	id INTEGER NOT NULL PRIMARY KEY,
	language_id INTEGER NOT NULL UNIQUE,
	constituent_order varchar,
	constituent_order_wals varchar,
	adposition_order varchar,
	adposition_order_wals varchar,
	genitive_order varchar,
	genitive_order_wals varchar,
	demonstrative_order varchar,
	demonstrative_order_wals varchar,
	definite_article varchar,
	article_distinct_third BOOLEAN,
	demonstrative_as_third BOOLEAN,
	nominal_person BOOLEAN,
	apc_order varchar,
	bound_person_order varchar,
	person_allowed varchar,
	person_third_available varchar,
	number_allowed varchar,
	ppdc varchar,
	FOREIGN KEY (language_id) REFERENCES languages(language_id) ON DELETE CASCADE
);

--- syntactic properties of articles
CREATE TABLE IF NOT EXISTS article_properties (
	language_id INT NOT NULL,
	article_order varchar,
	demonstrative_w_article varchar,
	nominal_person_w_article varchar,
	FOREIGN KEY (language_id) REFERENCES languages(language_id) ON DELETE CASCADE
);