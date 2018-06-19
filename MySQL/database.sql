SET TIME_ZONE = "+00:00";

SET sql_mode = 'STRICT_TRANS_TABLES';

DROP TABLE IF EXISTS `accounts`;
CREATE TABLE `accounts`
(
	`id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
	`name` VARCHAR(24) NOT NULL COLLATE 'utf8_unicode_ci',
	`password` VARCHAR(50) NOT NULL COLLATE 'ascii_general_ci',
	`email` VARCHAR(255) NOT NULL DEFAULT '' COLLATE 'utf8_unicode_ci',
	`ip` VARCHAR(40) NOT NULL DEFAULT '0.0.0.0' COLLATE 'ascii_general_ci',
	`registration_ip` VARCHAR(40) NOT NULL DEFAULT '0.0.0.0' COLLATE 'ascii_general_ci',
	`registered_date` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	`lastlogin_date` TIMESTAMP NOT NULL DEFAULT '0000-00-00 00:00:00',
	`score` INT(10) NOT NULL DEFAULT '0',
	`money` INT(10) NOT NULL DEFAULT '0',
	`administrator_rank` TINYINT(1) UNSIGNED NOT NULL DEFAULT '0',
	`developer_rank` TINYINT(1) UNSIGNED NOT NULL DEFAULT '0',
	`helper_rank` TINYINT(1) UNSIGNED NOT NULL DEFAULT '0',
	`vip_rank` TINYINT(1) UNSIGNED NOT NULL DEFAULT '0',
	`vip_start_date` INT(10) UNSIGNED NOT NULL DEFAULT '0',
	`vip_end_date` INT(10) UNSIGNED NOT NULL DEFAULT '0',
	`has_tag` TINYINT(1) UNSIGNED NOT NULL DEFAULT '0',
	`custom_skinid` SMALLINT(3) NOT NULL DEFAULT '-1',
	`fightingstyle_id` TINYINT(2) UNSIGNED NOT NULL DEFAULT '4',
	`weapon_skill` SMALLINT(3) UNSIGNED NOT NULL DEFAULT '1',
	`imprison_time` INT(10) UNSIGNED NOT NULL DEFAULT '0',
	`imprison_reason` VARCHAR(64) NOT NULL DEFAULT '' COLLATE 'utf8_unicode_ci',
	`imprisoned_by` VARCHAR(24) NOT NULL DEFAULT '' COLLATE 'utf8_unicode_ci',
	`mute_time` INT(6) UNSIGNED NOT NULL DEFAULT '0',
	`staff_notes` VARCHAR(64) NOT NULL DEFAULT '' COLLATE 'utf8_unicode_ci',
	`offline_pm` VARCHAR(128) NOT NULL DEFAULT '' COLLATE 'utf8_unicode_ci',
	`kills` INT(10) UNSIGNED NOT NULL DEFAULT '0',
	`killing_spree` INT(10) UNSIGNED NOT NULL DEFAULT '0',
	`deaths` INT(10) UNSIGNED NOT NULL DEFAULT '0',
	`headshot_kills` INT(10) UNSIGNED NOT NULL DEFAULT '0',
	`arena_wins` INT(10) UNSIGNED NOT NULL DEFAULT '0',
	`captured_zones` INT(10) UNSIGNED NOT NULL DEFAULT '0',
	`captured_prototypes` INT(10) UNSIGNED NOT NULL DEFAULT '0',
	`arena_loses` INT(10) UNSIGNED NOT NULL DEFAULT '0',
	`played_hours` BIGINT(20) UNSIGNED NOT NULL DEFAULT '0',
	`total_donates` TINYINT(3) UNSIGNED NOT NULL DEFAULT '0',
	`staff_warnings` TINYINT(1) UNSIGNED NOT NULL DEFAULT '0',
	`total_bans` TINYINT(2) UNSIGNED NOT NULL DEFAULT '0',
	`total_kicks` TINYINT(2) UNSIGNED NOT NULL DEFAULT '0',
	`total_warnings` TINYINT(2) UNSIGNED NOT NULL DEFAULT '0',
	`imprison_records` TINYINT(2) UNSIGNED NOT NULL DEFAULT '0',
	`total_banned_players` INT(10) UNSIGNED NOT NULL DEFAULT '0',
	`total_kicked_players` INT(10) UNSIGNED NOT NULL DEFAULT '0',
	`total_warned_players` INT(10) UNSIGNED NOT NULL DEFAULT '0',
	`total_imprisoned_players` INT(10) UNSIGNED NOT NULL DEFAULT '0',
	PRIMARY KEY (`id`),
	UNIQUE INDEX `unique_keys` (`name`)
) ENGINE = 'InnoDB' ROW_FORMAT = DEFAULT AUTO_INCREMENT = 0 DEFAULT CHARACTER SET = 'utf8' COLLATE = 'utf8_unicode_ci';

DROP TABLE IF EXISTS `closed_accounts`;
CREATE TABLE `closed_accounts`
(
	`account_id` INT(10) UNSIGNED NOT NULL,
	`close_type` TINYINT(1) UNSIGNED NOT NULL DEFAULT '0',
	`reason` VARCHAR(64) NOT NULL COLLATE 'utf8_unicode_ci',
	`is_permanently` TINYINT(1) UNSIGNED NOT NULL DEFAULT '0',
	`closed_date` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	`ip` VARCHAR(40) NOT NULL DEFAULT '0.0.0.0' COLLATE 'ascii_general_ci',
	`by_account_id` INT(10) UNSIGNED NOT NULL,
	PRIMARY KEY (`account_id`),
	UNIQUE INDEX `unique_keys` (`account_id`),
	CONSTRAINT `FK_closed_accounts_accounts` FOREIGN KEY (`account_id`) REFERENCES `accounts` (`id`) ON UPDATE NO ACTION ON DELETE CASCADE
) ENGINE = 'InnoDB' ROW_FORMAT = DEFAULT AUTO_INCREMENT = 0 DEFAULT CHARACTER SET = 'utf8' COLLATE = 'utf8_unicode_ci';
