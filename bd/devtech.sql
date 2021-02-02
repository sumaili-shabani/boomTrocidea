-- phpMyAdmin SQL Dump
-- version 4.7.4
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1
-- Généré le :  mar. 02 fév. 2021 à 09:25
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
-- Base de données :  `devtech`
--

DELIMITER $$
--
-- Fonctions
--
CREATE DEFINER=`root`@`localhost` FUNCTION `WORKDAYS` (`first_date` DATETIME, `second_date` DATETIME) RETURNS INT(11) BEGIN

  DECLARE start_date DATE;
  DECLARE end_date DATE;
  DECLARE diff INT;
  DECLARE cnt INT;

  IF (first_date < second_date) THEN
    SET start_date = first_date;
    SET end_date = second_date;
  ELSE
    SET start_date = second_date;
    SET end_date = first_date;
  END IF;

   SELECT COUNT(*) INTO cnt FROM `holiday` WHERE (hday BETWEEN start_date AND end_date) and (DAYOFWEEK(hday) != 7 and DAYOFWEEK(hday) != 1);

  SET diff = DATEDIFF(end_date, start_date) ;

  RETURN (CASE WHEN DAYNAME(start_date) not in ('Saturday', 'Sunday') && DAYNAME(end_date) = 'Saturday' THEN (diff - cnt)
               WHEN DAYNAME(start_date) not in ('Saturday', 'Sunday') && DAYNAME(end_date) = 'Sunday' THEN (diff - 2 - cnt)

               WHEN DAYNAME(start_date) = 'Saturday' && DAYNAME(end_date) = 'Sunday' THEN (diff - 1 - cnt)
               WHEN DAYNAME(start_date) = 'Saturday' && DAYNAME(end_date) = 'Saturday' THEN (diff + 1 - cnt)
               WHEN DAYNAME(start_date) = 'Sunday' && DAYNAME(end_date) in ('Saturday', 'Sunday') THEN (diff + 1 - cnt)

               WHEN DAYNAME(start_date) = 'Saturday' && DAYNAME(end_date) not in ('Saturday', 'Sunday') THEN (diff -1 - cnt)
               WHEN DAYNAME(start_date) = 'Sunday' && DAYNAME(end_date) not in ('Saturday', 'Sunday') THEN (diff + 1 - cnt)

               WHEN DAYNAME(start_date) not in ('Saturday', 'Sunday') && DAYNAME(end_date) not in ('Saturday', 'Sunday')
                    && WEEKDAY(start_date) > WEEKDAY(end_date) THEN (diff - 2 - cnt)
               ELSE (diff - cnt)  END)
    - (FLOOR(diff / 7) * 2)
    - (CASE WHEN DAYNAME(start_date) = 'Sunday' THEN 1 ELSE 0 END)
    - (CASE WHEN DAYNAME(end_date) = 'Saturday' THEN 1 ELSE 0 END);

END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Structure de la table `categorie_aprenant`
--

