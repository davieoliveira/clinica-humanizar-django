-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Tempo de geração: 05/11/2026 às 17:57
-- Versão do servidor: 10.4.32-MariaDB
-- Versão do PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Banco de dados: `projeto_integrador`
--

-- --------------------------------------------------------

--
-- Estrutura para tabela `tbconsulta`
--

CREATE TABLE `tbconsulta` (
  `id_consulta` int(11) NOT NULL,
  `id_medico` int(11) NOT NULL,
  `id_paciente` int(11) NOT NULL,
  `detalhes_consulta` text DEFAULT NULL,
  `horario_consulta` time NOT NULL,
  `data_consulta` date NOT NULL,
  `status_consulta` enum('agendada','confirmada','realizada','cancelada') DEFAULT 'agendada'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `tbconsulta`
--

INSERT INTO `tbconsulta` (`id_consulta`, `id_medico`, `id_paciente`, `detalhes_consulta`, `horario_consulta`, `data_consulta`, `status_consulta`) VALUES
(1, 3, 6, 'Paciente relata dores no peito ocasionais.', '08:00:00', '2026-11-05', 'confirmada'),
(2, 4, 7, 'Avaliação dermatológica de rotina.', '09:30:00', '2026-11-05', 'agendada'),
(3, 5, 8, 'Consulta pediátrica de acompanhamento.', '10:00:00', '2026-11-06', 'agendada'),
(4, 3, 9, 'Retorno para avaliação cardiológica.', '14:00:00', '2026-11-06', 'realizada'),
(5, 4, 10, 'Avaliação de irritação na pele.', '15:30:00', '2026-11-07', 'cancelada');

-- --------------------------------------------------------

--
-- Estrutura para tabela `tbespecialidade`
--

CREATE TABLE `tbespecialidade` (
  `id_especialidade` int(11) NOT NULL,
  `nome_especialidade` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `tbespecialidade`
--

INSERT INTO `tbespecialidade` (`id_especialidade`, `nome_especialidade`) VALUES
(1, 'Cardiologia'),
(2, 'Dermatologia'),
(3, 'Pediatria'),
(4, 'Ortopedia'),
(5, 'Neurologia');

-- --------------------------------------------------------

--
-- Estrutura para tabela `tbusuario`
--

CREATE TABLE `tbusuario` (
  `id_usuario` int(11) NOT NULL,
  `nome_usuario` varchar(150) NOT NULL,
  `email_usuario` varchar(150) NOT NULL,
  `senha_usuario` varchar(255) NOT NULL,
  `cpf_usuario` varchar(14) NOT NULL,
  `crm_usuario` varchar(20) DEFAULT NULL,
  `genero_usuario` varchar(30) DEFAULT NULL,
  `id_especialidade` int(11) DEFAULT NULL,
  `tipo_usuario` enum('paciente','medico','recepcionista','administrador') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `tbusuario`
--

INSERT INTO `tbusuario` (`id_usuario`, `nome_usuario`, `email_usuario`, `senha_usuario`, `cpf_usuario`, `crm_usuario`, `genero_usuario`, `id_especialidade`, `tipo_usuario`) VALUES
(1, 'Carlos Administrador', 'admin.humanizar@gmail.com', '$2b$12$EoiyuYgCNjakBv75NGe6kujY0aOZoRT0QXfGs7EZaiUZMsB9BagAG', '00000000001', NULL, 'Masculino', NULL, 'administrador'),
(2, 'Ana Recepcionista', 'recepcao.humanizar@gmail.com', '$2b$12$EoiyuYgCNjakBv75NGe6kujY0aOZoRT0QXfGs7EZaiUZMsB9BagAG', '00000000002', NULL, 'Feminino', NULL, 'recepcionista'),
(3, 'Roberto Almeida', 'roberto.almeida@gmail.com', '$2b$12$EoiyuYgCNjakBv75NGe6kujY0aOZoRT0QXfGs7EZaiUZMsB9BagAG', '00000000003', 'CRM12345', 'Masculino', 1, 'medico'),
(4, 'Mariana Costa', 'mariana.costa@gmail.com', '$2b$12$EoiyuYgCNjakBv75NGe6kujY0aOZoRT0QXfGs7EZaiUZMsB9BagAG', '00000000004', 'CRM23456', 'Feminino', 2, 'medico'),
(5, 'Pedro Santos', 'pedro.santos@gmail.com', '$2b$12$EoiyuYgCNjakBv75NGe6kujY0aOZoRT0QXfGs7EZaiUZMsB9BagAG', '00000000005', 'CRM34567', 'Masculino', 3, 'medico'),
(6, 'João Silva', 'joao.silva@gmail.com', '$2b$12$EoiyuYgCNjakBv75NGe6kujY0aOZoRT0QXfGs7EZaiUZMsB9BagAG', '00000000006', NULL, 'Masculino', NULL, 'paciente'),
(7, 'Maria Oliveira', 'maria.oliveira@gmail.com', '$2b$12$EoiyuYgCNjakBv75NGe6kujY0aOZoRT0QXfGs7EZaiUZMsB9BagAG', '00000000007', NULL, 'Feminino', NULL, 'paciente'),
(8, 'Lucas Ferreira', 'lucas.ferreira@gmail.com', '$2b$12$EoiyuYgCNjakBv75NGe6kujY0aOZoRT0QXfGs7EZaiUZMsB9BagAG', '00000000008', NULL, 'Masculino', NULL, 'paciente'),
(9, 'Juliana Souza', 'juliana.souza@gmail.com', '$2b$12$EoiyuYgCNjakBv75NGe6kujY0aOZoRT0QXfGs7EZaiUZMsB9BagAG', '00000000009', NULL, 'Feminino', NULL, 'paciente'),
(10, 'Fernanda Lima', 'fernanda.lima@gmail.com', '$2b$12$EoiyuYgCNjakBv75NGe6kujY0aOZoRT0QXfGs7EZaiUZMsB9BagAG', '00000000010', NULL, 'Feminino', NULL, 'paciente');

-- --------------------------------------------------------

--
-- Estrutura stand-in para view `vw_consultas`
-- (Veja abaixo para a visão atual)
--
CREATE TABLE `vw_consultas` (
`id_consulta` int(11)
,`id_medico` int(11)
,`nome_medico` varchar(150)
,`id_paciente` int(11)
,`nome_paciente` varchar(150)
,`especialidade` varchar(100)
,`detalhes_consulta` text
,`data_consulta` date
,`horario_consulta` time
,`status_consulta` enum('agendada','confirmada','realizada','cancelada')
);

-- --------------------------------------------------------

--
-- Estrutura para view `vw_consultas`
--
DROP TABLE IF EXISTS `vw_consultas`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vw_consultas`  AS SELECT `c`.`id_consulta` AS `id_consulta`, `c`.`id_medico` AS `id_medico`, `m`.`nome_usuario` AS `nome_medico`, `c`.`id_paciente` AS `id_paciente`, `p`.`nome_usuario` AS `nome_paciente`, `e`.`nome_especialidade` AS `especialidade`, `c`.`detalhes_consulta` AS `detalhes_consulta`, `c`.`data_consulta` AS `data_consulta`, `c`.`horario_consulta` AS `horario_consulta`, `c`.`status_consulta` AS `status_consulta` FROM (((`tbconsulta` `c` join `tbusuario` `m` on(`c`.`id_medico` = `m`.`id_usuario`)) join `tbusuario` `p` on(`c`.`id_paciente` = `p`.`id_usuario`)) left join `tbespecialidade` `e` on(`m`.`id_especialidade` = `e`.`id_especialidade`)) ;

--
-- Índices para tabelas despejadas
--

--
-- Índices de tabela `tbconsulta`
--
ALTER TABLE `tbconsulta`
  ADD PRIMARY KEY (`id_consulta`),
  ADD KEY `fk_consulta_medico` (`id_medico`),
  ADD KEY `fk_consulta_paciente` (`id_paciente`);

--
-- Índices de tabela `tbespecialidade`
--
ALTER TABLE `tbespecialidade`
  ADD PRIMARY KEY (`id_especialidade`);

--
-- Índices de tabela `tbusuario`
--
ALTER TABLE `tbusuario`
  ADD PRIMARY KEY (`id_usuario`),
  ADD UNIQUE KEY `email_usuario` (`email_usuario`),
  ADD UNIQUE KEY `cpf_usuario` (`cpf_usuario`),
  ADD UNIQUE KEY `crm_usuario` (`crm_usuario`),
  ADD KEY `fk_usuario_especialidade` (`id_especialidade`);

--
-- AUTO_INCREMENT para tabelas despejadas
--

--
-- AUTO_INCREMENT de tabela `tbconsulta`
--
ALTER TABLE `tbconsulta`
  MODIFY `id_consulta` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de tabela `tbespecialidade`
--
ALTER TABLE `tbespecialidade`
  MODIFY `id_especialidade` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de tabela `tbusuario`
--
ALTER TABLE `tbusuario`
  MODIFY `id_usuario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- Restrições para tabelas despejadas
--

--
-- Restrições para tabelas `tbconsulta`
--
ALTER TABLE `tbconsulta`
  ADD CONSTRAINT `fk_consulta_medico` FOREIGN KEY (`id_medico`) REFERENCES `tbusuario` (`id_usuario`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_consulta_paciente` FOREIGN KEY (`id_paciente`) REFERENCES `tbusuario` (`id_usuario`) ON UPDATE CASCADE;

--
-- Restrições para tabelas `tbusuario`
--
ALTER TABLE `tbusuario`
  ADD CONSTRAINT `fk_usuario_especialidade` FOREIGN KEY (`id_especialidade`) REFERENCES `tbespecialidade` (`id_especialidade`) ON DELETE SET NULL ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
