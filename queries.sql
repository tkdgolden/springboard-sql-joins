-- write your queries here --
--            List of relations
--  Schema |   Name   | Type  |   Owner
-- --------+----------+-------+-----------
--  public | owners   | table | tkdgolden
--  public | vehicles | table | tkdgolden
--  
--                                Table "public.owners"
--    Column   |  Type   | Collation | Nullable |              Default

-- ------------+---------+-----------+----------+------------------------------------
--  id         | integer |           | not null | nextval('owners_id_seq'::regclass)
--  first_name | text    |           |          |
--  last_name  | text    |           |          |
-- Indexes:
--     "owners_pkey" PRIMARY KEY, btree (id)
-- Referenced by:
--     TABLE "vehicles" CONSTRAINT "vehicles_owner_id_fkey" FOREIGN KEY (owner_id) REFERENCES owners(id)
--     
--                              Table "public.vehicles"
--   Column  |  Type   | Collation | Nullable |               Default

-- ----------+---------+-----------+----------+--------------------------------------
--  id       | integer |           | not null | nextval('vehicles_id_seq'::regclass)
--  make     | text    |           |          |
--  model    | text    |           |          |
--  year     | integer |           |          |
--  price    | real    |           |          |
--  owner_id | integer |           |          |
-- Indexes:
--     "vehicles_pkey" PRIMARY KEY, btree (id)
-- Foreign-key constraints:
--     "vehicles_owner_id_fkey" FOREIGN KEY (owner_id) REFERENCES owners(id)

-- Join the two tables so that every column and record appears, regardless of if there is not an owner_id . --
SELECT * FROM owners 
	JOIN vehicles ON owners.id = vehicles.owner_id;

-- Count the number of cars for each owner. 
-- Display the owners first_name , last_name and count of vehicles. 
-- The first_name should be ordered in ascending order. 
SELECT first_name, last_name, COUNT(*) FROM owners 
	JOIN vehicles ON owners.id = vehicles.owner_id 
	GROUP BY owners.id 
	ORDER BY first_name;
    
-- Count the number of cars for each owner and display the average price for each of the cars as integers. 
-- Display the owners first_name , last_name, average price and count of vehicles. 
-- The first_name should be ordered in descending order. 
-- Only display results with more than one vehicle and an average price greater than 10000. 
SELECT first_name, last_name, ROUND(AVG(price)), COUNT(*) FROM owners
	JOIN vehicles ON owners.id = vehicles.owner_id
    GROUP BY owners.id
    HAVING COUNT(*) > 1 AND AVG(price) > 10000
    ORDER BY first_name DESC;