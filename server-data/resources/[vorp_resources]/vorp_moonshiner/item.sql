USE `vorp`;

INSERT INTO `items` (`item`, `label`, `limit`, `can_remove`, `type`, `usable`) VALUES
                    ('soborno', 'Soborno Alcohol', 15, 1, 'item_standard', 0),
                    ('water', 'Wasser', 15, 1, 'item_standard', 1),
	                ('pear', 'Birne', 15, 1, 'item_standard', 1),
                    ('currant', 'Johannisbeere', 20, 1, 'item_standard', 0),
                    ('apple', 'Apfel', 20, 1, 'item_standard', 1),
                    ('blackberry', 'Heidelbeere', 20, 1, 'item_standard', 0),
                    ('tropicalPunchMash', 'Tropical Punch Meische', 10, 1, 'item_standard', 0),
                    ('wildCiderMash', 'Wild Cider Meische', 10, 1, 'item_standard', 0),
                    ('appleCrumbMash', 'Apfel Beeren Meische', 10, 1, 'item_standard', 0),
                    ('tropicalPunchMoonshine', 'Tropical Punch Moonshine', 10, 1, 'item_standard', 0),
                    ('wildCiderMoonshine', 'Wild Cider Moonshine', 10, 1, 'item_standard', 0),
                    ('appleCrumbMoonshine', 'Apfel Beeren Moonshine', 10, 1, 'item_standard', 0),
                    ('mp001_p_mp_still02x', 'Brennerei', 1, 1, 'item_standard', 1),
                    ('p_barrelmoonshine', 'Meische Fass', 1, 1, 'item_standard', 1),
	                ('vanillaFlower', 'Vanille Blume', 20, 1, 'item_standard', 0);

-- IF YOU USED THE FIRST VERSION OF THIS SCRIPT, THEN UPDATE YOURE DB WITH THE FOLLOWING LINES!!!
UPDATE `items`
SET `limit` = 15, `usable` = 0
WHERE `item` = 'soborno';

UPDATE `items`
SET `limit` = 15, `usable` = 1
WHERE `item` = 'water';

UPDATE `items`
SET `limit` = 15, `usable` = 1
WHERE `item` = 'pear';

UPDATE `items`
SET `limit` = 20, `usable` = 0
WHERE `item` = 'currant';

UPDATE `items`
SET `limit` = 20, `usable` = 1
WHERE `item` = 'apple';

UPDATE `items`
SET `limit` = 20, `usable` = 0
WHERE `item` = 'blackberry';

UPDATE `items`
SET `limit` = 10, `usable` = 0
WHERE `item` = 'tropicalPunchMash';

UPDATE `items`
SET `limit` = 10, `usable` = 0
WHERE `item` = 'wildCiderMash';

UPDATE `items`
SET `limit` = 10, `usable` = 0
WHERE `item` = 'tropicalPunchMoonshine';

UPDATE `items`
SET `limit` = 10, `usable` = 0
WHERE `item` = 'wildCiderMoonshine';

UPDATE `items`
SET `limit` = 10, `usable` = 0
WHERE `item` = 'appleCrumbMoonshine';

UPDATE `items`
SET `limit` = 1, `usable` = 1
WHERE `item` = 'mp001_p_mp_still02x';

UPDATE `items`
SET `limit` = 1, `usable` = 1
WHERE `item` = 'p_barrelmoonshine';

UPDATE `items`
SET `limit` = 20, `usable` = 0
WHERE `item` = 'blackberry';

UPDATE `items`
SET `limit` = 20, `usable` = 0
WHERE `item` = 'vanillaFlower';