ALTER TABLE `loadout` ADD COLUMN `dropped` INT(11) NOT NULL DEFAULT 0;
ALTER TABLE `loadout` ADD COLUMN `comps` LONGTEXT NOT NULL DEFAULT '{}';
ALTER TABLE `loadout` ADD COLUMN `used2` tinyint(4) NOT NULL DEFAULT 0;

INSERT INTO `items`(`item`, `label`, `limit`, `can_remove`, `type`, `usable`) VALUES ('ammorepeaterexplosive', 'Repeater Ammo Explosive', 10, 1, 'item_standard', 1);
INSERT INTO `items`(`item`, `label`, `limit`, `can_remove`, `type`, `usable`) VALUES ('ammorepeaterexpress', 'Repeater Ammo Express', 10, 1, 'item_standard', 1);
INSERT INTO `items`(`item`, `label`, `limit`, `can_remove`, `type`, `usable`) VALUES ('ammorepeaternormal', 'Repeater Ammo Normal', 10, 1, 'item_standard', 1);
INSERT INTO `items`(`item`, `label`, `limit`, `can_remove`, `type`, `usable`) VALUES ('ammorepeatervelocity', 'Repeater Ammo Velocity', 10, 1, 'item_standard', 1);
INSERT INTO `items`(`item`, `label`, `limit`, `can_remove`, `type`, `usable`) VALUES ('ammorepeatersplitpoint', 'Repeater Ammo Splitpoint', 10, 1, 'item_standard', 1);


INSERT INTO `items`(`item`, `label`, `limit`, `can_remove`, `type`, `usable`) VALUES ('ammorevolverexplosive', 'Revolver Ammo Explosive', 10, 1, 'item_standard', 1);
INSERT INTO `items`(`item`, `label`, `limit`, `can_remove`, `type`, `usable`) VALUES ('ammorevolverexpress', 'Revolver Ammo Express', 10, 1, 'item_standard', 1);
INSERT INTO `items`(`item`, `label`, `limit`, `can_remove`, `type`, `usable`) VALUES ('ammorevolvernormal', 'Revolver Ammo Normal', 10, 1, 'item_standard', 1);
INSERT INTO `items`(`item`, `label`, `limit`, `can_remove`, `type`, `usable`) VALUES ('ammorevolvervelocity', 'Revolver Ammo Velocity', 10, 1, 'item_standard', 1);
INSERT INTO `items`(`item`, `label`, `limit`, `can_remove`, `type`, `usable`) VALUES ('ammorevolversplitpoint', 'Revolver Ammo Splitpoint', 10, 1, 'item_standard', 1);

INSERT INTO `items`(`item`, `label`, `limit`, `can_remove`, `type`, `usable`) VALUES ('ammorifleexplosive', 'Rifle Ammo Explosive', 10, 1, 'item_standard', 1);
INSERT INTO `items`(`item`, `label`, `limit`, `can_remove`, `type`, `usable`) VALUES ('ammorifleexpress', 'Rifle Ammo Express', 10, 1, 'item_standard', 1);
INSERT INTO `items`(`item`, `label`, `limit`, `can_remove`, `type`, `usable`) VALUES ('ammoriflenormal', 'Rifle Ammo Normal', 10, 1, 'item_standard', 1);
INSERT INTO `items`(`item`, `label`, `limit`, `can_remove`, `type`, `usable`) VALUES ('ammoriflevelocity', 'Rifle Ammo Velocity', 10, 1, 'item_standard', 1);
INSERT INTO `items`(`item`, `label`, `limit`, `can_remove`, `type`, `usable`) VALUES ('ammoriflesplitpoint', 'Rifle Ammo Splitpoint', 10, 1, 'item_standard', 1);
INSERT INTO `items`(`item`, `label`, `limit`, `can_remove`, `type`, `usable`) VALUES ('ammoelephant', 'Elephant Rifle Ammo', 10, 1, 'item_standard', 1);

INSERT INTO `items`(`item`, `label`, `limit`, `can_remove`, `type`, `usable`) VALUES ('ammoshotgunincendiary', 'Shotgun Ammo Incendiary', 10, 1, 'item_standard', 1);
INSERT INTO `items`(`item`, `label`, `limit`, `can_remove`, `type`, `usable`) VALUES ('ammoshotgunexplosive', 'Shotgun Ammo Explosive', 10, 1, 'item_standard', 1);
INSERT INTO `items`(`item`, `label`, `limit`, `can_remove`, `type`, `usable`) VALUES ('ammoshotgunnormal', 'Shotgun Ammo Normal', 10, 1, 'item_standard', 1);
INSERT INTO `items`(`item`, `label`, `limit`, `can_remove`, `type`, `usable`) VALUES ('ammoshotgunslug', 'Shotgun Ammo Slug', 10, 1, 'item_standard', 1);

