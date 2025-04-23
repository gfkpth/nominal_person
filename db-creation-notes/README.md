# Introduction

This folder contains a jupyter notebook used to extract the example data from the LaTeX sources of Supplementary Material S3 of [Höhn (2024)](https://doi.org/10.1515/lingty-2023-0080), contained in S3.tex here.

# Notes

## Problems regarding "extra data after last expected column"

I got the error message above when trying to run the COPY ... FROM command to import a subset of the tables from my csv file. It turns out that imported csv files must not contain more columns than are to be imported (but they may probably contain fewer columns).

Simplest might have been to just manually create the restricted csv files for import, but that seemed tedious and somehow wrong. Possibly it would indeed have been faster, but I guess I would have learned a bit less in the process.

With some searching and a bit of prodding with ChatGPT I decided to use a python script to pick out only the columns I wanted for the first step of creating the "languages" table.

## New problem: consistent language_id

The primary key "language\_id" in the "languages" table is automatically generated as desired, but that actually turned out to complicate matters. In order to ensure that the other tables I'd import would be properly linked via foreign keys to the "languages" table, I would still need some unique identifier for the other tables I would extract from my master csv file.

I could import a temporary table containing the glottocode and use this to join with the "languages" table in order to then run a SELECT INTO query for the target table, but that seemed unnecessarily cumbersome considering I hadn't designed the scheme to contain the glottocode in tables outside of "languages" -- in fact, that would just be duplicating what "language\_id" was meant to do anyway. Moreover, while glottocodes are fairly comprehensive (and would be sufficient ) In retrospect, the need for some connecting property makes sense, but for some reason I had just expected there'd be some simpler way of automatically ensuring a consistent usage of the foreign key -- although typing this I suppose I didn't actually have any specific idea in mind. Probably I was simply still stuck in the mindset of a single CSV table. Maybe I also felt that because language\_id was defined as automatically incrementing I should use its automatic assignment?

In any case, at this point I backtracked and figured that since I was building the database from scratch anyway, it would make much more sense to just assign a unique ID in my source file that I would simply export into the subtables as necessary, rather than jumping through unnecessary hoops like temporary tables joining on additional columns or exporting the automatically created language\_id back into a csv to then include this in the next runs of my python script.


