/* Database schema to keep the structure of entire database. */

CREATE TABLE animals(
    id SERIAL NOT NULL PRIMARY KEY,
    name CHAR(50),
    date_of_birth DATE,
    escape_attempts INT,
    neutered BOOLEAN,
    weight_kg DECIMAL
);


-- Add a new column to the table
ALTER TABLE animals ADD species VARCHAR(255);

-- Create  owners table.
CREATE TABLE owners(
    ID SERIAL NOT NULL PRIMARY KEY,
    full_name CHAR(100),
    age INT NOT NULL
)

-- Create species table.
CREATE TABLE species(
    id SERIAL NOT NULL PRIMARY KEY,
    name VARCHAR(50)
)

-- Modify animals table: To do that we need first to drop the species column.
ALTER TABLE animals DROP COLUMN species;

--Add column species_id which is a foreign key referencing species table.
ALTER TABLE animals ADD COLUMN species_id INT REFERENCES species(id);

-- Add column owner_id which is a foreign key referencing the owners table
ALTER TABLE animals ADD COLUMN owner_id INT REFERENCES owners(id);
