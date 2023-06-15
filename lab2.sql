create table brand (
    brand_code nvarchar(100) primary key,
    brand_name nvarchar(100) not null,
    country nvarchar(100) not null
);

create table product (
    product_code nvarchar(10) primary key,
    name nvarchar(255) not null,
    color nvarchar(50) not null,
    price DECIMAL(18, 2) not null,
    brand_code nvarchar(100) not null,
    FOREIGN KEY (brand_code) REFERENCES brand (brand_code)
);

create table company (
    company_code nvarchar(255) primary key,
    name nvarchar(255) not null,
    address nvarchar(255) not null,
    tel VARCHAR(255) not null,
    manager nvarchar(100) not null
);

create table client (
    client_code nvarchar(255) primary key,
    name nvarchar(255) not null,
    address nvarchar(255) not null,
    tel VARCHAR(255) not null
);

create table history_supply (
    id bigint identity(1, 1) primary key,
    company_code nvarchar(255) not null,
    product_code nvarchar(10) not null,
    client_code nvarchar(255) not null,
    date date not null,
    quantity int not null,
    FOREIGN KEY (company_code) REFERENCES company (company_code),
    FOREIGN KEY (product_code) REFERENCES product (product_code),
    FOREIGN KEY (client_code) REFERENCES client (client_code)
);

-- Tạo dữ liệu cho bảng brand
INSERT INTO brand (brand_code, brand_name, country)
VALUES ('B001', 'Apple', 'Country 1'),
       ('B002', 'Apple', 'Country 2'),
       ('B003', 'Brand 3', 'Country 3');

-- Tạo dữ liệu cho bảng product
INSERT INTO product (product_code, name, color, price, brand_code)
VALUES ('P001', 'Product 1', 'Red', 10.99, 'B001'),
       ('P002', 'Product 2', 'Blue', 19.99, 'B002'),
       ('P003', 'Product 3', 'Green', 14.99, 'B003');

-- Tạo dữ liệu cho bảng company
INSERT INTO company (company_code, name, address, tel, manager)
VALUES ('C001', 'Company 1', N'Ha Noi', '1234567890', 'Manager 1'),
       ('C002', 'Company 2', N'Ha Noi', '9876543210', 'Manager 2'),
       ('C003', 'Company 3', 'Address 3', '4567890123', 'Manager 3');
-- Tạo dữ liệu cho bảng client
INSERT INTO client (client_code, name, address, tel)
VALUES ('K001', N'Hai Ha', 'Address 1', '1111111111'),
       ('K002', 'Client 2', 'Address 2', '2222222222'),
       ('K003', 'Client 3', 'Address 3', '3333333333');

-- Tạo dữ liệu cho bảng history_supply
INSERT INTO history_supply (company_code, product_code, client_code, date, quantity)
VALUES ('C001', 'P001', 'K001', '2023-01-01', 5),
       ('C002', 'P002', 'K002', '2023-01-02', 8),
       ('C003', 'P003', 'K003', '2023-01-03', 10),
	   ('C002', 'P001', 'K001', '2023-01-01', 5),
	   ('C003', 'P002', 'K001', '2023-01-01', 5),
	   ('C001', 'P003', 'K002', '2023-01-01', 5);

delete from product
select * from brand;
select * from client;
select * from company;
select * from product;
select * from history_supply;

select * from company where 
address like N'%Ha Noi%';

select * from company where company_code 
in ( select company_code from history_supply where product_code
in ( select product_code from product where brand_code 
in ( select brand_code from brand where brand_name like '%Apple%')))

select * from company where company_code 
in ( select company_code from history_supply where client_code
not in ( select client_code from client where name like N'%Hai Ha%'))
-- Mat hang co don gia lon nhat
select * from product where price = (select max(price) from product);

SELECT *, (SELECT COUNT(product_code) FROM history_supply WHERE history_supply.product_code = product.product_code) AS count
FROM product
WHERE product_code IN (SELECT product_code FROM history_supply where client_code
in (select client_code from client where name like N'%Hai Ha%'))

