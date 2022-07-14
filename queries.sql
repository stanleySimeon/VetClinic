/*Queries that provide answers to the questions from all projects.*/

SELECT * FROM animals WHERE name LIKE '%mon%'
SELECT name FROM animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-31'
SELECT name FROM animals WHERE neutered = TRUE AND escape_attempts < 3
SELECT date_of_birth FROM animals WHERE name = 'Agumon' OR name = 'Pikachu'
SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5
SELECT * FROM animals WHERE neutered = TRUE
SELECT * FROM animals WHERE name != 'Gabumon'
SELECT * FROM animals where weight_kg BETWEEN 10.4 AND 17.3 AND weight_kg BETWEEN 10.4 AND 17.3

-- **************Transation****************

-- Update the animals table to set species value to unspecified for all animals.
BEGIN;

UPDATE animals SET species = 'unspecified';
-- Check that the species column is now 'unspecified'.
select * from animals

-- Rollback the transaction.
ROLLBACK;

-- Set the species column to digimon for all animals that have a name ending in mon.
BEGIN;
UPDATE animals
SET species = 'digimon'
WHERE name LIKE '%mon%';

-- Check that the species column is now 'digimon'.
select * from animals

-- Set the species column to pokemon for all animals that doesn't have a name ending in mon.
UPDATE animals
SET species = 'pokemon'
WHERE species IS NULL;
-- Check that the species column is now 'pokemon'.
select * from animals

-- Commit the transaction.
COMMIT;

-- Remove all records from the animals table.
BEGIN;
DELETE FROM animals;
-- Check that the table is now empty.
select * from animals
-- Rollback the transaction.
ROLLBACK;
-- Check that the table is Rolled back to its original state.
select * from animals;

-- Delete all animals where the date of birth is before '01-01-2022'.
BEGIN;
DELETE FROM animals WHERE date_of_birth > '01-01-2022';
-- Check that the specifics columns are removed.
select * from animals
-- Create a savepoint.
SAVEPOINT animalsBornedAfterJanuary;
-- Multipliate all weight_kg by -1.
UPDATE animals SET weight_kg = weight_kg * -1
-- ckeck that the weight_kg column is now negative.
select * from animals
-- Roolback to the savepoint.
ROLLBACK TO animalsBornedAfterJanuary;
-- Update all animals' weights that are negative to be their weight multiplied by -1.
UPDATE animals SET weight_kg = weight_kg * -1
WHERE weight_kg < 0;
-- Commit the transaction.
COMMIT;

-- ****************QUERIES****************

-- animals number
SELECT COUNT(*) FROM animals;

-- Calculate how many animals have never tried to escape.
SELECT COUNT(*) FROM animals WHERE escape_attempts = 0;

-- Calculate the average weight of all animals.
SELECT AVG(weight_kg) FROM animals;

-- Who escapes the most, neutered or not neutered animals?
SELECT name, escape_attempts FROM animals ORDER BY escape_attempts DESC;

-- The minimum and maximum weight of each type of animal
SELECT species, MIN(weight_kg), MAX(weight_kg) FROM animals GROUP BY species;

-- The average number of escape attempts per animal type of those born between 1990 and 2000
SELECT species,
AVG(escape_attempts)
FROM animals
WHERE date_of_birth 
BETWEEN '1990-01-01' 
AND '2000-12-31' 
GROUP BY species;

-- Write queries (using JOIN) to answer the following questions
-- Write query for animals belong to Melody Pond.
SELECT * FROM animals
JOIN owners ON animals.owner_id = owners.id
WHERE owners.full_name = 'Melody Pond';

-- List of all animals that are pokemon (their type is Pokemon).
SELECT * FROM animals
JOIN species ON animals.species_id = species.id
WHERE species.name = 'Pokemon';

-- List of all owners and their animals.
SELECT owners.full_name, animals.name FROM owners
LEFT JOIN animals ON owners.id = animals.owner_id;

-- List of animals are there per species
SELECT species.name, COUNT(*) FROM animals
JOIN species ON animals.species_id = species.id
GROUP BY species.name;

-- List all Digimon owned by Jennifer Orwell.
SELECT * FROM animals
JOIN owners ON animals.owner_id = owners.id
WHERE owners.full_name = 'Jennifer Orwell';

-- List all animals owned by Dean Winchester that haven't tried to escape.
SELECT * FROM animals
JOIN owners ON animals.owner_id = owners.id
WHERE owners.full_name = 'Dean Winchester' AND animals.escape_attempts < 0;

-- List of person Who owns the most animals
SELECT owners.full_name, COUNT(*) FROM owners
LEFT JOIN animals ON owners.id = animals.owner_id
GROUP BY owners.full_name ORDER BY COUNT(*) DESC;

-- Who was the last animal seen by William Tatcher?
SELECT * FROM animals
JOIN owners ON animals.owner_id = owners.id
WHERE owners.full_name = 'William Tatcher' AND animals.date_of_last_seen = (
SELECT MAX(date_of_last_seen) FROM animals
WHERE owners.full_name = 'William Tatcher'
);

-- How many different animals did Stephanie Mendez see?
SELECT COUNT(DISTINCT animals.name) FROM animals
JOIN owners ON animals.owner_id = owners.id
WHERE owners.full_name = 'Stephanie Mendez';

-- List all vets and their specialties, including vets with no specialties.
SELECT vets.full_name, vets.specialty FROM vets
LEFT JOIN vets_specialties ON vets.id = vets_specialties.vet_id
ORDER BY vets.full_name;

-- List all animals that visited Stephanie Mendez between April 1st and August 30th, 2020.
SELECT * FROM animals
JOIN visits ON animals.id = visits.animal_id
WHERE visits.date_of_visit BETWEEN '2020-04-01' AND '2020-08-30'
AND visits.vet_id = (
SELECT vets.id FROM vets
JOIN vets_specialties ON vets.id = vets_specialties.vet_id
WHERE vets.full_name = 'Stephanie Mendez'
);

-- What animal has the most visits to vets?
SELECT animals.name, COUNT(*) FROM animals
JOIN visits ON animals.id = visits.animal_id
GROUP BY animals.name ORDER BY COUNT(*) DESC;

-- Who was Maisy Smith's first visit?
SELECT * FROM visits
JOIN animals ON visits.animal_id = animals.id
WHERE animals.name = 'Maisy Smith'
ORDER BY visits.date_of_visit ASC LIMIT 1;

-- Details for most recent visit: animal information, vet information, and date of visit.
SELECT animals.name, animals.species, animals.date_of_birth, animals.weight_kg,
vets.full_name, vets.specialty, visits.date_of_visit
FROM visits
JOIN animals ON visits.animal_id = animals.id
JOIN vets ON visits.vet_id = vets.id
ORDER BY visits.date_of_visit DESC LIMIT 1;

-- How many visits were with a vet that did not specialize in that animal's species?
SELECT COUNT(*) FROM visits
JOIN vets ON visits.vet_id = vets.id
JOIN animals ON visits.animal_id = animals.id
WHERE vets.specialty != animals.species;

-- What specialty should Maisy Smith consider getting? Look for the species she gets the most.
SELECT specialty FROM vets
JOIN animals ON vets.id = animals.vet_id
WHERE animals.name = 'Maisy Smith'
ORDER BY specialty ASC LIMIT 1;
