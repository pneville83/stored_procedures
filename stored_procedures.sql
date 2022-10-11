CREATE TABLE accounts (
  id serial PRIMARY KEY,
  bank_name varchar (100) NOT NULL,
  account_number NUMERIC (10) NOT NULL UNIQUE,
  costumer_name varchar (100) NOT NULL 
);


ALTER TABLE accounts ADD COLUMN balance decimal

INSERT INTO accounts (bank_name, account_number, costumer_name, balance ) VALUES ('Pichincha', '1709990848', 'Peter Neville', 125.50 ) 

INSERT INTO accounts (bank_name, account_number, costumer_name, balance ) VALUES
('Produbanco', '1710255892', 'Peter Neville', 125.50),
('Guayaquil', '1874567890', 'Peter Neville', 325.50)


CREATE PROCEDURE total_balance ()
LANGUAGE plpgsql
AS
$$
DECLARE 
 vbalance int;
BEGIN 
	SELECT sum (balance) INTO vbalance
	  FROM "public"."accounts";
	 RAISE NOTICE 'El saldo total de sus cientas es: %', vbalance;
END 	  
$$

CALL total_balance();

create or replace procedure transfer(
   sender int,
   receiver int, 
   amount dec
)
language plpgsql    
as $$
begin
    -- salida de dinero 
    update accounts 
    set balance = balance - amount 
    where id = sender;

    -- entrada de dinero 
    update accounts 
    set balance = balance + amount 
    where id = receiver;

    commit;
end;$$

CALL transfer (1, 2, 100);
SELECT * FROM accounts 

