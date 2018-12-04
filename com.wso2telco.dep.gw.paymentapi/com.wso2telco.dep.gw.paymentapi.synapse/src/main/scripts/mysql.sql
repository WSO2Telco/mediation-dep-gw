use proddepdb;

DROP TABLE IF EXISTS persisttansaction;
CREATE TABLE `persisttansaction` (
`consumerKey` varchar(255) NOT NULL,
`msisdn` varchar(255) NOT NULL,
`amount` decimal(40,4) NOT NULL,
`timestamp` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ,
`currency` varchar(3) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;