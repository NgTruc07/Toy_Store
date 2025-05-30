USE web_code
GO

Alter Table order_tb
add payment_method_id Varchar(25) NULL;

ALTER TABLE address
ALTER COLUMN user_id INT;
go

ALTER TABLE address
ADD CONSTRAINT FK_address_user
FOREIGN KEY (user_id)
REFERENCES user_tb(user_id);