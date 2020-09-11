-- --------------------------------------------------------
-- Servidor:                     127.0.0.1
-- Versão do servidor:           5.7.24 - MySQL Community Server (GPL)
-- OS do Servidor:               Win64
-- HeidiSQL Versão:              10.2.0.5599
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

-- Copiando estrutura para tabela ouvidoria.alunodisciplina
CREATE TABLE IF NOT EXISTS `alunodisciplina` (
  `CODDISC` int(11) NOT NULL,
  `MATRICULA` varchar(13) NOT NULL,
  `CODTURMA` int(11) NOT NULL,
  `NOTA` float DEFAULT NULL,
  `FALTA` float DEFAULT NULL,
  PRIMARY KEY (`CODDISC`),
  KEY `MATRICULA` (`MATRICULA`),
  KEY `CODTURMA` (`CODTURMA`),
  CONSTRAINT `alunodisciplina_ibfk_1` FOREIGN KEY (`MATRICULA`) REFERENCES `alunos` (`MATRICULA`),
  CONSTRAINT `alunodisciplina_ibfk_2` FOREIGN KEY (`CODDISC`) REFERENCES `disciplina` (`CODDISC`),
  CONSTRAINT `alunodisciplina_ibfk_3` FOREIGN KEY (`CODTURMA`) REFERENCES `turmas` (`CODTURMA`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela ouvidoria.alunos
CREATE TABLE IF NOT EXISTS `alunos` (
  `MATRICULA` varchar(13) NOT NULL,
  `NOME` varchar(50) DEFAULT NULL,
  `ENDERECO` varchar(50) DEFAULT NULL,
  `CPF` varchar(14) DEFAULT NULL,
  `EMAIL` varchar(50) DEFAULT NULL,
  `DATA_NASCIMENTO` date DEFAULT NULL,
  `ESTADO_CIVIL` varchar(1) DEFAULT NULL,
  `CEP` varchar(9) DEFAULT NULL,
  `ESTADO` varchar(2) DEFAULT NULL,
  `CIDADE` varchar(20) DEFAULT NULL,
  `BAIRRO` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`MATRICULA`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela ouvidoria.cursos
CREATE TABLE IF NOT EXISTS `cursos` (
  `CODCURSO` int(11) NOT NULL,
  `NOMECURSO` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`CODCURSO`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela ouvidoria.disciplina
CREATE TABLE IF NOT EXISTS `disciplina` (
  `CODDISC` int(11) NOT NULL,
  `NOMEDISC` varchar(50) NOT NULL,
  PRIMARY KEY (`CODDISC`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela ouvidoria.turmas
CREATE TABLE IF NOT EXISTS `turmas` (
  `CODTURMA` int(11) NOT NULL,
  `CODCURSO` int(11) DEFAULT NULL,
  `DESCRICAOTURMA` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`CODTURMA`),
  KEY `CODCURSO` (`CODCURSO`),
  CONSTRAINT `turmas_ibfk_1` FOREIGN KEY (`CODCURSO`) REFERENCES `cursos` (`CODCURSO`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Exportação de dados foi desmarcado.

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
