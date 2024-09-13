Halloween:

CREATE TABLE halloween (

id int auto_increment not null primary key,
nome varchar(100),
gmail varchar(100),
idade int(3)

);

DELIMITER $$
CREATE PROCEDURE InsereUsuariosAleatorios()
BEGIN
DECLARE i INT DEFAULT 0;
WHILE i < 10000 DO
SET @nome := CONCAT('Nome', i);
SET @gmail := CONCAT('usuario', i, '@exemplo.com');
SET @idade := FLOOR(RAND() * 80) + 18; 
INSERT INTO halloween (nome, email, idade) VALUES (@nome, @gmail, @idade);
SET i = i + 1;
END WHILE;
END$$
DELIMITER ;
 
CALL InsereUsuariosAleatorios();
 
select * from tabela_halloween;
--------------------------------------------------------------------------------

Teatro:


create table apresentacao_teatro (
 
	id_apresentacao int primary key not null auto_increment,
    	nome_apresentacao varchar(200),
    	descricao varchar(500),
    	duracao int,
    	data_hora datetime,
    	diretor varchar(100),
    	local_apresentacao varchar(100),
    	categoria varchar(100)
 
);


INSERT INTO apresentacao_teatro (nome_apresentacao, descricao, duracao, data_hora, diretor, local_ apresentacao, categoria)
VALUES ("Senhor dos aneis ", "Conflito contra o mal que se alastra pela Terra-média", 120, "2024-09-12 17:45:00", "Peter Jackson", "Teatro Vasques", "Aventura");

INSERT INTO apresentacao_teatro (nome_ apresentacao, descricao, duracao, data_hora, diretor, local_ apresentacao, categoria)
VALUES ("Dom Quixote", "é um cavaleiro andante, nomeado como Sancho como “Cavaleiro da Triste Figura”", 90, "2024-09-17 22:00:00", "Terry Gilliam", "Teatro Bradesco", "Ficção histórica");

SELECT AVG(duracao) AS media_duracao
FROM apresentacao_teatro;
 
DELIMITER $$

CREATE FUNCTION verificar_disponibilidade(data_hora DATETIME)
RETURNS BOOLEAN
DETERMINISTIC
BEGIN
    DECLARE resultado INT;

    SELECT COUNT(*)
    INTO resultado
    FROM apresentacao_teatro
    WHERE data_hora = data_hora;

    IF resultado > 0 THEN
        RETURN FALSE; -- Horário não disponível
    ELSE
        RETURN TRUE; -- Horário disponível
    END IF;
END $$

DELIMITER ;

SET @horario_verificar = '2024-09-12 17:45:00';
SELECT verificar_disponibilidade(@horario_verificar) AS disponivel;


---------------------------------------------------------------------------------------------
Biblioteca

CREATE TABLE autor (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100),
    sobrenome VARCHAR(100)
);

CREATE TABLE livro (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100),
    ano_publicacao DATE
);

CREATE TABLE autor_livro (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    id_autor INT,
    id_livro INT,
    FOREIGN KEY (id_autor) REFERENCES autor(id),
    FOREIGN KEY (id_livro) REFERENCES livro(id)
);

CREATE TABLE reserva (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    id_livro INT,
    data_inicio DATE,
    data_fim DATE,
    FOREIGN KEY (id_livro) REFERENCES livro(id)
);
DELIMITER $$

CREATE PROCEDURE criar_reserva (
    IN nome_autor VARCHAR(100),
    IN sobrenome_autor VARCHAR(100),
    IN nome_livro VARCHAR(100),
    IN ano_publicacao DATE,
    IN data_inicio DATE,
    IN data_fim DATE
)
BEGIN
    
    INSERT INTO autor (nome, sobrenome) 
    VALUES (nome_autor, sobrenome_autor);

  
    SET @id_autor = LAST_INSERT_ID();


    INSERT INTO livro (nome, ano_publicacao) 
    VALUES (nome_livro, ano_publicacao);

  
    SET @id_livro = LAST_INSERT_ID();

  
    INSERT INTO autor_livro (id_autor, id_livro) 
    VALUES (@id_autor, @id_livro);


    INSERT INTO reserva (id_livro, data_inicio, data_fim) 
    VALUES (@id_livro, data_inicio, data_fim);
END $$

DELIMITER ;