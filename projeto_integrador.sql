-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Tempo de geração: 10/11/2026 às 19:48
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
-- Estrutura para tabela `auth_group`
--

CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL,
  `name` varchar(150) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `auth_group_permissions`
--

CREATE TABLE `auth_group_permissions` (
  `id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `auth_permission`
--

CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `auth_permission`
--

INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
(1, 'Can add log entry', 6, 'add_logentry'),
(2, 'Can change log entry', 6, 'change_logentry'),
(3, 'Can delete log entry', 6, 'delete_logentry'),
(4, 'Can view log entry', 6, 'view_logentry'),
(5, 'Can add permission', 7, 'add_permission'),
(6, 'Can change permission', 7, 'change_permission'),
(7, 'Can delete permission', 7, 'delete_permission'),
(8, 'Can view permission', 7, 'view_permission'),
(9, 'Can add group', 8, 'add_group'),
(10, 'Can change group', 8, 'change_group'),
(11, 'Can delete group', 8, 'delete_group'),
(12, 'Can view group', 8, 'view_group'),
(13, 'Can add user', 9, 'add_user'),
(14, 'Can change user', 9, 'change_user'),
(15, 'Can delete user', 9, 'delete_user'),
(16, 'Can view user', 9, 'view_user'),
(17, 'Can add content type', 1, 'add_contenttype'),
(18, 'Can change content type', 1, 'change_contenttype'),
(19, 'Can delete content type', 1, 'delete_contenttype'),
(20, 'Can view content type', 1, 'view_contenttype'),
(21, 'Can add session', 2, 'add_session'),
(22, 'Can change session', 2, 'change_session'),
(23, 'Can delete session', 2, 'delete_session'),
(24, 'Can view session', 2, 'view_session'),
(25, 'Can add consulta', 5, 'add_consulta'),
(26, 'Can change consulta', 5, 'change_consulta'),
(27, 'Can delete consulta', 5, 'delete_consulta'),
(28, 'Can view consulta', 5, 'view_consulta'),
(29, 'Can add especialidade', 3, 'add_especialidade'),
(30, 'Can change especialidade', 3, 'change_especialidade'),
(31, 'Can delete especialidade', 3, 'delete_especialidade'),
(32, 'Can view especialidade', 3, 'view_especialidade'),
(33, 'Can add usuario', 4, 'add_usuario'),
(34, 'Can change usuario', 4, 'change_usuario'),
(35, 'Can delete usuario', 4, 'delete_usuario'),
(36, 'Can view usuario', 4, 'view_usuario');

-- --------------------------------------------------------

--
-- Estrutura para tabela `auth_user`
--

CREATE TABLE `auth_user` (
  `id` int(11) NOT NULL,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(150) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `auth_user_groups`
--

CREATE TABLE `auth_user_groups` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `auth_user_user_permissions`
--

CREATE TABLE `auth_user_user_permissions` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `django_admin_log`
--

CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext DEFAULT NULL,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) UNSIGNED NOT NULL CHECK (`action_flag` >= 0),
  `change_message` longtext NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `django_content_type`
--

CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `django_content_type`
--

INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES
(6, 'admin', 'logentry'),
(8, 'auth', 'group'),
(7, 'auth', 'permission'),
(9, 'auth', 'user'),
(1, 'contenttypes', 'contenttype'),
(2, 'sessions', 'session'),
(5, 'usuarios', 'consulta'),
(3, 'usuarios', 'especialidade'),
(4, 'usuarios', 'usuario');

-- --------------------------------------------------------

--
-- Estrutura para tabela `django_migrations`
--

CREATE TABLE `django_migrations` (
  `id` bigint(20) NOT NULL,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `django_migrations`
--

INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES
(1, 'contenttypes', '0001_initial', '2026-11-05 17:18:08.145823'),
(2, 'contenttypes', '0002_remove_content_type_name', '2026-11-05 17:18:08.209127'),
(3, 'sessions', '0001_initial', '2026-11-05 17:18:08.236962'),
(4, 'auth', '0001_initial', '2026-11-09 16:30:45.161074'),
(5, 'admin', '0001_initial', '2026-11-09 16:30:45.246999'),
(6, 'admin', '0002_logentry_remove_auto_add', '2026-11-09 16:30:45.253003'),
(7, 'admin', '0003_logentry_add_action_flag_choices', '2026-11-09 16:30:45.262692'),
(8, 'auth', '0002_alter_permission_name_max_length', '2026-11-09 16:30:45.305434'),
(9, 'auth', '0003_alter_user_email_max_length', '2026-11-09 16:30:45.317294'),
(10, 'auth', '0004_alter_user_username_opts', '2026-11-09 16:30:45.320653'),
(11, 'auth', '0005_alter_user_last_login_null', '2026-11-09 16:30:45.360555'),
(12, 'auth', '0006_require_contenttypes_0002', '2026-11-09 16:30:45.364597'),
(13, 'auth', '0007_alter_validators_add_error_messages', '2026-11-09 16:30:45.383094'),
(14, 'auth', '0008_alter_user_username_max_length', '2026-11-09 16:30:45.389436'),
(15, 'auth', '0009_alter_user_last_name_max_length', '2026-11-09 16:30:45.404228'),
(16, 'auth', '0010_alter_group_name_max_length', '2026-11-09 16:30:45.417240'),
(17, 'auth', '0011_update_proxy_permissions', '2026-11-09 16:30:45.423856'),
(18, 'auth', '0012_alter_user_first_name_max_length', '2026-11-09 16:30:45.436245'),
(19, 'usuarios', '0001_initial', '2026-11-09 16:30:45.440741');

-- --------------------------------------------------------

--
-- Estrutura para tabela `django_session`
--

CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `django_session`
--

INSERT INTO `django_session` (`session_key`, `session_data`, `expire_date`) VALUES
('2nbpm60lcsr1bi376erqq55quxbo6l00', 'e30:1xQVvF:U3m99fO_Gx7Za26gZhQLXdE_kjosJpcW85Ed59JioF4', '2026-11-23 20:24:57.437080'),
('6zkn301hdmpaczz6r6lqdwwr618er8cy', 'e30:1xQVvJ:PD-rxwJsutbAxXekYjarRfcbArIM6S0mC1A-6fIJtNc', '2026-11-23 20:25:01.931248'),
('g6hdjlt8fcnkdyurc6c06ctzigyyiyck', '.eJyrViotLk0sysyPz0xRsjLSgXPz8nNTlayUHPMSFYJSk1MLkjPz8zKLSxKVEEpKMgvygUqKUKRrAcXIHdQ:1xQSKX:mpIa-KR9eB3wuheS9YBZ_TP7yf-LQVhpTf64D0St3kw', '2026-11-23 16:34:49.102198'),
('gzzx6ep512ekuspmqflj7tcyb47zu5sk', 'e30:1xQoYZ:DkLTEk_fFg242LPybfw5-6CTMRZe2HKeFY210CvYLnw', '2026-11-24 13:18:47.891132'),
('muibi0ilp69kzu80kw2pw3vki2bk029p', '.eJyrViotLk0sysyPz0xRsjI00oHz8_JzU5WslFwSyzIVXHMT80pTcxSc84tLEhX8czLLUjOLEpUQiksyC_KBigsSkzNT80pSlWoBZnsfTA:1xQp8y:eCwGWqEj4InpVgSzeEem7-cSXC-ZWp2XqyNK6UE8tsg', '2026-11-24 16:56:24.754718'),
('p0edkaxjsn4bldrfkde0so9ffm4b3i1v', 'e30:1xQVtP:RYHG3XGJjLa3poLiVPIuZLS92FI7d6Gjmxmgqo59jHU', '2026-11-23 20:23:03.914188'),
('ppgoaq3fvqomu5cs25hggohe1fo0tlku', 'e30:1xQVmu:8DAQk3nmVHIxq71q35E6FjPumOzoVZJ19rlgC0iTXwo', '2026-11-23 20:16:20.858652'),
('yvluke1i1rd0mxbak4kw1xk9ss9vmi8q', '.eJyrViotLk0sysyPz0xRsjLSgXPz8nNTlayUHPMSFYJSk1MLkjPz8zKLSxKVEEpKMgvygUqKUKRrAcXIHdQ:1xQqm0:w3GOucPLuvfPpsrvSLw9uFxENkg7GNWXMKPWl3jtSm0', '2026-11-24 18:40:48.216225');

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
  `status_consulta` enum('pendente','confirmada','realizada','cancelada') DEFAULT 'pendente'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `tbconsulta`
--

INSERT INTO `tbconsulta` (`id_consulta`, `id_medico`, `id_paciente`, `detalhes_consulta`, `horario_consulta`, `data_consulta`, `status_consulta`) VALUES
(1, 3, 6, 'Paciente relata dores no peito ocasionais.', '08:00:00', '2026-11-05', 'confirmada'),
(2, 4, 7, 'Avaliação dermatológica de rotina.', '09:30:00', '2026-11-05', ''),
(3, 5, 8, 'Consulta pediátrica de acompanhamento.', '10:00:00', '2026-11-06', ''),
(4, 3, 9, 'Retorno para avaliação cardiológica.', '14:00:00', '2026-11-06', 'realizada'),
(5, 4, 10, 'Avaliação de irritação na pele.', '15:30:00', '2026-11-07', 'cancelada'),
(8, 3, 9, '', '10:00:00', '2026-11-10', ''),
(9, 4, 10, 'Verificar meu cabelo', '10:00:00', '2027-01-20', 'confirmada'),
(10, 4, 11, NULL, '10:00:00', '2026-11-11', 'pendente'),
(11, 4, 12, NULL, '10:00:00', '2026-11-11', 'pendente');

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
(10, 'Fernanda Lima', 'fernanda.lima@gmail.com', '$2b$12$EoiyuYgCNjakBv75NGe6kujY0aOZoRT0QXfGs7EZaiUZMsB9BagAG', '00000000010', NULL, 'Feminino', NULL, 'paciente'),
(11, 'Davi Oliveira', 'davi@gmail.com', '$2y$10$HwTHejjIzZPfNWjansXZVOFmqXmJmUoTnLfcPLrgWIv/aaAC.tvGO', '01670820432', NULL, 'Masculino', NULL, 'paciente'),
(12, 'Davi Emanuel Costa Oliveira', 'daviecostaoliveira@gmail.com', 'pbkdf2_sha256$720000$75RFKI1yeBYdYWhupyxBnB$hUIQgnSZdn3AQv5k/0S84GSq0zGgp6J8kJwFJ7czVQY=', '016.708.204-32', NULL, 'Masculino', NULL, 'paciente');

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
,`status_consulta` enum('pendente','confirmada','realizada','cancelada')
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
-- Índices de tabela `auth_group`
--
ALTER TABLE `auth_group`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Índices de tabela `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  ADD KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`);

--
-- Índices de tabela `auth_permission`
--
ALTER TABLE `auth_permission`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`);

