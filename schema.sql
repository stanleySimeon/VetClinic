/* Database schema to keep the structure of entire database. */

    CREATE TABLE animals (
       id int,
       name varchar(255),
       date_of_birth date,
       escape_attempts integer,
       neutered boolean,
       weight_kg decimal, 
    );
