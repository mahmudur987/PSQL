CREATE Table my_users
(
    user_name VARCHAR(50),
    email VARCHAR(100)
);

INSERT INTO my_users VALUES('Mezba', 'mezba@mail.com'), ('Mir', 'mir@mail.com');
SELECT * from my_users;
SELECT * from deleted_users_audit;

CREATE Table deleted_users_audit
(
    deleted_user_name VARCHAR(50),
    deletedAt TIMESTAMP
)

CREATE Trigger save_deleted_user
BEFORE DELETE
ON my_users
FOR EACH ROW
EXECUTE FUNCTION save_deleted_user_func();


CREATE OR REPLACE FUNCTION save_deleted_user_func()
RETURNS TRIGGER
LANGUAGE PLPGSQL
AS
$$

BEGIN
INSERT INTO deleted_users_audit(deleted_user_name, deletedAt)
VALUES(OLD.user_name, NOW());
RAISE NOTICE 'User  has been deleted at ';
RETURN OLD;

END
$$



DELETE FROM my_users where user_name='Mir';