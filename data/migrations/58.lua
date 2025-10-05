function onUpdateDatabase()
	logger.info("Updating database to version 58 (reset system)")
	db.query("ALTER TABLE `players` ADD COLUMN `resets` INT(11) UNSIGNED NOT NULL DEFAULT 0 AFTER `level`;")
end
