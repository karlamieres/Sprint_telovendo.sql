create schema telovendo_sprint;

CREATE USER 'equipo_verde'@'localhost' IDENTIFIED BY 'verde';

GRANT CREATE, DROP, ALTER, INSERT ON *.* TO 'equipo_verde'@'localhost';

FLUSH PRIVILEGES;

USE telovendo_sprint; 
-- Creamos tabla de proveedores
CREATE TABLE
    proveedores (
        id INT PRIMARY KEY,
        nombre_representante VARCHAR(50),
        nombre_corporativo VARCHAR(50),
        telefono1 VARCHAR(15),
        telefono2 VARCHAR(15),
        nombre_empresa VARCHAR(50),
        nombre_contacto VARCHAR(50),
        categoria VARCHAR(50),
        correo_electronico VARCHAR(50)
    );

-- Creamos tabla de clientes

CREATE TABLE
    clientes (
        id INT PRIMARY KEY,
        nombre VARCHAR(50),
        apellido VARCHAR(50),
        direccion VARCHAR(100)
    );

-- Creamos tabla de productos

CREATE TABLE
    productos (
        id INT PRIMARY KEY,
        nombre VARCHAR(50),
        precio DECIMAL(10, 2),
        categoria VARCHAR(50),
        color VARCHAR(20),
        stock INT,
        proveedor_id INT,
        FOREIGN KEY (proveedor_id) REFERENCES proveedores(id)
    );

-- Insertar datos de proveedores
INSERT INTO proveedores (id, nombre_representante, nombre_empresa, telefono1, telefono2, nombre_contacto, categoria, correo_electronico)
VALUES
  (1, 'Miguel Ángel Gómez', 'TechSoluciones', '1111111111', '2222222222', 'Juan Carlos López', 'Electrónicos', 'miguel@example.com'),
  (2, 'Gabriel García Márquez', 'TechInnovación', '3333333333', '4444444444', 'Luisa Fernández', 'Electrónicos', 'gabriel@example.com'),
  (3, 'Fernanda Silva', 'TechProyectos', '5555555555', '6666666666', 'María Rodríguez', 'Electrónicos', 'fernanda@example.com'),
  (4, 'Sebastián Hernández', 'TechSoluciones', '7777777777', '8888888888', 'Sofía Gutiérrez', 'Electrónicos', 'sebastian@example.com'),
  (5, 'Valentina González', 'TechInnovación', '9999999999', '0000000000', 'Camila López', 'Electrónicos', 'valentina@example.com');

Select * from proveedores; 
-- Insertar datos de clientes

INSERT INTO clientes (id, nombre, apellido, direccion)
VALUES
  (1, 'Miguel', 'Gómez', 'Calle Barros Arana 123'),
  (2, 'Gabriel', 'Márquez', 'Avenida OHiggins 456'),
  (3, 'Fernanda', 'Silva', 'Calle Aníbal Pinto 789'),
  (4, 'Sebastián', 'Hernández', 'Avenida Los Carrera 987'),
  (5, 'Valentina', 'González', 'Calle Freire 654');
  
  Select * from clientes;
  
-- Insertar datos de productos electrónicos
INSERT INTO productos (id, nombre, precio, categoria, proveedor_id, color, stock)
VALUES
  (1, 'iPhone 13 Pro', 129990, 'Smartphones', 1, 'Gris', 50),
  (2, 'Samsung Galaxy S21 Ultra', 119900, 'Smartphones', 2, 'Negro', 40),
  (3, 'Sony WH-1000XM4', 349000, 'Audífonos', 2, 'Negro', 30),
  (4, 'LG C1 OLED TV', 199900, 'Televisores', 1, 'Negro', 20),
  (5, 'DJI Mavic Air 2', 79900, 'Drones', 5, 'Gris', 10),
  (6, 'Nintendo Switch', 29900, 'Consolas de videojuegos', 5, 'Rojo/Negro', 15),
  (7, 'Sony PlayStation 5', 499000, 'Consolas de videojuegos', 3, 'Blanco', 5),
  (8, 'Apple MacBook Pro', 1999000, 'Computadoras portátiles', 4, 'Gris', 25),
  (9, 'Samsung Q90T QLED TV', 179900, 'Televisores', 4, 'Negro', 15),
  (10, 'GoPro HERO9 Black', 44900, 'Cámaras de acción', 3, 'Negro', 8);

select * from productos; 
-- a) Categoría de productos que más se repite:
SELECT categoria, COUNT(*) AS cantidad 
FROM productos
GROUP BY categoria
ORDER BY cantidad DESC
LIMIT 1;

-- b) Los 5 Productos con mayor stock

SELECT * FROM productos ORDER BY stock DESC LIMIT 5;

-- c) Color de producto más común

SELECT color, COUNT(*) AS cantidad
FROM productos
GROUP BY color
ORDER BY cantidad DESC
LIMIT 1;

-- d) Proveedor(es) con menor stock de productos

SELECT proveedores.* FROM proveedores
    INNER JOIN productos ON proveedores.id = productos.proveedor_id
GROUP BY proveedores.id
ORDER BY
    SUM(productos.stock) ASC
LIMIT 1;

-- Desactivamos el modo de actualización segura (safe update mode)

SET SQL_SAFE_UPDATES = 0;

-- Cambiar la categoría de productos más popular por 'Electrónica y computación':

UPDATE productos
SET categoria = 'Electrónica y computación'
WHERE categoria = (
  SELECT categoria
  FROM (
    SELECT categoria, COUNT(*) AS count
    FROM productos
    GROUP BY categoria
    ORDER BY count DESC
    LIMIT 1
  ) AS subquery
);

-- Activamos el modo de actualización segura (safe update mode)

SET SQL_SAFE_UPDATES = 1;
    
-- Error Code: 1175. You are using safe update mode and you tried to update a table without a WHERE that uses a KEY column To disable safe mode, toggle the option in Preferences -> SQL Editor and reconnect.
    
    