-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               10.4.21-MariaDB - mariadb.org binary distribution
-- Server OS:                    Win64
-- HeidiSQL Version:             11.3.0.6295
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

-- Dumping structure for table vorpv2.banks
CREATE TABLE IF NOT EXISTS `banks` (
  `name` varchar(50) NOT NULL,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Dumping data for table vorpv2.banks: ~3 rows (approximately)
/*!40000 ALTER TABLE `banks` DISABLE KEYS */;
INSERT INTO `banks` (`name`) VALUES
	('Blackwater'),
	('Saint Denis'),
	('Valentine');
/*!40000 ALTER TABLE `banks` ENABLE KEYS */;

-- Dumping structure for table vorpv2.bank_users
CREATE TABLE IF NOT EXISTS `bank_users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `identifier` varchar(50) NOT NULL,
  `charidentifier` int(11) NOT NULL,
  `money` double(22,2) DEFAULT 0.00,
  `gold` double(22,2) DEFAULT 0.00,
  `items` longtext DEFAULT '[]',
  `invspace` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`),
  CONSTRAINT `bank` FOREIGN KEY (`name`) REFERENCES `banks` (`name`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Dumping data for table vorpv2.bank_users: ~0 rows (approximately)
/*!40000 ALTER TABLE `bank_users` DISABLE KEYS */;
/*!40000 ALTER TABLE `bank_users` ENABLE KEYS */;

-- Dumping structure for table vorpv2.banneds
CREATE TABLE IF NOT EXISTS `banneds` (
  `b_id` int(11) NOT NULL AUTO_INCREMENT,
  `b_steam` varchar(100) NOT NULL,
  `b_license` varchar(255) DEFAULT NULL,
  `b_discord` varchar(100) DEFAULT NULL,
  `b_reason` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `b_banned` varchar(100) NOT NULL,
  `b_unban` varchar(100) NOT NULL,
  `b_permanent` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`b_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- Dumping data for table vorpv2.banneds: ~0 rows (approximately)
/*!40000 ALTER TABLE `banneds` DISABLE KEYS */;
/*!40000 ALTER TABLE `banneds` ENABLE KEYS */;

-- Dumping structure for table vorpv2.bills
CREATE TABLE IF NOT EXISTS `bills` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `job` longtext DEFAULT NULL,
  `playername` longtext DEFAULT NULL,
  `identifier` varchar(50) DEFAULT NULL,
  `charidentifier` int(11) DEFAULT NULL,
  `issuer` longtext DEFAULT NULL,
  `amount` double DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8mb4;

-- Dumping data for table vorpv2.bills: ~0 rows (approximately)
/*!40000 ALTER TABLE `bills` DISABLE KEYS */;
/*!40000 ALTER TABLE `bills` ENABLE KEYS */;

-- Dumping structure for table vorpv2.boates
CREATE TABLE IF NOT EXISTS `boates` (
  `identifier` varchar(40) NOT NULL,
  `charid` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `boat` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table vorpv2.boates: ~0 rows (approximately)
/*!40000 ALTER TABLE `boates` DISABLE KEYS */;
/*!40000 ALTER TABLE `boates` ENABLE KEYS */;

-- Dumping structure for table vorpv2.bounty
CREATE TABLE IF NOT EXISTS `bounty` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` longtext DEFAULT '',
  `identifier` varchar(50) DEFAULT NULL,
  `charidentifier` int(11) DEFAULT NULL,
  `info` longtext DEFAULT '[]',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4;

-- Dumping data for table vorpv2.bounty: ~0 rows (approximately)
/*!40000 ALTER TABLE `bounty` DISABLE KEYS */;
/*!40000 ALTER TABLE `bounty` ENABLE KEYS */;

-- Dumping structure for table vorpv2.characters
CREATE TABLE IF NOT EXISTS `characters` (
  `identifier` varchar(50) COLLATE utf8mb4_bin NOT NULL DEFAULT '',
  `steamname` varchar(50) COLLATE utf8mb4_bin NOT NULL DEFAULT '',
  `charidentifier` int(11) NOT NULL AUTO_INCREMENT,
  `group` varchar(10) COLLATE utf8mb4_bin DEFAULT 'user',
  `money` double(11,2) DEFAULT 0.00,
  `gold` double(11,2) DEFAULT 0.00,
  `rol` double(11,2) NOT NULL DEFAULT 0.00,
  `xp` int(11) DEFAULT 0,
  `inventory` longtext COLLATE utf8mb4_bin DEFAULT NULL,
  `job` varchar(50) COLLATE utf8mb4_bin DEFAULT 'unemployed',
  `status` varchar(140) COLLATE utf8mb4_bin DEFAULT '{}',
  `meta` varchar(255) COLLATE utf8mb4_bin NOT NULL DEFAULT '{}',
  `firstname` varchar(50) COLLATE utf8mb4_bin DEFAULT ' ',
  `lastname` varchar(50) COLLATE utf8mb4_bin DEFAULT ' ',
  `skinPlayer` longtext COLLATE utf8mb4_bin DEFAULT NULL,
  `compPlayer` longtext COLLATE utf8mb4_bin DEFAULT NULL,
  `jobgrade` int(11) DEFAULT 0,
  `coords` varchar(75) COLLATE utf8mb4_bin DEFAULT '{}',
  `isdead` tinyint(1) DEFAULT 0,
  `clanid` int(11) DEFAULT 0,
  `trust` int(11) DEFAULT 0,
  `supporter` int(11) DEFAULT 0,
  `walk` varchar(50) COLLATE utf8mb4_bin DEFAULT 'noanim',
  `crafting` longtext COLLATE utf8mb4_bin DEFAULT '{"medical":0,"blacksmith":0,"basic":0,"survival":0,"brewing":0,"food":0}',
  `info` longtext COLLATE utf8mb4_bin DEFAULT '{}',
  `gunsmith` double(11,2) DEFAULT 0.00,
  `ammo` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4 DEFAULT '{}',
  UNIQUE KEY `identifier_charidentifier` (`identifier`,`charidentifier`) USING BTREE,
  KEY `charidentifier` (`charidentifier`) USING BTREE,
  KEY `clanid` (`clanid`),
  KEY `crafting` (`crafting`(768)),
  KEY `compPlayer` (`compPlayer`(768)),
  KEY `info` (`info`(768)),
  KEY `inventory` (`inventory`(768)),
  KEY `coords` (`coords`),
  KEY `money` (`money`),
  KEY `meta` (`meta`),
  KEY `steamname` (`steamname`),
  INDEX `ammo` (`ammo`) USING BTREE,
  CONSTRAINT `FK_characters_users` FOREIGN KEY (`identifier`) REFERENCES `users` (`identifier`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=629 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC;


-- Dumping data for table vorpv2.characters: ~190 rows (approximately)
/*!40000 ALTER TABLE `characters` DISABLE KEYS */;
/*!40000 ALTER TABLE `characters` ENABLE KEYS */;

-- Dumping structure for table vorpv2.container
CREATE TABLE IF NOT EXISTS `container` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` longtext DEFAULT NULL,
  `items` longtext NOT NULL DEFAULT '{}',
  `invslots` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ID` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=217 DEFAULT CHARSET=utf8mb4;

-- Dumping data for table vorpv2.container: ~27 rows (approximately)
/*!40000 ALTER TABLE `container` DISABLE KEYS */;
INSERT INTO `container` (`id`, `name`, `items`, `invslots`) VALUES
	(1, 'police', '[]', 0),
	(3, 'horsetrainer', '[]', 600),
	(4, 'doctor', '[]', 600),
	(5, 'realestate', '[]', 600),
	(6, 'bastille', '[]', 600),
	(7, 'rgs', '[]', 600),
	(8, 'rguns', '[]', 600),
	(15, 'shaman', '{}', 600),
	(16, 'marshal', '[]', 0),
	(17, 'valtrain', '[]', 600),
	(18, 'bountyhunter', '[]', 600),
	(19, 'blacksmith', '[]', 600),
	(20, 'trash', '[]', 0),
	(21, 'trash', '[]', 0),
	(22, 'trash', '[]', 0),
	(23, 'gunsmith', '[]', 600),
	(24, 'miner', '[]', 600),
	(25, 'silvershot', '{}', 600),
	(26, 'bvs', '{}', 600),
	(27, 'ksd', '[]', 600);
/*!40000 ALTER TABLE `container` ENABLE KEYS */;

-- Dumping structure for table vorpv2.dogs
CREATE TABLE IF NOT EXISTS `dogs` (
  `identifier` varchar(40) NOT NULL,
  `charidentifier` varchar(5) DEFAULT NULL,
  `dog` varchar(255) DEFAULT NULL,
  `age` varchar(255) DEFAULT NULL,
  `skin` varchar(1) DEFAULT '0',
  `hunger` varchar(10) DEFAULT '0',
  `thirst` varchar(10) DEFAULT '0',
  `health` varchar(10) DEFAULT '0',
  `Command_1` varchar(10) DEFAULT '0',
  `Command_2` varchar(10) DEFAULT '0',
  `Command_3` varchar(10) DEFAULT '0',
  `Command_4` varchar(10) DEFAULT '0',
  `Command_5` varchar(10) DEFAULT '0',
  `Command_6` varchar(10) DEFAULT '0',
  `Command_7` varchar(10) DEFAULT '0',
  `Command_8` varchar(10) DEFAULT '0',
  `Command_9` varchar(10) DEFAULT '0',
  `Command_10` varchar(10) DEFAULT '0',
  `Command_11` varchar(10) DEFAULT '0',
  `Command_12` varchar(10) DEFAULT '0',
  `isdead` varchar(10) DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table vorpv2.dogs: ~10 rows (approximately)
/*!40000 ALTER TABLE `dogs` DISABLE KEYS */;
/*!40000 ALTER TABLE `dogs` ENABLE KEYS */;

-- Dumping structure for table vorpv2.doors
CREATE TABLE IF NOT EXISTS `doors` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `doorinfo` longtext NOT NULL DEFAULT '[]',
  `job` longtext NOT NULL DEFAULT '[]',
  `item` longtext NOT NULL,
  `break` int(11) DEFAULT 0,
  `breakin` int(11) DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=75 DEFAULT CHARSET=utf8mb4;

-- Dumping data for table vorpv2.doors: ~40 rows (approximately)
/*!40000 ALTER TABLE `doors` DISABLE KEYS */;
INSERT INTO `doors` (`id`, `doorinfo`, `job`, `item`, `break`, `breakin`) VALUES
	(17, '[{"objc":4067537969,"objYaw1":0.00126346363686,"p":809.7841796875,"q":119.42121124267573,"doorhash":849871129,"o":-287.7419372558596,"objYaw2":0.00016431239782,"y":809.7841796875,"objYaw3":-169.6079864501953,"entit":4437506,"z":118.42121124267578,"locked":true,"x":-286.6419372558594,"doorname":"p_door62x"}]', '["doctor"]', 'no key item', 0, 0),
	(19, '[{"objc":3588026089,"objYaw1":0.00106622942257,"p":803.9545288085938,"q":119.2931732177734,"doorhash":849871129,"o":-284.0079223632815,"objYaw2":0.00004140395321,"locked":false,"objYaw3":-170.0000457763672,"entit":3104770,"z":118.39317321777344,"y":803.9545288085938,"x":-282.8079223632813,"doorname":"p_door62x"}]', '["doctor"]', 'no key item', 0, 0),
	(20, '[{"objc":925575409,"objYaw1":0.00005818598947,"p":813.357421875,"q":119.51548156738277,"doorhash":831542679,"o":-289.8586120605467,"objYaw2":-2.5566565531320859e-10,"y":813.357421875,"objYaw3":9.99999237060546,"entit":2146819,"z":118.4154815673828,"locked":true,"x":-290.8586120605469,"doorname":"s_doorsldprtn01x"}]', '["doctor"]', 'no key item', 0, 0),
	(21, '[{"objc":3439738919,"objYaw1":-0.00285818148404,"p":815.2374267578125,"q":118.01589355468752,"doorhash":1680756541,"o":-283.9742492675788,"objYaw2":-0.00032217756961,"locked":true,"objYaw3":99.6661376953125,"entit":2882307,"z":118.4158935546875,"y":815.2374267578125,"x":-281.0742492675781,"doorname":"s_doorsldprtnbrd01x"}]', '["doctor"]', 'no key item', 0, 0),
	(22, '[{"entit":4463107,"z":118.39580535888672,"y":810.0264892578125,"locked":true,"o":-265.6664489746082,"doorhash":-1099727136,"objYaw3":-79.59313201904297,"x":-270.7664489746094,"q":117.59580535888677,"p":810.0264892578125,"doorname":"p_door_val_jail_cell02x","objYaw1":-0.00115369225386,"objc":1508776842,"objYaw2":0.00002403184225}]', '["police"]', 'no key item', 0, 0),
	(23, '[{"z":163.64759826660157,"locked":false,"x":-1806.6751708984376,"doorname":"p_door_val_bank02","objYaw2":0.0,"doorhash":990179346,"y":-350.3128051757813,"objYaw3":-115.00009155273438,"entit":6598659,"q":164.04759826660158,"p":-350.3128051757813,"o":-1811.8751708984328,"objYaw1":0.0,"objc":1821044729}]', '["police","marshal"]', 'no key item', 0, 0),
	(24, '[{"doorname":"p_door37x","objYaw1":0.0,"objYaw2":0.0,"z":163.64759826660157,"locked":true,"x":-1812.669189453125,"y":-345.08489990234377,"objYaw3":-115.00009155273438,"doorhash":-1497029950,"objc":1514359658,"entit":7538179,"q":165.34759826660148,"p":-345.08489990234377,"o":-1814.069189453124}]', '["police","marshal"]', 'no key item', 0, 0),
	(27, '[{"x":-757.0423583984375,"objc":3821185084,"doorhash":-1093732866,"objYaw3":89.71432495117188,"objYaw2":-0.00138236454222,"doorname":"p_door_bla_jail_l_01x","p":-1269.92333984375,"o":-756.1423583984373,"entit":9117699,"objYaw1":-0.00035303513868,"q":44.46863403320314,"locked":false,"z":43.06863403320312,"y":-1269.92333984375}]', '["police","marshal"]', 'no key item', 0, 0),
	(28, '[{"doorname":"p_door_bla_jail_r_01x","doorhash":784094203,"objYaw2":0.0,"objYaw3":89.99992370605469,"y":-1268.485107421875,"x":-757.0421752929688,"o":-763.3421752929702,"z":43.068603515625,"locked":true,"objYaw1":0.0,"objc":3410720590,"entit":9211395,"q":41.96860351562498,"p":-1268.485107421875}]', '["police","marshal"]', 'no key item', 0, 0),
	(29, '[{"doorname":"p_door34x","doorhash":447074149,"objYaw2":-0.00003090844984,"objYaw3":-89.69831085205078,"y":-1268.744873046875,"x":-769.136962890625,"o":-769.236962890625,"z":43.0400390625,"locked":true,"objYaw1":-0.00002747763028,"objc":2810801921,"entit":3817220,"q":44.04003906250001,"p":-1268.744873046875}]', '["police","marshal"]', 'no key item', 0, 0),
	(30, '[{"doorname":"p_doorrhosheriff02x","z":76.76842498779297,"objYaw2":0.0,"objYaw3":159.81829833984376,"y":-1305.9600830078126,"x":1359.710205078125,"entit":5355524,"objYaw1":0.0,"locked":false,"objc":349074475,"o":1358.710205078126,"doorhash":-1866470762,"q":78.0684249877929,"p":-1305.9600830078126}]', '["police","marshal"]', 'no key item', 0, 0),
	(31, '[{"doorname":"p_door04x","doorhash":-542955242,"objYaw2":-0.00094323337543,"objYaw3":-110.37109375,"y":-1297.5340576171876,"x":1359.0972900390626,"o":1358.8972900390627,"z":76.78761291503906,"locked":true,"objYaw1":0.00140971527434,"objc":1614494720,"entit":6161412,"q":77.787612915039,"p":-1297.5340576171876}]', '["police","marshal"]', 'no key item', 0, 0),
	(32, '[{"doorname":"p_doornbd39a","z":47.95257186889648,"objYaw2":0.0,"objYaw3":89.99993133544922,"y":-1309.9276123046876,"x":2516.144287109375,"entit":7446532,"objYaw1":0.0,"locked":false,"objc":417663242,"o":2516.8442871093745,"doorhash":1816996393,"q":49.0525718688965,"p":-1309.9276123046876}]', '["police","marshal"]', 'no key item', 0, 0),
	(33, '[{"doorname":"p_doornbd39a","z":47.95257186889648,"objYaw2":0.0,"objYaw3":-90.00000762939453,"y":-1307.724853515625,"x":2516.14453125,"entit":8310020,"objYaw1":0.0,"locked":false,"objc":1611175760,"o":2518.8445312499977,"doorhash":1816996393,"q":49.85257186889651,"p":-1307.724853515625}]', '["police","marshal"]', 'no key item', 0, 0),
	(38, '[{"doorname":"p_doorstrawberry01x_new","q":158.63195495605465,"objYaw1":0.0,"p":-429.39251708984377,"o":-1803.311816406249,"objYaw2":0.0,"objc":2543619259,"entit":1741570,"y":-429.39251708984377,"z":157.8319549560547,"doorhash":1898488517,"locked":false,"x":-1802.11181640625,"objYaw3":154.9999542236328}]', '["doctor"]', 'no key item', 0, 0),
	(40, '[{"q":117.72991180419922,"objYaw1":0.0,"objc":3886827663,"doorname":"p_door_val_bank00_rx","o":-306.8853454589844,"p":780.1154174804688,"y":780.1154174804688,"locked":false,"doorhash":169503210,"objYaw2":0.0,"z":117.72991180419922,"objYaw3":-169.9445037841797,"x":-306.8853454589844,"entit":6125571}]', '[]', 'no key item', 0, 0),
	(41, '[{"q":117.72991180419922,"objYaw1":0.0,"objc":2642457609,"doorname":"p_door_val_bank00_lx","o":-309.05206298828127,"p":779.7301025390625,"y":779.7301025390625,"locked":false,"doorhash":160636303,"objYaw2":0.0,"z":117.72991180419922,"objYaw3":10.05537796020507,"x":-309.05206298828127,"entit":6126595}]', '[]', 'no key item', 0, 0),
	(42, '[{"q":117.72991180419922,"objYaw1":0.0,"objc":1340831050,"doorname":"p_gate_valbankvlt","o":-311.7406311035156,"p":774.6756591796875,"y":774.6756591796875,"locked":false,"doorhash":-790938048,"objYaw2":0.0,"z":117.72991180419922,"objYaw3":10.05545711517334,"x":-311.7406311035156,"entit":7346691}]', '[]', 'no key item', 0, 0),
	(43, '[{"q":117.70217895507813,"objYaw1":0.0,"objc":3718620420,"doorname":"p_door_val_bank01","o":-311.0597839355469,"p":770.1240234375,"y":770.1240234375,"locked":false,"doorhash":760370349,"objYaw2":0.0,"z":117.70217895507813,"objYaw3":10.05545711517334,"x":-311.0597839355469,"entit":7554563}]', '[]', 'no key item', 0, 0),
	(45, '[{"q":48.21639251708984,"objYaw1":0.0,"objc":340151973,"doorname":"p_doornbd39x","o":2545.34619140625,"p":-1289.8310546875,"y":-1289.8310546875,"locked":false,"doorhash":367033685,"objYaw2":0.0,"z":48.21639251708984,"objYaw3":0.0,"x":2545.34619140625,"entit":9413635}]', '[]', 'no key item', 0, 0),
	(46, '[{"q":48.21639251708984,"objYaw1":0.0,"objc":544106233,"doorname":"p_doornbd39x","o":2547.55029296875,"p":-1289.8310546875,"y":-1289.8310546875,"locked":false,"doorhash":367033685,"objYaw2":0.0,"z":48.21639251708984,"objYaw3":179.99998474121095,"x":2547.55029296875,"entit":9410563}]', '[]', 'no key item', 0, 0),
	(47, '[{"q":43.66149902343751,"objYaw1":0.0,"z":42.6614990234375,"doorname":"p_door13x","o":-809.041845703125,"p":-1279.1900634765626,"y":-1279.1900634765626,"locked":false,"doorhash":-1819321039,"objc":531022111,"objYaw2":0.0,"objYaw3":89.99998474121094,"x":-809.141845703125,"entit":2499075}]', '[]', 'no key item', 0, 0),
	(49, '[{"doorname":"p_door_val_bank01","doorhash":760370349,"objYaw2":-0.00148201663978,"q":43.75194320678712,"p":-1277.6683349609376,"o":-817.810791015625,"objYaw3":-89.74759674072266,"y":-1277.6683349609376,"z":42.65194320678711,"entit":7655429,"x":-817.810791015625,"locked":true,"objYaw1":0.00069039629306,"objc":2817192481}]', '["realestate"]', 'no key item', 0, 0),
	(51, '[{"objYaw1":0.0,"locked":false,"x":-315.3799743652344,"doorhash":-542955242,"y":818.7929077148438,"objYaw3":-169.99996948242188,"entit":4502032,"objc":261929195,"z":117.96400451660156,"objYaw2":0.0,"p":818.7929077148438,"q":117.96400451660156,"doorname":"p_door04x","o":-315.3799743652344}]', '["bastille"]', 'no key item', 0, 0),
	(55, '[{"objc":2171243230,"objYaw1":0.0,"locked":true,"z":121.9578628540039,"objYaw2":0.0,"x":-2215.229736328125,"doorhash":233569385,"objYaw3":29.99999237060547,"doorname":"p_door_barn02","y":724.6326293945313,"q":122.1578628540039,"entit":6794249,"o":-2215.129736328125,"p":724.6326293945313}]', '["bountyhunter"]', 'no key item', 0, 0),
	(56, '[{"objc":2468163139,"objYaw1":0.0,"y":726.8384399414063,"z":121.9578628540039,"objYaw2":0.0,"doorhash":233569385,"objYaw3":-150.0,"locked":true,"doorname":"p_door_barn02","x":-2211.3740234375,"q":122.75786285400386,"entit":5037065,"o":-2211.2740234375,"p":726.8384399414063}]', '["bountyhunter"]', 'no key item', 0, 0),
	(57, '[{"doorname":"p_door_wornbarn_l","objYaw1":0.0,"p":745.0603637695313,"objYaw3":-150.0,"objc":2726022400,"x":-2216.4638671875,"doorhash":-559000589,"z":122.47724151611328,"y":745.0603637695313,"objYaw2":0.0,"o":-2216.4638671875,"q":122.47724151611328,"locked":true,"entit":8142601}]', '["bountyhunter"]', 'no key item', 0, 0),
	(58, '[{"doorname":"p_barn_door_l","objYaw1":0.0,"p":737.8558959960938,"objYaw3":-150.0,"objc":3025858750,"x":-2228.867431640625,"doorhash":-336539838,"z":122.49179077148438,"y":737.8558959960938,"objYaw2":0.0,"o":-2228.867431640625,"q":122.49179077148438,"locked":true,"entit":8807689}]', '["bountyhunter"]', 'no key item', 0, 0),
	(60, '[{"o":-322.74957275390627,"q":120.62322235107422,"objYaw1":-0.0003209762508,"objc":3765902977,"objYaw3":99.68075561523438,"doorname":"p_door33x","p":766.6564331054688,"entit":1012482,"y":766.6564331054688,"doorhash":1650744725,"x":-322.74957275390627,"z":120.62322235107422,"objYaw2":-0.00067330955062,"locked":true}]', '[]', 'no key item', 0, 0),
	(61, '[{"entit":6188553,"z":121.6198501586914,"y":724.8563842773438,"x":-2176.849609375,"o":-2177.849609374999,"objYaw2":0.00000112510235,"objYaw3":-155.00228881835938,"locked":true,"q":122.61985015869137,"p":724.8563842773438,"doorname":"p_doorbrait01bx","objYaw1":0.00086592242587,"objc":2670400201,"doorhash":1064769829}]', '["bountyhunter"]', 'no key item', 0, 0),
	(62, '[{"objYaw2":0.0,"entit":2735618,"doorname":"p_door34x","q":120.13214263916017,"p":682.674377441406,"o":501.7857543945315,"locked":true,"doorhash":447074149,"objYaw3":-94.99996185302736,"objYaw1":0.0,"z":120.03214263916016,"y":683.6743774414063,"x":500.5857543945313,"objc":6541948}]', '["blacksmith"]', 'no key item', 0, 1),
	(64, '[{"entit":3190787,"z":120.0238037109375,"y":672.7487182617188,"x":491.7784729003906,"o":492.8784729003909,"objYaw2":0.0,"objYaw3":85.00003051757813,"locked":true,"q":120.52380371093749,"p":673.848718261719,"doorname":"p_door34x","objYaw1":0.0,"objc":2337551683,"doorhash":447074149}]', '["blacksmith"]', 'no key item', 0, 1),
	(67, '[{"objc":2343746133,"y":771.751953125,"doorname":"p_gate_valbankvlt","z":117.72990417480468,"objYaw3":-169.99984741210938,"objYaw1":0.0,"o":-301.9361877441406,"doorhash":-790938048,"q":117.72990417480468,"p":771.751953125,"locked":true,"x":-301.9361877441406,"objYaw2":0.0,"entit":1819907}]', '["bastille"]', 'no key item', 0, 1),
	(68, '[{"objc":334467483,"y":767.6043090820313,"x":-302.9228210449219,"z":117.69805145263672,"objYaw3":100.0553970336914,"objYaw1":0.0,"o":-302.9228210449219,"doorhash":760370349,"q":117.69805145263672,"p":767.6043090820313,"locked":true,"objYaw2":0.0,"doorname":"p_door_val_bank01","entit":2344195}]', '["bastille"]', 'no key item', 0, 1),
	(69, '[{"objYaw1":0.0,"objYaw3":-169.94448852539066,"y":766.3489990234375,"x":-307.7537536621094,"o":-307.7537536621094,"z":117.70159149169922,"objYaw2":0.0,"doorname":"p_door_val_bankvault","objc":576950805,"entit":2945539,"locked":true,"p":766.3489990234375,"q":117.70159149169922,"doorhash":-765914358}]', '["bastille"]', 'no key item', 0, 1),
	(70, '[{"entit":9356802,"z":121.62875366210938,"y":716.46337890625,"x":-2182.510498046875,"o":-2181.210498046876,"objYaw2":0.0,"objYaw3":-64.99996185302735,"locked":true,"q":121.62875366210938,"p":716.46337890625,"doorname":"p_door37x","objYaw1":0.0,"objc":2212914984,"doorhash":-1497029950}]', '["bountyhunter"]', 'no key item', 0, 1),
	(71, '[{"objc":3065308386,"y":-361.5426330566406,"doorname":"p_door04x","z":87.0780029296875,"objYaw3":116.81532287597656,"objYaw1":0.00000590390027,"o":-333.3887329101563,"doorhash":-542955242,"q":87.0780029296875,"p":-361.5426330566406,"locked":true,"x":-333.3887329101563,"objYaw2":0.0001215565353,"entit":2270472}]', '["ksd"]', 'no key item', 0, 1),
	(72, '[{"objc":2818197357,"y":-362.57171630859377,"doorname":"p_door04x","z":87.0780029296875,"objYaw3":116.99994659423828,"objYaw1":0.0,"o":-339.0961608886719,"doorhash":-542955242,"q":87.0780029296875,"p":-362.57171630859377,"locked":true,"x":-339.0961608886719,"objYaw2":0.0,"entit":8104202}]', '["ksd"]', 'no key item', 0, 1),
	(73, '[{"objc":395506985,"y":812.0270385742188,"x":-275.8447570800781,"z":118.41483306884766,"objYaw3":-169.99998474121098,"objYaw1":0.0,"o":-275.8447570800781,"doorhash":980307335,"q":118.41483306884766,"p":812.0270385742188,"locked":true,"doorname":"p_door_val_jail01x","objYaw2":0.0,"entit":1592075}]', '["police"]', 'no key item', 0, 1),
	(74, '[{"entit":1546498,"z":118.41165161132813,"y":802.575927734375,"locked":true,"o":-276.0047912597656,"objYaw2":8.815490559754835e-7,"objYaw3":-11.78702926635742,"doorhash":1045059103,"q":118.41165161132813,"p":802.575927734375,"doorname":"p_door_val_jail02x","objYaw1":0.00029245525365,"objc":1988748538,"x":-276.0047912597656}]', '["police"]', 'no key item', 0, 1);
/*!40000 ALTER TABLE `doors` ENABLE KEYS */;

-- Dumping structure for table vorpv2.farming
CREATE TABLE IF NOT EXISTS `farming` (
  `identifier` varchar(255) COLLATE latin1_general_cs NOT NULL,
  `charid` varchar(255) COLLATE latin1_general_cs NOT NULL,
  `coords1` varchar(255) COLLATE latin1_general_cs DEFAULT '0',
  `coords2` varchar(255) COLLATE latin1_general_cs DEFAULT '0',
  `coords3` varchar(255) COLLATE latin1_general_cs DEFAULT '0',
  `coords4` varchar(255) COLLATE latin1_general_cs DEFAULT '0',
  `coords5` varchar(255) COLLATE latin1_general_cs DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_cs;

-- Dumping data for table vorpv2.farming: ~34 rows (approximately)
/*!40000 ALTER TABLE `farming` DISABLE KEYS */;
/*!40000 ALTER TABLE `farming` ENABLE KEYS */;

-- Dumping structure for table vorpv2.horses
CREATE TABLE IF NOT EXISTS `horses` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(40) NOT NULL,
  `charid` int(11) NOT NULL,
  `selected` int(11) NOT NULL DEFAULT 0,
  `model` varchar(50) NOT NULL,
  `name` varchar(50) NOT NULL,
  `components` varchar(5000) NOT NULL DEFAULT '{}',
  `exp` int(11) NOT NULL DEFAULT 0,
  `items` longtext DEFAULT '{}',
  `sex` int(11) DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `FK_horses_characters` (`charid`),
  KEY `model` (`model`)
) ENGINE=InnoDB AUTO_INCREMENT=396 DEFAULT CHARSET=utf8mb4;

-- Dumping data for table vorpv2.horses: ~136 rows (approximately)
/*!40000 ALTER TABLE `horses` DISABLE KEYS */;
/*!40000 ALTER TABLE `horses` ENABLE KEYS */;

-- Dumping structure for table vorpv2.items
CREATE TABLE IF NOT EXISTS `items` (
  `item` varchar(50) NOT NULL,
  `label` varchar(50) NOT NULL,
  `limit` int(11) NOT NULL DEFAULT 1,
  `can_remove` tinyint(1) NOT NULL DEFAULT 1,
  `type` varchar(50) DEFAULT NULL,
  `usable` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`item`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- Dumping data for table vorpv2.items: ~337 rows (approximately)
/*!40000 ALTER TABLE `items` DISABLE KEYS */;
INSERT INTO `items` (`item`, `label`, `limit`, `can_remove`, `type`, `usable`) VALUES
	('acid', 'Acid', 10, 1, 'item_standard', 1),
	('Agarita', 'Agarita', 10, 1, 'item_standard', 1),
	('Agarita_Seed', 'Agarita Seed', 10, 1, 'item_standard', 1),
	('Alaskan_Ginseng', 'Alaskan Ginseng', 10, 1, 'item_standard', 1),
	('Alaskan_Ginseng_Seed', 'Alaskan Ginseng Seed', 10, 1, 'item_standard', 1),
	('alcohol', 'Alcohol', 10, 1, 'item_standard', 1),
	('American_Ginseng', 'American Ginseng', 10, 1, 'item_standard', 1),
	('American_Ginseng_Seed', 'American Ginseng Seed', 10, 1, 'item_standard', 1),
	('ammoarrmownormal', 'Arrow Normal', 10, 1, 'item_standard', 1),
	('ammoarrowdynamite', 'Arrow Dynamite', 10, 1, 'item_standard', 1),
	('ammoarrowfire', 'Arrow Fire', 10, 1, 'item_standard', 1),
	('ammoarrowimproved', 'Arrow Improved', 10, 1, 'item_standard', 1),
	('ammoarrowpoison', 'Arrow Poison', 10, 1, 'item_standard', 1),
	('ammoarrowsmallgame', 'Arrow Small Game', 10, 1, 'item_standard', 1),
	('ammobolahawk', 'Bola Ammo Hawk', 10, 1, 'item_standard', 1),
	('ammobolainterwired', 'Bola Ammo Interwired', 10, 1, 'item_standard', 1),
	('ammobolaironspiked', 'Bola Ammo Ironspiked', 10, 1, 'item_standard', 1),
	('ammobolla', 'Bolla Ammo', 10, 1, 'item_standard', 1),
	('ammodynamite', 'Dynamite Ammo', 10, 1, 'item_standard', 1),
	('ammoelephant', 'Elephant Rifle Ammo', 10, 1, 'item_standard', 1),
	('ammoknives', 'Knives Ammo', 10, 1, 'item_standard', 1),
	('ammomolotov', 'Molotov Ammo', 10, 1, 'item_standard', 1),
	('ammopistolexplosive', 'Pistol Ammo Explosive', 10, 1, 'item_standard', 1),
	('ammopistolexpress', 'Pistol Ammo Express', 10, 1, 'item_standard', 1),
	('ammopistolnormal', 'Pistol Ammo Normal', 10, 1, 'item_standard', 1),
	('ammopistolsplitpoint', 'Pistol Ammo Splitpoint', 10, 1, 'item_standard', 1),
	('ammopistolvelocity', 'Pistol Ammo Velocity', 10, 1, 'item_standard', 1),
	('ammopoisonbottle', 'Poison Bottle Ammo', 10, 1, 'item_standard', 1),
	('ammorepeaterexplosive', 'Repeater Ammo Explosive', 10, 1, 'item_standard', 1),
	('ammorepeaterexpress', 'Repeater Ammo Express', 10, 1, 'item_standard', 1),
	('ammorepeaternormal', 'Repeater Ammo Normal', 10, 1, 'item_standard', 1),
	('ammorepeatersplitpoint', 'Repeater Ammo Splitpoint', 10, 1, 'item_standard', 1),
	('ammorepeatervelocity', 'Repeater Ammo Velocity', 10, 1, 'item_standard', 1),
	('ammorevolverexplosive', 'Revolver Ammo Explosive', 10, 1, 'item_standard', 1),
	('ammorevolverexpress', 'Revolver Ammo Express', 10, 1, 'item_standard', 1),
	('ammorevolvernormal', 'Revolver Ammo Normal', 10, 1, 'item_standard', 1),
	('ammorevolversplitpoint', 'Revolver Ammo Splitpoint', 10, 1, 'item_standard', 1),
	('ammorevolvervelocity', 'Revolver Ammo Velocity', 10, 1, 'item_standard', 1),
	('ammorifleexplosive', 'Rifle Ammo Explosive', 10, 1, 'item_standard', 1),
	('ammorifleexpress', 'Rifle Ammo Express', 10, 1, 'item_standard', 1),
	('ammoriflenormal', 'Rifle Ammo Normal', 10, 1, 'item_standard', 1),
	('ammoriflesplitpoint', 'Rifle Ammo Splitpoint', 10, 1, 'item_standard', 1),
	('ammoriflevelocity', 'Rifle Ammo Velocity', 10, 1, 'item_standard', 1),
	('ammoshotgunexplosive', 'Shotgun Ammo Explosive', 10, 1, 'item_standard', 1),
	('ammoshotgunincendiary', 'Shotgun Ammo Incendiary', 10, 1, 'item_standard', 1),
	('ammoshotgunnormal', 'Shotgun Ammo Normal', 10, 1, 'item_standard', 1),
	('ammoshotgunslug', 'Shotgun Ammo Slug', 10, 1, 'item_standard', 1),
	('ammotomahawk', 'Tonmahawk Ammo', 10, 1, 'item_standard', 1),
	('ammovarmint', 'Varmint Ammo', 10, 1, 'item_standard', 1),
	('ammovarminttranq', 'Varmint Tranquilizer Ammo', 10, 1, 'item_standard', 1),
	('ammovoldynamite', 'Volatile Dynamite Ammo', 10, 1, 'item_standard', 1),
	('ammovolmolotov', 'Volatile Molotov Ammo', 10, 1, 'item_standard', 1),
	('antipoison', 'Antipoison', 20, 1, 'item_standard', 1),
	('apple', 'Apple', 20, 1, 'item_standard', 1),
	('appleCrumbMash', 'Minty Berry Mash', 10, 1, 'item_standard', 1),
	('appleCrumbMoonshine', 'Minty Berry Moonshine', 10, 1, 'item_standard', 1),
	('a_c_fishbluegil_01_ms', 'Medium Bluegil', 10, 1, 'item_standard', 0),
	('a_c_fishbluegil_01_sm', 'Small Bluegil', 5, 1, 'item_standard', 0),
	('a_c_fishbullheadcat_01_ms', 'Medium Bullhead', 10, 1, 'item_standard', 0),
	('a_c_fishbullheadcat_01_sm', 'Small Bullhead', 5, 1, 'item_standard', 0),
	('a_c_fishchainpickerel_01_ms', 'Medium Pickerel', 10, 1, 'item_standard', 0),
	('a_c_fishchainpickerel_01_sm', 'Small Pickerel', 5, 1, 'item_standard', 0),
	('a_c_fishlargemouthbass_01_ms', 'Lardgemouth Bass', 10, 1, 'item_standard', 0),
	('a_c_fishperch_01_ms', 'Medium Perch', 10, 1, 'item_standard', 0),
	('a_c_fishperch_01_sm', 'Small Perch', 5, 1, 'item_standard', 0),
	('a_c_fishrainbowtrout_01_ms', 'Rainbow Trout', 10, 1, 'item_standard', 0),
	('a_c_fishredfinpickerel_01_ms', 'Medium Redfin Pickerel', 10, 1, 'item_standard', 0),
	('a_c_fishredfinpickerel_01_sm', 'Small Redfin Pickerel', 5, 1, 'item_standard', 0),
	('a_c_fishrockbass_01_ms', 'Medium Rockbass', 10, 1, 'item_standard', 0),
	('a_c_fishrockbass_01_sm', 'Small Rockbass', 5, 1, 'item_standard', 0),
	('a_c_fishsalmonsockeye_01_ms', 'Sockeye Salmon', 10, 1, 'item_standard', 0),
	('a_c_fishsmallmouthbass_01_ms', 'Smallmouth Bass', 10, 1, 'item_standard', 0),
	('bait', 'Bait', 20, 1, 'item_standard', 1),
	('banana', 'Banana', 20, 1, 'item_standard', 1),
	('bandage', 'Bandage', 20, 1, 'item_standard', 1),
	('Bay_Bolete', 'Bay Bolete', 10, 1, 'item_standard', 1),
	('Bay_Bolete_Seed', 'Bay Bolete Seed', 10, 1, 'item_standard', 1),
	('beefjerky', 'Beef Jerky', 20, 1, 'item_standard', 1),
	('beer', 'Beer', 10, 1, 'item_standard', 1),
	('Big_Leather', 'Big Leather', 10, 1, 'item_standard', 1),
	('Bitter_Weed', 'Bitter Weed', 10, 1, 'item_standard', 1),
	('Bitter_Weed_Seed', 'Bitter Weed Seed', 10, 1, 'item_standard', 1),
	('blackberryale', 'Black Berry Ale', 10, 1, 'item_standard', 1),
	('Black_Berry', 'Black Berry', 10, 1, 'item_standard', 1),
	('Black_Berry_Seed', 'Black Berry Seed', 10, 1, 'item_standard', 1),
	('Black_Currant', 'Black Currant', 10, 1, 'item_standard', 1),
	('Black_Currant_Seed', 'Black Currant Seed', 10, 1, 'item_standard', 1),
	('Blood_Flower', 'Blood Flower', 10, 1, 'item_standard', 1),
	('Blood_Flower_Seed', 'Blood Flower Seed', 10, 1, 'item_standard', 1),
	('blueberry', 'Blueberry', 10, 1, 'item_standard', 1),
	('boiledegg', 'Boiled Egg', 10, 1, 'item_standard', 1),
	('book', 'Book', 5, 1, 'item_standard', 1),
	('bountylicns', 'Bounty Hunter License', 10, 1, 'item_standard', 1),
	('Bulrush', 'Bulrush', 10, 1, 'item_standard', 1),
	('Bulrush_Seed', 'Bulrush Seed', 10, 1, 'item_standard', 1),
	('Burdock_Root', 'Burdock Root', 10, 1, 'item_standard', 1),
	('Burdock_Root_Seed', 'Burdock Root Seed', 10, 1, 'item_standard', 1),
	('campfire', 'Campfire', 5, 1, 'item_standard', 1),
	('Cardinal_Flower', 'Cardinal Flower', 10, 1, 'item_standard', 1),
	('Cardinal_Flower_Seed', 'Cardinal Flower Seed', 10, 1, 'item_standard', 1),
	('carrots', 'Carrot', 10, 1, 'item_standard', 1),
	('Chanterelles', 'Chanterelles', 10, 1, 'item_standard', 1),
	('Chanterelles_Seed', 'Chanterelles Seed', 10, 1, 'item_standard', 1),
	('char', 'Char', 10, 1, 'item_standard', 0),
	('chewingtobacco', 'Chewing Tobacco', 20, 1, 'item_standard', 1),
	('Choc_Daisy', 'Choc Daisy', 10, 1, 'item_standard', 1),
	('Choc_Daisy_Seed', 'Choc Daisy Seed', 10, 1, 'item_standard', 1),
	('cigar', 'Cigar', 20, 1, 'item_standard', 1),
	('cigarette', 'Cigarette', 20, 1, 'item_standard', 1),
	('cigarettefilter', 'Cig Filter', 20, 1, 'item_standard', 1),
	('clay', 'Clay', 20, 1, 'item_standard', 1),
	('coal', 'Coal', 20, 1, 'item_standard', 1),
	('cocoa', 'Cocoa', 20, 1, 'item_standard', 1),
	('consumable_bluegil', 'Dried Bluegil', 10, 1, 'item_standard', 1),
	('consumable_breakfast', 'Breakfast', 5, 1, 'item_standard', 1),
	('consumable_caramel', 'Caramel', 5, 1, 'item_standard', 1),
	('consumable_chocolate', 'Chocolate Bar', 10, 1, 'item_standard', 1),
	('consumable_coffee', 'Coffee', 5, 1, 'item_standard', 1),
	('consumable_fruitsalad', 'Fruit Salad', 5, 1, 'item_standard', 1),
	('consumable_game', 'Jerkied GameMeat', 10, 1, 'item_standard', 1),
	('consumable_haycube', 'Haycube', 10, 1, 'item_standard', 1),
	('consumable_herb_chanterelles', 'Chanterelles', 10, 1, 'item_standard', 1),
	('consumable_herb_evergreen_huckleberry', 'Evergreen Huckleberry', 10, 1, 'item_standard', 1),
	('consumable_herb_oregano', 'Oregano', 10, 1, 'item_standard', 1),
	('consumable_herb_vanilla_flower', 'Vanilla Flower', 10, 1, 'item_standard', 1),
	('consumable_herb_wintergreen_berry', 'Wintergreen Berry', 10, 1, 'item_standard', 1),
	('consumable_kidneybeans_can', 'Kidney Beans', 5, 1, 'item_standard', 1),
	('consumable_lock_breaker', 'Lock Breaker', 10, 1, 'item_standard', 1),
	('consumable_meat_greavy', 'Meat Stew', 12, 1, 'item_standard', 1),
	('consumable_medicine', 'Medicine', 10, 1, 'item_standard', 1),
	('consumable_peach', 'Peach', 5, 1, 'item_standard', 1),
	('consumable_pear', 'Pear', 10, 1, 'item_standard', 1),
	('consumable_raspberrywater', 'Berry Water', 10, 1, 'item_standard', 1),
	('consumable_salmon', 'Dried Salmon', 10, 1, 'item_standard', 1),
	('consumable_salmon_can', 'Salmon Can', 10, 1, 'item_standard', 1),
	('consumable_trout', 'Cooked Trout', 10, 1, 'item_standard', 1),
	('consumable_veggies', 'Edible Veggies', 5, 1, 'item_standard', 1),
	('cookedbluegil', 'Cooked Bluegil with Veggies', 5, 1, 'item_standard', 1),
	('copper', 'Copper', 30, 1, 'item_standard', 1),
	('corn', 'Corn', 10, 1, 'item_standard', 1),
	('cornseed', 'Corn seed', 10, 1, 'item_standard', 1),
	('Creeking_Thyme', 'Creeping Thyme', 10, 1, 'item_standard', 1),
	('Creeking_Thyme_Seed', 'Creeping Thyme Seed', 10, 1, 'item_standard', 1),
	('Creekplum', 'Creekplum', 10, 1, 'item_standard', 1),
	('Creekplum_Seed', 'Creekplum Seed', 10, 1, 'item_standard', 1),
	('Crows_Garlic', 'Crows Garlic', 10, 1, 'item_standard', 1),
	('Crows_Garlic_Seed', 'Crows Garlic Seed', 10, 1, 'item_standard', 1),
	('Desert_Sage', 'Desert Sage', 10, 1, 'item_standard', 1),
	('Desert_Sage_Seed', 'Desert Sage Seed', 10, 1, 'item_standard', 1),
	('diamond', 'Diamond', 20, 1, 'item_standard', 1),
	('Drink_For_Dog', 'Pet Water', 10, 1, 'item_standard', 1),
	('Duck_Egg', 'Duck Egg', 10, 1, 'item_standard', 1),
	('dynamite', 'Pipe charge dynamite', 30, 1, 'item_standard', 1),
	('eggs', 'Egg', 50, 1, 'item_standard', 1),
	('emerald', 'Emerald', 20, 1, 'item_standard', 1),
	('English_Mace', 'English Mace', 10, 1, 'item_standard', 1),
	('English_Mace_Seed', 'English Mace Seed', 10, 1, 'item_standard', 1),
	('Evergreen_Huckleberry', 'Evergreen Huckleberry', 10, 1, 'item_standard', 1),
	('Evergreen_Huckleberry_Seed', 'Evergreen Huckleberry Seed', 10, 1, 'item_standard', 1),
	('fan', 'Fan', 5, 1, 'item_standard', 1),
	('Fat', 'Animal Fat', 10, 1, 'item_standard', 1),
	('Feather', 'Feather', 20, 1, 'item_standard', 1),
	('Feed_For_Dog', 'Dog Food', 10, 1, 'item_standard', 1),
	('fibers', 'Fibers', 20, 1, 'item_standard', 0),
	('fish', 'Fish', 50, 1, 'item_standard', 1),
	('fishbait', 'Fishbait', 10, 1, 'item_standard', 1),
	('fishchips', 'Fish and Chips', 10, 1, 'item_standard', 1),
	('flag', 'Camp Flag', 10, 1, 'item_standard', 1),
	('friedtater', 'Fried Taters', 10, 1, 'item_standard', 1),
	('Gamey_Meat', 'Gamey Meat', 10, 1, 'item_standard', 1),
	('Gator_Egg_3', 'Aligator Egg 3', 10, 1, 'item_standard', 1),
	('Gator_Egg_4', 'Aligator Egg 4', 10, 1, 'item_standard', 1),
	('Gator_Egg_5', 'Aligator Egg 5', 10, 1, 'item_standard', 1),
	('ginsengtea', 'Ginseng Tea', 10, 1, 'item_standard', 1),
	('glassbottle', 'Glass Bottle', 15, 1, 'item_standard', 1),
	('goldbar', 'GoldBar', 5, 1, 'item_standard', 1),
	('Golden_Currant', 'Golden Currant', 10, 1, 'item_standard', 1),
	('Golden_Currant_Seed', 'Golden Currant Seed', 10, 1, 'item_standard', 1),
	('goldfish', 'Gold Fish', 10, 1, 'item_standard', 0),
	('goldnugget', 'Gold nugget', 30, 1, 'item_standard', 0),
	('goldpan', 'Gold pan', 10, 1, 'item_standard', 1),
	('goldring', 'Gold Ring', 10, 1, 'item_standard', 1),
	('Goose_Egg_4', 'Goose Egg', 10, 1, 'item_standard', 1),
	('hairpomade', 'Hair Pomade', 10, 1, 'item_standard', 1),
	('handcuffs', 'Handcuffs', 10, 1, 'item_standard', 1),
	('hatchet', 'Hatchet', 1, 1, 'item_standard', 1),
	('Health_For_Dog', 'Pet Bandages', 10, 1, 'item_standard', 1),
	('hemp', 'Hemp', 10, 1, 'item_standard', 1),
	('hemp_cig', 'Hemp Cigarette', 1, 1, 'item_standard', 1),
	('herbmed', 'Herbal Remedy', 10, 1, 'item_standard', 1),
	('heroin', 'Heroin', 5, 1, 'item_standard', 1),
	('honey', 'Honey', 10, 1, 'item_standard', 1),
	('horsebrush', 'Horse Brush', 5, 1, 'item_standard', 1),
	('Hummingbird_Sage', 'Hummingbird Sage', 10, 1, 'item_standard', 1),
	('Hummingbird_Sage_Seed', 'Hummingbird Sage Seed', 10, 1, 'item_standard', 1),
	('hwood', 'Hard Wood', 20, 1, 'item_standard', 0),
	('Indian_Tobbaco', 'Indian Tobbaco', 20, 1, 'item_standard', 1),
	('Indian_Tobbaco_Seed', 'Indian Tobbaco Seed', 10, 1, 'item_standard', 1),
	('iron', 'Iron Ore', 30, 1, 'item_standard', 1),
	('ironbar', 'Iron Bar', 30, 1, 'item_standard', 1),
	('ironextract', 'Iron Extract', 1, 1, 'item_standard', 0),
	('ironhammer', 'Iron Hammer', 5, 1, 'item_standard', 1),
	('kit_bandana', 'Bandana', 2, 1, 'item_standard', 1),
	('leather', 'Leather', 50, 1, 'item_standard', 1),
	('lockpick', 'Lockpick', 5, 1, 'item_standard', 1),
	('lockpickmold', 'Lockpick Mold', 5, 1, 'item_standard', 1),
	('mackerel', 'Mackerel', 10, 1, 'item_standard', 0),
	('meat', 'Meat', 20, 1, 'item_standard', 1),
	('milk', 'Milk', 50, 1, 'item_standard', 1),
	('Milk_Weed', 'Milk Weed', 10, 1, 'item_standard', 1),
	('Milk_Weed_Seed', 'Milk Weed Seed', 10, 1, 'item_standard', 1),
	('moonshine', 'Moonshine', 10, 1, 'item_standard', 1),
	('morpcert', 'Morphine Perscription', 10, 1, 'item_standard', 1),
	('morphine', 'Morphine', 10, 1, 'item_standard', 1),
	('mp001_p_mp_still02x', 'Brennerei', 1, 1, 'item_standard', 1),
	('Mutton', 'Mutton', 20, 1, 'item_standard', 1),
	('nails', 'Nails', 40, 1, 'item_standard', 1),
	('newspaper', 'NewsPaper', 20, 1, 'item_standard', 1),
	('nitrite', 'Nitrite', 20, 1, 'item_standard', 1),
	('nitroglyserolia', 'Nitroglycerol', 30, 1, 'item_standard', 1),
	('notebook', 'Notebook', 5, 1, 'item_standard', 1),
	('Oleander_Sage', 'Oleander Sage', 10, 1, 'item_standard', 1),
	('Oleander_Sage_Seed', 'Oleander Sage Seed', 10, 1, 'item_standard', 1),
	('orden_presidente', 'Order of the President', 10, 1, 'item_standard', 0),
	('Oregano', 'Oregano', 10, 1, 'item_standard', 1),
	('Oregano_Seed', 'Oregano Seed', 10, 1, 'item_standard', 1),
	('paper', 'Paper', 20, 1, 'item_standard', 1),
	('Parasol_Mushroom', 'Parasol Mushroom', 10, 1, 'item_standard', 1),
	('Parasol_Mushroom_Seed', 'Parasol Mushroom Seed', 10, 1, 'item_standard', 1),
	('pickaxe', 'Pickaxe', 1, 1, 'item_standard', 0),
	('pipe', 'Pipe', 5, 1, 'item_standard', 1),
	('pocket_watch', 'Pocket Watch', 5, 1, 'item_standard', 1),
	('potato', 'Potato', 20, 1, 'item_standard', 1),
	('Prairie_Poppy', 'Prairie Poppy', 10, 1, 'item_standard', 1),
	('Prairie_Poppy_Seed', 'Prairie Poppy Seed', 10, 1, 'item_standard', 1),
	('provision_jail_keys', 'Jail Keys', 10, 1, 'item_standard', 1),
	('pulp', 'Pulp', 20, 1, 'item_standard', 0),
	('p_barrelmoonshine', 'Barrel', 1, 1, 'item_standard', 1),
	('quartz', 'Quartz', 20, 1, 'item_standard', 1),
	('rajahdysoljy', 'Explosive Oil', 30, 1, 'item_standard', 1),
	('Rams_Head', 'Rams Head', 10, 1, 'item_standard', 1),
	('Rams_Head_Seed', 'Rams Head Seed', 10, 1, 'item_standard', 1),
	('raspberryale', 'Raspberry Ale', 10, 1, 'item_standard', 1),
	('Red_Raspberry', 'Red Raspberry', 10, 1, 'item_standard', 1),
	('Red_Raspberry_Seed', 'Red Raspberry Seed', 10, 1, 'item_standard', 1),
	('Red_Sage', 'Red Sage', 10, 1, 'item_standard', 1),
	('Red_Sage_Seed', 'Red Sage Seed', 10, 1, 'item_standard', 1),
	('repeaterbarrel', 'Repeater Barrel', 5, 1, 'item_standard', 1),
	('repeatermold', 'Repeater Mold', 5, 1, 'item_standard', 1),
	('repeaterreceiver', 'Repeater Receiver', 5, 1, 'item_standard', 1),
	('repeaterrecmold', 'Repeater Receiver Mold', 5, 1, 'item_standard', 1),
	('repeaterstock', 'Repeater Stock', 5, 1, 'item_standard', 1),
	('revolverbarrel', 'Revolver Barrel', 5, 1, 'item_standard', 1),
	('revolvercylinder', 'Revolver Cylinder', 5, 1, 'item_standard', 1),
	('revolverhandle', 'Revolver Handle', 5, 1, 'item_standard', 1),
	('revolvermold', 'Revolver Mold', 5, 1, 'item_standard', 1),
	('riflebarrel', 'Rifle Barrel', 5, 1, 'item_standard', 1),
	('riflemold', 'Rifle Mold', 5, 1, 'item_standard', 1),
	('riflereceiver', 'Rifle Receiver', 5, 1, 'item_standard', 1),
	('riflerecmold', 'Rifle Receiver Mold', 5, 1, 'item_standard', 1),
	('riflestock', 'Rifle Stock', 5, 1, 'item_standard', 1),
	('roach', 'Roach', 10, 1, 'item_standard', 0),
	('rock', 'Rock', 30, 1, 'item_standard', 0),
	('rollingpaper', 'Rolling paper', 30, 1, 'item_standard', 1),
	('rubber', 'Rubber', 20, 1, 'item_standard', 0),
	('salamelle', 'Fresh Pork ', 20, 1, 'item_standard', 1),
	('salmon', 'Salmon', 10, 1, 'item_standard', 0),
	('salt', 'Salt', 20, 1, 'item_standard', 1),
	('Saltbush', 'Saltbush', 10, 1, 'item_standard', 1),
	('Saltbush_Seed', 'Saltbush Seed', 10, 1, 'item_standard', 1),
	('sap', 'Sap', 20, 1, 'item_standard', 0),
	('sarsaparilla', 'Sarsaparilla', 10, 1, 'item_standard', 1),
	('scale', 'Scale', 5, 1, 'item_standard', 1),
	('secondchance', 'Second Chance', 10, 1, 'item_standard', 1),
	('shellcasing', 'Shell Casing', 40, 1, 'item_standard', 1),
	('shotgunbarrel', 'Shotgun Barrel', 5, 1, 'item_standard', 1),
	('shotgunmold', 'Shotgun Mold', 5, 1, 'item_standard', 1),
	('shotgunstock', 'Shotgun Stock', 5, 1, 'item_standard', 1),
	('shrimps', 'Shrimp Stew', 1, 1, 'item_standard', 1),
	('Small_Leather', 'Small Leather', 10, 1, 'item_standard', 1),
	('SnakeSkin', 'Snake Skin', 20, 1, 'item_standard', 1),
	('Snake_Poison', 'Snake Poison', 10, 1, 'item_standard', 1),
	('soborno', 'Soborno Alcohol', 15, 1, 'item_standard', 0),
	('steak', 'Steak', 10, 1, 'item_standard', 1),
	('steakveg', 'Steak with Veggies', 10, 1, 'item_standard', 1),
	('stim', 'Horse Stimulant', 2, 1, 'item_standard', 1),
	('stolenmerch', 'Stolen Items', 10, 1, 'item_standard', 0),
	('stonehammer', 'Stone Hammer', 5, 1, 'item_standard', 1),
	('sugar', 'Sugar', 20, 1, 'item_standard', 0),
	('sugarcaneseed', 'Surgarcane seed', 10, 1, 'item_standard', 1),
	('sulfur', 'Sulfur', 30, 1, 'item_standard', 0),
	('syn', 'Syn', 50, 1, 'item_standard', 1),
	('synpackage', 'Syn Package', 10, 1, 'item_standard', 1),
	('syringe', 'Syringe', 20, 1, 'item_standard', 1),
	('syringecert', 'Syringe Cert', 10, 1, 'item_standard', 1),
	('tent', 'Tent', 1, 1, 'item_standard', 1),
	('tequila', 'Tequila', 10, 1, 'item_standard', 1),
	('Texas_Bonnet', 'Texas Bonnet', 10, 1, 'item_standard', 1),
	('Texas_Bonnet_Seed', 'Texas Bonnet Seed', 10, 1, 'item_standard', 1),
	('token', 'Camp License', 5, 1, 'item_standard', 1),
	('trainkey', 'Train Key', 1, 1, 'item_standard', 1),
	('tropicalPunchMash', 'Ginseng Mash', 10, 1, 'item_standard', 0),
	('tropicalPunchMoonshine', 'Ginseng Moonshine', 10, 1, 'item_standard', 0),
	('trout', 'Trout', 10, 1, 'item_standard', 0),
	('TurtleShell', 'Turtle Shell', 20, 1, 'item_standard', 1),
	('tylenol', 'Tylenol', 10, 1, 'item_standard', 1),
	('vanillaFlower', 'Vanille Flower', 20, 1, 'item_standard', 0),
	('Violet_Snowdrop', 'Violet Snowdrop', 10, 1, 'item_standard', 1),
	('Violet_Snowdrop_Seed', 'Violet Snowdrop Seed', 10, 1, 'item_standard', 1),
	('vodka', 'Vodka', 10, 1, 'item_standard', 1),
	('Volture_Egg', 'Volture Egg', 10, 1, 'item_standard', 1),
	('water', 'Water', 15, 1, 'item_standard', 1),
	('wateringcan', 'Water Jug', 10, 1, 'item_standard', 1),
	('wateringcan_dirtywater', 'Dirty Watering Jug', 10, 1, 'item_standard', 1),
	('wateringcan_empty', 'Empty Watering Jug', 10, 1, 'item_standard', 1),
	('whisky', 'Whisky', 10, 1, 'item_standard', 1),
	('wildCiderMash', 'Black Berry Mash', 10, 1, 'item_standard', 0),
	('wildCiderMoonshine', 'Black Berry Moonshine', 10, 1, 'item_standard', 0),
	('Wild_Carrot', 'Wild Carrot', 10, 1, 'item_standard', 1),
	('Wild_Carrot_Seed', 'Wild Carrot Seed', 10, 1, 'item_standard', 1),
	('Wild_Feverfew', 'Wild Feverfew', 10, 1, 'item_standard', 1),
	('Wild_Feverfew_Seed', 'Wild Feverfew Seed', 10, 1, 'item_standard', 1),
	('Wild_Mint', 'Wild Mint', 10, 1, 'item_standard', 1),
	('Wild_Mint_Seed', 'Wild Mint Seed', 10, 1, 'item_standard', 1),
	('Wild_Rhubarb', 'Wild Rhubarb', 10, 1, 'item_standard', 1),
	('Wild_Rhubarb_Seed', 'Wild Rhubarb Seed', 10, 1, 'item_standard', 1),
	('wine', 'Wine', 10, 1, 'item_standard', 1),
	('Wintergreen_Berry', 'Wintergreen Berry', 10, 1, 'item_standard', 1),
	('Wintergreen_Berry_Seed', 'Wintergreen Berry Seed', 10, 1, 'item_standard', 1),
	('Wisteria', 'Wisteria', 10, 1, 'item_standard', 1),
	('Wisteria_Seed', 'Wisteria Seed', 10, 1, 'item_standard', 1),
	('wojape', 'Wojape', 5, 1, 'item_standard', 1),
	('wood', 'Soft Wood', 20, 1, 'item_standard', 0),
	('wooden_boards', 'Wooden Boards', 25, 1, 'item_standard', 0),
	('wool', 'Wool', 50, 1, 'item_standard', 1),
	('Yarrow', 'Yarrow', 10, 1, 'item_standard', 1),
	('Yarrow_Seed', 'Yarrow Seed', 10, 1, 'item_standard', 1);
/*!40000 ALTER TABLE `items` ENABLE KEYS */;

-- Dumping structure for table vorpv2.jail
CREATE TABLE IF NOT EXISTS `jail` (
  `identifier` varchar(100) NOT NULL DEFAULT '0',
  `name` varchar(100) NOT NULL DEFAULT '0',
  `characterid` varchar(5) NOT NULL DEFAULT '0',
  `time` varchar(100) NOT NULL DEFAULT '0',
  `time_s` varchar(100) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table vorpv2.jail: ~2 rows (approximately)
/*!40000 ALTER TABLE `jail` DISABLE KEYS */;
/*!40000 ALTER TABLE `jail` ENABLE KEYS */;

-- Dumping structure for table vorpv2.loadout
CREATE TABLE IF NOT EXISTS `loadout` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(50) NOT NULL,
  `charidentifier` int(11) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `ammo` varchar(255) NOT NULL DEFAULT '{}',
  `components` varchar(255) NOT NULL DEFAULT '{}',
  `dirtlevel` double DEFAULT 0,
  `mudlevel` double DEFAULT 0,
  `conditionlevel` double DEFAULT 0,
  `rustlevel` double DEFAULT 0,
  `used` tinyint(4) DEFAULT 0,
  `used2` tinyint(4) DEFAULT 0,
  `dropped` int(11) NOT NULL DEFAULT 0,
  `comps` longtext NOT NULL DEFAULT '{}',
  `label` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2280 DEFAULT CHARSET=utf8mb4;

-- Dumping data for table vorpv2.loadout: ~644 rows (approximately)
/*!40000 ALTER TABLE `loadout` DISABLE KEYS */;
/*!40000 ALTER TABLE `loadout` ENABLE KEYS */;

-- Dumping structure for table vorpv2.logs
CREATE TABLE IF NOT EXISTS `logs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `time` timestamp NULL DEFAULT current_timestamp(),
  `user` text DEFAULT NULL,
  `steam` text DEFAULT NULL,
  `ip` text DEFAULT NULL,
  `category` text DEFAULT NULL,
  `action` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table vorpv2.logs: ~0 rows (approximately)
/*!40000 ALTER TABLE `logs` DISABLE KEYS */;
/*!40000 ALTER TABLE `logs` ENABLE KEYS */;

-- Dumping structure for table vorpv2.mail
CREATE TABLE IF NOT EXISTS `mail` (
  `adress` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(50) DEFAULT NULL,
  `charidentifier` int(11) DEFAULT NULL,
  `adressbook` longtext NOT NULL DEFAULT '[]',
  PRIMARY KEY (`adress`)
) ENGINE=InnoDB AUTO_INCREMENT=122 DEFAULT CHARSET=utf8mb4;

-- Dumping data for table vorpv2.mail: ~68 rows (approximately)
/*!40000 ALTER TABLE `mail` DISABLE KEYS */;
/*!40000 ALTER TABLE `mail` ENABLE KEYS */;

-- Dumping structure for table vorpv2.mail_inbox
CREATE TABLE IF NOT EXISTS `mail_inbox` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `adress` int(11) DEFAULT NULL,
  `msgs` longtext DEFAULT NULL,
  `date` longtext DEFAULT NULL,
  `time` longtext DEFAULT NULL,
  `sender` longtext DEFAULT NULL,
  `unred` int(11) DEFAULT 1,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=337 DEFAULT CHARSET=utf8mb4;

-- Dumping data for table vorpv2.mail_inbox: ~115 rows (approximately)
/*!40000 ALTER TABLE `mail_inbox` DISABLE KEYS */;
/*!40000 ALTER TABLE `mail_inbox` ENABLE KEYS */;

-- Dumping structure for table vorpv2.market
CREATE TABLE IF NOT EXISTS `market` (
  `charidentifier` int(11) NOT NULL DEFAULT 0,
  `listing` longtext DEFAULT '[]',
  `invid` int(11) DEFAULT 0,
  `invslots` int(11) DEFAULT 0,
  PRIMARY KEY (`charidentifier`) USING BTREE,
  KEY `charid` (`charidentifier`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Dumping data for table vorpv2.market: ~6 rows (approximately)
/*!40000 ALTER TABLE `market` DISABLE KEYS */;
/*!40000 ALTER TABLE `market` ENABLE KEYS */;

-- Dumping structure for table vorpv2.newspaper
CREATE TABLE IF NOT EXISTS `newspaper` (
  `news` longtext DEFAULT '[]'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Dumping data for table vorpv2.newspaper: ~0 rows (approximately)
/*!40000 ALTER TABLE `newspaper` DISABLE KEYS */;
INSERT INTO `newspaper` (`news`) VALUES
	('[]');
/*!40000 ALTER TABLE `newspaper` ENABLE KEYS */;

-- Dumping structure for table vorpv2.outfits
CREATE TABLE IF NOT EXISTS `outfits` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(45) NOT NULL,
  `charidentifier` int(11) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `comps` longtext DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=840 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- Dumping data for table vorpv2.outfits: ~409 rows (approximately)
/*!40000 ALTER TABLE `outfits` DISABLE KEYS */;
/*!40000 ALTER TABLE `outfits` ENABLE KEYS */;

-- Dumping structure for table vorpv2.outfitter
CREATE TABLE IF NOT EXISTS `outfitter` (
  `identifier` varchar(50) DEFAULT NULL,
  `charidentifier` int(11) DEFAULT NULL,
  `props` longtext DEFAULT '[]'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Dumping data for table vorpv2.outfitter: ~8 rows (approximately)
/*!40000 ALTER TABLE `outfitter` DISABLE KEYS */;
/*!40000 ALTER TABLE `outfitter` ENABLE KEYS */;

-- Dumping structure for table vorpv2.playerhousing
CREATE TABLE IF NOT EXISTS `playerhousing` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` int(11) NOT NULL DEFAULT 0,
  `primarydoor` longtext NOT NULL DEFAULT '[]',
  `otherdoors` longtext NOT NULL DEFAULT '[]',
  `range` int(11) DEFAULT 0,
  `owned` int(11) DEFAULT 0,
  `selleridentifier` varchar(50) NOT NULL DEFAULT '',
  `sellercharidentifier` int(11) NOT NULL DEFAULT 0,
  `ledger` double NOT NULL DEFAULT 0,
  `tax` int(11) NOT NULL DEFAULT 0,
  `repoed` int(11) NOT NULL DEFAULT 0,
  `invspace` int(11) NOT NULL DEFAULT 0,
  `upgrade` int(11) NOT NULL DEFAULT 0,
  `keyholders` longtext NOT NULL DEFAULT '[]',
  `changingroom` longtext NOT NULL DEFAULT '[]',
  `inventorylocation` longtext NOT NULL DEFAULT '[]',
  `items` longtext NOT NULL DEFAULT '[]',
  `furniture` longtext NOT NULL DEFAULT '[]',
  `price` int(11) NOT NULL DEFAULT 0,
  `buyeridentifier` varchar(50) NOT NULL DEFAULT '0',
  `buyercharidentifier` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `id` (`id`),
  KEY `primarydoor` (`primarydoor`(768))
) ENGINE=InnoDB AUTO_INCREMENT=234 DEFAULT CHARSET=utf8mb4;

-- Dumping data for table vorpv2.playerhousing: ~42 rows (approximately)
/*!40000 ALTER TABLE `playerhousing` DISABLE KEYS */;
/*!40000 ALTER TABLE `playerhousing` ENABLE KEYS */;

-- Dumping structure for table vorpv2.playerhousing_sold_home_ledger
CREATE TABLE IF NOT EXISTS `playerhousing_sold_home_ledger` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(50) DEFAULT NULL,
  `charidentifier` int(11) DEFAULT NULL,
  `amount` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=182 DEFAULT CHARSET=utf8mb4;

-- Dumping data for table vorpv2.playerhousing_sold_home_ledger: ~3 rows (approximately)
/*!40000 ALTER TABLE `playerhousing_sold_home_ledger` DISABLE KEYS */;
/*!40000 ALTER TABLE `playerhousing_sold_home_ledger` ENABLE KEYS */;

-- Dumping structure for table vorpv2.playerscenes
CREATE TABLE IF NOT EXISTS `playerscenes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `coords` longtext DEFAULT '{}',
  `text` longtext DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=137 DEFAULT CHARSET=utf8mb4;

-- Dumping data for table vorpv2.playerscenes: ~5 rows (approximately)
/*!40000 ALTER TABLE `playerscenes` DISABLE KEYS */;
/*!40000 ALTER TABLE `playerscenes` ENABLE KEYS */;

-- Dumping structure for table vorpv2.playershops
CREATE TABLE IF NOT EXISTS `playershops` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(50) NOT NULL DEFAULT '0',
  `charidentifier` int(11) NOT NULL DEFAULT 0,
  `items` longtext NOT NULL DEFAULT '[]',
  `weapons` longtext NOT NULL DEFAULT '[]',
  `price` float NOT NULL DEFAULT 0,
  `name` varchar(50) NOT NULL DEFAULT '',
  `slots` int(11) NOT NULL DEFAULT 0,
  `coords` longtext NOT NULL DEFAULT '[]',
  `owned` int(11) DEFAULT 0,
  `blip` int(11) DEFAULT 1,
  `ledger` float DEFAULT 0,
  `level` int(255) DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `items` (`items`(768)),
  KEY `weapons` (`weapons`(768))
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4;

-- Dumping data for table vorpv2.playershops: ~0 rows (approximately)
/*!40000 ALTER TABLE `playershops` DISABLE KEYS */;
/*!40000 ALTER TABLE `playershops` ENABLE KEYS */;

-- Dumping structure for table vorpv2.player_ranch
CREATE TABLE IF NOT EXISTS `player_ranch` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(50) DEFAULT NULL,
  `charidentifier` int(11) DEFAULT NULL,
  `name` longtext DEFAULT NULL,
  `price` float DEFAULT NULL,
  `coords` longtext DEFAULT '[]',
  `owned` int(11) DEFAULT 0,
  `herdtrail` longtext DEFAULT '[]',
  `cattle` longtext DEFAULT '[]',
  `q_cattle` longtext DEFAULT '[]',
  `dist` int(11) DEFAULT NULL,
  `chores` longtext DEFAULT '[]',
  `cows` longtext DEFAULT '[]',
  `chickens` longtext DEFAULT '[]',
  `milk` int(11) DEFAULT 0,
  `eggs` int(11) DEFAULT 0,
  `ledger` float DEFAULT 0,
  `dog` varchar(50) DEFAULT '0',
  `q_ranch` int(11) DEFAULT 0,
  `repoed` int(11) DEFAULT 0,
  `herding` int(11) DEFAULT 0,
  `selling` int(11) DEFAULT 0,
  `milking` int(11) DEFAULT 0,
  `checking` int(11) DEFAULT 0,
  `tax` int(11) DEFAULT 0,
  `hired` longtext DEFAULT '[]',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8mb4;

-- Dumping data for table vorpv2.player_ranch: ~4 rows (approximately)
/*!40000 ALTER TABLE `player_ranch` DISABLE KEYS */;
/*!40000 ALTER TABLE `player_ranch` ENABLE KEYS */;

-- Dumping structure for table vorpv2.player_trains
CREATE TABLE IF NOT EXISTS `player_trains` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL DEFAULT '0',
  `contid` int(11) DEFAULT NULL,
  `maint` float DEFAULT 100,
  `coal` int(11) DEFAULT 0,
  `coalcap` int(11) DEFAULT NULL,
  `speed` float DEFAULT NULL,
  `hash` varchar(50) DEFAULT NULL,
  `company` varchar(50) DEFAULT NULL,
  `coalcon` int(11) DEFAULT NULL,
  `img` varchar(50) DEFAULT NULL,
  `coalup` int(11) DEFAULT 0,
  `speedup` int(11) DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4;

-- Dumping data for table vorpv2.player_trains: ~0 rows (approximately)
/*!40000 ALTER TABLE `player_trains` DISABLE KEYS */;
/*!40000 ALTER TABLE `player_trains` ENABLE KEYS */;

-- Dumping structure for table vorpv2.posters
CREATE TABLE IF NOT EXISTS `posters` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) DEFAULT NULL,
  `poster_link` varchar(255) DEFAULT NULL,
  `city` varchar(255) DEFAULT '',
  `charidentifier` varchar(255) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=45 DEFAULT CHARSET=utf8mb4;

-- Dumping data for table vorpv2.posters: ~28 rows (approximately)
/*!40000 ALTER TABLE `posters` DISABLE KEYS */;
/*!40000 ALTER TABLE `posters` ENABLE KEYS */;

-- Dumping structure for table vorpv2.races
CREATE TABLE IF NOT EXISTS `races` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(50) DEFAULT NULL,
  `charidentifier` int(11) DEFAULT NULL,
  `name` varchar(50) NOT NULL DEFAULT '[]',
  `loc` longtext DEFAULT '[]',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8mb4;

-- Dumping data for table vorpv2.races: ~0 rows (approximately)
/*!40000 ALTER TABLE `races` DISABLE KEYS */;
/*!40000 ALTER TABLE `races` ENABLE KEYS */;

-- Dumping structure for table vorpv2.robbery
CREATE TABLE IF NOT EXISTS `robbery` (
  `name_robbery` varchar(50) COLLATE latin1_general_cs DEFAULT '0',
  `time_robbery` datetime DEFAULT NULL ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_cs;

-- Dumping data for table vorpv2.robbery: ~0 rows (approximately)
/*!40000 ALTER TABLE `robbery` DISABLE KEYS */;
/*!40000 ALTER TABLE `robbery` ENABLE KEYS */;

-- Dumping structure for table vorpv2.rooms
CREATE TABLE IF NOT EXISTS `rooms` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `interiorId` int(11) NOT NULL,
  `inventory` longtext DEFAULT NULL,
  `identifier` varchar(60) NOT NULL,
  `charidentifier` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- Dumping data for table vorpv2.rooms: ~0 rows (approximately)
/*!40000 ALTER TABLE `rooms` DISABLE KEYS */;
/*!40000 ALTER TABLE `rooms` ENABLE KEYS */;

-- Dumping structure for table vorpv2.society
CREATE TABLE IF NOT EXISTS `society` (
  `job` longtext DEFAULT NULL,
  `jobgrade` int(11) DEFAULT NULL,
  `salary` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Dumping data for table vorpv2.society: ~81 rows (approximately)
/*!40000 ALTER TABLE `society` DISABLE KEYS */;
INSERT INTO `society` (`job`, `jobgrade`, `salary`) VALUES
	('police', 0, 10),
	('police', 1, 18),
	('police', 2, 18),
	('police', 3, 18),
	('police', 4, 18),
	('police', 5, 18),
	('police', 6, 18),
	('miner', 1, 0),
	('miner', 2, 0),
	('miner', 3, 0),
	('miner', 4, 0),
	('miner', 0, 0),
	('doctor', 0, 1),
	('doctor', 1, 1),
	('doctor', 2, 1),
	('doctor', 3, 1),
	('horsetrainer', 0, 0),
	('horsetrainer', 1, 0),
	('horsetrainer', 2, 0),
	('horsetrainer', 3, 0),
	('horsetrainer', 4, 0),
	('realestate', 0, 0),
	('realestate', 1, 0),
	('realestate', 2, 0),
	('bastille', 0, 0),
	('bastille', 1, 0),
	('bastille', 2, 0),
	('bastille', 3, 0),
	('bastille', 4, 0),
	('bastille', 5, 0),
	('rguns', 2, 0),
	('sgs', 1, 0),
	('sgs', 2, 0),
	('sgs', 3, 0),
	('sgs', 4, 0),
	('sgs', 5, 0),
	('sgs', 0, 0),
	('rguns', 0, 0),
	('rguns', 1, 0),
	('rguns', 3, 0),
	('rguns', 4, 0),
	('rguns', 5, 0),
	('shaman', 0, 0),
	('shaman', 1, 0),
	('shaman', 2, 0),
	('shaman', 3, 0),
	('marshal', 0, 0),
	('marshal', 1, 0),
	('marshal', 2, 0),
	('marshal', 3, 10),
	('valtrain', 0, 0),
	('valtrain', 1, 0),
	('valtrain', 2, 0),
	('valtrain', 3, 0),
	('bountyhunter', 0, 0),
	('bountyhunter', 1, 0),
	('bountyhunter', 2, 0),
	('bountyhunter', 3, 0),
	('blacksmith', 0, 0),
	('blacksmith', 1, 0),
	('gunsmith', 0, 0),
	('gunsmith', 1, 0),
	('gunsmith', 2, 0),
	('gunsmith', 4, 0),
	('gunsmith', 3, 0),
	('gunsmith', 5, 0),
	('gunsmith', 6, 0),
	('gunsmith', 7, 0),
	('blacksmith', 2, 0),
	('miner', 0, 0),
	('miner', 1, 0),
	('miner', 2, 0),
	('silvershot', 0, 0),
	('silvershot', 1, 0),
	('silvershot', 2, 0),
	('bvs', 0, 0),
	('bvs', 1, 0),
	('bvs', 2, 0),
	('ksd', 0, 0),
	('ksd', 1, 0),
	('ksd', 2, 0);
/*!40000 ALTER TABLE `society` ENABLE KEYS */;

-- Dumping structure for table vorpv2.society_ledger
CREATE TABLE IF NOT EXISTS `society_ledger` (
  `job` longtext DEFAULT NULL,
  `ledger` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Dumping data for table vorpv2.society_ledger: ~18 rows (approximately)
/*!40000 ALTER TABLE `society_ledger` DISABLE KEYS */;
INSERT INTO `society_ledger` (`job`, `ledger`) VALUES
	('police', 0),
	('miner', 0),
	('doctor', 0),
	('horsetrainer', 0),
	('realestate', 0),
	('bastille', 0),
	('sgs', 0),
	('rguns', 0),
	('shaman', 0),
	('marshal', 0),
	('valtrain', 0),
	('bountyhunter', 0),
	('gunsmith', 0),
	('blacksmith', 0),
	('miner', 0),
	('silvershot', 0),
	('bvs', 0),
	('ksd', 0);
/*!40000 ALTER TABLE `society_ledger` ENABLE KEYS */;

-- Dumping structure for table vorpv2.society_shops
CREATE TABLE IF NOT EXISTS `society_shops` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `society` varchar(50) NOT NULL DEFAULT '0',
  `items` longtext NOT NULL DEFAULT '[]',
  `weapons` longtext NOT NULL DEFAULT '[]',
  `slots` int(11) NOT NULL DEFAULT 50,
  `level` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `id` (`id`),
  KEY `society` (`society`),
  KEY `items` (`items`(768)),
  KEY `slots` (`slots`),
  KEY `weapons` (`weapons`(768))
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4;

-- Dumping data for table vorpv2.society_shops: ~12 rows (approximately)
/*!40000 ALTER TABLE `society_shops` DISABLE KEYS */;
INSERT INTO `society_shops` (`id`, `society`, `items`, `weapons`, `slots`, `level`) VALUES
	(1, 'bastille', '[]', '[]', 50, 0),
	(2, 'sgs', '[]', '[]', 50, 0),
	(3, 'rguns', '[]', '[]', 50, 0),
	(4, 'shaman', '[]', '[]', 50, 0),
	(5, 'bountyhunter', '[]', '[]', 50, 0),
	(6, 'gunsmith', '[]', '[]', 50, 0),
	(7, 'blacksmith', '[]', '[]', 50, 0),
	(8, 'miner', '[]', '[]', 50, 0),
	(9, 'horsetrainer', '[]', '[]', 50, 0),
	(10, 'silvershot', '[]', '[]', 50, 0),
	(11, 'bvs', '[]', '[]', 50, 0),
	(12, 'ksd', '[]', '[]', 50, 0);
/*!40000 ALTER TABLE `society_shops` ENABLE KEYS */;

-- Dumping structure for table vorpv2.transactions
CREATE TABLE IF NOT EXISTS `transactions` (
  `bank` varchar(50) DEFAULT NULL,
  `fromIdentifier` varchar(50) DEFAULT NULL,
  `fromcharid` int(11) DEFAULT NULL,
  `toIdentifier` varchar(50) DEFAULT NULL,
  `tocharid` int(11) DEFAULT NULL,
  `date` date DEFAULT NULL,
  `money` double(22,2) DEFAULT 0.00,
  `gold` double(22,2) DEFAULT 0.00,
  `reason` varchar(100) DEFAULT NULL,
  `bankto` varchar(50) DEFAULT NULL,
  KEY `FK_transactions_banks` (`bank`),
  KEY `FK_transactions_banks_2` (`bankto`),
  CONSTRAINT `FK_transactions_banks` FOREIGN KEY (`bank`) REFERENCES `banks` (`name`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_transactions_banks_2` FOREIGN KEY (`bankto`) REFERENCES `banks` (`name`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Dumping data for table vorpv2.transactions: ~0 rows (approximately)
/*!40000 ALTER TABLE `transactions` DISABLE KEYS */;
/*!40000 ALTER TABLE `transactions` ENABLE KEYS */;

-- Dumping structure for table vorpv2.users
CREATE TABLE IF NOT EXISTS `users` (
  `identifier` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `group` varchar(50) DEFAULT 'user',
  `warnings` int(11) DEFAULT 0,
  `banned` boolean,
  `banneduntil` int(10) DEFAULT 0,
  `char` varchar(50) NOT NULL DEFAULT 'false',
  PRIMARY KEY (`identifier`),
  UNIQUE KEY `identifier` (`identifier`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
-- Dumping data for table vorpv2.users: ~0 rows (approximately)
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
/*!40000 ALTER TABLE `users` ENABLE KEYS */;

-- Dumping structure for table vorpv2.wagons
CREATE TABLE IF NOT EXISTS `wagons` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(40) NOT NULL,
  `charid` int(11) NOT NULL,
  `selected` int(11) NOT NULL DEFAULT 0,
  `model` varchar(50) NOT NULL,
  `name` varchar(50) NOT NULL,
  `items` longtext DEFAULT '{}',
  PRIMARY KEY (`id`),
  KEY `FK_horses_characters` (`charid`),
  KEY `model` (`model`)
) ENGINE=InnoDB AUTO_INCREMENT=116 DEFAULT CHARSET=utf8mb4;

-- Dumping data for table vorpv2.wagons: ~0 rows (approximately)
/*!40000 ALTER TABLE `wagons` DISABLE KEYS */;
/*!40000 ALTER TABLE `wagons` ENABLE KEYS */;

-- Dumping structure for table vorpv2.wagon_water
CREATE TABLE IF NOT EXISTS `wagon_water` (
  `identifier` varchar(255) COLLATE latin1_general_cs DEFAULT '0',
  `charid` varchar(255) COLLATE latin1_general_cs DEFAULT '0',
  `wagon` varchar(255) COLLATE latin1_general_cs DEFAULT '0',
  `water` varchar(255) COLLATE latin1_general_cs DEFAULT '0',
  `wagon_name` varchar(50) COLLATE latin1_general_cs DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_cs;

-- Dumping data for table vorpv2.wagon_water: ~0 rows (approximately)
/*!40000 ALTER TABLE `wagon_water` DISABLE KEYS */;
/*!40000 ALTER TABLE `wagon_water` ENABLE KEYS */;

-- Dumping structure for table vorpv2.whitelist
CREATE TABLE IF NOT EXISTS `whitelist` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `status` boolean,
  `firstconnection` boolean DEFAULT TRUE,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `identifier` (`identifier`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- Dumping data for table vorpv2.whitelist: ~0 rows (approximately)
/*!40000 ALTER TABLE `whitelist` DISABLE KEYS */;
/*!40000 ALTER TABLE `whitelist` ENABLE KEYS */;




/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;




DROP TABLE IF EXISTS `stables`;
CREATE TABLE `stables`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `charidentifier` int(11) NOT NULL,
  `name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `modelname` varchar(70) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `type` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `status` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  `xp` int(11) NULL DEFAULT 0,
  `injured` int(11) NULL DEFAULT 0,
  `gear` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  `isDefault` int(11) NOT NULL DEFAULT 0,
  `inventory` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

DROP TABLE IF EXISTS `horse_complements`;
CREATE TABLE `horse_complements`  (
  `identifier` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `charidentifier` int(11) NOT NULL,
  `complements` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  UNIQUE INDEX `identifier`(`identifier`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;
