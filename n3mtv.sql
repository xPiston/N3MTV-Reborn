-- --------------------------------------------------------
-- Hôte :                        127.0.0.1
-- Version du serveur:           10.2.6-MariaDB - mariadb.org binary distribution
-- SE du serveur:                Win64
-- HeidiSQL Version:             9.4.0.5125
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

-- Export de la structure de la table version_partage. bans
CREATE TABLE IF NOT EXISTS `bans` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `banned` varchar(50) NOT NULL DEFAULT '0',
  `banner` varchar(50) NOT NULL,
  `reason` varchar(150) NOT NULL DEFAULT '0',
  `expires` datetime NOT NULL,
  `timestamp` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8;

-- Export de données de la table version_partage.bans : ~0 rows (environ)
DELETE FROM `bans`;
/*!40000 ALTER TABLE `bans` DISABLE KEYS */;
/*!40000 ALTER TABLE `bans` ENABLE KEYS */;

-- Export de la structure de la table version_partage. clothes_outfits
CREATE TABLE IF NOT EXISTS `clothes_outfits` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL DEFAULT '0',
  `category` varchar(50) NOT NULL DEFAULT '0',
  `skin_model` varchar(50) NOT NULL DEFAULT '0',
  `price` int(11) NOT NULL DEFAULT 0,
  `arm` int(11) NOT NULL DEFAULT 0,
  `arm_txt` int(11) NOT NULL DEFAULT 0,
  `tshirt` int(11) NOT NULL DEFAULT 0,
  `tshirt_txt` int(11) NOT NULL DEFAULT 0,
  `jacket` int(11) NOT NULL DEFAULT 0,
  `jacket_txt` int(11) NOT NULL DEFAULT 0,
  `pant` int(11) NOT NULL DEFAULT 0,
  `pant_txt` int(11) NOT NULL DEFAULT 0,
  `shoe` int(11) NOT NULL DEFAULT 0,
  `shoe_txt` int(11) NOT NULL DEFAULT 0,
  `glasses` int(11) NOT NULL DEFAULT 0,
  `glasses_txt` int(11) NOT NULL DEFAULT 0,
  `hat` int(11) NOT NULL DEFAULT 0,
  `hat_txt` int(11) NOT NULL DEFAULT 0,
  `mask` int(11) NOT NULL DEFAULT 0,
  `mask_txt` int(11) NOT NULL DEFAULT 0,
  `shield` int(11) NOT NULL DEFAULT 0,
  `shield_txt` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=232 DEFAULT CHARSET=utf8;