INSERT INTO `items`(`item`, `label`, `limit`, `can_remove`, `type`, `usable`) VALUES ('ammopistolexplosive', 'Pistol Ammo Explosive', 10, 1, 'item_standard', 1);
INSERT INTO `items`(`item`, `label`, `limit`, `can_remove`, `type`, `usable`) VALUES ('ammopistolexpress', 'Pistol Ammo Express', 10, 1, 'item_standard', 1);
INSERT INTO `items`(`item`, `label`, `limit`, `can_remove`, `type`, `usable`) VALUES ('ammopistolnormal', 'Pistol Ammo Normal', 10, 1, 'item_standard', 1);
INSERT INTO `items`(`item`, `label`, `limit`, `can_remove`, `type`, `usable`) VALUES ('ammopistolvelocity', 'Pistol Ammo Velocity', 10, 1, 'item_standard', 1);
INSERT INTO `items`(`item`, `label`, `limit`, `can_remove`, `type`, `usable`) VALUES ('ammopistolsplitpoint', 'Pistol Ammo Splitpoint', 10, 1, 'item_standard', 1);

INSERT INTO `items`(`item`, `label`, `limit`, `can_remove`, `type`, `usable`) VALUES ('ammoarrowdynamite', 'Arrow Dynamite', 10, 1, 'item_standard', 1);
INSERT INTO `items`(`item`, `label`, `limit`, `can_remove`, `type`, `usable`) VALUES ('ammoarrowfire', 'Arrow Fire', 10, 1, 'item_standard', 1);
INSERT INTO `items`(`item`, `label`, `limit`, `can_remove`, `type`, `usable`) VALUES ('ammoarrownormal', 'Arrow Normal', 10, 1, 'item_standard', 1);
INSERT INTO `items`(`item`, `label`, `limit`, `can_remove`, `type`, `usable`) VALUES ('ammoarrowimproved', 'Arrow Improved', 10, 1, 'item_standard', 1);
INSERT INTO `items`(`item`, `label`, `limit`, `can_remove`, `type`, `usable`) VALUES ('ammoarrowsmallgame', 'Arrow Small Game', 10, 1, 'item_standard', 1);
INSERT INTO `items`(`item`, `label`, `limit`, `can_remove`, `type`, `usable`) VALUES ('ammoarrowpoison', 'Arrow Poison', 10, 1, 'item_standard', 1);

INSERT INTO `items`(`item`, `label`, `limit`, `can_remove`, `type`, `usable`) VALUES ('ammovarmint', 'Varmint Ammo', 10, 1, 'item_standard', 1);
INSERT INTO `items`(`item`, `label`, `limit`, `can_remove`, `type`, `usable`) VALUES ('ammovarminttranq', 'Varmint Tranquilizer Ammo', 10, 1, 'item_standard', 1);

INSERT INTO `items`(`item`, `label`, `limit`, `can_remove`, `type`, `usable`) VALUES ('ammoknives', 'Knives Ammo', 10, 1, 'item_standard', 1);
INSERT INTO `items`(`item`, `label`, `limit`, `can_remove`, `type`, `usable`) VALUES ('ammotomahawk', 'Tonmahawk Ammo', 10, 1, 'item_standard', 1);
INSERT INTO `items`(`item`, `label`, `limit`, `can_remove`, `type`, `usable`) VALUES ('ammopoisonbottle', 'Poison Bottle Ammo', 10, 1, 'item_standard', 1);
INSERT INTO `items`(`item`, `label`, `limit`, `can_remove`, `type`, `usable`) VALUES ('ammobolla', 'Bolla Ammo', 10, 1, 'item_standard', 1);

INSERT INTO `items`(`item`, `label`, `limit`, `can_remove`, `type`, `usable`) VALUES ('ammodynamite', 'Dynamite Ammo', 10, 1, 'item_standard', 1);
INSERT INTO `items`(`item`, `label`, `limit`, `can_remove`, `type`, `usable`) VALUES ('ammovoldynamite', 'Volatile Dynamite Ammo', 10, 1, 'item_standard', 1);
INSERT INTO `items`(`item`, `label`, `limit`, `can_remove`, `type`, `usable`) VALUES ('ammomolotov', 'Molotov Ammo', 10, 1, 'item_standard', 1);
INSERT INTO `items`(`item`, `label`, `limit`, `can_remove`, `type`, `usable`) VALUES ('ammovolmolotov', 'Volatile Molotov Ammo', 10, 1, 'item_standard', 1);
