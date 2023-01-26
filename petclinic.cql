CREATE KEYSPACE IF NOT EXISTS petclinic WITH REPLICATION = {'class': 'SimpleStrategy', 'replication_factor': 1};
USE petclinic;

CREATE TABLE IF NOT EXISTS owner (
    id         timeuuid,
    first_name text,
    last_name  text,
    address    text,
    city       text,
    telephone  text,
    PRIMARY KEY (id)
);
CREATE CUSTOM INDEX IF NOT EXISTS owner_name ON owner (last_name) USING 'org.apache.cassandra.index.sasi.SASIIndex' WITH OPTIONS = {
    'mode': 'CONTAINS', 'analyzer_class': 'org.apache.cassandra.index.sasi.analyzer.StandardAnalyzer',
    'tokenization_normalize_lowercase': 'true', 'tokenization_locale': 'de'
    };

CREATE TABLE IF NOT EXISTS pet_by_owner (
    owner_id   timeuuid,
    pet_id     timeuuid,
    birth_date date,
    name       text,
    pet_type   text,
    PRIMARY KEY (owner_id, pet_id)
);
CREATE TABLE IF NOT EXISTS visit_by_pet (
    pet_id      timeuuid,
    visit_id    timeuuid,
    visit_date  date,
    description text,
    PRIMARY KEY (pet_id, visit_id)
);
CREATE TABLE IF NOT EXISTS vet (
    id          timeuuid,
    first_name  text,
    last_name   text,
    specialties set<text>,
    PRIMARY KEY (id)
);
CREATE INDEX IF NOT EXISTS ON vet (specialties);

INSERT INTO vet (id, first_name, last_name, specialties)
VALUES (e7313036-8a1b-11ed-9d61-14857f0c9b17, 'James', 'Carter', {});
INSERT INTO vet (id, first_name, last_name, specialties)
VALUES (e77e3d5e-8a1b-11ed-95f9-14857f0c9b17, 'Helen', 'Leary', {'radiology'});
INSERT INTO vet (id, first_name, last_name, specialties)
VALUES (e7cb4966-8a1b-11ed-bc91-14857f0c9b17, 'Linda', 'Douglas', {'dentistry', 'surgery'});
INSERT INTO vet (id, first_name, last_name, specialties)
VALUES (e8183404-8a1b-11ed-8d71-14857f0c9b17, 'Rafael', 'Ortega', {'surgery'});
INSERT INTO vet (id, first_name, last_name, specialties)
VALUES (e8650e5a-8a1b-11ed-b9c5-14857f0c9b17, 'Henry', 'Stevens', {'radiology'});
INSERT INTO vet (id, first_name, last_name, specialties)
VALUES (e8b202bf-8a1b-11ed-bad1-14857f0c9b17, 'Sharon', 'Jenkins', {});

INSERT INTO owner (id, first_name, last_name, address, city, telephone)
VALUES (d7678d94-8a1b-11ed-bca6-14857f0c9b17, 'George', 'Franklin', '110 W. Liberty St.', 'Madison', '6085551023');
INSERT INTO owner (id, first_name, last_name, address, city, telephone)
VALUES (d7b4c8d4-8a1b-11ed-abd5-14857f0c9b17, 'Betty', 'Davis', '638 Cardinal Ave.', 'Sun Prairie', '6085551749');
INSERT INTO owner (id, first_name, last_name, address, city, telephone)
VALUES (d8020400-8a1b-11ed-9ce9-14857f0c9b17, 'Eduardo', 'Rodriquez', '2693 Commerce St.', 'McFarland', '6085558763');
INSERT INTO owner (id, first_name, last_name, address, city, telephone)
VALUES (d84f2e7e-8a1b-11ed-9e39-14857f0c9b17, 'Harold', 'Davis', '563 Friendly St.', 'Windsor', '6085553198');
INSERT INTO owner (id, first_name, last_name, address, city, telephone)
VALUES (d89c6626-8a1b-11ed-81b8-14857f0c9b17, 'Peter', 'McTavish', '2387 S. Fair Way', 'Madison', '6085552765');
INSERT INTO owner (id, first_name, last_name, address, city, telephone)
VALUES (d8e97ea2-8a1b-11ed-9b0f-14857f0c9b17, 'Jean', 'Coleman', '105 N. Lake St.', 'Monona', '6085552654');
INSERT INTO owner (id, first_name, last_name, address, city, telephone)
VALUES (d93684c2-8a1b-11ed-8d51-14857f0c9b17, 'Jeff', 'Black', '1450 Oak Blvd.', 'Monona', '6085555387');
INSERT INTO owner (id, first_name, last_name, address, city, telephone)
VALUES (d983a202-8a1b-11ed-b35b-14857f0c9b17, 'Maria', 'Escobito', '345 Maple St.', 'Madison', '6085557683');
INSERT INTO owner (id, first_name, last_name, address, city, telephone)
VALUES (d9d0bf24-8a1b-11ed-a68e-14857f0c9b17, 'David', 'Schroeder', '2749 Blackhawk Trail', 'Madison', '6085559435');
INSERT INTO owner (id, first_name, last_name, address, city, telephone)
VALUES (da1dc18e-8a1b-11ed-ac3f-14857f0c9b17, 'Carlos', 'Estaban', '2335 Independence La.', 'Waunakee', '6085555487');

