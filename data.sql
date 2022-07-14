/* Populate database with sample data. */

INSERT INTO animals(id, name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES (1, 'Agumon', '02-03-2022', 0, TRUE, 10.23);
INSERT INTO animals(id, name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES (2, 'Gabumon', '11-15-2018', 2, TRUE, 8);
INSERT INTO animals(id, name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES (3, 'Pikachu', '01-07-2021', 1, FALSE, 15.04);
INSERT INTO animals(id, name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES (4, 'Devimon', '05-12-2017', 5, TRUE, 11);
INSERT INTO animals(id, name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES (5, 'Charmander', '02-8-2020', 0, FALSE, -11);
INSERT INTO animals(id, name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES (6, 'Plantmon', '11-15-2021', 2, TRUE, -5.7);
INSERT INTO animals(id, name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES (7, 'Squirtle', '04-02-1993', 3, FALSE, -12.13);
INSERT INTO animals(id, name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES (8, 'Angemon', '06-12-2005', 1, TRUE, -45);
INSERT INTO animals(id, name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES (9, 'Boarmon', '06-07-2005', 7, TRUE, 20.4);
INSERT INTO animals(id, name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES (10, 'Blossom', '10-13-1998', 3, TRUE, 17);
INSERT INTO animals(id, name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES (11, 'Ditto', '05-14-2022', 4, TRUE, 22);

-- Insert the following owners into the owners table.
INSERT INTO owners(full_name, age) VALUES ('Sam Smith', 34);
INSERT INTO owners(full_name, age) VALUES ('Jennifer Orwell', 19);
INSERT INTO owners(full_name, age) VALUES ('Bob', 45);
INSERT INTO owners(full_name, age) VALUES ('Melody Pond', 77);
INSERT INTO owners(full_name, age) VALUES ('Dean Winchester', 14);
INSERT INTO owners(full_name, age) VALUES ('Jodie Whittaker', 38);

-- Insert the following animals into the species table.
INSERT INTO species(name) VALUES ('Pokemon');
INSERT INTO species(name) VALUES ('Digimon');

-- Modify your inserted animals so it includes the species_id value.
UPDATE animals
SET species_id = (SELECT id FROM species WHERE name = 'Digimon')
WHERE name LIKE '%mon%';

-- Make all others 'Pokemon'.
UPDATE animals
SET species_id = (SELECT id FROM species WHERE name = 'Pokemon')
WHERE species_id IS NULL;
select * from animals;

-- Modify your inserted animals to include owner information (
-- Sam Smith owns Agumon.
UPDATE animals
SET owner_id = (SELECT id FROM owners WHERE full_name = 'Sam Smith')
WHERE name = 'Agumon';

-- Jennifer Orwell owns Gabumon and Pikachu.
UPDATE animals
SET owner_id = (SELECT id FROM owners WHERE full_name = 'Jennifer Orwell')
WHERE name  IN ('Gabumon', 'Pikachu');

-- Bob owns Devimon and Plantmon.
UPDATE animals
SET owner_id = (SELECT id FROM owners WHERE full_name = 'Bob')
WHERE name  IN ('Devimon', 'Plantmon');

-- Melody Pond owns Charmander, Squirtle, and Blossom
UPDATE animals
SET owner_id = (SELECT id FROM owners WHERE full_name = 'Melody Pond')
WHERE name  IN ('Charmander', 'Squirtle', 'Blossom');

-- Dean Winchester owns Angemon and Boarmon.
UPDATE animals 
SET owner_id = (SELECT id FROM owners WHERE full_name = 'Dean Winchester')
WHERE name  IN ('Angemon', 'Boarmon');

-- Insert data to vets table.
INSERT INTO vets (name, age, date_of_graduation) VALUES ('William Tatcher', 45, '04-23-2000');
INSERT INTO vets (name, age, date_of_graduation) VALUES ('Maisy Smith', 26, '01-17-2019');
INSERT INTO vets (name, age, date_of_graduation) VALUES ('Stephanie Mendez', 64, '05-04-1981');
INSERT INTO vets (name, age, date_of_graduation) VALUES ('Jack Harkness', 38, '06-08-2008');

-- Insert data for William Tatcher specialize in Pokemon.
INSERT INTO specializations (vets_id, species_id)
VALUES (
    (SELECT id FROM vets WHERE name = 'William Tatcher'),
    SELECT id FROM species WHERE name = 'Pokemon');
-- Stephanie Mendez is specialized in Digimon and Pokemon.
INSERT INTO specializations (vets_id, species_id)
VALUES (
    (SELECT id FROM vets WHERE name = 'Stephanie Mendez'),
    (SELECT id FROM species WHERE name = 'Digimon')
    );
INSERT INTO specializations (vets_id, species_id)
VALUES (
    (SELECT id FROM vets WHERE name = 'Stephanie Mendez'),
    (SELECT id FROM species WHERE name = 'Pokemon')
);

-- Jack Harkness is specialized in Digimon
INSERT INTO specializations (vets_id, species_id) VALUES (
    (SELECT id FROM vets WHERE name = 'Jack Harkness'),
    (SELECT id FROM species WHERE name = 'Digimon')
)

-- Agumon visited William Tatcher on May 24th, 2020.
INSERT INTO visits (animal_id, vets_id, visit_date) VALUES (
    (SELECT id FROM animals WHERE name = 'Agumon'),
    (SELECT id FROM vets WHERE name = 'William Tatcher'),
    '2020-05-24'
);
-- Agumon visited Stephanie Mendez on Jul 22th, 2020.
INSERT INTO visits (animal_id, vets_id, visit_date) VALUES (
    (SELECT id FROM animals WHERE name = 'Agumon'),
    (SELECT id FROM vets WHERE name = 'Stephanie Mendez'),
    '2020-07-22'
);
-- Gabumon visited Jack Harkness on Feb 2nd, 2021.
INSERT INTO visits (animal_id, vets_id, visit_date) VALUES (
    (SELECT id FROM animals WHERE name = 'Gabumon'),
    (SELECT id FROM vets WHERE name = 'Jack Harkness'),
    '2021-02-02'
);
-- Pikachu visited Maisy Smith on Jan 5th, 2020.
INSERT INTO visits (animal_id, vets_id, visit_date) VALUES (
    (SELECT id FROM animals WHERE name = 'Pikachu'),
    (SELECT id FROM vets WHERE name = 'Maisy Smith'),
    '2020-01-05'
);
-- Pikachu visited Maisy Smith on Mar 8th, 2020.
INSERT INTO visits (animal_id, vets_id, visit_date) VALUES (
    (SELECT id FROM animals WHERE name = 'Pikachu'),
    (SELECT id FROM vets WHERE name = 'Maisy Smith'),
    '2020-03-08'
);
-- Pikachu visited Maisy Smith on May 14th, 2020.
INSERT INTO visits (animal_id, vets_id, visit_date) VALUES (
    (SELECT id FROM animals WHERE name = 'Pikachu'),
    (SELECT id FROM vets WHERE name = 'Maisy Smith'),
    '2020-05-14'
);
-- Devimon visited Stephanie Mendez on May 4th, 2021.
INSERT INTO visits (animal_id, vets_id, visit_date) VALUES (
    (SELECT id FROM animals WHERE name = 'Devimon'),
    (SELECT id FROM vets WHERE name = 'Stephanie Mendez'),
    '2021-05-04'
);
-- Charmander visited Jack Harkness on Feb 24th, 2021.
INSERT INTO visits (animal_id, vets_id, visit_date) VALUES (
    (SELECT id FROM animals WHERE name = 'Charmander'),
    (SELECT id FROM vets WHERE name = 'Jack Harkness'),
    '2021-02-24'
);
-- Plantmon visited Maisy Smith on Dec 21st, 2019.
INSERT INTO visits (animal_id, vets_id, visit_date) VALUES (
    (SELECT id FROM animals WHERE name = 'Plantmon'),
    (SELECT id FROM vets WHERE name = 'Maisy Smith'),
    '2019-12-21'
);
-- Plantmon visited William Tatcher on Aug 10th, 2020.
INSERT INTO visits (animal_id, vets_id, visit_date) VALUES (
    (SELECT id FROM animals WHERE name = 'Plantmon'),
    (SELECT id FROM vets WHERE name = 'William Tatcher'),
    '2020-08-10'
);
-- Plantmon visited Maisy Smith on Apr 7th, 2021.
INSERT INTO visits (animal_id, vets_id, visit_date) VALUES (
    (SELECT id FROM animals WHERE name = 'Plantmon'),
    (SELECT id FROM vets WHERE name = 'Maisy Smith'),
    '2021-04-07'
);
-- Squirtle visited Stephanie Mendez on Sep 29th, 2019.
INSERT INTO visits (animal_id, vets_id, visit_date) VALUES (
    (SELECT id FROM animals WHERE name = 'Squirtle'),
    (SELECT id FROM vets WHERE name = 'Stephanie Mendez'),
    '2019-09-29'
);
-- Angemon visited Jack Harkness on Oct 3rd, 2020.
INSERT INTO visits (animal_id, vets_id, visit_date) VALUES (
    (SELECT id FROM animals WHERE name = 'Angemon'),
    (SELECT id FROM vets WHERE name = 'Jack Harkness'),
    '2020-10-03'
);
-- Angemon visited Jack Harkness on Nov 4th, 2020.
INSERT INTO visits (animal_id, vets_id, visit_date) VALUES (
    (SELECT id FROM animals WHERE name = 'Angemon'),
    (SELECT id FROM vets WHERE name = 'Jack Harkness'),
    '2020-11-04'
);
-- Boarmon visited Maisy Smith on Jan 24th, 2019.
INSERT INTO visits (animal_id, vets_id, visit_date) VALUES (
    (SELECT id FROM animals WHERE name = 'Boarmon'),
    (SELECT id FROM vets WHERE name = 'Maisy Smith'),
    '2019-01-24'
);
-- Boarmon visited Maisy Smith on May 15th, 2019.
INSERT INTO visits (animal_id, vets_id, visit_date) VALUES (
    (SELECT id FROM animals WHERE name = 'Boarmon'),
    (SELECT id FROM vets WHERE name = 'Maisy Smith'),
    '2019-05-15'
);
-- Boarmon visited Maisy Smith on Feb 27th, 2020.
INSERT INTO visits (animal_id, vets_id, visit_date) VALUES (
    (SELECT id FROM animals WHERE name = 'Boarmon'),
    (SELECT id FROM vets WHERE name = 'Maisy Smith'),
    '2020-02-27'
);
-- Boarmon visited Maisy Smith on Aug 3rd, 2020.
INSERT INTO visits (animal_id, vets_id, visit_date) VALUES (
    (SELECT id FROM animals WHERE name = 'Boarmon'),
    (SELECT id FROM vets WHERE name = 'Maisy Smith'),
    '2020-08-03'
);
-- Blossom visited Stephanie Mendez on May 24th, 2020.
INSERT INTO visits (animal_id, vets_id, visit_date) VALUES (
    (SELECT id FROM animals WHERE name = 'Blossom'),
    (SELECT id FROM vets WHERE name = 'Stephanie Mendez'),
    '2020-05-24'
);
-- Blossom visited William Tatcher on Jan 11th, 2021.
INSERT INTO visits (animal_id, vets_id, visit_date) VALUES (
    (SELECT id FROM animals WHERE name = 'Blossom'),
    (SELECT id FROM vets WHERE name = 'William Tatcher'),
    '2021-01-11'
);
