CREATE OR REPLACE FUNCTION adder(num1 integer, num2 integer) RETURNS integer ---CREATE function
LANGUAGE plpgsql AS $$
BEGIN
RETURN NUM1+ NUM2;
END
$$;  --THESE ARE BASICALLY ()

--CALL FUNCTION
SELECT  adder(10,11);
SELECT adder(100,5);


CREATE OR REPLACE FUNCTION square_num(num1 integer) RETURNS integer
LANGUAGE plpgsql AS $$
BEGIN
RETURN num1 * num1 ;
END
$$;

SELECT square_num(10)


SELECT power(10,2)  --shortcut TO GET squared num



----late fee 
CREATE OR REPLACE FUNCTION addLateFee(
	customer_id INTEGER,
	staff_id INTEGER,
	rental_id INTEGER, 
	fee NUMERIC(4,2)
) RETURNS INTEGER AS $$
	BEGIN
		INSERT INTO payment(
			customer_id,
			staff_id,
			rental_id,
			amount,
			payment_date
		)	VALUES (
			customer_id,
			staff_id,
			rental_id,
			fee,
			NOW()
		);
		RETURN customer_id;
	END
$$ LANGUAGE plpgsql;

SELECT * FROM rental
WHERE return_date IS NULL;

SELECT addLateFee(22,1,12222,3);

SELECT * FROM payment
WHERE customer_id = 22;


----return rental

CREATE OR REPLACE PROCEDURE updateReturnDate(
	_rental_id INTEGER, 
	_customer_id INTEGER
) LANGUAGE plpgsql AS $$
	BEGIN
		UPDATE rental
		SET return_date = NOW()
		WHERE rental_id = _rental_id AND customer_id = _customer_id;
		COMMIT;
	END
$$;

SELECT * FROM rental
WHERE rental_id = 11496;

CALL updateReturnDate(12222, 22);

CALL updateReturnDate(11496, 155);


----------------------------------------------------------------  update email
SELECT * FROM CUSTOMER
WHERE customer_id = 1;

CREATE PROCEDURE updateEmail(_customer_id integer, _email varchar ) ----- created fun TO CALL AND reuse 
AS $$
BEGIN
	UPDATE customer
	SET email= _email
	WHERE customer_id = _customer_id;
	COMMIT;
	END
$$ LANGUAGE plpgsql;


CALL updateEmail(1, 'marysmith@gmail.com');   ----updating email  BY calling customer id AND NEW email

---------------------------------------------------------------------------add actor

CREATE PROCEDURE addActor(_first_name varchar,_last_name varchar) --------created function
LANGUAGE plpgsql AS $$
BEGIN
	INSERT INTO actor(first_name,last_name)
	VALUES(_first_name, _last_name);
END
$$;

CALL  addActor('Sean','Currie');

SELECT* FROM actor
WHERE first_name = 'Sean' AND last_name = 'Currie';
