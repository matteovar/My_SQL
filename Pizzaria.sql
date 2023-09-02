DROP TABLE Endereco CASCADE CONSTRAINT;
DROP TABLE Cliente CASCADE CONSTRAINT; 
DROP TABLE Ingredientes CASCADE CONSTRAINT; 
DROP TABLE Pizza CASCADE CONSTRAINT; 
DROP TABLE Bebida CASCADE CONSTRAINT;
DROP TABLE Pedido CASCADE CONSTRAINT; 
DROP TABLE Pagamento CASCADE CONSTRAINT; 
DROP TABLE Empregado CASCADE CONSTRAINT; 
DROP TABLE Entrega CASCADE CONSTRAINT;


-- CRIACAO DAS TABELAS


CREATE TABLE Endereco ( 
Id_Endereco INTEGER NOT NULL,
CEP VARCHAR(9) NOT NULL,
PRIMARY KEY(Id_Endereco));

CREATE TABLE Cliente ( 
Id_Cliente INTEGER NOT NULL, 
Nome VARCHAR(50) NOT NULL, 
Sobrenome VARCHAR(50) NOT NULL, 
Email VARCHAR(100) NOT NULL, 
Telefone VARCHAR(20) NOT NULL, 
Numero VARCHAR(10) NOT NULL, 
Id_Endereco INTEGER, 
PRIMARY KEY(Id_Cliente),
FOREIGN KEY (Id_Endereco) REFERENCES Endereco(Id_Endereco) );

CREATE TABLE Ingredientes ( 
Id_Ingredientes INTEGER NOT NULL,
Nome VARCHAR(50) NOT NULL, 
Quantidade INTEGER NOT NULL,
PRIMARY KEY (Id_Ingredientes));

CREATE TABLE Pizza ( 
Id_Pizza INTEGER NOT NULL, 
Quantidade INTEGER NOT NULL, 
Tamanho VARCHAR(50) NOT NULL, 
Nome VARCHAR(50) NOT NULL, 
Preco DECIMAL(10,2) NOT NULL, 
Id_Ingredientes INTEGER, 
PRIMARY KEY (Id_Pizza),
FOREIGN KEY (Id_Ingredientes) REFERENCES Ingredientes(Id_Ingredientes) );

CREATE TABLE Bebida ( 
Id_Bebida INTEGER NOT NULL, 
Valor DECIMAL(10,2) NOT NULL, 
Nome VARCHAR(50) NOT NULL, 
Quantidade INTEGER NOT NULL,
PRIMARY KEY (Id_Bebida));

CREATE TABLE Pedido ( 
Id_Pedido INTEGER, 
Status VARCHAR(50) NOT NULL, 
Id_Pizza INTEGER, 
Id_Bebida INTEGER, 
Id_Cliente INTEGER, 
PRIMARY KEY (Id_Pedido),
FOREIGN KEY (Id_Pizza) REFERENCES Pizza(Id_Pizza), 
FOREIGN KEY (Id_Bebida) REFERENCES Bebida(Id_Bebida), 
FOREIGN KEY (Id_Cliente) REFERENCES Cliente(Id_Cliente) );

CREATE TABLE Pagamento ( 
Id_Pagamento INTEGER NOT NULL, 
Tipo_de_Pagamento VARCHAR(50) NOT NULL, 
Total DECIMAL(10,2) NOT NULL, 
Id_Pedido INTEGER, 
PRIMARY KEY (Id_Pagamento),
FOREIGN KEY (Id_Pedido) REFERENCES Pedido(Id_Pedido));

CREATE TABLE Empregado ( 
Id_Empregado INTEGER NOT NULL, 
Nome VARCHAR(50) NOT NULL, 
Telefone VARCHAR(20) NOT NULL, 
Id_Pedido INTEGER, 
PRIMARY KEY(Id_Empregado),
FOREIGN KEY (Id_Pedido) REFERENCES Pedido(Id_Pedido) );

CREATE TABLE Entrega ( 
Id_Entrega INTEGER NOT NULL,
Status_da_entrega VARCHAR(50) NOT NULL, 
Horario_de_Entrega VARCHAR(50) NOT NULL, 
Id_Empregado INTEGER, 
PRIMARY KEY(Id_Entrega),
FOREIGN KEY (Id_Empregado) REFERENCES Empregado(Id_Empregado) );


-- INSERCAO DOS DADOS


INSERT INTO Endereco  VALUES (2001, '12680-091');
INSERT INTO Endereco  VALUES (2002, '85097-736');
INSERT INTO Endereco  VALUES (2003, '59890-123');

INSERT INTO Cliente  VALUES (1001, 'Maria', 'Souza', 'Souza@outlook.com', '(11) 9812673876', '50', 2001) ;
INSERT INTO Cliente  VALUES (1002, 'André', 'Miyazaki', 'miyazaki@gmail.com', '(11) 2135159872', '30', 2001);
INSERT INTO Cliente  VALUES (1003, 'Toguro', 'Andrade', 'Toguro@gmail.com', '(11) 6587927630', '10', 2002);

INSERT INTO Ingredientes VALUES (7001, 'Calabresa, Cebola', 1) ;
INSERT INTO Ingredientes VALUES (7002, 'Mussarela', 2);
INSERT INTO Ingredientes VALUES (7003, 'Frango', 1);