INSERT INTO pet_by_owner (owner_id, pet_id, name, birth_date, pet_type)
VALUES (d7678d94-8a1b-11ed-bca6-14857f0c9b17, 7fb8cdc8-8a1c-11ed-a9ab-14857f0c9b17, 'Leo', '2000-09-07', 'cat');
INSERT INTO pet_by_owner (owner_id, pet_id, name, birth_date, pet_type)
VALUES (d7b4c8d4-8a1b-11ed-abd5-14857f0c9b17, 8005c7ea-8a1c-11ed-80be-14857f0c9b17, 'Basil', '2002-08-06', 'hamster');
INSERT INTO pet_by_owner (owner_id, pet_id, name, birth_date, pet_type)
VALUES (d8020400-8a1b-11ed-9ce9-14857f0c9b17, 8052e07a-8a1c-11ed-ba37-14857f0c9b17, 'Rosy', '2001-04-17', 'dog');
INSERT INTO pet_by_owner (owner_id, pet_id, name, birth_date, pet_type)
VALUES (d8020400-8a1b-11ed-9ce9-14857f0c9b17, 80a006ac-8a1c-11ed-89c5-14857f0c9b17, 'Jewel', '2000-03-07', 'dog');
INSERT INTO pet_by_owner (owner_id, pet_id, name, birth_date, pet_type)
VALUES (d84f2e7e-8a1b-11ed-9e39-14857f0c9b17, 80ed39b8-8a1c-11ed-a6fd-14857f0c9b17, 'Iggy', '2000-11-30', 'lizard');
INSERT INTO pet_by_owner (owner_id, pet_id, name, birth_date, pet_type)
VALUES (d89c6626-8a1b-11ed-81b8-14857f0c9b17, 813a5f9a-8a1c-11ed-9170-14857f0c9b17, 'George', '2000-01-20', 'snake');
INSERT INTO pet_by_owner (owner_id, pet_id, name, birth_date, pet_type)
VALUES (d8e97ea2-8a1b-11ed-9b0f-14857f0c9b17, 81877cda-8a1c-11ed-896b-14857f0c9b17, 'Samantha', '1995-09-04', 'cat');
INSERT INTO pet_by_owner (owner_id, pet_id, name, birth_date, pet_type)
VALUES (d8e97ea2-8a1b-11ed-9b0f-14857f0c9b17, 81d48930-8a1c-11ed-98eb-14857f0c9b17, 'Max', '1995-09-04', 'cat');
INSERT INTO pet_by_owner (owner_id, pet_id, name, birth_date, pet_type)
VALUES (d93684c2-8a1b-11ed-8d51-14857f0c9b17, 82218668-8a1c-11ed-b854-14857f0c9b17, 'Lucky', '1999-08-06', 'bird');
INSERT INTO pet_by_owner (owner_id, pet_id, name, birth_date, pet_type)
VALUES (d983a202-8a1b-11ed-b35b-14857f0c9b17, 826eb15e-8a1c-11ed-bbf1-14857f0c9b17, 'Mulligan', '1997-02-24', 'dog');
INSERT INTO pet_by_owner (owner_id, pet_id, name, birth_date, pet_type)
VALUES (d9d0bf24-8a1b-11ed-a68e-14857f0c9b17, 82bbdef2-8a1c-11ed-9f40-14857f0c9b17, 'Freddy', '2000-03-09', 'bird');
INSERT INTO pet_by_owner (owner_id, pet_id, name, birth_date, pet_type)
VALUES (da1dc18e-8a1b-11ed-ac3f-14857f0c9b17, 830911b8-8a1c-11ed-abaa-14857f0c9b17, 'Lucky', '2000-06-24', 'dog');
INSERT INTO pet_by_owner (owner_id, pet_id, name, birth_date, pet_type)
VALUES (da1dc18e-8a1b-11ed-ac3f-14857f0c9b17, 835619fe-8a1c-11ed-9692-14857f0c9b17, 'Sly', '2002-06-08', 'cat');

INSERT INTO visit_by_pet (pet_id, visit_id, visit_date, description)
VALUES (81d48930-8a1c-11ed-98eb-14857f0c9b17, 9e634ada-8a1e-11ed-8f4a-14857f0c9b17, '2010-03-04', 'rabies shot');
INSERT INTO visit_by_pet (pet_id, visit_id, visit_date, description)
VALUES (81877cda-8a1c-11ed-896b-14857f0c9b17, 9eb074ea-8a1e-11ed-a1b7-14857f0c9b17, '2011-03-04', 'rabies shot');
INSERT INTO visit_by_pet (pet_id, visit_id, visit_date, description)
VALUES (81877cda-8a1c-11ed-896b-14857f0c9b17, 9efd8e1a-8a1e-11ed-9d82-14857f0c9b17, '2009-06-04', 'neutered');
INSERT INTO visit_by_pet (pet_id, visit_id, visit_date, description)
VALUES (81d48930-8a1c-11ed-98eb-14857f0c9b17, 9f4aa556-8a1e-11ed-a3ad-14857f0c9b17, '2008-09-04', 'spayed');
