-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               10.4.19-MariaDB - mariadb.org binary distribution
-- Server OS:                    Win64
-- HeidiSQL Version:             11.2.0.6213
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Dumping database structure for vorpv2
CREATE DATABASE IF NOT EXISTS `vorpv2` /*!40100 DEFAULT CHARACTER SET utf8mb4 */;
USE `vorpv2`;

-- Dumping structure for table vorpv2.newspaper
CREATE TABLE IF NOT EXISTS `newspaper` (
  `news` longtext DEFAULT '[]'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
INSERT INTO `items`(`item`, `label`, `limit`, `can_remove`, `type`, `usable`) VALUES ('newspaper', 'NewsPaper', 1, 1, 'item_standard', 1);
-- Dumping data for table vorpv2.newspaper: ~0 rows (approximately)
/*!40000 ALTER TABLE `newspaper` DISABLE KEYS */;
INSERT INTO `newspaper` (`news`) VALUES
	('["https://images-ext-2.discordapp.net/external/qKIAr7ECvUVez9qaSl1nxSA8oVxzPOXdvVENwP52qug/%3Fwidth%3D1238%26height%3D676/https/media.discordapp.net/attachments/912801489766989845/912801655429406740/Changretta_foundation_Announcement.jpg","https://images-ext-2.discordapp.net/external/qKIAr7ECvUVez9qaSl1nxSA8oVxzPOXdvVENwP52qug/%3Fwidth%3D1238%26height%3D676/https/media.discordapp.net/attachments/912801489766989845/912801655429406740/Changretta_foundation_Announcement.jpg","https://images-ext-2.discordapp.net/external/qKIAr7ECvUVez9qaSl1nxSA8oVxzPOXdvVENwP52qug/%3Fwidth%3D1238%26height%3D676/https/media.discordapp.net/attachments/912801489766989845/912801655429406740/Changretta_foundation_Announcement.jpg","https://media.discordapp.net/attachments/881258396412686356/912400837094031380/twprp_supplies.png"]');
/*!40000 ALTER TABLE `newspaper` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
