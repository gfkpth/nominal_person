--- import languages table

COPY public.languages (lang_name, glottocode, walscode, iso639_3, lat, lon, coord_notes, area_wals, area_glottolog, sort_affiliation, genus_wals, family_genus)
   FROM '/home/georg/studium/2024-Professional development/self-learn/SQL/01-adnompers_grammars/Scripts/grammarchecks.csv'
   DELIMITER ','
   CSV HEADER;


--- issues with file permissions, use psql directly instead
/*
psql -u postgres -d persn -c "\copy public.languages (lang_name, glottocode, walscode, iso639_3, lat, lon, coord_notes, area_wals, area_glottolog, sort_affiliation, genus_wals, family_genus) FROM 'Scripts/grammarchecks.csv' WITH CSV;"
*/

--- problems regarding "extra data after last expected column"
