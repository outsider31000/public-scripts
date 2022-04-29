CREATE TABLE `bank_users` (
  `identifier` varchar(50) CHARACTER SET utf8 COLLATE utf8_czech_ci DEFAULT '0',
  `charidentifier` varchar(5) CHARACTER SET utf8 COLLATE utf8_czech_ci DEFAULT '0',
  `money` varchar(255) CHARACTER SET utf8 COLLATE utf8_czech_ci DEFAULT '0',
  `gold` varchar(255) CHARACTER SET utf8 COLLATE utf8_czech_ci DEFAULT '0',
  `name` varchar(255) COLLATE utf8_czech_ci DEFAULT '0',
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_czech_ci;

