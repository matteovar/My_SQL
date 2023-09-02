# Criação do banco de dados
CREATE DATABASE MeuBancoDeDados;
USE MeuBancoDeDados;

# Criação das tabelas
CREATE TABLE Palco (
  Id_palco INT PRIMARY KEY,
  Ambientacao VARCHAR(50),
  Shows VARCHAR(50)
);

CREATE TABLE Colaboradores (
  Id_colaborador INT PRIMARY KEY,
  Nome VARCHAR(50)
);

CREATE TABLE Bilheteria (
  Id_bilheteria INT PRIMARY KEY,
  Ingressos INT
);

CREATE TABLE Atracoes (
  Id_artista INT PRIMARY KEY,
  Nome VARCHAR(50),
  Horarios VARCHAR(50),
  Localizacao VARCHAR(50),
  Lotacao INT
);

CREATE TABLE Palco_Colaboradores (
  Id_palco INT,
  Id_colaborador INT,
  Turnos VARCHAR(50),
  PRIMARY KEY (Id_palco, Id_colaborador),
  FOREIGN KEY (Id_palco) REFERENCES Palco(Id_palco),
  FOREIGN KEY (Id_colaborador) REFERENCES Colaboradores(Id_colaborador)
);

CREATE TABLE Colaboradores_Bilheteria (
  Id_colaborador INT,
  Id_bilheteria INT,
  Turnos VARCHAR(50),
  PRIMARY KEY (Id_colaborador, Id_bilheteria),
  FOREIGN KEY (Id_colaborador) REFERENCES Colaboradores(Id_colaborador),
  FOREIGN KEY (Id_bilheteria) REFERENCES Bilheteria(Id_bilheteria)
);

CREATE TABLE Bilheteria_Atracoes (
  Id_bilheteria INT,
  Id_artista INT,
  Preparacao VARCHAR(50),
  PRIMARY KEY (Id_bilheteria, Id_artista),
  FOREIGN KEY (Id_bilheteria) REFERENCES Bilheteria(Id_bilheteria),
  FOREIGN KEY (Id_artista) REFERENCES Atracoes(Id_artista)
);

# Inserção de dados nas tabelas
INSERT INTO Palco (Id_palco, Ambientacao, Shows)
VALUES
  (124, 'Iluminação de Neon', 'Show das Estrelas'),
  (215, 'Cenário Futurista', 'Aventuras Musicais'),
  (397, 'Decoração de Praia', 'Sons do Verão'),
  (411, 'Estilo Vintage', 'Noite Retrô'),
  (700, 'Cenário Clássico', 'Noite de Ópera'),
  (800, 'Palco das Maravilhas', 'Show de Ilusionismo'),
  (900, 'Estilo Country', 'Country Music Festival');


INSERT INTO Colaboradores (Id_colaborador, Nome)
VALUES
  (123, 'Miguel Angelo'),
  (215, 'Luna Silva'),
  (411, 'Aurora Costa'),
  (534, 'Dante Martins'),
  (700, 'Gustavo Ciola'),
  (800, 'André Akio'),
  (900, 'Fernando Bilha');

INSERT INTO Bilheteria (Id_bilheteria, Ingressos)
VALUES
  (123, 100),
  (221, 150),
  (475, 200),
  (534, 120),
  (700, 112),
  (800, 267),
  (900, 121);

INSERT INTO Atracoes (Id_artista, Nome, Horarios, Localizacao, Lotacao)
VALUES
  (125, 'Mágico Melchior', '19:00 - 21:00', 'Palco Central', 500),
  (221, 'Banda Lunáticos', '20:30 - 22:30', 'Palco Principal', 300),
  (475, 'DJ Astro', '22:00 - 23:30', 'Palco Eletrônico', 400),
  (542, 'Cantor Encantador', '21:30 - 23:00', 'Palco Acústico', 250),
  (700, 'Cantor de funk', '20:30 - 22:30', 'Palco Principal', 200),
  (800, 'Ilusionista de mágica', '21:00 - 23:00', 'Palco Eletrônico', 300),
  (900, 'Banda Country', '22:30 - 00:30', 'Palco Acústico', 250);

INSERT INTO Palco_Colaboradores (Id_palco, Id_colaborador, Turnos)
VALUES
  (124, 123, 'Manhã'),
  (215, 215, 'Tarde'),
  (397, 411, 'Noite'),
  (411, 534, 'Manhã'),
  (700, 700, 'Manhã'),
  (800, 800, 'Tarde'),
  (900, 900, 'Manhã');

INSERT INTO Colaboradores_Bilheteria (Id_colaborador, Id_bilheteria, Turnos)
VALUES
  (123, 123, 'Tarde'),
  (215, 221, 'Noite'),
  (411, 475, 'Manhã'),
  (534, 534, 'Tarde'),
  (700, 700, 'Tarde'),
  (800, 800, 'Noite'),
  (900, 900, 'Manhã');

INSERT INTO Bilheteria_Atracoes (Id_bilheteria, Id_artista, Preparacao)
VALUES
  (123, 125, 'Montagem de palco'),
  (221, 221, 'Controle de ingressos'),
  (475, 475, 'Venda de produtos'),
  (534, 542, 'Recepção de público'),
  (700, 700, 'Montagem de palco'),
  (800, 800, 'Recepção de público'),
  (900, 900, 'Preparação de equipamentos');