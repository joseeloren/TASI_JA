CREATE USER 'r_ja2'@'localhost' IDENTIFIED BY '12345678';GRANT ALL PRIVILEGES ON *.* TO 'r_ja2'@'localhost' REQUIRE NONE WITH GRANT OPTION MAX_QUERIES_PER_HOUR 0 MAX_CONNECTIONS_PER_HOUR 0 MAX_UPDATES_PER_HOUR 0 MAX_USER_CONNECTIONS 0;CREATE DATABASE IF NOT EXISTS `r_ja2`;GRANT ALL PRIVILEGES ON `r\_ja2`.* TO 'r_ja2'@'localhost';GRANT ALL PRIVILEGES ON `r\_ja2\_%`.* TO 'r_ja2'@'localhost';