--
-- Índices de tabela `auth_user`
--
ALTER TABLE `auth_user`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- Índices de tabela `auth_user_groups`
--
ALTER TABLE `auth_user_groups`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  ADD KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`);

--
-- Índices de tabela `auth_user_user_permissions`
--
ALTER TABLE `auth_user_user_permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  ADD KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`);

--
-- Índices de tabela `django_admin_log`
--
ALTER TABLE `django_admin_log`
  ADD PRIMARY KEY (`id`),
  ADD KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  ADD KEY `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id`);

--
-- Índices de tabela `django_content_type`
--
ALTER TABLE `django_content_type`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`);

--
-- Índices de tabela `django_migrations`
--
ALTER TABLE `django_migrations`
  ADD PRIMARY KEY (`id`);

--
-- Índices de tabela `django_session`
--
ALTER TABLE `django_session`
  ADD PRIMARY KEY (`session_key`),
  ADD KEY `django_session_expire_date_a5c62663` (`expire_date`);

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
-- AUTO_INCREMENT de tabela `auth_group`
--
ALTER TABLE `auth_group`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `auth_permission`
--
ALTER TABLE `auth_permission`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=37;

--
-- AUTO_INCREMENT de tabela `auth_user`
--
ALTER TABLE `auth_user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `auth_user_groups`
--
ALTER TABLE `auth_user_groups`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `auth_user_user_permissions`
--
ALTER TABLE `auth_user_user_permissions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `django_admin_log`
--
ALTER TABLE `django_admin_log`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `django_content_type`
--
ALTER TABLE `django_content_type`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT de tabela `django_migrations`
--
ALTER TABLE `django_migrations`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT de tabela `tbconsulta`
--
ALTER TABLE `tbconsulta`
  MODIFY `id_consulta` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT de tabela `tbespecialidade`
--
ALTER TABLE `tbespecialidade`
  MODIFY `id_especialidade` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de tabela `tbusuario`
--
ALTER TABLE `tbusuario`
  MODIFY `id_usuario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- Restrições para tabelas despejadas
--

--
-- Restrições para tabelas `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  ADD CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  ADD CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`);

--
-- Restrições para tabelas `auth_permission`
--
ALTER TABLE `auth_permission`
  ADD CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`);

--
-- Restrições para tabelas `auth_user_groups`
--
ALTER TABLE `auth_user_groups`
  ADD CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  ADD CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Restrições para tabelas `auth_user_user_permissions`
--
ALTER TABLE `auth_user_user_permissions`
  ADD CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  ADD CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Restrições para tabelas `django_admin_log`
--
ALTER TABLE `django_admin_log`
  ADD CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  ADD CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

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
