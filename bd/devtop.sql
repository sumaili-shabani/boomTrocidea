-- phpMyAdmin SQL Dump
-- version 4.7.4
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1
-- Généré le :  lun. 25 jan. 2021 à 11:12
-- Version du serveur :  10.1.26-MariaDB
-- Version de PHP :  7.1.9

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données :  `devtop`
--

DELIMITER $$
--
-- Procédures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `addCount` (IN `id` INT, IN `montants` INT)  INSERT compte (id_user,montant) VALUES(id,montants)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `afficher_monant` (IN `id` INT)  SELECT id_user, first_name,last_name,email,SUM(montant) AS montant FROM profile_compte WHERE id_user =id$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `deleteCount` (IN `id` INT)  DELETE FROM compte WHERE id_user=id$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `updateCount` (IN `id` INT, IN `montant` INT)  UPDATE compte SET montant=montant WHERE id_user=id$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Structure de la table `compte`
--

CREATE TABLE `compte` (
  `idc` int(11) NOT NULL,
  `id_user` int(11) DEFAULT NULL,
  `montant` int(11) DEFAULT '100'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Déchargement des données de la table `compte`
--

INSERT INTO `compte` (`idc`, `id_user`, `montant`) VALUES
(1, 8, 250),
(2, 2, 100),
(3, 3, 100),
(4, 4, 100),
(5, 5, 100),
(6, 6, 100),
(7, 7, 100),
(8, 10, 100);

-- --------------------------------------------------------

--
-- Doublure de structure pour la vue `profile_compte`
-- (Voir ci-dessous la vue réelle)
--
CREATE TABLE `profile_compte` (
`first_name` varchar(300)
,`last_name` varchar(300)
,`email` varchar(300)
,`id_user` int(11)
,`montant` int(11)
,`image` varchar(300)
);

-- --------------------------------------------------------

--
-- Structure de la table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `first_name` varchar(300) DEFAULT NULL,
  `last_name` varchar(300) DEFAULT NULL,
  `email` varchar(300) DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `passwords` varchar(300) DEFAULT NULL,
  `image` varchar(300) DEFAULT NULL,
  `sexe` varchar(5) DEFAULT NULL,
  `idrole` int(11) DEFAULT '0',
  `bio` text,
  `facebook` varchar(300) DEFAULT NULL,
  `twitter` varchar(300) DEFAULT NULL,
  `linkedin` varchar(300) DEFAULT NULL,
  `adresse` varchar(300) DEFAULT NULL,
  `tel` varchar(300) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Déchargement des données de la table `users`
--

INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `created_at`, `passwords`, `image`, `sexe`, `idrole`, `bio`, `facebook`, `twitter`, `linkedin`, `adresse`, `tel`) VALUES
(2, 'Simon', 'lubangu', 'simon@gmail.com', '2021-01-18 10:05:13', 'e10adc3949ba59abbe56e057f20f883e', 'icone-user.png', 'M', 0, NULL, NULL, NULL, NULL, NULL, NULL),
(3, 'mikah', 'ktoko', 'mikah@gmail.com', '2021-01-18 10:05:13', 'e10adc3949ba59abbe56e057f20f883e', 'icone-user.png', 'M', 0, NULL, NULL, NULL, NULL, NULL, NULL),
(4, 'jonathan', 'boroto', 'jonathan@gmail.com', '2021-01-18 10:05:13', 'e10adc3949ba59abbe56e057f20f883e', 'icone-user.png', 'M', 0, NULL, NULL, NULL, NULL, NULL, NULL),
(5, 'Schadrack', 'kabinzo', 'kabinzo@gmail.com', '2021-01-18 10:05:13', 'e10adc3949ba59abbe56e057f20f883e', 'icone-user.png', 'M', 0, NULL, NULL, NULL, NULL, NULL, NULL),
(6, 'Apoline dembo', 'pataule', 'apoline345@gmail.com', '2021-01-18 10:05:13', 'e10adc3949ba59abbe56e057f20f883e', '1002710650.jpg', 'F', 0, NULL, NULL, NULL, NULL, NULL, NULL),
(7, 'Emakuye', 'daniel', 'emakuye@gmail.com', '2021-01-18 10:05:13', 'e10adc3949ba59abbe56e057f20f883e', 'icone-user.png', 'M', 0, NULL, NULL, NULL, NULL, NULL, NULL),
(8, 'jojo', 'kayembe', 'jojo@gmail.com', '2021-01-19 08:35:08', 'e10adc3949ba59abbe56e057f20f883e', 'icone-user.png', 'M', 0, NULL, NULL, NULL, NULL, NULL, NULL),
(10, 'jojo bouer', 'kayembe', 'jojobouer@gmail.com', '2021-01-19 08:38:33', 'e10adc3949ba59abbe56e057f20f883e', 'icone-user.png', 'M', 0, NULL, NULL, NULL, NULL, NULL, NULL),
(12, 'kasumba kipundula', 'bertin', 'kasumba@gmail.com', '2021-01-22 12:06:12', 'e10adc3949ba59abbe56e057f20f883e', '276600865.JPG', 'M', 0, NULL, NULL, NULL, NULL, NULL, NULL),
(13, 'papa boss', 'sumaili', 'sumaili@gmail.com', '2021-01-25 09:27:54', 'e10adc3949ba59abbe56e057f20f883e', 'icone-user.png', 'M', 1, NULL, NULL, NULL, NULL, NULL, NULL),
(14, 'sumaili shabani ', NULL, 'sumailiroger681@gmail.com', '2021-01-25 10:24:06', '9db09d6ae665e42340ef0b1ef1eb95b4', 'icone-user.png', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Structure de la vue `profile_compte`
--
DROP TABLE IF EXISTS `profile_compte`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `profile_compte`  AS  select `users`.`first_name` AS `first_name`,`users`.`last_name` AS `last_name`,`users`.`email` AS `email`,`compte`.`id_user` AS `id_user`,`compte`.`montant` AS `montant`,`users`.`image` AS `image` from (`users` join `compte` on((`users`.`id` = `compte`.`id_user`))) ;

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `compte`
--
ALTER TABLE `compte`
  ADD PRIMARY KEY (`idc`),
  ADD KEY `id_user` (`id_user`);

--
-- Index pour la table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `u_email_to_user` (`email`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `compte`
--
ALTER TABLE `compte`
  MODIFY `idc` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT pour la table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `compte`
--
ALTER TABLE `compte`
  ADD CONSTRAINT `compte_ibfk_1` FOREIGN KEY (`id_user`) REFERENCES `users` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