INSERT INTO Pizza VALUES (6001,1,   'Grande','Calabresa',59.99, 7001);
INSERT INTO Pizza VALUES (6002, 2, 'Grande','Queijo',  120.00, 7002);
INSERT INTO Pizza VALUES (6003,1, 'Grande','Frango',   69.99, 7003);
    
INSERT INTO Bebida  VALUES (5000,  8.00,'Sprite 2L', 1);
INSERT INTO Bebida  VALUES (5001,  16.00,'Coca 2L', 2);
INSERT INTO Bebida  VALUES (5002,  6.00,'Guarana (lata)', 1);

INSERT INTO Pedido VALUES (4001, 'Pronto', 6001, 5002, 1001);
INSERT INTO Pedido VALUES (4002, 'Fazendo', 6002, 5000, 1003);
INSERT INTO Pedido VALUES (4003, 'Pronto', 6003, 5001, 1002);

INSERT INTO Pagamento VALUES (8001, 'pix', 64.99, 4001);
INSERT INTO Pagamento VALUES (8002, 'Cartão_credito',  128.00,4002); 
INSERT INTO Pagamento VALUES (8003, 'Cartão_devito', 85.99 ,4003);

INSERT INTO Empregado VALUES (3001, 'Rogerio', '11 09816359', 4001); 
INSERT INTO Empregado VALUES (3002, 'Theodoro', '11 17563490', 4002);
INSERT INTO Empregado VALUES (3003, 'Mickey', '11 87191873', 4003);

INSERT INTO Entrega VALUES (9001,'entregue', '19h', 3001 );
INSERT INTO Entrega VALUES (9002,'A caminho', '21h - 22h', 3002);
INSERT INTO Entrega VALUES (9003,'entregue','20h', 3002 );

-- TABELAS COM DADOS
SELECT * 
FROM Endereco;

SELECT * 
FROM Cliente ;

SELECT * 
FROM Ingredientes ;

SELECT * 
FROM Pizza ;

SELECT * 
FROM Bebida ;

SELECT * 
FROM Pedido ;

SELECT * 
FROM Pagamento ;

SELECT * 
FROM Empregado ;

SELECT * 
FROM Entrega ;

SELECT Cliente.Nome, Cliente.Sobrenome, Endereco.CEP 
FROM Cliente 
INNER JOIN Endereco ON Cliente.Id_Endereco = Endereco.Id_Endereco;

SELECT Pagamento.Tipo_de_Pagamento, SUM(Pagamento.Total) 
FROM Pagamento 
INNER JOIN Pedido ON Pagamento.Id_Pedido = Pedido.Id_Pedido 
GROUP BY Pagamento.Tipo_de_Pagamento;

SELECT p.Id_Pedido, b.Nome, b.Valor
FROM Pedido p
LEFT JOIN Bebida b ON p.Id_Bebida = b.Id_Bebida;

SELECT pa.Id_Pagamento, pa.Tipo_de_Pagamento, pa.Total, pe.Status
FROM Pagamento pa
RIGHT JOIN Pedido pe ON pa.Id_Pedido = pe.Id_Pedido;

SELECT Pedido.Id_Pedido, Cliente.Nome, Cliente.Sobrenome, Pizza.Nome, Bebida.Nome, Pagamento.Tipo_de_Pagamento 
FROM Pedido 
INNER JOIN Cliente ON Pedido.Id_Cliente = Cliente.Id_Cliente 
LEFT JOIN Pizza ON Pedido.Id_Pizza = Pizza.Id_Pizza 
LEFT JOIN Bebida ON Pedido.Id_Bebida = Bebida.Id_Bebida 
INNER JOIN Pagamento ON Pedido.Id_Pedido = Pagamento.Id_Pedido 
WHERE Pedido.Status = 'Pronto';

# 5.1. Consulta sem GROUP BY envolvendo duas tabelas (com INNER JOIN):
SELECT P.Ambientacao, C.Nome
FROM Palco P
INNER JOIN colaboradores c ON P.Id_palco = C.Id_colaborador;

# 5.2. Consulta com GROUP BY envolvendo duas tabelas (com INNER JOIN):
SELECT B.Ingressos, COUNT(A.Id_artista) AS Total_Atracoes
FROM bilheteria B
INNER JOIN Atracoes A ON B.Id_bilheteria = A.Id_artista
GROUP BY B.Ingressos;

# 5.3. Consulta contendo duas tabelas e utilizando LEFT JOIN ou RIGHT JOIN:
SELECT C.Nome, B.Ingressos
FROM Colaboradores C
LEFT JOIN Colaboradores_Bilheteria CB ON C.Id_colaborador = CB.Id_colaborador
LEFT JOIN Bilheteria B ON CB.Id_bilheteria = B.Id_bilheteria;

# 5.4. Consulta contendo três ou mais tabelas (pode ser utilizado INNER JOIN, LEFT JOIN ou RIGHT JOIN):
SELECT P.Ambientacao, A.Nome, B.Ingressos
FROM Palco P
INNER JOIN Atracoes A ON P.Id_palco = A.Id_artista
LEFT JOIN Bilheteria_Atracoes BA ON A.Id_artista = BA.Id_artista
INNER JOIN Bilheteria B ON BA.Id_bilheteria = B.Id_bilheteria;
