/*Queries that provide answers to the questions from all projects.*/

SELECT * FROM animals WHERE name LIKE '%mon';
SELECT name FROM animals WHERE date_of_birth BETWEEN '2016-1-1' AND '2019-12-31';
SELECT name FROM animals WHERE neutered AND escape_attempts < '3';
SELECT date_of_birth FROM animals WHERE name = 'Agumon' OR name = 'Pikachu';
SELECT name, escape_attempts FROM animals WHERE weight_kg > '10.5';
SELECT * FROM animals WHERE neutered;
SELECT * FROM animals WHERE name != 'Gabumon';
SELECT * FROM animals WHERE weight_kg BETWEEN '10.4' AND '17.3';

-- Start transaction 
BEGIN;

-- Update transaction
UPDATE animals
SET species = 'unspecified';

SELECT * FROM animals;

-- Return to previous state
ROLLBACK;

SELECT * FROM animals;

-- Start transaction
BEGIN;

-- Update transaction
UPDATE animals
SET species = 'digimon'
WHERE name LIKE '%mon';

UPDATE animals
SET species = 'pokemon'
WHERE species IS NULL;

-- Commit transaction
COMMIT;

SELECT * FROM animals;

-- Start transaction
BEGIN;

-- Delete all transactions
DELETE FROM animals;

-- Return to previous state
ROLLBACK;

SELECT * FROM animals;

-- Start transaction
BEGIN;

-- Delete transaction
DELETE FROM animals
WHERE date_of_birth > '2022-01-01';

-- Create a savepoint
SAVEPOINT savepoint1;

-- Update transaction
UPDATE animals
SET weight_kg = weight_kg * -1;

-- Return to savepoint
ROLLBACK TO savepoint1;

-- Update transaction
UPDATE animals
SET weight_kg = weight_kg * -1
WHERE weight_kg < 0;

-- Commit transaction
COMMIT;

SELECT * FROM animals;

-- Count animals 
SELECT COUNT(*) FROM animals;

-- Animals that don't escape
SELECT COUNT(*) FROM animals WHERE escape_attempts = 0;

-- Average weight
SELECT AVG(weight_kg) FROM animals;

-- Escapes by neutered and not neutered
SELECT neutered, SUM(escape_attempts) FROM animals GROUP BY neutered;

-- Max and Min weight of each species
SELECT species, MAX(weight_kg), MIN(weight_kg) FROM animals GROUP BY species;

-- Avg escapes per type of those born between 1990 and 2000
SELECT species, AVG(escape_attempts) FROM animals 
WHERE date_of_birth BETWEEN '1990-01-01' AND '2000-12-31' GROUP BY species;