CREATE TABLE `categorie_aprenant` (
  `idcat` int(11) NOT NULL,
  `nom` varchar(300) DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Déchargement des données de la table `categorie_aprenant`
--

INSERT INTO `categorie_aprenant` (`idcat`, `nom`, `created_at`) VALUES
(1, 'Apprenants sponsorisés ', '2020-12-25 17:33:24'),
(2, 'Apprenants non sponsorisés ', '2020-12-25 17:33:46');

-- --------------------------------------------------------

--
-- Structure de la table `derogation`
--

CREATE TABLE `derogation` (
  `idd` int(11) NOT NULL,
  `id_user` int(11) DEFAULT NULL,
  `date_debit` date DEFAULT NULL,
  `date_fin` date DEFAULT NULL,
  `active` int(11) DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Déchargement des données de la table `derogation`
--

INSERT INTO `derogation` (`idd`, `id_user`, `date_debit`, `date_fin`, `active`) VALUES
(1, 8, '2021-01-05', '2021-01-15', 1),
(3, 10, '2021-01-03', '2021-01-04', 0);

-- --------------------------------------------------------

--
-- Structure de la table `edition`
--

CREATE TABLE `edition` (
  `idedition` int(11) NOT NULL,
  `nom` varchar(300) DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Déchargement des données de la table `edition`
--

INSERT INTO `edition` (`idedition`, `nom`, `created_at`) VALUES
(1, 'première édition', '2020-12-25 17:06:34'),
(2, 'deuxième édition', '2020-12-25 17:06:53'),
(4, 'troisième édition', '2020-12-25 17:08:50');

-- --------------------------------------------------------

--
-- Structure de la table `formation`
--

CREATE TABLE `formation` (
  `idformation` int(11) NOT NULL,
  `nom` varchar(300) DEFAULT NULL,
  `description` varchar(300) DEFAULT NULL,
  `image` varchar(300) DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Déchargement des données de la table `formation`
--

INSERT INTO `formation` (`idformation`, `nom`, `description`, `image`, `created_at`) VALUES
(1, 'Programmation web', 'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod\r\n                    	tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam,\r\n                    	quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo\r\n                    	consequat. D', '258319375.jpg', '2020-12-26 09:26:07'),
(2, 'Programmation mobile', 'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod\r\n                    	tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam,\r\n                    	quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo\r\n                    	consequat. D', '2106409444.jpg', '2020-12-26 09:28:40'),
(3, 'administration réseau', 'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod\r\n                    	tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam,\r\n                    	quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo\r\n                    	consequat. D', '1421448654.png', '2020-12-26 09:29:27');

-- --------------------------------------------------------

--
-- Structure de la table `inscription_formation`
--

CREATE TABLE `inscription_formation` (
  `idinscription` int(11) NOT NULL,
  `idedition` int(11) DEFAULT NULL,
  `idformation` int(11) DEFAULT NULL,
  `idcat` int(11) DEFAULT NULL,
  `id_user` int(11) DEFAULT NULL,
  `date_inscription` date DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Déchargement des données de la table `inscription_formation`
--

INSERT INTO `inscription_formation` (`idinscription`, `idedition`, `idformation`, `idcat`, `id_user`, `date_inscription`, `created_at`) VALUES
(2, 1, 1, 2, 6, '2020-12-10', '2020-12-26 13:56:28'),
(3, 1, 1, 2, 8, '2020-12-10', '2020-12-26 13:59:30'),
(4, 1, 1, 1, 5, '2020-12-10', '2020-12-26 14:00:10'),
(5, 1, 1, 2, 7, '2020-12-28', '2020-12-28 10:38:06'),
(6, 1, 1, 2, 9, '2020-12-28', '2020-12-28 10:40:39'),
(7, 1, 1, 2, 10, '2020-12-29', '2020-12-29 15:15:17'),
(8, 1, 3, 2, 2, '2020-12-31', '2020-12-31 16:07:07'),
(9, 1, 1, 2, 13, '2020-12-10', '2021-01-05 13:20:40');

-- --------------------------------------------------------

--
-- Structure de la table `messagerie`
--

CREATE TABLE `messagerie` (
  `idmessage` int(11) NOT NULL,
  `id_user` int(11) DEFAULT NULL,
  `id_recever` int(11) DEFAULT NULL,
  `message` text,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `code` longtext,
  `fichier` varchar(300) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Déchargement des données de la table `messagerie`
--

INSERT INTO `messagerie` (`idmessage`, `id_user`, `id_recever`, `message`, `created_at`, `code`, `fichier`) VALUES
(1, 2, 1, 'je vais bien merci et vous?', '2020-10-11 14:00:25', '60aa705cf0', NULL),
(2, 1, 2, 'ce bon!', '2020-10-11 14:02:23', '8f04778c11', NULL),
(3, 2, 1, 'ok bien merci et vous?', '2020-10-11 14:00:25', '60aa705cf0', NULL),
(4, 1, 2, 'ce bon!', '2020-10-11 14:02:23', '8f04778c11', NULL),
(6, 1, 2, 'cool!', '2020-10-11 14:02:23', '8f04778c11', NULL),
(8, 1, 2, 'ce bon!', '2020-10-11 14:02:23', '8f04778c11', NULL),
(9, 1, 2, 'prenez cette photo bro!', '2021-01-20 18:13:02', '16fc168f2c', 'bfe486118594e989892f4f6e4f84b125react-native-developpement-mobile.png'),
(10, 1, 2, 'cool mon frère!', '2021-01-20 18:14:13', 'eca00df915', NULL),
(11, 1, 2, '???? ce très bon!', '2021-01-28 10:36:48', '946c4cee24', NULL);

-- --------------------------------------------------------

--
-- Structure de la table `notification`
--

CREATE TABLE `notification` (
  `id` int(11) NOT NULL,
  `message` varchar(800) DEFAULT NULL,
  `url` varchar(800) DEFAULT NULL,
  `id_user` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `icone` varchar(300) DEFAULT NULL,
  `titre` varchar(300) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Déchargement des données de la table `notification`
--

INSERT INTO `notification` (`id`, `message`, `url`, `id_user`, `created_at`, `icone`, `titre`) VALUES
(1, 'Grace kilumbu vient de payer 1$', 'admin/compte', 1, '2021-01-19 15:36:59', 'fa fa-bell', 'nouveau paiement'),
(2, 'Grace kilumbu vient de payer 1$', 'admin/compte', 1, '2021-01-19 15:36:59', 'fa fa-bell', 'nouveau paiement'),
(3, 'Grace kilumbu vient de payer 1$', 'admin/compte', 1, '2021-01-19 15:36:59', 'fa fa-bell', 'nouveau paiement'),
(6, 'salut yuma kayanda  vous avez peut-être raté une information', 'user/teste_suggestion', 2, '2021-01-19 16:45:22', 'fa fa-bell', 'nouvelle notificaton'),
(7, 'salut yuma kayanda  vous avez peut-être raté une information', 'user/teste_suggestion', 2, '2021-01-19 16:45:22', 'fa fa-bell', 'nouvelle notificaton'),
(8, 'salut yuma kayanda  vous avez peut-être raté une information', 'user/teste_suggestion', 2, '2021-01-19 16:45:22', 'fa fa-bell', 'nouvelle notificaton'),
(9, 'salut yuma kayanda  vous avez peut-être raté une information', 'user/teste_suggestion', 2, '2021-01-19 16:45:23', 'fa fa-bell', 'nouvelle notificaton'),
(10, 'salut yuma kayanda  vous avez peut-être raté une information', 'user/teste_suggestion', 2, '2021-01-19 16:45:23', 'fa fa-bell', 'nouvelle notificaton'),
(11, 'salut kakese pandamiti vous avez peut-être raté une information', 'user/teste_suggestion', 4, '2021-01-19 16:45:23', 'fa fa-bell', 'nouvelle notificaton'),
(12, 'salut kakese pandamiti vous avez peut-être raté une information', 'user/teste_suggestion', 4, '2021-01-19 16:45:23', 'fa fa-bell', 'nouvelle notificaton'),
(13, 'salut kakese pandamiti vous avez peut-être raté une information', 'user/teste_suggestion', 4, '2021-01-19 16:45:23', 'fa fa-bell', 'nouvelle notificaton'),
(14, 'salut kakese pandamiti vous avez peut-être raté une information', 'user/teste_suggestion', 4, '2021-01-19 16:45:23', 'fa fa-bell', 'nouvelle notificaton'),
(15, 'salut kakese pandamiti vous avez peut-être raté une information', 'user/teste_suggestion', 4, '2021-01-19 16:45:23', 'fa fa-bell', 'nouvelle notificaton'),
(16, 'salut dembo apoline vous avez peut-être raté une information', 'user/teste_suggestion', 5, '2021-01-19 16:45:23', 'fa fa-bell', 'nouvelle notificaton'),
(17, 'salut dembo apoline vous avez peut-être raté une information', 'user/teste_suggestion', 5, '2021-01-19 16:45:23', 'fa fa-bell', 'nouvelle notificaton'),
(18, 'salut dembo apoline vous avez peut-être raté une information', 'user/teste_suggestion', 5, '2021-01-19 16:45:23', 'fa fa-bell', 'nouvelle notificaton'),
(19, 'salut dembo apoline vous avez peut-être raté une information', 'user/teste_suggestion', 5, '2021-01-19 16:45:23', 'fa fa-bell', 'nouvelle notificaton'),
(20, 'salut dembo apoline vous avez peut-être raté une information', 'user/teste_suggestion', 5, '2021-01-19 16:45:23', 'fa fa-bell', 'nouvelle notificaton'),
(21, 'salut jonathan boroto vous avez peut-être raté une information', 'user/teste_suggestion', 6, '2021-01-19 16:45:23', 'fa fa-bell', 'nouvelle notificaton'),
(22, 'salut jonathan boroto vous avez peut-être raté une information', 'user/teste_suggestion', 6, '2021-01-19 16:45:23', 'fa fa-bell', 'nouvelle notificaton'),
(23, 'salut jonathan boroto vous avez peut-être raté une information', 'user/teste_suggestion', 6, '2021-01-19 16:45:24', 'fa fa-bell', 'nouvelle notificaton'),
(24, 'salut jonathan boroto vous avez peut-être raté une information', 'user/teste_suggestion', 6, '2021-01-19 16:45:24', 'fa fa-bell', 'nouvelle notificaton'),
(25, 'salut jonathan boroto vous avez peut-être raté une information', 'user/teste_suggestion', 6, '2021-01-19 16:45:24', 'fa fa-bell', 'nouvelle notificaton'),
(26, 'salut simon lubango vous avez peut-être raté une information', 'user/teste_suggestion', 7, '2021-01-19 16:45:24', 'fa fa-bell', 'nouvelle notificaton'),
(27, 'salut simon lubango vous avez peut-être raté une information', 'user/teste_suggestion', 7, '2021-01-19 16:45:24', 'fa fa-bell', 'nouvelle notificaton'),
(28, 'salut simon lubango vous avez peut-être raté une information', 'user/teste_suggestion', 7, '2021-01-19 16:45:24', 'fa fa-bell', 'nouvelle notificaton'),
(29, 'salut simon lubango vous avez peut-être raté une information', 'user/teste_suggestion', 7, '2021-01-19 16:45:24', 'fa fa-bell', 'nouvelle notificaton'),
(30, 'salut simon lubango vous avez peut-être raté une information', 'user/teste_suggestion', 7, '2021-01-19 16:45:24', 'fa fa-bell', 'nouvelle notificaton'),
(31, 'salut schadrack kambinzo vous avez peut-être raté une information', 'user/teste_suggestion', 8, '2021-01-19 16:45:24', 'fa fa-bell', 'nouvelle notificaton'),
(32, 'salut schadrack kambinzo vous avez peut-être raté une information', 'user/teste_suggestion', 8, '2021-01-19 16:45:24', 'fa fa-bell', 'nouvelle notificaton'),
(33, 'salut schadrack kambinzo vous avez peut-être raté une information', 'user/teste_suggestion', 8, '2021-01-19 16:45:24', 'fa fa-bell', 'nouvelle notificaton'),
(34, 'salut schadrack kambinzo vous avez peut-être raté une information', 'user/teste_suggestion', 8, '2021-01-19 16:45:24', 'fa fa-bell', 'nouvelle notificaton'),
(35, 'salut schadrack kambinzo vous avez peut-être raté une information', 'user/teste_suggestion', 8, '2021-01-19 16:45:24', 'fa fa-bell', 'nouvelle notificaton'),
(36, 'salut kalume kitoko vous avez peut-être raté une information', 'user/teste_suggestion', 9, '2021-01-19 16:45:25', 'fa fa-bell', 'nouvelle notificaton'),
(37, 'salut kalume kitoko vous avez peut-être raté une information', 'user/teste_suggestion', 9, '2021-01-19 16:45:25', 'fa fa-bell', 'nouvelle notificaton'),
(38, 'salut kalume kitoko vous avez peut-être raté une information', 'user/teste_suggestion', 9, '2021-01-19 16:45:25', 'fa fa-bell', 'nouvelle notificaton'),
(39, 'salut kalume kitoko vous avez peut-être raté une information', 'user/teste_suggestion', 9, '2021-01-19 16:45:25', 'fa fa-bell', 'nouvelle notificaton'),
(40, 'salut kalume kitoko vous avez peut-être raté une information', 'user/teste_suggestion', 9, '2021-01-19 16:45:25', 'fa fa-bell', 'nouvelle notificaton'),
(41, 'salut Grace kilumbu vous avez peut-être raté une information', 'user/teste_suggestion', 10, '2021-01-19 16:45:25', 'fa fa-bell', 'nouvelle notificaton'),
(42, 'salut Grace kilumbu vous avez peut-être raté une information', 'user/teste_suggestion', 10, '2021-01-19 16:45:25', 'fa fa-bell', 'nouvelle notificaton'),
(43, 'salut Grace kilumbu vous avez peut-être raté une information', 'user/teste_suggestion', 10, '2021-01-19 16:45:25', 'fa fa-bell', 'nouvelle notificaton'),
(44, 'salut Grace kilumbu vous avez peut-être raté une information', 'user/teste_suggestion', 10, '2021-01-19 16:45:25', 'fa fa-bell', 'nouvelle notificaton'),
(45, 'salut Grace kilumbu vous avez peut-être raté une information', 'user/teste_suggestion', 10, '2021-01-19 16:45:25', 'fa fa-bell', 'nouvelle notificaton'),
(46, 'salut sifa abeli deborah vous avez peut-être raté une information', 'user/teste_suggestion', 11, '2021-01-19 16:45:25', 'fa fa-bell', 'nouvelle notificaton'),
(47, 'salut sifa abeli deborah vous avez peut-être raté une information', 'user/teste_suggestion', 11, '2021-01-19 16:45:25', 'fa fa-bell', 'nouvelle notificaton'),
(48, 'salut sifa abeli deborah vous avez peut-être raté une information', 'user/teste_suggestion', 11, '2021-01-19 16:45:25', 'fa fa-bell', 'nouvelle notificaton'),
(49, 'salut sifa abeli deborah vous avez peut-être raté une information', 'user/teste_suggestion', 11, '2021-01-19 16:45:26', 'fa fa-bell', 'nouvelle notificaton'),
(50, 'salut sifa abeli deborah vous avez peut-être raté une information', 'user/teste_suggestion', 11, '2021-01-19 16:45:26', 'fa fa-bell', 'nouvelle notificaton'),
(51, 'salut kasumba kipundula vous avez peut-être raté une information', 'user/teste_suggestion', 12, '2021-01-19 16:45:26', 'fa fa-bell', 'nouvelle notificaton'),
(52, 'salut kasumba kipundula vous avez peut-être raté une information', 'user/teste_suggestion', 12, '2021-01-19 16:45:26', 'fa fa-bell', 'nouvelle notificaton'),
(53, 'salut kasumba kipundula vous avez peut-être raté une information', 'user/teste_suggestion', 12, '2021-01-19 16:45:26', 'fa fa-bell', 'nouvelle notificaton'),
(54, 'salut kasumba kipundula vous avez peut-être raté une information', 'user/teste_suggestion', 12, '2021-01-19 16:45:26', 'fa fa-bell', 'nouvelle notificaton'),
(55, 'salut kasumba kipundula vous avez peut-être raté une information', 'user/teste_suggestion', 12, '2021-01-19 16:45:26', 'fa fa-bell', 'nouvelle notificaton'),
(56, 'salut emakuya vous avez peut-être raté une information', 'user/teste_suggestion', 13, '2021-01-19 16:45:26', 'fa fa-bell', 'nouvelle notificaton'),
(57, 'salut emakuya vous avez peut-être raté une information', 'user/teste_suggestion', 13, '2021-01-19 16:45:26', 'fa fa-bell', 'nouvelle notificaton'),
(58, 'salut emakuya vous avez peut-être raté une information', 'user/teste_suggestion', 13, '2021-01-19 16:45:26', 'fa fa-bell', 'nouvelle notificaton'),
(59, 'salut emakuya vous avez peut-être raté une information', 'user/teste_suggestion', 13, '2021-01-19 16:45:26', 'fa fa-bell', 'nouvelle notificaton'),
(60, 'salut emakuya vous avez peut-être raté une information', 'user/teste_suggestion', 13, '2021-01-19 16:45:27', 'fa fa-bell', 'nouvelle notificaton');

-- --------------------------------------------------------

--
-- Structure de la table `online`
--

CREATE TABLE `online` (
  `id` int(11) NOT NULL,
  `id_user` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `paiement`
--

CREATE TABLE `paiement` (
  `idp` int(11) NOT NULL,
  `idpersonne` int(11) DEFAULT NULL,
  `date_paie` date DEFAULT NULL,
  `montant` float DEFAULT NULL,
  `motif` text,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Déchargement des données de la table `paiement`
--

INSERT INTO `paiement` (`idp`, `idpersonne`, `date_paie`, `montant`, `motif`, `created_at`) VALUES
(1, 6, '2020-12-17', 15, 'paiement montant première tranche', '2020-12-26 15:30:12'),
(2, 8, '2020-12-18', 5, 'paiement frais de la première tranche', '2020-12-26 15:35:06'),
(3, 8, '2020-12-28', 2, 'avance sur première tranche', '2020-12-28 10:41:37'),
(4, 9, '2020-12-28', 10, 'avance sur première tranche', '2020-12-28 10:42:57'),
(5, 7, '2020-12-28', 10, 'avance sur première tranche', '2020-12-28 10:43:35'),
(6, 10, '2020-12-29', 2, 'avance première tranche', '2020-12-29 15:18:12'),
(7, 6, '2020-12-30', 5, 'avance sur deuxième tranche', '2021-01-02 11:49:03'),
(8, 8, '2021-01-04', 3, 'paiement première tranche', '2021-01-04 07:49:12'),
(9, 9, '2021-01-04', 5, 'paiement de première tranche', '2021-01-04 15:45:12'),
(10, 7, '2021-01-04', 5, 'paiement de première tranche', '2021-01-04 15:45:41'),
(11, 13, '2021-01-05', 15, 'paiement première tranche', '2021-01-05 13:21:40'),
(12, 10, '2021-01-19', 1, 'paiement', '2021-01-19 15:36:59');

-- --------------------------------------------------------

--
-- Structure de la table `presence`
--

CREATE TABLE `presence` (
  `idp` int(11) NOT NULL,
  `id_user` int(11) DEFAULT NULL,
  `jour` date DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Déchargement des données de la table `presence`
--

INSERT INTO `presence` (`idp`, `id_user`, `jour`, `created_at`) VALUES
(1, 5, '2020-12-30', '2020-12-30 17:14:39'),
(2, 10, '2020-12-30', '2020-12-30 17:20:31'),
(3, 6, '2020-12-30', '2020-12-30 17:20:34'),
(4, 9, '2020-12-30', '2020-12-30 17:20:44'),
(6, 7, '2020-12-30', '2020-12-30 17:20:52'),
(7, 5, '2020-12-31', '2020-12-31 10:36:24'),
(8, 10, '2020-12-31', '2020-12-31 10:36:28'),
(9, 6, '2020-12-31', '2020-12-31 10:36:30'),
(10, 9, '2020-12-31', '2020-12-31 10:36:33'),
(11, 8, '2020-12-31', '2020-12-31 10:36:35'),
(13, 7, '2020-12-31', '2020-12-31 13:47:46'),
(14, 5, '2021-01-04', '2021-01-04 17:05:24'),
(16, 10, '2021-01-05', '2021-01-05 14:02:22'),
(17, 13, '2021-01-05', '2021-01-05 14:04:19'),
(18, 6, '2021-01-05', '2021-01-05 14:04:58'),
(19, 7, '2021-01-05', '2021-01-05 14:10:40'),
(21, 9, '2021-01-05', '2021-01-05 14:10:53'),
(22, 13, '2021-01-07', '2021-01-07 11:26:35'),
(23, 6, '2021-01-07', '2021-01-07 11:27:04'),
(24, 8, '2021-01-07', '2021-01-07 11:27:34'),
(25, 7, '2021-01-07', '2021-01-07 11:28:54'),
(26, 2, '2021-01-19', '2021-01-19 13:42:16');

-- --------------------------------------------------------

--
-- Doublure de structure pour la vue `profile_derogation`
-- (Voir ci-dessous la vue réelle)
--
CREATE TABLE `profile_derogation` (
`idd` int(11)
,`id_user` int(11)
,`date_debit` date
,`date_fin` date
,`active` int(11)
,`first_name` varchar(300)
,`last_name` varchar(300)
,`sexe` varchar(30)
,`email` varchar(300)
,`telephone` varchar(300)
,`image` varchar(300)
);

-- --------------------------------------------------------

--
-- Doublure de structure pour la vue `profile_inscription`
-- (Voir ci-dessous la vue réelle)
--
CREATE TABLE `profile_inscription` (
`idinscription` int(11)
,`idedition` int(11)
,`idformation` int(11)
,`idcat` int(11)
,`id_user` int(11)
,`date_inscription` date
,`created_at` datetime
,`nom_edition` varchar(300)
,`nom_formation` varchar(300)
,`nom_categorie` varchar(300)
,`id` int(11)
,`first_name` varchar(300)
,`last_name` varchar(300)
,`email` varchar(300)
,`image` varchar(300)
,`telephone` varchar(300)
,`sexe` varchar(30)
,`qrcode` varchar(300)
);

-- --------------------------------------------------------

--
-- Doublure de structure pour la vue `profile_online`
-- (Voir ci-dessous la vue réelle)
--
CREATE TABLE `profile_online` (
`reference` int(11)
,`id_user` int(11)
,`created_at` datetime
,`first_name` varchar(300)
,`last_name` varchar(300)
,`image` varchar(300)
);

-- --------------------------------------------------------

--
-- Doublure de structure pour la vue `profile_paiement`
-- (Voir ci-dessous la vue réelle)
--
CREATE TABLE `profile_paiement` (
`idp` int(11)
,`idpersonne` int(11)
,`date_paie` date
,`montant` float
,`motif` text
,`created_at` datetime
,`first_name` varchar(300)
,`last_name` varchar(300)
,`email` varchar(300)
,`image` varchar(300)
,`telephone` varchar(300)
,`full_adresse` text
,`date_nais` date
,`sexe` varchar(30)
);

-- --------------------------------------------------------

--
-- Doublure de structure pour la vue `profile_paiement_recouvrement`
-- (Voir ci-dessous la vue réelle)
--
CREATE TABLE `profile_paiement_recouvrement` (
`idp` int(11)
,`idpersonne` int(11)
,`date_paie` date
,`montant` float
,`motif` text
,`created_at` datetime
,`idformation` int(11)
,`idedition` int(11)
,`idcat` int(11)
,`nom_formation` varchar(300)
,`nom_categorie` varchar(300)
,`nom_edition` varchar(300)
,`first_name` varchar(300)
,`last_name` varchar(300)
,`email` varchar(300)
,`image` varchar(300)
,`telephone` varchar(300)
,`full_adresse` text
,`date_nais` date
,`sexe` varchar(30)
);

-- --------------------------------------------------------

--
-- Doublure de structure pour la vue `profile_presence`
-- (Voir ci-dessous la vue réelle)
--
CREATE TABLE `profile_presence` (
`idp` int(11)
,`id_user` int(11)
,`jour` date
,`created_at` datetime
,`first_name` varchar(300)
,`last_name` varchar(300)
,`email` varchar(300)
,`telephone` varchar(300)
,`image` varchar(300)
,`sexe` varchar(30)
);

-- --------------------------------------------------------

--
-- Doublure de structure pour la vue `profile_question`
-- (Voir ci-dessous la vue réelle)
--
CREATE TABLE `profile_question` (
`idq` int(11)
,`nomq` text
,`idr` int(11)
,`nomr` varchar(300)
,`token` varchar(300)
,`active` int(11)
,`idformation` int(11)
,`idedition` int(11)
,`nom_formation` varchar(300)
,`nom_edition` varchar(300)
);

-- --------------------------------------------------------

--
-- Doublure de structure pour la vue `profile_recouvrement`
-- (Voir ci-dessous la vue réelle)
--
CREATE TABLE `profile_recouvrement` (
`idr` int(11)
,`date_debit` date
,`date_fin` date
,`idt` int(11)
,`nomt` varchar(300)
,`montant` int(11)
,`active` int(11)
,`total_montant` int(11)
,`idformation` int(11)
,`idedition` int(11)
,`nom_formation` varchar(300)
,`nom_edition` varchar(300)
);

-- --------------------------------------------------------

--
-- Doublure de structure pour la vue `profile_reponse`
-- (Voir ci-dessous la vue réelle)
--
CREATE TABLE `profile_reponse` (
`idrep` int(11)
,`idq` int(11)
,`valeur` varchar(300)
,`created_at` datetime
,`nomq` text
,`idr` int(11)
,`nomr` varchar(300)
,`token` varchar(300)
,`active` int(11)
,`idformation` int(11)
,`idedition` int(11)
,`nom_formation` varchar(300)
,`nom_edition` varchar(300)
);

-- --------------------------------------------------------

--
-- Doublure de structure pour la vue `profile_rubrique`
-- (Voir ci-dessous la vue réelle)
--
CREATE TABLE `profile_rubrique` (
`idr` int(11)
,`nomr` varchar(300)
,`token` varchar(300)
,`active` int(11)
,`idformation` int(11)
,`idedition` int(11)
,`nom_formation` varchar(300)
,`nom_edition` varchar(300)
);

-- --------------------------------------------------------

--
-- Doublure de structure pour la vue `profile_tranche`
-- (Voir ci-dessous la vue réelle)
--
CREATE TABLE `profile_tranche` (
`idt` int(11)
,`nomt` varchar(300)
,`montant` int(11)
,`active` int(11)
,`total_montant` int(11)
,`idformation` int(11)
,`idedition` int(11)
,`nom_formation` varchar(300)
,`nom_edition` varchar(300)
);

-- --------------------------------------------------------

--
-- Structure de la table `question`
--

CREATE TABLE `question` (
  `idq` int(11) NOT NULL,
  `nomq` text,
  `idr` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Déchargement des données de la table `question`
--

INSERT INTO `question` (`idq`, `nomq`, `idr`) VALUES
(1, 'Comment avez-vous trouvé l\'accueil?', 1),
(2, 'En HTML sur le plan  pédagogique, comment avez-vous évalué le formateur du point de vie enseignement de la matière?', 1),
(3, 'En CSS, comment avez-vous trouvé la matière?', 1),
(4, 'En BOOTSTRAP, comment avez-vous trouvé la matière?', 1),
(5, 'En BOOTSTRAP, comment avez-vous évaluer le formateur du point de vue enseignement de la matière?', 1),
(6, 'EN JAVASCRIPT, comment avez-vous trouvé la matière?', 1),
(7, 'En JAVASCRIPT, comment avez-vous évalué le formateur du point de vue enseignement de la matière?', 1),
(8, 'En  MYSQL, comment avez-vous trouvé les différentes leçons données par le formateur?', 1),
(9, 'En MYSQL, comment avez-vous évalué le formateur du point de vue enseignement de la matière?', 1),
(10, 'En PHP comment avez-vous trouvé la matière?', 1),
(11, 'En PHP, comment avez-vous évalué le formateur du point de vue enseignement de la matière?', 1),
(12, 'Du point de vue évaluation des différents travaux faits,  comment avez-vous évalué le formateur par sa méthodologie du travail?', 1),
(14, 'EN réseau, Comment avez-vous trouvé l\'accueil?', 2),
(15, 'EN réseau, Du point de vue évaluation des différents travaux faits,  comment avez-vous évalué le formateur par sa méthodologie du travail?', 2);

-- --------------------------------------------------------

--
-- Structure de la table `recouvrement`
--

CREATE TABLE `recouvrement` (
  `idr` int(11) NOT NULL,
  `idt` int(11) DEFAULT NULL,
  `date_debit` date DEFAULT NULL,
  `date_fin` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Déchargement des données de la table `recouvrement`
--

INSERT INTO `recouvrement` (`idr`, `idt`, `date_debit`, `date_fin`) VALUES
(1, 1, '2021-01-04', '2021-01-20');

-- --------------------------------------------------------

--
-- Structure de la table `recupere`
--

CREATE TABLE `recupere` (
  `id` int(11) NOT NULL,
  `email` varchar(255) DEFAULT NULL,
  `verification_key` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Déchargement des données de la table `recupere`
--

INSERT INTO `recupere` (`id`, `email`, `verification_key`) VALUES
(1, 'sumailiroger681@gmail.com', '88857a4c72041734397653be7f124680'),
(2, 'sumailiroger681@gmail.com', 'ce341224ff761a02e42bb19c0c02fcf7');

-- --------------------------------------------------------

--
-- Structure de la table `reponse`
--

CREATE TABLE `reponse` (
  `idrep` int(11) NOT NULL,
  `valeur` varchar(300) DEFAULT NULL,
  `idq` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Déchargement des données de la table `reponse`
--

INSERT INTO `reponse` (`idrep`, `valeur`, `idq`, `created_at`) VALUES
(6, 'très bien', 3, '2021-01-10 13:21:11'),
(10, 'très bien', 14, '2021-01-10 15:49:01'),
(11, 'bien', 15, '2021-01-10 15:49:13'),
(12, 'très bien', 2, '2021-01-13 17:26:52'),
(13, 'très bien', 3, '2021-01-13 17:27:01'),
(14, 'mal', 1, '2021-01-18 15:44:27'),
(15, 'très bien', 12, '2021-01-18 15:44:41'),
(16, 'très bien', 8, '2021-01-18 15:44:49'),
(17, 'bien', 5, '2021-01-18 15:44:57'),
(18, 'mal', 4, '2021-01-18 15:45:17'),
(19, 'très bien', 3, '2021-01-18 15:45:25'),
(20, 'très bien', 2, '2021-01-18 15:45:53'),
(21, 'très bien', 7, '2021-01-18 15:46:00'),
(22, 'très bien', 6, '2021-01-18 15:46:06'),
(23, 'très bien', 9, '2021-01-18 15:46:11'),
(24, 'bien', 10, '2021-01-18 15:46:16'),
(25, 'très bien', 11, '2021-01-18 15:46:22'),
(26, 'bien', 1, '2021-01-19 13:35:30');

-- --------------------------------------------------------

--
-- Structure de la table `role`
--

CREATE TABLE `role` (
  `idrole` int(11) NOT NULL,
  `nom` varchar(300) DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Déchargement des données de la table `role`
--

INSERT INTO `role` (`idrole`, `nom`, `created_at`) VALUES
(1, 'admin', '2020-12-24 15:51:36'),
(2, 'user', '2020-12-24 15:51:36');

-- --------------------------------------------------------

--
-- Structure de la table `rubrique`
--

CREATE TABLE `rubrique` (
  `idr` int(11) NOT NULL,
  `nomr` varchar(300) DEFAULT NULL,
  `token` varchar(300) DEFAULT NULL,
  `idformation` int(11) DEFAULT NULL,
  `idedition` int(11) DEFAULT NULL,
  `active` int(11) DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Déchargement des données de la table `rubrique`
--

INSERT INTO `rubrique` (`idr`, `nomr`, `token`, `idformation`, `idedition`, `active`) VALUES
(1, 'webformation1', '123web145', 1, 1, 1),
(2, 'réseau1', '56web100', 3, 1, 0);

-- --------------------------------------------------------

--
-- Structure de la table `tbl_info`
--

CREATE TABLE `tbl_info` (
  `idinfo` int(11) NOT NULL,
  `nom_site` varchar(300) DEFAULT NULL,
  `icone` varchar(300) DEFAULT NULL,
  `tel1` varchar(300) DEFAULT NULL,
  `tel2` varchar(300) DEFAULT NULL,
  `adresse` text,
  `facebook` varchar(600) DEFAULT NULL,
  `twitter` varchar(600) DEFAULT NULL,
  `linkedin` varchar(600) DEFAULT NULL,
  `email` varchar(300) DEFAULT NULL,
  `termes` text,
  `confidentialite` text
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Déchargement des données de la table `tbl_info`
--

INSERT INTO `tbl_info` (`idinfo`, `nom_site`, `icone`, `tel1`, `tel2`, `adresse`, `facebook`, `twitter`, `linkedin`, `email`, `termes`, `confidentialite`) VALUES
(1, 'apkdevtech', '1552922677.png', '+243817883541', '+243970524665', 'RDC Nord-kivu goma quartier  7 bougies', 'https://facebook.com/', 'https://twitter.com/', 'https://linkedin.com/', 'info.devtech@gmail.com', 'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod\r\ntempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam,\r\nquis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo\r\nconsequat. Duis aute irure dolor in reprehenderit in voluptate velit esse\r\ncillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non\r\nproident, sunt in culpa qui officia deserunt mollit anim id est laborum.', 'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod\r\ntempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam,\r\nquis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo\r\nconsequat. Duis aute irure dolor in reprehenderit in voluptate velit esse\r\ncillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non\r\nproident, sunt in culpa qui officia deserunt mollit anim id est laborum.');

-- --------------------------------------------------------

--
-- Structure de la table `tranche`
--

CREATE TABLE `tranche` (
  `idt` int(11) NOT NULL,
  `nomt` varchar(300) DEFAULT NULL,
  `idformation` int(11) DEFAULT NULL,
  `idedition` int(11) DEFAULT NULL,
  `montant` int(11) DEFAULT NULL,
  `active` int(11) DEFAULT '0',
  `total_montant` int(11) DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Déchargement des données de la table `tranche`
--

INSERT INTO `tranche` (`idt`, `nomt`, `idformation`, `idedition`, `montant`, `active`, `total_montant`) VALUES
(1, 'Premier tranche', 1, 1, 15, 1, 15),
(2, 'Deuxième tranche', 1, 1, 15, 0, 30),
(4, 'Première  tranche', 3, 1, 10, 0, 10);

-- --------------------------------------------------------

--
-- Structure de la table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `first_name` varchar(300) DEFAULT NULL,
  `last_name` varchar(300) DEFAULT NULL,
  `email` varchar(300) DEFAULT NULL,
  `image` varchar(300) DEFAULT NULL,
  `telephone` varchar(300) DEFAULT NULL,
  `full_adresse` text,
  `biographie` text,
  `date_nais` date DEFAULT NULL,
  `passwords` varchar(300) DEFAULT NULL,
  `idrole` int(11) DEFAULT NULL,
  `sexe` varchar(30) DEFAULT NULL,
  `facebook` varchar(900) DEFAULT NULL,
  `linkedin` varchar(900) DEFAULT NULL,
  `twitter` varchar(900) DEFAULT NULL,
  `qrcode` varchar(300) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Déchargement des données de la table `users`
--

INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `image`, `telephone`, `full_adresse`, `biographie`, `date_nais`, `passwords`, `idrole`, `sexe`, `facebook`, `linkedin`, `twitter`, `qrcode`) VALUES
(1, 'patrona shabani sumaili', 'roger', 'sumailiroger681@gmail.com', '669260788.js_logo', '0817883541', 'Nord-kivu goma', 'Développeur et entrepreneur en temps plein', '1998-08-12', '9db09d6ae665e42340ef0b1ef1eb95b4', 1, 'M', 'https://www.facebook.com/patronat.shabanisumaili.9/', 'https://www.linkedin.com/in/sumaili-shabani-roger-patr%C3%B4na-7426a71a1/', 'https://twitter.com/RogerPatrona', '2079159452.png'),
(2, 'yuma kayanda ', 'françois', 'yuma@gmail.com', '766568747.JPG', '+243990084881', 'Nord-viu goma quartier katoyi', NULL, '1995-12-30', 'e10adc3949ba59abbe56e057f20f883e', 2, 'M', 'https://facebook.com/', 'https://linkedin.com/', 'https://twitter.com/', NULL),
(4, 'kakese pandamiti', NULL, 'kakese@gmail.com', 'icone-user.png', NULL, NULL, NULL, NULL, 'e10adc3949ba59abbe56e057f20f883e', 2, 'M', NULL, NULL, NULL, NULL),
(5, 'dembo apoline', 'pataule', 'dembo@gmail.com', '340596697.jpg', '+243810409151', 'Nord-kivu goma quartier Virunga Aeroport', NULL, '2000-07-03', 'e10adc3949ba59abbe56e057f20f883e', 2, 'F', 'https://facebook.com/', 'https://linkedin.com/', 'https://twitter.com/', '259539583.png'),
(6, 'jonathan boroto', 'boroto', 'jonathan@gmail.com', 'icone-user.png', '0992786599', 'Nord-kivu goma quartier katoyi', NULL, '2000-01-03', 'e10adc3949ba59abbe56e057f20f883e', 2, 'M', '', '', '', '1236252959.png'),
(7, 'simon lubango', 'katabi', 'simon@gmail.com', '2144670232.jpg', '0992206522', 'Nord-kivu goma aéroport', NULL, '1995-01-01', 'e10adc3949ba59abbe56e057f20f883e', 2, 'M', '', '', '', '229575970.png'),
(8, 'schadrack kambinzo', 'kambinzo', 'schadrack@gmail.com', 'icone-user.png', '0994480142', '', NULL, '2000-01-02', 'e10adc3949ba59abbe56e057f20f883e', 2, 'M', '', '', '', '1286343739.png'),
(9, 'kalume kitoko', 'mikah', 'mikah@gmail.com', '866759042.jpg', '0977182484', '', NULL, '1997-08-01', 'e10adc3949ba59abbe56e057f20f883e', 2, 'M', '', '', '', '1928184354.png'),
(10, 'Grace kilumbu', 'Marque', 'kilumbu@gmail.com', 'icone-user.png', '0976159086', 'Nord-kivu goma quartier tmk', NULL, '1999-12-30', 'e10adc3949ba59abbe56e057f20f883e', 2, 'M', '', '', '', '616128621.png'),
(11, 'sifa abeli deborah', 'blessing debis', 'debis@gmail.com', '1124124937.jpg', '0990084881', 'Goma quartier Himbi', NULL, '2000-12-29', 'e10adc3949ba59abbe56e057f20f883e', 2, 'F', 'https://facebook.com/', 'https://linkedin.com/', 'https://twitter.com/', '309062084.png'),
(12, 'kasumba kipundula', 'bertin', 'kasumba@gmail.com', '901134631.png', '+243990084881', 'Nord-kivu goma quartier birere', NULL, '1999-12-30', 'e10adc3949ba59abbe56e057f20f883e', 2, 'M', 'https://facebook.com/', 'https://linkedin.com/', 'https://twitter.com/', NULL),
(13, 'emakuya', 'daniel', 'emakuya@gmail.com', 'icone-user.png', '0990084881', 'GOMA virunga', NULL, '2000-01-02', NULL, 2, 'M', '', '', '', '1857981147.png');

-- --------------------------------------------------------

--
-- Structure de la vue `profile_derogation`
--
DROP TABLE IF EXISTS `profile_derogation`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `profile_derogation`  AS  select `derogation`.`idd` AS `idd`,`derogation`.`id_user` AS `id_user`,`derogation`.`date_debit` AS `date_debit`,`derogation`.`date_fin` AS `date_fin`,`derogation`.`active` AS `active`,`users`.`first_name` AS `first_name`,`users`.`last_name` AS `last_name`,`users`.`sexe` AS `sexe`,`users`.`email` AS `email`,`users`.`telephone` AS `telephone`,`users`.`image` AS `image` from (`derogation` join `users` on((`derogation`.`id_user` = `users`.`id`))) ;

-- --------------------------------------------------------

--
-- Structure de la vue `profile_inscription`
--
DROP TABLE IF EXISTS `profile_inscription`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `profile_inscription`  AS  select `inscription_formation`.`idinscription` AS `idinscription`,`inscription_formation`.`idedition` AS `idedition`,`inscription_formation`.`idformation` AS `idformation`,`inscription_formation`.`idcat` AS `idcat`,`inscription_formation`.`id_user` AS `id_user`,`inscription_formation`.`date_inscription` AS `date_inscription`,`inscription_formation`.`created_at` AS `created_at`,`edition`.`nom` AS `nom_edition`,`formation`.`nom` AS `nom_formation`,`categorie_aprenant`.`nom` AS `nom_categorie`,`users`.`id` AS `id`,`users`.`first_name` AS `first_name`,`users`.`last_name` AS `last_name`,`users`.`email` AS `email`,`users`.`image` AS `image`,`users`.`telephone` AS `telephone`,`users`.`sexe` AS `sexe`,`users`.`qrcode` AS `qrcode` from ((((`inscription_formation` join `edition` on((`inscription_formation`.`idedition` = `edition`.`idedition`))) join `formation` on((`formation`.`idformation` = `inscription_formation`.`idformation`))) join `categorie_aprenant` on((`inscription_formation`.`idcat` = `categorie_aprenant`.`idcat`))) join `users` on((`users`.`id` = `inscription_formation`.`id_user`))) ;

-- --------------------------------------------------------

--
-- Structure de la vue `profile_online`
--
DROP TABLE IF EXISTS `profile_online`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `profile_online`  AS  select `online`.`id` AS `reference`,`online`.`id_user` AS `id_user`,`online`.`created_at` AS `created_at`,`users`.`first_name` AS `first_name`,`users`.`last_name` AS `last_name`,`users`.`image` AS `image` from (`online` join `users` on((`online`.`id_user` = `users`.`id`))) ;

-- --------------------------------------------------------

--
-- Structure de la vue `profile_paiement`
--
DROP TABLE IF EXISTS `profile_paiement`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `profile_paiement`  AS  select `paiement`.`idp` AS `idp`,`paiement`.`idpersonne` AS `idpersonne`,`paiement`.`date_paie` AS `date_paie`,`paiement`.`montant` AS `montant`,`paiement`.`motif` AS `motif`,`paiement`.`created_at` AS `created_at`,`users`.`first_name` AS `first_name`,`users`.`last_name` AS `last_name`,`users`.`email` AS `email`,`users`.`image` AS `image`,`users`.`telephone` AS `telephone`,`users`.`full_adresse` AS `full_adresse`,`users`.`date_nais` AS `date_nais`,`users`.`sexe` AS `sexe` from (`paiement` join `users` on((`users`.`id` = `paiement`.`idpersonne`))) ;

-- --------------------------------------------------------

--
-- Structure de la vue `profile_paiement_recouvrement`
--
DROP TABLE IF EXISTS `profile_paiement_recouvrement`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `profile_paiement_recouvrement`  AS  select `paiement`.`idp` AS `idp`,`paiement`.`idpersonne` AS `idpersonne`,`paiement`.`date_paie` AS `date_paie`,`paiement`.`montant` AS `montant`,`paiement`.`motif` AS `motif`,`paiement`.`created_at` AS `created_at`,`inscription_formation`.`idformation` AS `idformation`,`inscription_formation`.`idedition` AS `idedition`,`inscription_formation`.`idcat` AS `idcat`,`formation`.`nom` AS `nom_formation`,`categorie_aprenant`.`nom` AS `nom_categorie`,`edition`.`nom` AS `nom_edition`,`users`.`first_name` AS `first_name`,`users`.`last_name` AS `last_name`,`users`.`email` AS `email`,`users`.`image` AS `image`,`users`.`telephone` AS `telephone`,`users`.`full_adresse` AS `full_adresse`,`users`.`date_nais` AS `date_nais`,`users`.`sexe` AS `sexe` from (((((`paiement` join `users` on((`users`.`id` = `paiement`.`idpersonne`))) join `inscription_formation` on((`paiement`.`idpersonne` = `inscription_formation`.`id_user`))) join `formation` on((`formation`.`idformation` = `inscription_formation`.`idformation`))) join `edition` on((`edition`.`idedition` = `inscription_formation`.`idedition`))) join `categorie_aprenant` on((`categorie_aprenant`.`idcat` = `inscription_formation`.`idcat`))) ;

-- --------------------------------------------------------

--
-- Structure de la vue `profile_presence`
--
DROP TABLE IF EXISTS `profile_presence`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `profile_presence`  AS  select `presence`.`idp` AS `idp`,`presence`.`id_user` AS `id_user`,`presence`.`jour` AS `jour`,`presence`.`created_at` AS `created_at`,`users`.`first_name` AS `first_name`,`users`.`last_name` AS `last_name`,`users`.`email` AS `email`,`users`.`telephone` AS `telephone`,`users`.`image` AS `image`,`users`.`sexe` AS `sexe` from (`presence` join `users` on((`presence`.`id_user` = `users`.`id`))) ;

-- --------------------------------------------------------

--
-- Structure de la vue `profile_question`
--
DROP TABLE IF EXISTS `profile_question`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `profile_question`  AS  select `question`.`idq` AS `idq`,`question`.`nomq` AS `nomq`,`question`.`idr` AS `idr`,`rubrique`.`nomr` AS `nomr`,`rubrique`.`token` AS `token`,`rubrique`.`active` AS `active`,`rubrique`.`idformation` AS `idformation`,`rubrique`.`idedition` AS `idedition`,`formation`.`nom` AS `nom_formation`,`edition`.`nom` AS `nom_edition` from (((`question` join `rubrique` on((`question`.`idr` = `rubrique`.`idr`))) join `formation` on((`formation`.`idformation` = `rubrique`.`idformation`))) join `edition` on((`edition`.`idedition` = `rubrique`.`idedition`))) ;

-- --------------------------------------------------------

--
-- Structure de la vue `profile_recouvrement`
--
DROP TABLE IF EXISTS `profile_recouvrement`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `profile_recouvrement`  AS  select `recouvrement`.`idr` AS `idr`,`recouvrement`.`date_debit` AS `date_debit`,`recouvrement`.`date_fin` AS `date_fin`,`recouvrement`.`idt` AS `idt`,`tranche`.`nomt` AS `nomt`,`tranche`.`montant` AS `montant`,`tranche`.`active` AS `active`,`tranche`.`total_montant` AS `total_montant`,`tranche`.`idformation` AS `idformation`,`tranche`.`idedition` AS `idedition`,`formation`.`nom` AS `nom_formation`,`edition`.`nom` AS `nom_edition` from (((`recouvrement` join `tranche` on((`recouvrement`.`idt` = `tranche`.`idt`))) join `formation` on((`formation`.`idformation` = `tranche`.`idformation`))) join `edition` on((`edition`.`idedition` = `tranche`.`idedition`))) ;

-- --------------------------------------------------------

--
-- Structure de la vue `profile_reponse`
--
DROP TABLE IF EXISTS `profile_reponse`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `profile_reponse`  AS  select `reponse`.`idrep` AS `idrep`,`reponse`.`idq` AS `idq`,`reponse`.`valeur` AS `valeur`,`reponse`.`created_at` AS `created_at`,`question`.`nomq` AS `nomq`,`question`.`idr` AS `idr`,`rubrique`.`nomr` AS `nomr`,`rubrique`.`token` AS `token`,`rubrique`.`active` AS `active`,`rubrique`.`idformation` AS `idformation`,`rubrique`.`idedition` AS `idedition`,`formation`.`nom` AS `nom_formation`,`edition`.`nom` AS `nom_edition` from ((((`reponse` join `question` on((`reponse`.`idq` = `question`.`idq`))) join `rubrique` on((`question`.`idr` = `rubrique`.`idr`))) join `formation` on((`formation`.`idformation` = `rubrique`.`idformation`))) join `edition` on((`edition`.`idedition` = `rubrique`.`idedition`))) ;

-- --------------------------------------------------------

--
-- Structure de la vue `profile_rubrique`
--
DROP TABLE IF EXISTS `profile_rubrique`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `profile_rubrique`  AS  select `rubrique`.`idr` AS `idr`,`rubrique`.`nomr` AS `nomr`,`rubrique`.`token` AS `token`,`rubrique`.`active` AS `active`,`rubrique`.`idformation` AS `idformation`,`rubrique`.`idedition` AS `idedition`,`formation`.`nom` AS `nom_formation`,`edition`.`nom` AS `nom_edition` from ((`rubrique` join `formation` on((`formation`.`idformation` = `rubrique`.`idformation`))) join `edition` on((`edition`.`idedition` = `rubrique`.`idedition`))) ;

-- --------------------------------------------------------

--
-- Structure de la vue `profile_tranche`
--
DROP TABLE IF EXISTS `profile_tranche`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `profile_tranche`  AS  select `tranche`.`idt` AS `idt`,`tranche`.`nomt` AS `nomt`,`tranche`.`montant` AS `montant`,`tranche`.`active` AS `active`,`tranche`.`total_montant` AS `total_montant`,`tranche`.`idformation` AS `idformation`,`tranche`.`idedition` AS `idedition`,`formation`.`nom` AS `nom_formation`,`edition`.`nom` AS `nom_edition` from ((`tranche` join `formation` on((`formation`.`idformation` = `tranche`.`idformation`))) join `edition` on((`edition`.`idedition` = `tranche`.`idedition`))) ;

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `categorie_aprenant`
--
ALTER TABLE `categorie_aprenant`
  ADD PRIMARY KEY (`idcat`);

--
-- Index pour la table `derogation`
--
ALTER TABLE `derogation`
  ADD PRIMARY KEY (`idd`),
  ADD KEY `id_user` (`id_user`);

--
-- Index pour la table `edition`
--
ALTER TABLE `edition`
  ADD PRIMARY KEY (`idedition`);

--
-- Index pour la table `formation`
--
ALTER TABLE `formation`
  ADD PRIMARY KEY (`idformation`);

--
-- Index pour la table `inscription_formation`
--
ALTER TABLE `inscription_formation`
  ADD PRIMARY KEY (`idinscription`),
  ADD KEY `idedition` (`idedition`),
  ADD KEY `idformation` (`idformation`),
  ADD KEY `idcat` (`idcat`),
  ADD KEY `id_user` (`id_user`);

--
-- Index pour la table `messagerie`
--
ALTER TABLE `messagerie`
  ADD PRIMARY KEY (`idmessage`),
  ADD KEY `id_user` (`id_user`),
  ADD KEY `id_recever` (`id_recever`);

--
-- Index pour la table `notification`
--
ALTER TABLE `notification`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_user` (`id_user`);

--
-- Index pour la table `online`
--
ALTER TABLE `online`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_user` (`id_user`);

--
-- Index pour la table `paiement`
--
ALTER TABLE `paiement`
  ADD PRIMARY KEY (`idp`),
  ADD KEY `idpersonne` (`idpersonne`);

--
-- Index pour la table `presence`
--
ALTER TABLE `presence`
  ADD PRIMARY KEY (`idp`),
  ADD KEY `id_user` (`id_user`);

--
-- Index pour la table `question`
--
ALTER TABLE `question`
  ADD PRIMARY KEY (`idq`),
  ADD KEY `idr` (`idr`);

--
-- Index pour la table `recouvrement`
--
ALTER TABLE `recouvrement`
  ADD PRIMARY KEY (`idr`),
  ADD KEY `idt` (`idt`);

--
-- Index pour la table `recupere`
--
ALTER TABLE `recupere`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `reponse`
--
ALTER TABLE `reponse`
  ADD PRIMARY KEY (`idrep`),
  ADD KEY `idq` (`idq`);

--
-- Index pour la table `role`
--
ALTER TABLE `role`
  ADD PRIMARY KEY (`idrole`);

--
-- Index pour la table `rubrique`
--
ALTER TABLE `rubrique`
  ADD PRIMARY KEY (`idr`),
  ADD KEY `idformation` (`idformation`),
  ADD KEY `idedition` (`idedition`);

--
-- Index pour la table `tbl_info`
--
ALTER TABLE `tbl_info`
  ADD PRIMARY KEY (`idinfo`);

--
-- Index pour la table `tranche`
--
ALTER TABLE `tranche`
  ADD PRIMARY KEY (`idt`),
  ADD KEY `idformation` (`idformation`),
  ADD KEY `idedition` (`idedition`);

--
-- Index pour la table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idrole` (`idrole`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `categorie_aprenant`
--
ALTER TABLE `categorie_aprenant`
  MODIFY `idcat` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT pour la table `derogation`
--
ALTER TABLE `derogation`
  MODIFY `idd` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT pour la table `edition`
--
ALTER TABLE `edition`
  MODIFY `idedition` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT pour la table `formation`
--
ALTER TABLE `formation`
  MODIFY `idformation` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT pour la table `inscription_formation`
--
ALTER TABLE `inscription_formation`
  MODIFY `idinscription` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT pour la table `messagerie`
--
ALTER TABLE `messagerie`
  MODIFY `idmessage` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT pour la table `notification`
--
ALTER TABLE `notification`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=61;

--
-- AUTO_INCREMENT pour la table `online`
--
ALTER TABLE `online`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT pour la table `paiement`
--
ALTER TABLE `paiement`
  MODIFY `idp` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT pour la table `presence`
--
ALTER TABLE `presence`
  MODIFY `idp` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=27;

--
-- AUTO_INCREMENT pour la table `question`
--
ALTER TABLE `question`
  MODIFY `idq` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT pour la table `recouvrement`
--
ALTER TABLE `recouvrement`
  MODIFY `idr` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT pour la table `recupere`
--
ALTER TABLE `recupere`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT pour la table `reponse`
--
ALTER TABLE `reponse`
  MODIFY `idrep` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=27;

--
-- AUTO_INCREMENT pour la table `role`
--
ALTER TABLE `role`
  MODIFY `idrole` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT pour la table `rubrique`
--
ALTER TABLE `rubrique`
  MODIFY `idr` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT pour la table `tbl_info`
--
ALTER TABLE `tbl_info`
  MODIFY `idinfo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT pour la table `tranche`
--
ALTER TABLE `tranche`
  MODIFY `idt` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT pour la table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `derogation`
--
ALTER TABLE `derogation`
  ADD CONSTRAINT `derogation_ibfk_1` FOREIGN KEY (`id_user`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `inscription_formation`
--
ALTER TABLE `inscription_formation`
  ADD CONSTRAINT `inscription_formation_ibfk_1` FOREIGN KEY (`idedition`) REFERENCES `edition` (`idedition`) ON DELETE CASCADE,
  ADD CONSTRAINT `inscription_formation_ibfk_2` FOREIGN KEY (`idformation`) REFERENCES `formation` (`idformation`) ON DELETE CASCADE,
  ADD CONSTRAINT `inscription_formation_ibfk_3` FOREIGN KEY (`idcat`) REFERENCES `categorie_aprenant` (`idcat`) ON DELETE CASCADE,
  ADD CONSTRAINT `inscription_formation_ibfk_4` FOREIGN KEY (`id_user`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `messagerie`
--
ALTER TABLE `messagerie`
  ADD CONSTRAINT `messagerie_ibfk_1` FOREIGN KEY (`id_user`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `messagerie_ibfk_2` FOREIGN KEY (`id_recever`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `notification`
--
ALTER TABLE `notification`
  ADD CONSTRAINT `notification_ibfk_1` FOREIGN KEY (`id_user`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `online`
--
ALTER TABLE `online`
  ADD CONSTRAINT `online_ibfk_1` FOREIGN KEY (`id_user`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `paiement`
--
ALTER TABLE `paiement`
  ADD CONSTRAINT `paiement_ibfk_1` FOREIGN KEY (`idpersonne`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `presence`
--
ALTER TABLE `presence`
  ADD CONSTRAINT `presence_ibfk_1` FOREIGN KEY (`id_user`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `question`
--
ALTER TABLE `question`
  ADD CONSTRAINT `question_ibfk_1` FOREIGN KEY (`idr`) REFERENCES `rubrique` (`idr`) ON DELETE CASCADE;

--
-- Contraintes pour la table `recouvrement`
--
ALTER TABLE `recouvrement`
  ADD CONSTRAINT `recouvrement_ibfk_1` FOREIGN KEY (`idt`) REFERENCES `tranche` (`idt`) ON DELETE CASCADE;

--
-- Contraintes pour la table `reponse`
--
ALTER TABLE `reponse`
  ADD CONSTRAINT `reponse_ibfk_1` FOREIGN KEY (`idq`) REFERENCES `question` (`idq`) ON DELETE CASCADE;

--
-- Contraintes pour la table `rubrique`
--
ALTER TABLE `rubrique`
  ADD CONSTRAINT `rubrique_ibfk_1` FOREIGN KEY (`idformation`) REFERENCES `formation` (`idformation`) ON DELETE CASCADE,
  ADD CONSTRAINT `rubrique_ibfk_2` FOREIGN KEY (`idedition`) REFERENCES `edition` (`idedition`) ON DELETE CASCADE;

--
-- Contraintes pour la table `tranche`
--
ALTER TABLE `tranche`
  ADD CONSTRAINT `tranche_ibfk_1` FOREIGN KEY (`idformation`) REFERENCES `formation` (`idformation`) ON DELETE CASCADE,
  ADD CONSTRAINT `tranche_ibfk_2` FOREIGN KEY (`idedition`) REFERENCES `edition` (`idedition`) ON DELETE CASCADE;

--
-- Contraintes pour la table `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `users_ibfk_1` FOREIGN KEY (`idrole`) REFERENCES `role` (`idrole`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