-- Export de données de la table version_partage.clothes_outfits : 223 rows
DELETE FROM `clothes_outfits`;
/*!40000 ALTER TABLE `clothes_outfits` DISABLE KEYS */;
INSERT INTO `clothes_outfits` (`id`, `name`, `category`, `skin_model`, `price`, `arm`, `arm_txt`, `tshirt`, `tshirt_txt`, `jacket`, `jacket_txt`, `pant`, `pant_txt`, `shoe`, `shoe_txt`, `glasses`, `glasses_txt`, `hat`, `hat_txt`, `mask`, `mask_txt`, `shield`, `shield_txt`) VALUES
	(3, 'Négligé', 'skincreator', 'mp_m_freemode_01', 1500, 0, 0, 15, 0, 22, 1, 5, 0, 12, 6, 0, 0, 0, 0, 0, 0, 0, 0),
	(2, 'Mauvais Goût', 'skincreator', 'mp_m_freemode_01', 1500, 5, 0, 15, 0, 5, 0, 12, 0, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0),
	(1, 'Bronzage', 'skincreator', 'mp_m_freemode_01', 1500, 5, 0, 15, 0, 5, 7, 16, 11, 16, 9, 0, 0, 0, 0, 0, 0, 0, 0),
	(4, 'Ordinaire', 'skincreator', 'mp_m_freemode_01', 1500, 6, 0, 5, 0, 3, 0, 2, 11, 7, 0, 0, 0, 0, 0, 0, 0, 0, 0),
	(5, 'Le Quartier', 'skincreator', 'mp_m_freemode_01', 1500, 6, 0, 5, 2, 7, 0, 7, 12, 9, 0, 0, 0, 0, 0, 0, 0, 0, 0),
	(6, 'Sportif', 'skincreator', 'mp_m_freemode_01', 1500, 6, 0, 0, 3, 3, 15, 3, 15, 2, 6, 0, 0, 0, 0, 0, 0, 0, 0),
	(21, 'Gangsta', 'skincreator', 'mp_f_freemode_01', 1500, 4, 0, 15, 0, 5, 0, 3, 0, 1, 3, 0, 0, 0, 0, 0, 0, 0, 0),
	(22, 'Garçon manqué', 'skincreator', 'mp_f_freemode_01', 1500, 3, 0, 14, 0, 3, 1, 1, 4, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0),
	(23, 'Normale', 'skincreator', 'mp_f_freemode_01', 1500, 4, 0, 14, 0, 0, 11, 1, 4, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0),
	(24, 'Jeune', 'skincreator', 'mp_f_freemode_01', 1500, 1, 0, 0, 9, 1, 11, 8, 7, 3, 5, 0, 0, 0, 0, 0, 0, 0, 0),
	(25, 'Sportive', 'skincreator', 'mp_f_freemode_01', 1500, 1, 0, 22, 2, 10, 0, 14, 0, 11, 0, 0, 0, 0, 0, 0, 0, 0, 0),
	(26, 'Diablesse', 'skincreator', 'mp_f_freemode_01', 1500, 15, 0, 15, 0, 4, 13, 2, 2, 11, 3, 0, 0, 0, 0, 0, 0, 0, 0),
	(7, 'Street', 'skincreator', 'mp_m_freemode_01', 1500, 4, 0, 15, 0, 14, 13, 9, 7, 1, 2, 0, 0, 0, 0, 0, 0, 0, 0),
	(8, 'Loveur', 'skincreator', 'mp_m_freemode_01', 2000, 4, 0, 21, 1, 4, 2, 20, 0, 18, 0, 0, 0, 0, 0, 0, 0, 0, 0),
	(9, 'Plage', 'skincreator', 'mp_m_freemode_01', 750, 5, 0, 15, 1, 17, 2, 14, 12, 34, 0, 0, 0, 0, 0, 0, 0, 0, 0),
	(10, 'Motard', 'skincreator', 'mp_m_freemode_01', 1500, 4, 0, 27, 2, 37, 1, 24, 0, 26, 1, 0, 0, 0, 0, 0, 0, 0, 0),
	(11, 'Barman', 'skincreator', 'mp_m_freemode_01', 2000, 11, 0, 7, 0, 40, 1, 20, 0, 15, 2, 0, 0, 0, 0, 0, 0, 0, 0),
	(37, 'Short - Tshirt', '0', 'mp_m_freemode_01', 1500, 0, 0, 15, 0, 131, 0, 6, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0),
	(13, 'Casual Chic', 'skincreator', 'mp_m_freemode_01', 2000, 4, 0, 32, 2, 142, 0, 10, 0, 10, 0, 0, 0, 0, 0, 0, 0, 0, 0),
	(14, 'Casual Liberty', 'skincreator', 'mp_m_freemode_01', 1500, 0, 0, 15, 0, 131, 0, 48, 1, 40, 3, 0, 0, 0, 0, 0, 0, 0, 0),
	(15, 'BaBaCool', 'skincreator', 'mp_m_freemode_01', 1500, 0, 0, 15, 0, 121, 3, 62, 1, 3, 15, 0, 0, 0, 0, 0, 0, 0, 0),
	(16, 'BlingBling', 'skincreator', 'mp_m_freemode_01', 2500, 14, 0, 15, 0, 70, 7, 20, 2, 28, 1, 0, 0, 0, 0, 0, 0, 0, 0),
	(17, 'Sous vetement', 'skincreator', 'mp_m_freemode_01', 500, 15, 0, 15, 0, 15, 7, 21, 0, 5, 2, 0, 0, 0, 0, 0, 0, 0, 0),
	(27, 'Jean\'s 1', 'skincreator', 'mp_f_freemode_01', 1500, 9, 0, 0, 0, 9, 2, 8, 2, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0),
	(28, 'Fatal', 'skincreator', 'mp_f_freemode_01', 1500, 15, 0, 2, 0, 26, 2, 27, 4, 14, 15, 0, 0, 0, 0, 0, 0, 0, 0),
	(29, 'Plage', 'skincreator', 'mp_f_freemode_01', 750, 15, 0, 2, 0, 15, 10, 10, 2, 5, 13, 0, 0, 0, 0, 0, 0, 0, 0),
	(33, 'Working Girl', 'skincreator', 'mp_f_freemode_01', 2000, 5, 0, 64, 0, 93, 2, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
	(30, 'Motarde', 'skincreator', 'mp_f_freemode_01', 1500, 23, 0, 15, 0, 110, 7, 43, 0, 24, 0, 0, 0, 0, 0, 0, 0, 0, 0),
	(31, 'BarMaid', 'skincreator', 'mp_f_freemode_01', 2000, 0, 0, 24, 4, 28, 9, 23, 7, 19, 3, 0, 0, 0, 0, 0, 0, 0, 0),
	(38, 'Short - Pull noir', '0', 'mp_m_freemode_01', 1500, 1, 0, 15, 0, 134, 0, 6, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0),
	(34, 'Casual', 'skincreator', 'mp_f_freemode_01', 1500, 14, 0, 15, 0, 14, 10, 0, 1, 13, 14, 0, 0, 0, 0, 0, 0, 0, 0),
	(35, 'BaBaCool', 'skincreator', 'mp_f_freemode_01', 1500, 0, 0, 15, 0, 123, 3, 66, 2, 1, 14, 0, 0, 0, 0, 0, 0, 0, 0),
	(36, 'BlingBling', 'skincreator', 'mp_f_freemode_01', 2500, 6, 0, 1, 0, 65, 8, 26, 0, 8, 7, 0, 0, 0, 0, 0, 0, 0, 0),
	(39, 'Short - Pull rouge', '0', 'mp_m_freemode_01', 1500, 1, 0, 15, 0, 134, 1, 6, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0),
	(40, 'Short - Pull blanc', '0', 'mp_m_freemode_01', 1500, 1, 0, 15, 0, 134, 2, 6, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0),
	(41, 'Veste en cuir - Jean', '0', 'mp_m_freemode_01', 2000, 1, 0, 1, 4, 122, 8, 0, 0, 9, 0, 0, 0, 0, 0, 0, 0, 0, 0),
	(42, 'Pull à capuche', '0', 'mp_m_freemode_01', 1500, 4, 0, 15, 0, 96, 0, 43, 0, 22, 0, 0, 0, 0, 0, 0, 0, 0, 0),
	(43, 'Chic noir et gris', '0', 'mp_m_freemode_01', 1500, 11, 0, 7, 0, 11, 0, 25, 0, 12, 6, 0, 0, 0, 0, 0, 0, 0, 0),
	(44, 'Détente au soleil', '0', 'mp_m_freemode_01', 1000, 15, 0, 15, 0, 15, 0, 54, 1, 34, 0, 0, 0, 0, 0, 0, 0, 0, 0),
	(45, 'Ville - bad boy', '0', 'mp_m_freemode_01', 1500, 1, 0, 0, 7, 62, 0, 0, 1, 12, 6, 0, 0, 0, 0, 0, 0, 0, 0),
	(46, 'Biker', '0', 'mp_m_freemode_01', 2500, 1, 0, 1, 0, 151, 1, 1, 1, 25, 0, 0, 0, 0, 0, 0, 0, 0, 0),
	(50, 'Classy', '0', 'mp_m_freemode_01', 1750, 6, 0, 32, 2, 27, 0, 24, 0, 10, 0, 0, 0, 0, 0, 0, 0, 0, 0),
	(51, 'NewStyle', '0', 'mp_m_freemode_01', 2650, 6, 0, 15, 0, 50, 0, 1, 1, 12, 3, 0, 0, 0, 0, 0, 0, 0, 0),
	(52, 'TenueNoir', '0', 'mp_m_freemode_01', 1825, 1, 0, 44, 0, 64, 0, 4, 0, 4, 1, 0, 0, 0, 0, 0, 0, 0, 0),
	(53, 'Classy', '0', 'mp_f_freemode_01', 1750, 6, 0, 59, 1, 66, 0, 6, 0, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0),
	(54, 'NewStyle', '0', 'mp_f_freemode_01', 2650, 6, 0, 66, 3, 70, 1, 54, 2, 13, 0, 0, 0, 0, 0, 0, 0, 0, 0),
	(55, 'TenueNoir', '0', 'mp_f_freemode_01', 1825, 5, 0, 2, 0, 79, 0, 3, 0, 27, 0, 0, 0, 0, 0, 0, 0, 0, 0),
	(56, 'Casual', '0', 'mp_f_freemode_01', 1500, 9, 0, 7, 0, 9, 9, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0),
	(57, 'Ville - Moderne', '0', 'mp_f_freemode_01', 1500, 5, 0, 16, 0, 64, 3, 4, 1, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0),
	(58, 'Working Girl 2', '0', 'mp_f_freemode_01', 2000, 7, 0, 64, 0, 57, 0, 6, 0, 42, 2, 0, 0, 0, 0, 0, 0, 0, 0),
	(59, 'La rue 1', '0', 'mp_f_freemode_01', 1500, 4, 0, 2, 0, 118, 0, 45, 2, 1, 5, 0, 0, 0, 0, 0, 0, 0, 0),
	(60, 'La rue 2', '0', 'mp_f_freemode_01', 1500, 3, 0, 2, 0, 3, 4, 4, 1, 11, 2, 0, 0, 0, 0, 0, 0, 0, 0),
	(61, 'Tenue de nuit', '0', 'mp_f_freemode_01', 750, 2, 0, 6, 0, 38, 3, 62, 2, 35, 0, 0, 0, 0, 0, 0, 0, 0, 0),
	(62, 'Ecolière', '0', 'mp_f_freemode_01', 1500, 0, 0, 10, 0, 27, 0, 12, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
	(63, 'Randonnée', '0', 'mp_f_freemode_01', 1500, 14, 0, 10, 0, 73, 2, 14, 9, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0),
	(64, 'Fan de country', '0', 'mp_f_freemode_01', 1500, 0, 0, 15, 0, 9, 13, 0, 12, 38, 1, 0, 0, 0, 0, 0, 0, 0, 0),
	(65, 'Croft', '0', 'mp_f_freemode_01', 5000, 63, 0, 5, 0, 16, 2, 25, 6, 24, 0, 0, 0, 0, 0, 0, 0, 0, 0),
	(66, 'Chic', '0', 'mp_f_freemode_01', 2000, 5, 0, 20, 1, 65, 3, 43, 2, 22, 10, 0, 0, 0, 0, 0, 0, 0, 0),
	(67, 'Discrète', '0', 'mp_f_freemode_01', 1500, 5, 0, 23, 9, 64, 1, 27, 0, 8, 0, 0, 0, 0, 0, 0, 0, 0, 0),
	(68, 'Secrétaire', '0', 'mp_f_freemode_01', 1500, 6, 0, 22, 0, 66, 3, 9, 6, 20, 3, 0, 0, 0, 0, 0, 0, 0, 0),
	(69, 'Asiatique', '0', 'mp_m_freemode_01', 2000, 14, 0, 15, 0, 107, 4, 37, 2, 7, 0, 0, 0, 0, 0, 0, 0, 0, 0),
	(70, 'Ville', '0', 'mp_m_freemode_01', 1500, 1, 0, 0, 2, 62, 0, 4, 1, 0, 10, 0, 0, 0, 0, 0, 0, 0, 0),
	(71, 'Simple', '0', 'mp_m_freemode_01', 1500, 0, 0, 15, 0, 1, 4, 9, 1, 7, 3, 0, 0, 0, 0, 0, 0, 0, 0),
	(72, 'Stylisé', '0', 'mp_m_freemode_01', 1500, 1, 0, 24, 0, 69, 5, 4, 4, 12, 0, 0, 0, 0, 0, 0, 0, 0, 0),
	(73, 'Sport', '0', 'mp_m_freemode_01', 1500, 0, 0, 15, 0, 150, 3, 64, 10, 9, 15, 0, 0, 0, 0, 0, 0, 0, 0),
	(74, 'Djeunes', '0', 'mp_m_freemode_01', 1500, 14, 0, 47, 1, 74, 4, 37, 2, 8, 6, 0, 0, 0, 0, 0, 0, 0, 0),
	(75, 'Columbo', '0', 'mp_m_freemode_01', 2100, 11, 0, 10, 0, 77, 1, 25, 6, 21, 5, 0, 0, 0, 0, 0, 0, 0, 0),
	(76, 'Vieu jeu', '0', 'mp_m_freemode_01', 1200, 19, 1, 38, 0, 156, 1, 25, 0, 3, 4, 0, 0, 0, 0, 0, 0, 0, 0),
	(77, 'Lambda', '0', 'mp_m_freemode_01', 1500, 8, 0, 15, 0, 38, 3, 27, 8, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0),
	(78, 'Lambda 2', '0', 'mp_m_freemode_01', 1500, 14, 0, 47, 0, 7, 7, 15, 1, 6, 1, 0, 0, 0, 0, 0, 0, 0, 0),
	(79, 'Militaire', '0', 'mp_m_freemode_01', 2000, 0, 0, 15, 0, 97, 1, 31, 4, 25, 0, 0, 0, 0, 0, 0, 0, 0, 0),
	(80, 'Parrain blanc', '0', 'mp_m_freemode_01', 3000, 14, 0, 69, 0, 20, 0, 20, 0, 20, 3, 0, 0, 0, 0, 0, 0, 0, 0),
	(81, 'Parrain noir', '0', 'mp_m_freemode_01', 3000, 14, 0, 69, 0, 20, 2, 20, 2, 20, 7, 0, 0, 0, 0, 0, 0, 0, 0),
	(82, 'Discret', '0', 'mp_m_freemode_01', 1500, 14, 0, 18, 0, 68, 2, 8, 0, 7, 3, 0, 0, 0, 0, 0, 0, 0, 0),
	(83, 'Décontracté', '0', 'mp_m_freemode_01', 1500, 11, 0, 15, 0, 105, 0, 23, 12, 3, 1, 0, 0, 0, 0, 0, 0, 0, 0),
	(84, 'Homme d affaire', '0', 'mp_m_freemode_01', 2300, 4, 0, 72, 1, 31, 1, 25, 1, 20, 0, 0, 0, 0, 0, 0, 0, 0, 0),
	(90, 'Riche', '0', 'mp_m_freemode_01', 3400, 4, 0, 72, 5, 108, 4, 45, 0, 36, 0, 0, 0, 0, 0, 0, 0, 0, 0),
	(91, 'Pyjama', '0', 'mp_m_freemode_01', 3400, 14, 0, 15, 0, 145, 0, 65, 0, 41, 0, 0, 0, 0, 0, 0, 0, 0, 0),
	(92, 'fan de country', '0', 'mp_m_freemode_01', 1500, 11, 0, 15, 0, 95, 2, 4, 1, 37, 3, 0, 0, 0, 0, 0, 0, 0, 0),
	(85, 'Classic', '0', 'mp_f_freemode_01', 1500, 1, 0, 27, 2, 35, 5, 23, 0, 14, 0, 0, 0, 0, 0, 0, 0, 0, 0),
	(86, 'Ecoissaise', '0', 'mp_f_freemode_01', 1500, 4, 0, 15, 0, 13, 5, 12, 1, 14, 0, 0, 0, 0, 0, 0, 0, 0, 0),
	(87, 'Soirée', '0', 'mp_f_freemode_01', 1500, 4, 0, 15, 0, 13, 6, 9, 8, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
	(88, 'Noir et Blanc', '0', 'mp_f_freemode_01', 1500, 4, 0, 15, 0, 13, 14, 24, 7, 19, 9, 0, 0, 0, 0, 0, 0, 0, 0),
	(89, 'Ville 2', '0', 'mp_f_freemode_01', 1500, 12, 0, 14, 0, 12, 8, 23, 0, 42, 4, 0, 0, 0, 0, 0, 0, 0, 0),
	(93, 'Peignoir', '0', 'mp_f_freemode_01', 1500, 0, 0, 15, 0, 105, 0, 57, 0, 16, 1, 0, 0, 0, 0, 0, 0, 0, 0),
	(94, 'Robe', '0', 'mp_f_freemode_01', 1500, 15, 0, 15, 0, 112, 0, 14, 0, 14, 0, 0, 0, 0, 0, 0, 0, 0, 0),
	(95, 'Comando', '0', 'mp_f_freemode_01', 1500, 11, 0, 3, 0, 117, 1, 30, 4, 24, 0, 0, 0, 0, 0, 0, 0, 0, 0),
	(96, 'Hentai', '0', 'mp_f_freemode_01', 1500, 4, 0, 34, 0, 33, 6, 27, 11, 8, 13, 0, 0, 0, 0, 0, 0, 0, 0),
	(97, 'Robe Fleur', '0', 'mp_f_freemode_01', 1500, 4, 0, 34, 0, 37, 5, 17, 8, 13, 3, 0, 0, 0, 0, 0, 0, 0, 0),
	(98, 'Simple', '0', 'mp_f_freemode_01', 1500, 2, 0, 15, 0, 2, 2, 25, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 0),
	(99, 'Décontracté 2', '0', 'mp_m_freemode_01', 2200, 1, 0, 63, 0, 4, 0, 25, 1, 30, 1, 0, 0, 0, 0, 0, 0, 0, 0),
	(100, 'Costar Gris', '0', 'mp_m_freemode_01', 3000, 4, 0, 32, 0, 31, 1, 25, 1, 20, 0, 0, 0, 0, 0, 0, 0, 0, 0),
	(101, 'Costar Blanc', '0', 'mp_m_freemode_01', 3000, 1, 0, 34, 4, 31, 7, 20, 0, 15, 9, 0, 0, 0, 0, 0, 0, 0, 0),
	(102, 'Costar Noir', '0', 'mp_m_freemode_01', 3000, 1, 0, 34, 1, 31, 0, 10, 0, 15, 0, 0, 0, 0, 0, 0, 0, 0, 0),
	(103, 'Pas trop chaud', '0', 'mp_m_freemode_01', 2000, 4, 0, 71, 5, 140, 9, 23, 8, 20, 5, 0, 0, 0, 0, 0, 0, 0, 0),
	(104, 'Racaille', '0', 'mp_m_freemode_01', 1000, 0, 0, 15, 0, 128, 0, 55, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0),
	(105, 'Biker Style', '0', 'mp_m_freemode_01', 1850, 15, 0, 15, 0, 176, 0, 71, 0, 56, 1, 0, 0, 0, 0, 0, 0, 0, 0),
	(106, 'Full Jean', '0', 'mp_m_freemode_01', 1500, 4, 0, 90, 0, 169, 0, 0, 1, 55, 7, 0, 0, 0, 0, 0, 0, 0, 0),
	(107, 'Élégant', '0', 'mp_m_freemode_01', 4261, 4, 0, 25, 8, 23, 2, 48, 1, 3, 5, 0, 0, 0, 0, 0, 0, 0, 0),
	(108, 'Old Class', '0', 'mp_m_freemode_01', 4000, 4, 0, 32, 0, 32, 6, 25, 1, 21, 2, 0, 0, 0, 0, 0, 0, 0, 0),
	(109, 'Comptable', '0', 'mp_m_freemode_01', 3400, 4, 0, 22, 4, 25, 9, 22, 8, 20, 3, 0, 0, 0, 0, 0, 0, 0, 0),
	(110, 'Maillot Noir', '0', 'mp_f_freemode_01', 1000, 15, 0, 15, 0, 18, 1, 17, 1, 35, 0, 0, 0, 0, 0, 0, 0, 0, 0),
	(111, 'Maillot Léopard', '0', 'mp_f_freemode_01', 1550, 15, 0, 15, 0, 18, 3, 17, 3, 35, 0, 0, 0, 0, 0, 0, 0, 0, 0),
	(112, 'Malibu', '0', 'mp_f_freemode_01', 3720, 11, 0, 14, 0, 11, 10, 17, 4, 35, 0, 0, 0, 0, 0, 0, 0, 0, 0),
	(113, 'Topless 1', '0', 'mp_f_freemode_01', 750, 15, 0, 2, 0, 82, 0, 62, 11, 35, 0, 0, 0, 0, 0, 0, 0, 0, 0),
	(114, 'Topless 2', '0', 'mp_f_freemode_01', 750, 15, 0, 2, 0, 82, 0, 62, 2, 35, 0, 0, 0, 0, 0, 0, 0, 0, 0),
	(115, 'Rebelle', '0', 'mp_f_freemode_01', 2250, 15, 0, 80, 3, 154, 0, 73, 4, 51, 0, 0, 0, 0, 0, 0, 0, 0, 0),
	(116, 'Jean 1', '0', 'mp_f_freemode_01', 2050, 14, 0, 30, 3, 166, 1, 11, 1, 24, 0, 0, 0, 0, 0, 0, 0, 0, 0),
	(117, 'Jean 2', '0', 'mp_f_freemode_01', 2050, 14, 0, 80, 1, 174, 1, 73, 1, 49, 0, 0, 0, 0, 0, 0, 0, 0, 0),
	(118, 'Classic 2', '0', 'mp_f_freemode_01', 1810, 4, 0, 2, 0, 32, 1, 0, 0, 11, 2, 0, 0, 0, 0, 0, 0, 0, 0),
	(119, 'Rue 3', '0', 'mp_f_freemode_01', 1500, 12, 0, 2, 0, 207, 4, 45, 1, 33, 1, 0, 0, 0, 0, 0, 0, 0, 0),
	(120, 'Biker 2', '0', 'mp_m_freemode_01', 1500, 14, 0, 14, 0, 174, 0, 72, 3, 50, 0, 0, 0, 0, 0, 0, 0, 0, 0),
	(121, 'Jean\'s 2', '0', 'mp_m_freemode_01', 1500, 14, 0, 76, 0, 172, 3, 75, 7, 48, 0, 0, 0, 0, 0, 0, 0, 0, 0),
	(122, 'Jean\'s 3', '0', 'mp_m_freemode_01', 1500, 14, 0, 76, 0, 172, 1, 75, 0, 48, 0, 0, 0, 0, 0, 0, 0, 0, 0),
	(123, 'Chic noir', '0', 'mp_m_freemode_01', 1500, 11, 0, 7, 0, 11, 1, 13, 0, 12, 6, 0, 0, 0, 0, 0, 0, 0, 0),
	(139, 'Cross Bleu', '0', 'mp_m_freemode_01', 2500, 110, 7, 15, 0, 148, 7, 67, 7, 47, 7, 0, 0, 0, 0, 0, 0, 0, 0),
	(138, 'Cross Rouge', '0', 'mp_m_freemode_01', 2500, 110, 1, 15, 0, 148, 1, 67, 1, 47, 1, 0, 0, 0, 0, 0, 0, 0, 0),
	(137, 'Cross Violet', '0', 'mp_m_freemode_01', 2500, 110, 10, 15, 0, 148, 10, 67, 10, 47, 10, 0, 0, 0, 0, 0, 0, 0, 0),
	(136, 'Cross Jaune', '0', 'mp_f_freemode_01', 2500, 127, 3, 3, 0, 145, 5, 69, 5, 48, 5, 0, 0, 0, 0, 0, 0, 0, 0),
	(135, 'Cross Bleu', '0', 'mp_f_freemode_01', 2500, 127, 7, 3, 0, 145, 7, 69, 7, 48, 7, 0, 0, 0, 0, 0, 0, 0, 0),
	(134, 'Cross Rouge', '0', 'mp_f_freemode_01', 2500, 127, 1, 3, 0, 145, 1, 69, 1, 48, 1, 0, 0, 0, 0, 0, 0, 0, 0),
	(133, 'Cross Violet', '0', 'mp_f_freemode_01', 2500, 127, 10, 3, 0, 145, 10, 69, 10, 48, 10, 0, 0, 0, 0, 0, 0, 0, 0),
	(131, 'Casual Bleu', '0', 'mp_m_freemode_01', 1500, 1, 0, 15, 0, 12, 11, 63, 0, 22, 5, 0, 0, 0, 0, 0, 0, 0, 0),
	(130, 'Carreaux Bleu', '0', 'mp_m_freemode_01', 1500, 11, 0, 6, 0, 120, 4, 27, 5, 40, 4, 0, 0, 0, 0, 0, 0, 0, 0),
	(128, 'Salopette', '0', 'mp_f_freemode_01', 1500, 4, 0, 2, 0, 0, 5, 93, 2, 33, 1, 0, 0, 0, 0, 0, 0, 0, 0),
	(129, 'Décontracté marron', '0', 'mp_m_freemode_01', 1500, 0, 0, 15, 0, 16, 1, 8, 0, 9, 0, 0, 0, 0, 0, 0, 0, 0, 0),
	(127, 'Tailleur Pant', '0', 'mp_f_freemode_01', 1500, 3, 0, 40, 2, 57, 5, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
	(126, 'Badass', '0', 'mp_f_freemode_01', 1500, 32, 0, 60, 1, 154, 1, 75, 1, 7, 4, 0, 0, 0, 0, 0, 0, 0, 0),
	(132, 'Red Black', '0', 'mp_m_freemode_01', 1500, 0, 0, 15, 0, 146, 2, 9, 7, 32, 3, 0, 0, 0, 0, 0, 0, 0, 0),
	(125, 'Mini short', '0', 'mp_f_freemode_01', 1500, 12, 0, 2, 0, 26, 3, 25, 6, 44, 3, 0, 0, 0, 0, 0, 0, 0, 0),
	(124, 'Biker rose', '0', 'mp_f_freemode_01', 1500, 5, 0, 16, 3, 8, 2, 44, 0, 7, 8, 0, 0, 0, 0, 0, 0, 0, 0),
	(140, 'Cross Jaune', '0', 'mp_m_freemode_01', 2500, 110, 3, 15, 0, 148, 5, 67, 5, 47, 5, 0, 0, 0, 0, 0, 0, 0, 0),
	(141, 'City NB', '0', 'mp_f_freemode_01', 2000, 1, 0, 0, 13, 64, 1, 4, 3, 13, 0, 0, 0, 0, 0, 0, 0, 0, 0),
	(142, 'Hipster', '0', 'mp_m_freemode_01', 2000, 11, 0, 0, 2, 191, 8, 26, 0, 31, 3, 0, 0, 0, 0, 0, 0, 0, 0),
	(143, 'Joke-r', '0', 'mp_m_freemode_01', 2000, 14, 0, 26, 2, 58, 0, 22, 2, 18, 0, 0, 0, 0, 0, 0, 0, 0, 0),
	(144, 'Motard S-manche', '0', 'mp_m_freemode_01', 2000, 0, 0, 85, 16, 175, 3, 76, 0, 24, 0, 0, 0, 0, 0, 0, 0, 0, 0),
	(145, 'Street 2', '0', 'mp_m_freemode_01', 2000, 14, 0, 8, 0, 191, 25, 62, 2, 43, 4, 0, 0, 0, 0, 0, 0, 0, 0),
	(146, 'Plage Rose', '0', 'mp_f_freemode_01', 1000, 11, 0, 3, 0, 208, 13, 16, 2, 16, 8, 0, 0, 0, 0, 0, 0, 0, 0),
	(147, 'Plage NB', '0', 'mp_f_freemode_01', 1000, 11, 0, 3, 0, 208, 5, 16, 4, 16, 0, 0, 0, 0, 0, 0, 0, 0, 0),
	(148, 'Cargo bleu', '0', 'mp_f_freemode_01', 1500, 4, 0, 3, 0, 16, 4, 45, 2, 1, 10, 0, 0, 0, 0, 0, 0, 0, 0),
	(149, 'Laitière', '0', 'mp_m_freemode_01', 1500, 11, 0, 15, 0, 13, 0, 24, 5, 10, 0, 0, 0, 0, 0, 0, 0, 0, 0),
	(150, 'Cuir noir', '0', 'mp_f_freemode_01', 1000, 4, 0, 3, 0, 173, 0, 8, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
	(151, 'Banale', '0', 'mp_m_freemode_01', 1500, 1, 0, 15, 0, 12, 3, 25, 0, 1, 2, 0, 0, 0, 0, 0, 0, 0, 0),
	(152, 'Rayure', '0', 'mp_f_freemode_01', 2000, 15, 0, 3, 0, 32, 2, 78, 3, 7, 1, 0, 0, 0, 0, 0, 0, 0, 0),
	(153, 'Mr Pink', '0', 'mp_m_freemode_01', 1500, 1, 0, 15, 0, 200, 8, 16, 9, 32, 6, 0, 0, 0, 0, 0, 0, 0, 0),
	(154, 'Bike noir', '0', 'mp_m_freemode_01', 2500, 21, 0, 0, 2, 179, 0, 76, 7, 51, 0, 0, 0, 0, 0, 0, 0, 0, 0),
	(155, 'Tailleur C-Rose', '0', 'mp_f_freemode_01', 2500, 4, 0, 3, 0, 173, 0, 52, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
	(156, 'Jean Gris', '0', 'mp_m_freemode_01', 2500, 6, 0, 0, 2, 156, 2, 43, 1, 12, 6, 0, 0, 0, 0, 0, 0, 0, 0),
	(157, 'Veste Rouge', '0', 'mp_m_freemode_01', 2500, 6, 0, 0, 2, 4, 2, 10, 0, 12, 9, 0, 0, 0, 0, 0, 0, 0, 0),
	(158, 'Jean Cuir', '0', 'mp_m_freemode_01', 2500, 6, 0, 0, 2, 163, 0, 1, 14, 12, 6, 0, 0, 0, 0, 0, 0, 0, 0),
	(159, 'Jupapaillettes', '12', 'mp_f_freemode_01', 1500, 6, 0, 23, 0, 7, 1, 9, 1, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0),
	(160, 'Mariage', '0', 'mp_f_freemode_01', 2500, 4, 0, 3, 0, 116, 0, 19, 5, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0),
	(161, 'Cuir Pant', '0', 'mp_m_freemode_01', 2500, 20, 2, 15, 0, 61, 3, 24, 1, 3, 3, 0, 0, 0, 0, 0, 0, 0, 0),
	(162, 'Claquette Chemise', '0', 'mp_m_freemode_01', 2500, 1, 0, 15, 0, 12, 5, 48, 2, 16, 5, 0, 0, 0, 0, 0, 0, 0, 0),
	(163, 'Joke-r2', '0', 'mp_m_freemode_01', 2500, 75, 0, 27, 3, 24, 2, 22, 2, 18, 0, 0, 0, 0, 0, 0, 0, 0, 0),
	(164, 'employée', '0', 'mp_f_freemode_01', 2500, 14, 0, 2, 0, 124, 0, 65, 0, 14, 0, 0, 0, 0, 0, 0, 0, 0, 0),
	(165, 'Slim Noir', '0', 'mp_f_freemode_01', 1500, 7, 0, 13, 0, 10, 15, 27, 0, 11, 2, 0, 0, 0, 0, 0, 0, 0, 0),
	(166, 'Pant Beige', '0', 'mp_f_freemode_01', 1500, 4, 0, 3, 0, 4, 14, 3, 8, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0),
	(167, 'Noir Bleu', '0', 'mp_f_freemode_01', 1500, 2, 0, 3, 0, 2, 2, 11, 4, 13, 0, 0, 0, 0, 0, 0, 0, 0, 0),
	(168, 'Carreaux Vert', '0', 'mp_f_freemode_01', 1500, 9, 0, 3, 0, 9, 13, 1, 10, 3, 8, 0, 0, 0, 0, 0, 0, 0, 0),
	(169, 'Veste cuir Noir', '0', 'mp_f_freemode_01', 1500, 64, 0, 5, 7, 8, 2, 11, 1, 24, 0, 0, 0, 0, 0, 0, 0, 0, 0),
	(170, 'Indiana', '0', 'mp_f_freemode_01', 1500, 0, 0, 24, 2, 28, 4, 11, 2, 8, 2, 0, 0, 0, 0, 0, 0, 0, 0),
	(171, 'Pant Carreaux', '0', 'mp_f_freemode_01', 1500, 0, 0, 2, 0, 27, 4, 23, 4, 19, 8, 0, 0, 0, 0, 0, 0, 0, 0),
	(172, 'Jean TS Rose', '0', 'mp_f_freemode_01', 1500, 2, 0, 2, 0, 2, 7, 0, 8, 6, 2, 0, 0, 0, 0, 0, 0, 0, 0),
	(173, 'Tailleur Beige Noir', '0', 'mp_f_freemode_01', 1500, 6, 0, 23, 1, 25, 10, 23, 10, 19, 5, 0, 0, 0, 0, 0, 0, 0, 0),
	(174, 'Veste Carreaux Rose', '0', 'mp_f_freemode_01', 1500, 5, 0, 23, 1, 24, 6, 8, 0, 19, 4, 0, 0, 0, 0, 0, 0, 0, 0),
	(175, 'Jupe Indien', '0', 'mp_f_freemode_01', 1500, 5, 0, 4, 13, 1, 5, 8, 8, 15, 1, 0, 0, 0, 0, 0, 0, 0, 0),
	(176, 'Corset Rose', '0', 'mp_f_freemode_01', 1500, 4, 0, 2, 0, 13, 7, 0, 1, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0),
	(177, 'Jean Blouz cuir', '0', 'mp_f_freemode_01', 1500, 5, 0, 0, 10, 8, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
	(178, 'Papillon Gris', '0', 'mp_f_freemode_01', 1500, 4, 0, 2, 0, 4, 14, 8, 11, 7, 0, 0, 0, 0, 0, 0, 0, 0, 0),
	(179, 'Jupe à pois', '0', 'mp_f_freemode_01', 1500, 1, 0, 0, 7, 1, 0, 8, 12, 15, 1, 0, 0, 0, 0, 0, 0, 0, 0),
	(180, 'Pull Noir', '0', 'mp_f_freemode_01', 1500, 3, 0, 14, 0, 43, 0, 30, 0, 24, 0, 0, 0, 0, 0, 0, 0, 0, 0),
	(181, 'Mauvais gout', '0', 'mp_f_freemode_01', 500, 5, 0, 28, 7, 31, 2, 27, 12, 22, 5, 0, 0, 0, 0, 0, 0, 0, 0),
	(182, 'Short leopard', '0', 'mp_f_freemode_01', 1500, 5, 0, 4, 14, 35, 9, 25, 4, 21, 9, 0, 0, 0, 0, 0, 0, 0, 0),
	(183, 'Perroquet', '0', 'mp_f_freemode_01', 1500, 4, 0, 2, 0, 33, 4, 25, 12, 3, 13, 0, 0, 0, 0, 0, 0, 0, 0),
	(184, 'Dessous N-Leopard', '0', 'mp_f_freemode_01', 750, 4, 0, 3, 0, 111, 4, 63, 4, 41, 4, 0, 0, 0, 0, 0, 0, 0, 0),
	(185, 'Dessous Noir Rose', '0', 'mp_f_freemode_01', 750, 4, 0, 3, 0, 111, 6, 62, 6, 42, 6, 0, 0, 0, 0, 0, 0, 0, 0),
	(186, 'Dessous Coeur Rose', '0', 'mp_f_freemode_01', 750, 4, 0, 3, 0, 111, 5, 63, 5, 41, 5, 0, 0, 0, 0, 0, 0, 0, 0),
	(187, 'Dessous Rose Merron', '0', 'mp_f_freemode_01', 750, 4, 0, 3, 0, 111, 0, 62, 0, 42, 0, 0, 0, 0, 0, 0, 0, 0, 0),
	(188, 'Dessous Coeur Rouge', '0', 'mp_f_freemode_01', 750, 4, 0, 3, 0, 111, 7, 63, 7, 41, 7, 0, 0, 0, 0, 0, 0, 0, 0),
	(189, 'Dessous Bleu', '0', 'mp_f_freemode_01', 750, 4, 0, 3, 0, 111, 3, 62, 3, 42, 3, 0, 0, 0, 0, 0, 0, 0, 0),
	(190, 'Pant beige TS blanc', '0', 'mp_f_freemode_01', 1500, 11, 0, 3, 0, 117, 0, 64, 0, 44, 7, 0, 0, 0, 0, 0, 0, 0, 0),
	(191, 'Pull Gris', '0', 'mp_f_freemode_01', 1500, 1, 0, 3, 0, 79, 1, 0, 0, 43, 2, 0, 0, 0, 0, 0, 0, 0, 0),
	(192, 'TS Noir Milli Beige ', '0', 'mp_f_freemode_01', 2500, 70, 0, 3, 0, 73, 1, 49, 0, 36, 0, 0, 0, 0, 0, 0, 0, 0, 0),
	(193, 'Calecon Coeur Rose', '0', 'mp_m_freemode_01', 750, 15, 0, 15, 0, 15, 0, 61, 5, 34, 0, 0, 0, 0, 0, 0, 0, 0, 0),
	(194, 'Tarzan', '0', 'mp_m_freemode_01', 750, 15, 0, 15, 0, 15, 0, 61, 3, 34, 0, 0, 0, 0, 0, 0, 0, 0, 0),
	(195, 'Costume Carreaux', '0', 'mp_m_freemode_01', 2500, 4, 0, 21, 4, 119, 2, 60, 2, 40, 2, 0, 0, 0, 0, 0, 0, 0, 0),
	(196, 'Gilet Costume Carreaux', '0', 'mp_m_freemode_01', 2500, 4, 0, 22, 4, 120, 9, 60, 9, 40, 9, 0, 0, 0, 0, 0, 0, 0, 0),
	(197, 'Jogging Rouge', '0', 'mp_m_freemode_01', 1500, 6, 0, 15, 0, 113, 0, 55, 1, 8, 1, 0, 0, 0, 0, 0, 0, 0, 0),
	(198, 'Jogging Gris', '0', 'mp_m_freemode_01', 1500, 6, 0, 15, 0, 113, 1, 55, 1, 8, 0, 0, 0, 0, 0, 0, 0, 0, 0),
	(199, 'Costume Basket', '0', 'mp_m_freemode_01', 2500, 4, 0, 31, 0, 32, 1, 25, 1, 8, 0, 0, 0, 0, 0, 0, 0, 0, 0),
	(200, 'Costume Noir', '0', 'mp_m_freemode_01', 2500, 4, 0, 10, 0, 28, 0, 25, 0, 10, 0, 0, 0, 0, 0, 0, 0, 0, 0),
	(201, 'Veste rouge et noir', '0', 'mp_m_freemode_01', 1500, 4, 0, 23, 0, 122, 5, 43, 1, 42, 2, 0, 0, 0, 0, 0, 0, 0, 0),
	(202, 'Chaud mais pas trop', '0', 'mp_m_freemode_01', 1500, 4, 0, 23, 1, 122, 12, 15, 3, 43, 1, 0, 0, 0, 0, 0, 0, 0, 0),
	(203, 'Gilet bleu carreaux', '0', 'mp_m_freemode_01', 2500, 4, 0, 22, 4, 120, 11, 60, 11, 40, 11, 0, 0, 0, 0, 0, 0, 0, 0),
	(204, 'Veste verte', '0', 'mp_m_freemode_01', 2500, 4, 0, 10, 2, 23, 0, 23, 8, 20, 8, 0, 0, 0, 0, 0, 0, 0, 0),
	(205, 'Gilet Marron', '0', 'mp_m_freemode_01', 2500, 11, 0, 6, 12, 25, 9, 23, 8, 21, 6, 0, 0, 0, 0, 0, 0, 0, 0),
	(206, 'Chemise Carreaux Gris', '0', 'mp_m_freemode_01', 1500, 4, 0, 15, 0, 14, 11, 1, 15, 1, 9, 0, 0, 0, 0, 0, 0, 0, 0),
	(207, 'Tee-S Bleu', '0', 'mp_m_freemode_01', 1500, 0, 0, 15, 0, 0, 8, 7, 0, 0, 10, 0, 0, 0, 0, 0, 0, 0, 0),
	(208, 'Cuir Marron', '0', 'mp_m_freemode_01', 2000, 1, 0, 2, 11, 6, 6, 8, 0, 14, 8, 0, 0, 0, 0, 0, 0, 0, 0),
	(209, 'Costume Marron', '0', 'mp_m_freemode_01', 2500, 12, 0, 32, 14, 31, 6, 25, 6, 10, 12, 0, 0, 0, 0, 0, 0, 0, 0),
	(210, 'Short Pull Gris', '0', 'mp_m_freemode_01', 1500, 6, 0, 15, 0, 78, 4, 12, 5, 30, 0, 0, 0, 0, 0, 0, 0, 0, 0),
	(211, 'Basketteur', '0', 'mp_m_freemode_01', 1500, 4, 0, 15, 0, 87, 2, 42, 1, 32, 1, 0, 0, 0, 0, 0, 0, 0, 0),
	(212, 'Manteaux Long Gris', '0', 'mp_m_freemode_01', 2500, 33, 0, 10, 0, 77, 0, 37, 0, 30, 0, 0, 0, 0, 0, 0, 0, 0, 0),
	(213, 'Tee-S Gold', '0', 'mp_m_freemode_01', 1500, 0, 0, 15, 0, 71, 0, 37, 1, 29, 0, 0, 0, 0, 0, 0, 0, 0, 0),
	(214, 'Bling leopard', '0', 'mp_m_freemode_01', 2500, 4, 0, 10, 2, 70, 1, 26, 9, 28, 4, 0, 0, 0, 0, 0, 0, 0, 0),
	(215, 'Blouson fourrure blanc ', '0', 'mp_m_freemode_01', 2500, 6, 0, 5, 0, 70, 4, 26, 0, 28, 0, 0, 0, 0, 0, 0, 0, 0, 0),
	(216, 'Ville - Bad Boy 2', '0', 'mp_m_freemode_01', 2000, 4, 0, 23, 2, 62, 0, 0, 4, 22, 5, 0, 0, 0, 0, 0, 0, 0, 0),
	(217, 'Urban Classic', '0', 'mp_m_freemode_01', 1500, 0, 0, 15, 0, 80, 0, 43, 1, 9, 0, 0, 0, 0, 0, 0, 0, 0, 0),
	(218, 'Agent Sécu', '0', 'mp_m_freemode_01', 2500, 4, 0, 10, 0, 59, 2, 37, 2, 11, 12, 0, 0, 0, 0, 0, 0, 0, 0),
	(219, 'Sweet Bleu', '0', 'mp_m_freemode_01', 1500, 1, 0, 1, 0, 7, 4, 1, 0, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0),
	(220, 'Polo', '0', 'mp_m_freemode_01', 1500, 0, 0, 15, 0, 9, 2, 1, 1, 7, 3, 0, 0, 0, 0, 0, 0, 0, 0),
	(221, 'Slim Chemise', '0', 'mp_m_freemode_01', 1500, 1, 0, 15, 0, 12, 1, 4, 0, 0, 10, 0, 0, 0, 0, 0, 0, 0, 0),
	(222, 'CJ', '0', 'mp_m_freemode_01', 1500, 5, 0, 15, 0, 5, 0, 7, 1, 12, 0, 0, 0, 0, 0, 0, 0, 0, 0),
	(223, 'Commercial', '0', 'mp_m_freemode_01', 2500, 4, 0, 10, 15, 4, 0, 10, 0, 21, 0, 0, 0, 0, 0, 0, 0, 0, 0),
	(224, 'Concessionaire', '0', 'mp_m_freemode_01', 2000, 1, 0, 60, 0, 59, 1, 37, 1, 21, 2, 0, 0, 0, 0, 0, 0, 0, 0),
	(225, 'Lambda 3', '0', 'mp_m_freemode_01', 1500, 11, 0, 6, 11, 25, 0, 22, 7, 20, 2, 0, 0, 0, 0, 0, 0, 0, 0),
	(226, 'Lambda 4', '0', 'mp_m_freemode_01', 1500, 4, 0, 15, 0, 14, 3, 8, 3, 1, 8, 0, 0, 0, 0, 0, 0, 0, 0),
	(227, '80\'S', '0', 'mp_m_freemode_01', 1500, 14, 0, 23, 0, 74, 6, 26, 6, 28, 0, 0, 0, 0, 0, 0, 0, 0, 0),
	(228, 'Valkyrie', '0', 'mp_m_freemode_01', 1500, 14, 0, 65, 3, 74, 5, 7, 4, 22, 11, 0, 0, 0, 0, 0, 0, 0, 0),
	(229, 'Collégien', '0', 'mp_m_freemode_01', 1500, 4, 0, 23, 0, 88, 0, 43, 1, 32, 5, 0, 0, 0, 0, 0, 0, 0, 0),
	(230, 'Jogging Bleu', '0', 'mp_m_freemode_01', 1500, 6, 0, 15, 0, 113, 3, 55, 3, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0),
	(231, 'Chic Marron Rouge', '0', 'mp_m_freemode_01', 2500, 11, 0, 6, 12, 25, 9, 23, 8, 21, 3, 0, 0, 0, 0, 0, 0, 0, 0);
/*!40000 ALTER TABLE `clothes_outfits` ENABLE KEYS */;

-- Export de la structure de la table version_partage. clothes_props
CREATE TABLE IF NOT EXISTS `clothes_props` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `model` varchar(50) NOT NULL DEFAULT '0',
  `price` int(11) NOT NULL DEFAULT 500,
  `category` varchar(50) DEFAULT '0',
  `item_id` int(11) DEFAULT 0,
  `item_txt_allowed` varchar(255) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=187 DEFAULT CHARSET=utf8;

-- Export de données de la table version_partage.clothes_props : 186 rows
DELETE FROM `clothes_props`;
/*!40000 ALTER TABLE `clothes_props` DISABLE KEYS */;
INSERT INTO `clothes_props` (`id`, `model`, `price`, `category`, `item_id`, `item_txt_allowed`) VALUES
	(1, 'mp_m_freemode_01', 500, 'hat', 2, '0'),
	(2, 'mp_m_freemode_01', 500, 'hat', 4, '0'),
	(3, 'mp_m_freemode_01', 500, 'hat', 5, '0'),
	(4, 'mp_m_freemode_01', 500, 'hat', 6, '0'),
	(5, 'mp_m_freemode_01', 500, 'hat', 7, '0'),
	(6, 'mp_m_freemode_01', 500, 'hat', 12, '0'),
	(7, 'mp_m_freemode_01', 500, 'hat', 13, '0'),
	(8, 'mp_m_freemode_01', 500, 'hat', 14, '0'),
	(9, 'mp_m_freemode_01', 500, 'hat', 15, '0'),
	(10, 'mp_m_freemode_01', 500, 'hat', 16, '0'),
	(11, 'mp_m_freemode_01', 500, 'hat', 17, '0'),
	(12, 'mp_m_freemode_01', 500, 'hat', 18, '0'),
	(13, 'mp_m_freemode_01', 500, 'hat', 19, '0'),
	(14, 'mp_m_freemode_01', 500, 'hat', 20, '0'),
	(15, 'mp_m_freemode_01', 500, 'hat', 21, '0'),
	(16, 'mp_m_freemode_01', 500, 'hat', 25, '0'),
	(17, 'mp_m_freemode_01', 500, 'hat', 26, '0'),
	(18, 'mp_m_freemode_01', 500, 'hat', 27, '0'),
	(19, 'mp_m_freemode_01', 500, 'hat', 28, '0'),
	(20, 'mp_m_freemode_01', 500, 'hat', 29, '0'),
	(21, 'mp_m_freemode_01', 500, 'hat', 30, '0'),
	(22, 'mp_m_freemode_01', 500, 'hat', 31, '0'),
	(23, 'mp_m_freemode_01', 500, 'hat', 44, '0'),
	(24, 'mp_m_freemode_01', 500, 'hat', 45, '0'),
	(25, 'mp_m_freemode_01', 500, 'hat', 48, '0'),
	(26, 'mp_m_freemode_01', 500, 'hat', 49, '0'),
	(27, 'mp_m_freemode_01', 500, 'hat', 50, '0'),
	(28, 'mp_m_freemode_01', 500, 'hat', 51, '0'),
	(29, 'mp_m_freemode_01', 500, 'hat', 52, '0'),
	(30, 'mp_m_freemode_01', 500, 'hat', 53, '0'),
	(31, 'mp_m_freemode_01', 500, 'hat', 54, '0'),
	(32, 'mp_m_freemode_01', 500, 'hat', 55, '0'),
	(33, 'mp_m_freemode_01', 500, 'hat', 56, '0'),
	(34, 'mp_m_freemode_01', 500, 'hat', 58, '0'),
	(35, 'mp_m_freemode_01', 500, 'hat', 60, '0'),
	(36, 'mp_m_freemode_01', 500, 'hat', 61, '0'),
	(37, 'mp_m_freemode_01', 500, 'hat', 62, '0'),
	(38, 'mp_m_freemode_01', 500, 'hat', 63, '0'),
	(39, 'mp_m_freemode_01', 500, 'hat', 64, '0'),
	(40, 'mp_m_freemode_01', 500, 'hat', 65, '0'),
	(41, 'mp_m_freemode_01', 500, 'hat', 66, '0'),
	(42, 'mp_m_freemode_01', 500, 'hat', 67, '0'),
	(43, 'mp_m_freemode_01', 500, 'hat', 68, '0'),
	(44, 'mp_m_freemode_01', 500, 'hat', 69, '0'),
	(45, 'mp_m_freemode_01', 500, 'hat', 70, '0'),
	(46, 'mp_m_freemode_01', 500, 'hat', 71, '0'),
	(47, 'mp_m_freemode_01', 500, 'hat', 72, '0'),
	(48, 'mp_m_freemode_01', 500, 'hat', 73, '0'),
	(49, 'mp_m_freemode_01', 500, 'hat', 74, '0'),
	(50, 'mp_m_freemode_01', 500, 'hat', 75, '0'),
	(51, 'mp_m_freemode_01', 500, 'hat', 76, '0'),
	(52, 'mp_m_freemode_01', 500, 'hat', 77, '0'),
	(53, 'mp_m_freemode_01', 500, 'hat', 78, '0'),
	(54, 'mp_m_freemode_01', 500, 'hat', 79, '0'),
	(55, 'mp_m_freemode_01', 500, 'hat', 80, '0'),
	(56, 'mp_m_freemode_01', 500, 'hat', 81, '0'),
	(57, 'mp_m_freemode_01', 500, 'hat', 82, '0'),
	(58, 'mp_f_freemode_01', 500, 'hat', 4, '0'),
	(59, 'mp_f_freemode_01', 500, 'hat', 5, '0'),
	(60, 'mp_f_freemode_01', 500, 'hat', 6, '0'),
	(61, 'mp_f_freemode_01', 500, 'hat', 7, '0'),
	(62, 'mp_f_freemode_01', 500, 'hat', 9, '0'),
	(63, 'mp_f_freemode_01', 500, 'hat', 12, '0'),
	(64, 'mp_f_freemode_01', 500, 'hat', 13, '0'),
	(65, 'mp_f_freemode_01', 500, 'hat', 14, '0'),
	(66, 'mp_f_freemode_01', 500, 'hat', 15, '0'),
	(67, 'mp_f_freemode_01', 500, 'hat', 16, '0'),
	(68, 'mp_f_freemode_01', 500, 'hat', 17, '0'),
	(69, 'mp_f_freemode_01', 500, 'hat', 18, '0'),
	(70, 'mp_f_freemode_01', 500, 'hat', 19, '0'),
	(71, 'mp_f_freemode_01', 500, 'hat', 20, '0'),
	(72, 'mp_f_freemode_01', 500, 'hat', 21, '0'),
	(73, 'mp_f_freemode_01', 500, 'hat', 22, '0'),
	(74, 'mp_f_freemode_01', 500, 'hat', 26, '0'),
	(75, 'mp_f_freemode_01', 500, 'hat', 27, '0'),
	(76, 'mp_f_freemode_01', 500, 'hat', 28, '0'),
	(77, 'mp_f_freemode_01', 500, 'hat', 29, '0'),
	(78, 'mp_f_freemode_01', 500, 'hat', 43, '0'),
	(79, 'mp_f_freemode_01', 500, 'hat', 44, '0'),
	(80, 'mp_f_freemode_01', 500, 'hat', 47, '0'),
	(81, 'mp_f_freemode_01', 500, 'hat', 48, '0'),
	(82, 'mp_f_freemode_01', 500, 'hat', 49, '0'),
	(83, 'mp_f_freemode_01', 500, 'hat', 50, '0'),
	(84, 'mp_f_freemode_01', 500, 'hat', 51, '0'),
	(85, 'mp_f_freemode_01', 500, 'hat', 52, '0'),
	(86, 'mp_f_freemode_01', 500, 'hat', 53, '0'),
	(87, 'mp_f_freemode_01', 500, 'hat', 54, '0'),
	(88, 'mp_f_freemode_01', 500, 'hat', 55, '0'),
	(89, 'mp_f_freemode_01', 500, 'hat', 56, '0'),
	(90, 'mp_f_freemode_01', 500, 'hat', 57, '0'),
	(91, 'mp_f_freemode_01', 500, 'hat', 58, '0'),
	(92, 'mp_f_freemode_01', 500, 'hat', 81, '0'),
	(93, 'mp_f_freemode_01', 500, 'glasses', 1, '0'),
	(94, 'mp_f_freemode_01', 500, 'glasses', 2, '0'),
	(95, 'mp_f_freemode_01', 500, 'glasses', 3, '0'),
	(96, 'mp_f_freemode_01', 500, 'glasses', 4, '0'),
	(97, 'mp_f_freemode_01', 500, 'glasses', 6, '0'),
	(98, 'mp_f_freemode_01', 500, 'glasses', 7, '0'),
	(99, 'mp_f_freemode_01', 500, 'glasses', 8, '0'),
	(100, 'mp_f_freemode_01', 500, 'glasses', 9, '0'),
	(101, 'mp_f_freemode_01', 500, 'glasses', 10, '0'),
	(102, 'mp_f_freemode_01', 500, 'glasses', 11, '0'),
	(103, 'mp_f_freemode_01', 500, 'glasses', 14, '0'),
	(104, 'mp_f_freemode_01', 500, 'glasses', 16, '0'),
	(105, 'mp_f_freemode_01', 500, 'glasses', 17, '0'),
	(106, 'mp_f_freemode_01', 500, 'glasses', 18, '0'),
	(107, 'mp_f_freemode_01', 500, 'glasses', 19, '0'),
	(108, 'mp_f_freemode_01', 500, 'glasses', 20, '0'),
	(109, 'mp_f_freemode_01', 500, 'glasses', 21, '0'),
	(110, 'mp_m_freemode_01', 500, 'glasses', 3, '0'),
	(111, 'mp_m_freemode_01', 500, 'glasses', 4, '0'),
	(112, 'mp_m_freemode_01', 500, 'glasses', 5, '0'),
	(113, 'mp_m_freemode_01', 500, 'glasses', 7, '0'),
	(114, 'mp_m_freemode_01', 500, 'glasses', 8, '0'),
	(115, 'mp_m_freemode_01', 500, 'glasses', 9, '0'),
	(116, 'mp_m_freemode_01', 500, 'glasses', 10, '0'),
	(117, 'mp_m_freemode_01', 500, 'glasses', 12, '0'),
	(118, 'mp_m_freemode_01', 500, 'glasses', 13, '0'),
	(119, 'mp_m_freemode_01', 500, 'glasses', 15, '0'),
	(120, 'mp_m_freemode_01', 500, 'glasses', 16, '0'),
	(121, 'mp_m_freemode_01', 500, 'glasses', 17, '0'),
	(122, 'mp_m_freemode_01', 500, 'glasses', 18, '0'),
	(123, 'mp_m_freemode_01', 500, 'glasses', 19, '0'),
	(124, 'mp_m_freemode_01', 500, 'glasses', 20, '0'),
	(125, 'mp_m_freemode_01', 500, 'glasses', 24, '0'),
	(126, 'mp_m_freemode_01', 500, 'glasses', 25, '0'),
	(127, 'mp_m_freemode_01', 500, 'hat', 82, '0'),
	(128, 'mp_m_freemode_01', 500, 'hat', 83, '0'),
	(129, 'mp_m_freemode_01', 500, 'hat', 84, '0'),
	(130, 'mp_m_freemode_01', 500, 'hat', 85, '0'),
	(131, 'mp_m_freemode_01', 500, 'hat', 86, '0'),
	(132, 'mp_m_freemode_01', 500, 'hat', 87, '0'),
	(133, 'mp_m_freemode_01', 500, 'hat', 88, '0'),
	(134, 'mp_m_freemode_01', 500, 'hat', 89, '0'),
	(135, 'mp_m_freemode_01', 500, 'hat', 90, '0'),
	(136, 'mp_m_freemode_01', 500, 'hat', 91, '0'),
	(137, 'mp_m_freemode_01', 500, 'hat', 92, '0'),
	(138, 'mp_m_freemode_01', 500, 'hat', 93, '0'),
	(139, 'mp_m_freemode_01', 500, 'hat', 94, '0'),
	(140, 'mp_m_freemode_01', 500, 'hat', 95, '0'),
	(141, 'mp_m_freemode_01', 500, 'hat', 96, '0'),
	(142, 'mp_m_freemode_01', 500, 'hat', 97, '0'),
	(143, 'mp_m_freemode_01', 500, 'hat', 98, '0'),
	(144, 'mp_m_freemode_01', 500, 'hat', 99, '0'),
	(145, 'mp_m_freemode_01', 500, 'hat', 100, '0'),
	(146, 'mp_m_freemode_01', 500, 'hat', 101, '0'),
	(147, 'mp_m_freemode_01', 500, 'hat', 102, '0'),
	(148, 'mp_m_freemode_01', 500, 'hat', 103, '0'),
	(149, 'mp_m_freemode_01', 500, 'hat', 104, '0'),
	(150, 'mp_m_freemode_01', 500, 'hat', 105, '0'),
	(151, 'mp_m_freemode_01', 500, 'hat', 106, '0'),
	(152, 'mp_m_freemode_01', 500, 'hat', 107, '0'),
	(153, 'mp_m_freemode_01', 500, 'hat', 108, '0'),
	(154, 'mp_m_freemode_01', 500, 'hat', 109, '0'),
	(155, 'mp_m_freemode_01', 500, 'hat', 110, '0'),
	(156, 'mp_f_freemode_01', 500, 'hat', 81, '0'),
	(157, 'mp_f_freemode_01', 500, 'hat', 82, '0'),
	(158, 'mp_f_freemode_01', 500, 'hat', 83, '0'),
	(159, 'mp_f_freemode_01', 500, 'hat', 84, '0'),
	(160, 'mp_f_freemode_01', 500, 'hat', 85, '0'),
	(161, 'mp_f_freemode_01', 500, 'hat', 86, '0'),
	(162, 'mp_f_freemode_01', 500, 'hat', 87, '0'),
	(163, 'mp_f_freemode_01', 500, 'hat', 88, '0'),
	(164, 'mp_f_freemode_01', 500, 'hat', 89, '0'),
	(165, 'mp_f_freemode_01', 500, 'hat', 90, '0'),
	(166, 'mp_f_freemode_01', 500, 'hat', 91, '0'),
	(167, 'mp_f_freemode_01', 500, 'hat', 92, '0'),
	(168, 'mp_f_freemode_01', 500, 'hat', 93, '0'),
	(169, 'mp_f_freemode_01', 500, 'hat', 94, '0'),
	(170, 'mp_f_freemode_01', 500, 'hat', 95, '0'),
	(171, 'mp_f_freemode_01', 500, 'hat', 96, '0'),
	(172, 'mp_f_freemode_01', 500, 'hat', 97, '0'),
	(173, 'mp_f_freemode_01', 500, 'hat', 98, '0'),
	(174, 'mp_f_freemode_01', 500, 'hat', 99, '0'),
	(175, 'mp_f_freemode_01', 500, 'hat', 100, '0'),
	(176, 'mp_f_freemode_01', 500, 'hat', 101, '0'),
	(177, 'mp_f_freemode_01', 500, 'hat', 102, '0'),
	(178, 'mp_f_freemode_01', 500, 'hat', 103, '0'),
	(179, 'mp_f_freemode_01', 500, 'hat', 104, '0'),
	(180, 'mp_f_freemode_01', 500, 'hat', 105, '0'),
	(181, 'mp_f_freemode_01', 500, 'hat', 106, '0'),
	(182, 'mp_f_freemode_01', 500, 'hat', 107, '0'),
	(183, 'mp_f_freemode_01', 500, 'hat', 108, '0'),
	(184, 'mp_f_freemode_01', 500, 'hat', 109, '0'),
	(185, 'mp_f_freemode_01', 500, 'glasses', 26, '0'),
	(186, 'mp_f_freemode_01', 500, 'glasses', 27, '0');
/*!40000 ALTER TABLE `clothes_props` ENABLE KEYS */;

-- Export de la structure de la table version_partage. clothes_users_outfits
CREATE TABLE IF NOT EXISTS `clothes_users_outfits` (
  `identifier` varchar(50) NOT NULL DEFAULT '0',
  `current` int(11) NOT NULL DEFAULT 0,
  `outfit_id` int(11) NOT NULL DEFAULT 0
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- Export de données de la table version_partage.clothes_users_outfits : 0 rows
DELETE FROM `clothes_users_outfits`;
/*!40000 ALTER TABLE `clothes_users_outfits` DISABLE KEYS */;
/*!40000 ALTER TABLE `clothes_users_outfits` ENABLE KEYS */;

-- Export de la structure de la table version_partage. clothes_users_props
CREATE TABLE IF NOT EXISTS `clothes_users_props` (
  `identifier` varchar(50) DEFAULT '0',
  `category` varchar(50) DEFAULT NULL,
  `current` int(11) DEFAULT 0,
  `prop_id` int(11) DEFAULT 0,
  `prop_txt` int(11) DEFAULT 0
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- Export de données de la table version_partage.clothes_users_props : 0 rows
DELETE FROM `clothes_users_props`;
/*!40000 ALTER TABLE `clothes_users_props` DISABLE KEYS */;
/*!40000 ALTER TABLE `clothes_users_props` ENABLE KEYS */;

-- Export de la structure de la table version_partage. coordinates
CREATE TABLE IF NOT EXISTS `coordinates` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `x` double DEFAULT NULL,
  `y` double DEFAULT NULL,
  `z` double DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8;

-- Export de données de la table version_partage.coordinates : ~21 rows (environ)
DELETE FROM `coordinates`;
/*!40000 ALTER TABLE `coordinates` DISABLE KEYS */;
INSERT INTO `coordinates` (`id`, `x`, `y`, `z`) VALUES
	(1, -596.082, 2088.9, 131.413),
	(2, 1959.02, 4628.06, 41.0668),
	(3, 1888.83, 3927.82, 33.636),
	(4, 2474.32, -427.899, 109.522),
	(5, 269.182, -432.846, 45.3247),
	(6, -1589.15, -3230.37, 26.3127),
	(7, 1414.71, 6332.43, 24.3832),
	(8, 3564.72, 3626.06, 40.8907),
	(9, 132.152, -1187.66, 29.5028),
	(13, 534.507, -782.719, 16.2271),
	(14, -539.912, -1638.08, 19.8927),
	(15, -1042.23, -520.167, 36.0386),
	(16, 1013.11, 2905.5, 41.3794),
	(17, 109.465, -1797.63, 27.0782),
	(18, 1221.72, -3004.98, 5.86536),
	(19, -2168.64, 5197.1, 17.0286),
	(20, -487.439, -335.004, 91.0076),
	(21, -1805.51, 439.942, 128.707),
	(22, -1572.1, 772.55, 189.194),
	(23, 1207.75, -3115.15, 5.54033),
	(24, 977.003, -99.1305, 74.8508);
/*!40000 ALTER TABLE `coordinates` ENABLE KEYS */;

-- Export de la structure de la table version_partage. items
CREATE TABLE IF NOT EXISTS `items` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `libelle` varchar(255) DEFAULT NULL,
  `isIllegal` tinyint(1) NOT NULL DEFAULT 0,
  `canUse` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=100 DEFAULT CHARSET=utf8;

-- Export de données de la table version_partage.items : ~36 rows (environ)
DELETE FROM `items`;
/*!40000 ALTER TABLE `items` DISABLE KEYS */;
INSERT INTO `items` (`id`, `libelle`, `isIllegal`, `canUse`) VALUES
	(1, 'Minerai', 0, 0),
	(2, 'Metal', 0, 0),
	(3, 'Or', 0, 0),
	(4, 'Cannabis', 1, 0),
	(5, 'Farine', 0, 0),
	(6, 'Eau', 0, 0),
	(7, 'Feuille de Coca', 1, 0),
	(8, 'Joint', 1, 0),
	(9, 'Lingot', 0, 0),
	(10, 'Blé', 0, 0),
	(11, 'Meth', 1, 0),
	(12, 'Meth Transformée', 1, 0),
	(13, 'Feuille de sassafras', 1, 0),
	(14, 'Ecstasy', 1, 0),
	(15, 'Pierre précieuse', 1, 0),
	(16, 'Bijoux', 1, 0),
	(17, 'Organe Sale', 1, 0),
	(18, 'Organe Stérilisé', 1, 0),
	(19, 'Bois Brut', 0, 0),
	(20, 'Planche', 0, 0),
	(21, 'poisson', 0, 0),
	(22, 'Filet de Poisson', 0, 0),
	(23, 'Viande fraiche', 0, 0),
	(24, 'Orge', 0, 0),
	(25, 'Bière', 0, 0),
	(26, 'Raisin', 0, 0),
	(27, 'Bouteille de vin', 0, 0),
	(28, 'Cocaine', 1, 0),
	(29, 'Documents secrets', 1, 0),
	(30, 'Sandwich', 0, 0),
	(31, 'faux papiers', 1, 0),
	(32, 'Opium', 1, 0),
	(33, 'Heroine', 1, 0),
	(34, 'Poudre et Metal', 1, 0),
	(35, 'Munitions', 1, 0),
	(99, 'GPS', 0, 0);
/*!40000 ALTER TABLE `items` ENABLE KEYS */;

-- Export de la structure de la table version_partage. jobs
CREATE TABLE IF NOT EXISTS `jobs` (
  `job_id` int(11) NOT NULL AUTO_INCREMENT,
  `job_name` varchar(40) NOT NULL,
  `salary` int(11) NOT NULL DEFAULT 500,
  PRIMARY KEY (`job_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1000 DEFAULT CHARSET=utf8;

-- Export de données de la table version_partage.jobs : ~14 rows (environ)
DELETE FROM `jobs`;
/*!40000 ALTER TABLE `jobs` DISABLE KEYS */;
INSERT INTO `jobs` (`job_id`, `job_name`, `salary`) VALUES
	(1, 'Chomeur', 150),
	(2, 'Policier', 2750),
	(6, 'Fermier', 700),
	(7, 'Bucheron', 700),
	(8, 'Gang', 1),
	(9, 'Mineur', 700),
	(10, 'Pecheur', 700),
	(11, 'Docker', 700),
	(12, 'Brasseur', 700),
	(13, 'Vigneron', 700),
	(14, 'Livreur', 700),
	(15, 'Ambulancier', 2800),
	(16, 'Mecano', 2100),
	(17, 'Taxi', 2750);
/*!40000 ALTER TABLE `jobs` ENABLE KEYS */;

-- Export de la structure de la table version_partage. licences
CREATE TABLE IF NOT EXISTS `licences` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `price` int(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- Export de données de la table version_partage.licences : ~1 rows (environ)
DELETE FROM `licences`;
/*!40000 ALTER TABLE `licences` DISABLE KEYS */;
INSERT INTO `licences` (`id`, `name`, `price`) VALUES
	(1, 'De conduire', 200);
/*!40000 ALTER TABLE `licences` ENABLE KEYS */;

-- Export de la structure de la table version_partage. outfits
CREATE TABLE IF NOT EXISTS `outfits` (
  `identifier` varchar(30) NOT NULL,
  `skin` varchar(30) CHARACTER SET utf8 NOT NULL DEFAULT 'mp_m_freemode_01',
  `face` int(11) NOT NULL DEFAULT 0,
  `face_text` int(11) NOT NULL DEFAULT 0,
  `hair` int(11) NOT NULL DEFAULT 0,
  `hair_text` int(11) NOT NULL DEFAULT 0,
  `pants` int(11) NOT NULL DEFAULT 0,
  `pants_text` int(11) NOT NULL DEFAULT 0,
  `shoes` int(11) NOT NULL DEFAULT 0,
  `shoes_text` int(11) NOT NULL DEFAULT 10,
  `torso` int(11) NOT NULL DEFAULT 0,
  `torso_text` int(11) NOT NULL DEFAULT 0,
  `shirt` int(11) NOT NULL DEFAULT 0,
  `shirt_text` int(11) NOT NULL DEFAULT 0
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- Export de données de la table version_partage.outfits : 0 rows
DELETE FROM `outfits`;
/*!40000 ALTER TABLE `outfits` DISABLE KEYS */;
/*!40000 ALTER TABLE `outfits` ENABLE KEYS */;

-- Export de la structure de la table version_partage. phone_messages
CREATE TABLE IF NOT EXISTS `phone_messages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `transmitter` varchar(10) NOT NULL,
  `receiver` varchar(10) NOT NULL,
  `message` varchar(255) NOT NULL DEFAULT '0',
  `time` timestamp NOT NULL DEFAULT current_timestamp(),
  `isRead` int(11) NOT NULL DEFAULT 0,
  `owner` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Export de données de la table version_partage.phone_messages : ~0 rows (environ)
DELETE FROM `phone_messages`;
/*!40000 ALTER TABLE `phone_messages` DISABLE KEYS */;
/*!40000 ALTER TABLE `phone_messages` ENABLE KEYS */;

-- Export de la structure de la table version_partage. phone_users_contacts
CREATE TABLE IF NOT EXISTS `phone_users_contacts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(255) NOT NULL,
  `number` varchar(10) NOT NULL,
  `display` varchar(64) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Export de données de la table version_partage.phone_users_contacts : ~0 rows (environ)
DELETE FROM `phone_users_contacts`;
/*!40000 ALTER TABLE `phone_users_contacts` DISABLE KEYS */;
/*!40000 ALTER TABLE `phone_users_contacts` ENABLE KEYS */;

-- Export de la structure de la table version_partage. police
CREATE TABLE IF NOT EXISTS `police` (
  `identifier` varchar(255) NOT NULL,
  `rank` varchar(255) NOT NULL DEFAULT 'Recrue',
  PRIMARY KEY (`identifier`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Export de données de la table version_partage.police : ~0 rows (environ)
DELETE FROM `police`;
/*!40000 ALTER TABLE `police` DISABLE KEYS */;
/*!40000 ALTER TABLE `police` ENABLE KEYS */;

-- Export de la structure de la table version_partage. recolt
CREATE TABLE IF NOT EXISTS `recolt` (
  `ID` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `raw_id` int(11) unsigned DEFAULT NULL,
  `treated_id` int(11) unsigned DEFAULT NULL,
  `job_id` int(11) DEFAULT NULL,
  `price` int(11) DEFAULT NULL,
  `field_id` int(10) unsigned DEFAULT NULL,
  `treatment_id` int(10) unsigned DEFAULT NULL,
  `seller_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `raw_id` (`raw_id`),
  KEY `treated_id` (`treated_id`),
  KEY `job_id` (`job_id`),
  KEY `field_id` (`field_id`),
  KEY `treatment_id` (`treatment_id`),
  KEY `seller_id` (`seller_id`),
  CONSTRAINT `recolt_ibfk_1` FOREIGN KEY (`raw_id`) REFERENCES `items` (`id`),
  CONSTRAINT `recolt_ibfk_2` FOREIGN KEY (`treated_id`) REFERENCES `items` (`id`),
  CONSTRAINT `recolt_ibfk_3` FOREIGN KEY (`job_id`) REFERENCES `jobs` (`job_id`),
  CONSTRAINT `recolt_ibfk_4` FOREIGN KEY (`field_id`) REFERENCES `coordinates` (`id`),
  CONSTRAINT `recolt_ibfk_5` FOREIGN KEY (`treatment_id`) REFERENCES `coordinates` (`id`),
  CONSTRAINT `recolt_ibfk_6` FOREIGN KEY (`seller_id`) REFERENCES `coordinates` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

-- Export de données de la table version_partage.recolt : ~7 rows (environ)
DELETE FROM `recolt`;
/*!40000 ALTER TABLE `recolt` DISABLE KEYS */;
INSERT INTO `recolt` (`ID`, `raw_id`, `treated_id`, `job_id`, `price`, `field_id`, `treatment_id`, `seller_id`) VALUES
	(1, 7, 28, 8, 107, 22, 23, 24),
	(2, 29, 31, 8, 102, 4, 5, 6),
	(3, 13, 14, 8, 112, 13, 14, 15),
	(4, 15, 16, 8, 100, 16, 17, 18),
	(5, 17, 18, 8, 104, 19, 20, 21),
	(6, 32, 33, 8, 114, 7, 8, 9),
	(7, 34, 35, 8, 106, 1, 2, 3);
/*!40000 ALTER TABLE `recolt` ENABLE KEYS */;

-- Export de la structure de la table version_partage. skin
CREATE TABLE IF NOT EXISTS `skin` (
  `identifier` varchar(120) DEFAULT NULL,
  `model` varchar(50) NOT NULL DEFAULT '0',
  `face` varchar(900) NOT NULL DEFAULT 'NOT',
  `head` int(11) NOT NULL DEFAULT 0,
  `body_color` int(11) NOT NULL DEFAULT 0,
  `hair` int(11) NOT NULL DEFAULT 0,
  `hair_color` int(11) NOT NULL DEFAULT 0,
  `beard` int(11) NOT NULL DEFAULT 0,
  `beard_color` int(11) NOT NULL DEFAULT 0,
  `eyebrows` int(11) NOT NULL DEFAULT 0,
  `eyebrows_color` int(11) NOT NULL DEFAULT 0,
  `percing` int(11) DEFAULT 0,
  `percing_txt` int(11) DEFAULT 0,
  `makeup` int(11) DEFAULT 0,
  `makeup_opacity` int(11) DEFAULT 0,
  `lipstick` int(11) DEFAULT 0,
  `lipstick_color` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Export de données de la table version_partage.skin : ~0 rows (environ)
DELETE FROM `skin`;
/*!40000 ALTER TABLE `skin` DISABLE KEYS */;
/*!40000 ALTER TABLE `skin` ENABLE KEYS */;

-- Export de la structure de la table version_partage. users
CREATE TABLE IF NOT EXISTS `users` (
  `identifier` varchar(255) CHARACTER SET utf8mb4 NOT NULL DEFAULT '',
  `group` varchar(50) NOT NULL DEFAULT 'user',
  `permission_level` int(11) NOT NULL DEFAULT 0,
  `money` double NOT NULL DEFAULT 0,
  `bankbalance` int(32) DEFAULT 0,
  `job` int(11) DEFAULT 1,
  `lastPosition` varchar(255) DEFAULT '{-1044.99914550781,-2749.8173828125,21.3634204864502}',
  `personalvehicle` varchar(60) DEFAULT NULL,
  `isFirstConnection` int(11) DEFAULT 1,
  `nom` varchar(128) NOT NULL DEFAULT '',
  `prenom` varchar(128) NOT NULL DEFAULT '',
  `dateNaissance` date DEFAULT '1980-01-01',
  `sexe` varchar(1) NOT NULL DEFAULT 'f',
  `taille` int(10) unsigned NOT NULL DEFAULT 0,
  `health` int(11) NOT NULL DEFAULT 200,
  `food` double NOT NULL DEFAULT 100,
  `water` double NOT NULL DEFAULT 100,
  `needs` double NOT NULL DEFAULT 0,
  `dirtymoney` double NOT NULL DEFAULT 0,
  `phone_number` varchar(50) DEFAULT '0',
  `last_seen_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `DmvTest` varchar(50) NOT NULL DEFAULT 'Required'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Export de données de la table version_partage.users : ~0 rows (environ)
DELETE FROM `users`;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
/*!40000 ALTER TABLE `users` ENABLE KEYS */;

-- Export de la structure de la table version_partage. user_contacts
CREATE TABLE IF NOT EXISTS `user_contacts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `number` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Export de données de la table version_partage.user_contacts : ~0 rows (environ)
DELETE FROM `user_contacts`;
/*!40000 ALTER TABLE `user_contacts` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_contacts` ENABLE KEYS */;

-- Export de la structure de la table version_partage. user_inventory
CREATE TABLE IF NOT EXISTS `user_inventory` (
  `user_id` varchar(255) NOT NULL DEFAULT '',
  `item_id` int(11) unsigned NOT NULL,
  `quantity` int(11) DEFAULT NULL,
  PRIMARY KEY (`user_id`,`item_id`),
  KEY `item_id` (`item_id`),
  CONSTRAINT `user_inventory_ibfk_2` FOREIGN KEY (`item_id`) REFERENCES `items` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Export de données de la table version_partage.user_inventory : ~0 rows (environ)
DELETE FROM `user_inventory`;
/*!40000 ALTER TABLE `user_inventory` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_inventory` ENABLE KEYS */;

-- Export de la structure de la table version_partage. user_license
CREATE TABLE IF NOT EXISTS `user_license` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(255) NOT NULL,
  `licence_id` int(255) NOT NULL,
  `type` varchar(20) NOT NULL DEFAULT 'car',
  `points` int(11) NOT NULL DEFAULT 6,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=177 DEFAULT CHARSET=utf8;

-- Export de données de la table version_partage.user_license : ~0 rows (environ)
DELETE FROM `user_license`;
/*!40000 ALTER TABLE `user_license` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_license` ENABLE KEYS */;

-- Export de la structure de la table version_partage. user_phonelist
CREATE TABLE IF NOT EXISTS `user_phonelist` (
  `owner_id` varchar(50) NOT NULL,
  `contact_id` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Export de données de la table version_partage.user_phonelist : ~0 rows (environ)
DELETE FROM `user_phonelist`;
/*!40000 ALTER TABLE `user_phonelist` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_phonelist` ENABLE KEYS */;

-- Export de la structure de la table version_partage. user_vehicle
CREATE TABLE IF NOT EXISTS `user_vehicle` (
  `owner` varchar(255) NOT NULL,
  `name` varchar(60) DEFAULT NULL,
  `model` varchar(60) DEFAULT NULL,
  `price` int(60) DEFAULT NULL,
  `plate` varchar(60) DEFAULT NULL,
  `state` int(11) DEFAULT 0,
  `type` int(11) DEFAULT NULL,
  `customs` longtext NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Export de données de la table version_partage.user_vehicle : ~0 rows (environ)
DELETE FROM `user_vehicle`;
/*!40000 ALTER TABLE `user_vehicle` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_vehicle` ENABLE KEYS */;

-- Export de la structure de la table version_partage. user_weapons
CREATE TABLE IF NOT EXISTS `user_weapons` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(255) NOT NULL,
  `weapon_model` varchar(255) NOT NULL,
  `withdraw_cost` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=361 DEFAULT CHARSET=utf8;

-- Export de données de la table version_partage.user_weapons : ~0 rows (environ)
DELETE FROM `user_weapons`;
/*!40000 ALTER TABLE `user_weapons` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_weapons` ENABLE KEYS */;

-- Export de la structure de la table version_partage. vehicles
CREATE TABLE IF NOT EXISTS `vehicles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `price` int(255) NOT NULL,
  `model` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=164 DEFAULT CHARSET=utf8;

-- Export de données de la table version_partage.vehicles : ~163 rows (environ)
DELETE FROM `vehicles`;
/*!40000 ALTER TABLE `vehicles` DISABLE KEYS */;
INSERT INTO `vehicles` (`id`, `name`, `price`, `model`) VALUES
	(1, 'Blista', 15000, 'blista'),
	(2, 'Brioso R/A', 155000, 'brioso'),
	(3, 'Dilettante', 25000, 'Dilettante'),
	(4, 'Issi', 18000, 'issi2'),
	(5, 'Panto', 85000, 'panto'),
	(6, 'Prairie', 30000, 'prairie'),
	(7, 'Rhapsody', 120000, 'rhapsody'),
	(8, 'Cognoscenti Cabrio', 180000, 'cogcabrio'),
	(9, 'Exemplar', 200000, 'exemplar'),
	(10, 'F620', 80000, 'f620'),
	(11, 'Felon', 90000, 'felon'),
	(12, 'Felon GT', 95000, 'felon2'),
	(13, 'Jackal', 60000, 'jackal'),
	(14, 'Oracle', 80000, 'oracle'),
	(15, 'Oracle XS', 82000, 'oracle2'),
	(16, 'Sentinel', 90000, 'sentinel'),
	(17, 'Sentinel XS', 60000, 'sentinel2'),
	(18, 'Windsor', 800000, 'windsor'),
	(19, 'Windsor Drop', 850000, 'windsor2'),
	(20, 'Zion', 60000, 'zion'),
	(21, 'Zion Cabrio', 65000, 'zion2'),
	(22, '9F', 120000, 'ninef'),
	(23, '9F Cabrio', 130000, 'ninef2'),
	(24, 'Alpha', 150000, 'alpha'),
	(25, 'Banshee', 105000, 'banshee'),
	(26, 'Bestia GTS', 610000, 'bestiagts'),
	(27, 'Blista Compact', 42000, 'blista'),
	(28, 'Buffalo', 35000, 'buffalo'),
	(29, 'Buffalo S', 96000, 'buffalo2'),
	(30, 'Carbonizzare', 195000, 'carbonizzare'),
	(31, 'Comet', 100000, 'comet2'),
	(32, 'Coquette', 138000, 'coquette'),
	(33, 'Drift Tampa', 995000, 'tampa2'),
	(34, 'Feltzer', 130000, 'feltzer2'),
	(35, 'Furore GT', 448000, 'furoregt'),
	(36, 'Fusilade', 36000, 'fusilade'),
	(37, 'Jester', 240000, 'jester'),
	(38, 'Jester(Racecar)', 350000, 'jester2'),
	(39, 'Kuruma', 95000, 'kuruma'),
	(40, 'Lynx', 1735000, 'lynx'),
	(41, 'Massacro', 275000, 'massacro'),
	(42, 'Massacro(Racecar)', 385000, 'massacro2'),
	(43, 'Omnis', 701000, 'omnis'),
	(44, 'Penumbra', 24000, 'penumbra'),
	(45, 'Rapid GT', 140000, 'rapidgt'),
	(46, 'Rapid GT Convertible', 150000, 'rapidgt2'),
	(47, 'Schafter V12', 140000, 'schafter3'),
	(48, 'Sultan', 12000, 'sultan'),
	(49, 'Surano', 110000, 'surano'),
	(50, 'Tropos', 816000, 'tropos'),
	(51, 'Verkierer', 695000, 'verlierer2'),
	(52, 'Casco', 680000, 'casco'),
	(53, 'Coquette Classic', 665000, 'coquette2'),
	(54, 'JB 700', 350000, 'jb700'),
	(55, 'Pigalle', 400000, 'pigalle'),
	(56, 'Stinger', 850000, 'stinger'),
	(57, 'Stinger GT', 875000, 'stingergt'),
	(58, 'Stirling GT', 975000, 'feltzer3'),
	(59, 'Z-Type', 950000, 'ztype'),
	(60, 'Adder', 1000000, 'adder'),
	(61, 'Banshee 900R', 565000, 'banshee2'),
	(62, 'Bullet', 155000, 'bullet'),
	(63, 'Cheetah', 650000, 'cheetah'),
	(64, 'Entity XF', 795000, 'entityxf'),
	(65, 'ETR1', 199500, 'sheava'),
	(66, 'FMJ', 1750000, 'fmj'),
	(67, 'Infernus', 440000, 'infernus'),
	(68, 'Osiris', 1950000, 'osiris'),
	(69, 'RE-7B', 2475000, 'le7b'),
	(70, 'Reaper', 1595000, 'reaper'),
	(71, 'Sultan RS', 795000, 'sultanrs'),
	(72, 'T20', 2200000, 't20'),
	(73, 'Turismo R', 500000, 'turismor'),
	(74, 'Tyrus', 2550000, 'tyrus'),
	(75, 'Vacca', 240000, 'vacca'),
	(76, 'Voltic', 150000, 'voltic'),
	(77, 'X80 Proto', 2700000, 'prototipo'),
	(78, 'Zentorno', 725000, 'zentorno'),
	(79, 'Blade', 160000, 'blade'),
	(80, 'Buccaneer', 29000, 'buccaneer'),
	(81, 'Chino', 225000, 'chino'),
	(82, 'Coquette BlackFin', 695000, 'coquette3'),
	(83, 'Dominator', 35000, 'dominator'),
	(84, 'Dukes', 62000, 'dukes'),
	(85, 'Gauntlet', 32000, 'gauntlet'),
	(86, 'Hotknife', 90000, 'hotknife'),
	(87, 'Faction', 36000, 'faction'),
	(88, 'Nightshade', 585000, 'nightshade'),
	(89, 'Picador', 9000, 'picador'),
	(90, 'Sabre Turbo', 15000, 'sabregt'),
	(91, 'Tampa', 375000, 'tampa'),
	(92, 'Virgo', 195000, 'virgo'),
	(93, 'Vigero', 21000, 'vigero'),
	(94, 'Bifta', 75000, 'bifta'),
	(95, 'Blazer', 8000, 'blazer'),
	(96, 'Brawler', 715000, 'brawler'),
	(97, 'Bubsta 6x6', 249000, 'dubsta3'),
	(98, 'Dune Buggy', 20000, 'dune'),
	(99, 'Rebel', 22000, 'rebel2'),
	(100, 'Sandking', 38000, 'sandking'),
	(101, 'The Liberator', 550000, 'monster'),
	(102, 'Trophy Truck', 550000, 'trophytruck'),
	(103, 'Baller', 90000, 'baller'),
	(104, 'Cavalcade', 60000, 'cavalcade'),
	(105, 'Grabger', 35000, 'granger'),
	(106, 'Huntley S', 195000, 'huntley'),
	(107, 'Landstalker', 58000, 'landstalker'),
	(108, 'Radius', 32000, 'radi'),
	(109, 'Rocoto', 85000, 'rocoto'),
	(110, 'Seminole', 30000, 'seminole'),
	(111, 'XLS', 253000, 'xls'),
	(112, 'Bison', 30000, 'bison'),
	(113, 'Bobcat XL', 23000, 'bobcatxl'),
	(114, 'Gang Burrito', 65000, 'gburrito'),
	(115, 'Journey', 15000, 'journey'),
	(116, 'Minivan', 30000, 'minivan'),
	(117, 'Paradise', 25000, 'paradise'),
	(118, 'Rumpo', 13000, 'rumpo'),
	(119, 'Surfer', 11000, 'surfer'),
	(120, 'Youga', 16000, 'youga'),
	(121, 'Asea', 1000000, 'asea'),
	(122, 'Asterope', 1000000, 'asterope'),
	(123, 'Fugitive', 24000, 'fugitive'),
	(124, 'Glendale', 200000, 'glendale'),
	(125, 'Ingot', 9000, 'ingot'),
	(126, 'Intruder', 16000, 'intruder'),
	(127, 'Premier', 10000, 'premier'),
	(128, 'Primo', 9000, 'primo'),
	(129, 'Primo Custom', 9500, 'primo2'),
	(130, 'Regina', 8000, 'regina'),
	(131, 'Schafter', 65000, 'schafter2'),
	(132, 'Stanier', 10000, 'stanier'),
	(133, 'Stratum', 10000, 'stratum'),
	(134, 'Stretch', 30000, 'stretch'),
	(135, 'Super Diamond', 250000, 'superd'),
	(136, 'Surge', 38000, 'surge'),
	(137, 'Tailgater', 55000, 'tailgater'),
	(138, 'Warrener', 120000, 'warrener'),
	(139, 'Washington', 15000, 'washington'),
	(140, 'Akuma', 9000, 'AKUMA'),
	(141, 'Bagger', 5000, 'bagger'),
	(142, 'Bati 801', 15000, 'bati'),
	(143, 'Bati 801RR', 15000, 'bati2'),
	(144, 'BF400', 95000, 'bf400'),
	(145, 'Carbon RS', 40000, 'carbonrs'),
	(146, 'Cliffhanger', 225000, 'cliffhanger'),
	(147, 'Daemon', 5000, 'daemon'),
	(148, 'Double T', 12000, 'double'),
	(149, 'Enduro', 48000, 'enduro'),
	(150, 'Faggio', 4000, 'faggio2'),
	(151, 'Gargoyle', 120000, 'gargoyle'),
	(152, 'Hakuchou', 82000, 'hakuchou'),
	(153, 'Hexer', 15000, 'hexer'),
	(154, 'Innovation', 90000, 'innovation'),
	(155, 'Lectro', 700000, 'lectro'),
	(156, 'Nemesis', 12000, 'nemesis'),
	(157, 'PCJ-600', 9000, 'pcj'),
	(158, 'Ruffian', 9000, 'ruffian'),
	(159, 'Sanchez', 7000, 'sanchez'),
	(160, 'Sovereign', 90000, 'sovereign'),
	(161, 'Thrust', 75000, 'thrust'),
	(162, 'Vader', 9000, 'vader'),
	(163, 'Vindicator', 600000, 'vindicator');
/*!40000 ALTER TABLE `vehicles` ENABLE KEYS */;

-- Export de la structure de la table version_partage. whitelist
CREATE TABLE IF NOT EXISTS `whitelist` (
  `identifier` varchar(255) NOT NULL,
  `listed` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`identifier`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- Export de données de la table version_partage.whitelist : 0 rows
DELETE FROM `whitelist`;
/*!40000 ALTER TABLE `whitelist` DISABLE KEYS */;
/*!40000 ALTER TABLE `whitelist` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
