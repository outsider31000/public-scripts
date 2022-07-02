
ALTER TABLE `characters` ADD COLUMN `ammo` longtext DEFAULT '{}';
ALTER TABLE `characters` ADD INDEX `ammo` (`ammo`);