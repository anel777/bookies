/*
SQLyog Community v13.0.1 (64 bit)
MySQL - 8.0.33 : Database - library
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`library` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;

USE `library`;

/*Table structure for table `auth_group` */

DROP TABLE IF EXISTS `auth_group`;

CREATE TABLE `auth_group` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(150) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `auth_group` */

/*Table structure for table `auth_group_permissions` */

DROP TABLE IF EXISTS `auth_group_permissions`;

CREATE TABLE `auth_group_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `group_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `auth_group_permissions` */

/*Table structure for table `auth_permission` */

DROP TABLE IF EXISTS `auth_permission`;

CREATE TABLE `auth_permission` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=85 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `auth_permission` */

insert  into `auth_permission`(`id`,`name`,`content_type_id`,`codename`) values 
(1,'Can add log entry',1,'add_logentry'),
(2,'Can change log entry',1,'change_logentry'),
(3,'Can delete log entry',1,'delete_logentry'),
(4,'Can view log entry',1,'view_logentry'),
(5,'Can add permission',2,'add_permission'),
(6,'Can change permission',2,'change_permission'),
(7,'Can delete permission',2,'delete_permission'),
(8,'Can view permission',2,'view_permission'),
(9,'Can add group',3,'add_group'),
(10,'Can change group',3,'change_group'),
(11,'Can delete group',3,'delete_group'),
(12,'Can view group',3,'view_group'),
(13,'Can add user',4,'add_user'),
(14,'Can change user',4,'change_user'),
(15,'Can delete user',4,'delete_user'),
(16,'Can view user',4,'view_user'),
(17,'Can add content type',5,'add_contenttype'),
(18,'Can change content type',5,'change_contenttype'),
(19,'Can delete content type',5,'delete_contenttype'),
(20,'Can view content type',5,'view_contenttype'),
(21,'Can add session',6,'add_session'),
(22,'Can change session',6,'change_session'),
(23,'Can delete session',6,'delete_session'),
(24,'Can view session',6,'view_session'),
(25,'Can add book number table',7,'add_booknumbertable'),
(26,'Can change book number table',7,'change_booknumbertable'),
(27,'Can delete book number table',7,'delete_booknumbertable'),
(28,'Can view book number table',7,'view_booknumbertable'),
(29,'Can add book stall books table',8,'add_bookstallbookstable'),
(30,'Can change book stall books table',8,'change_bookstallbookstable'),
(31,'Can delete book stall books table',8,'delete_bookstallbookstable'),
(32,'Can view book stall books table',8,'view_bookstallbookstable'),
(33,'Can add issue table',9,'add_issuetable'),
(34,'Can change issue table',9,'change_issuetable'),
(35,'Can delete issue table',9,'delete_issuetable'),
(36,'Can view issue table',9,'view_issuetable'),
(37,'Can add library table',10,'add_librarytable'),
(38,'Can change library table',10,'change_librarytable'),
(39,'Can delete library table',10,'delete_librarytable'),
(40,'Can view library table',10,'view_librarytable'),
(41,'Can add libray book table',11,'add_libraybooktable'),
(42,'Can change libray book table',11,'change_libraybooktable'),
(43,'Can delete libray book table',11,'delete_libraybooktable'),
(44,'Can view libray book table',11,'view_libraybooktable'),
(45,'Can add login table',12,'add_logintable'),
(46,'Can change login table',12,'change_logintable'),
(47,'Can delete login table',12,'delete_logintable'),
(48,'Can view login table',12,'view_logintable'),
(49,'Can add user table',13,'add_usertable'),
(50,'Can change user table',13,'change_usertable'),
(51,'Can delete user table',13,'delete_usertable'),
(52,'Can view user table',13,'view_usertable'),
(53,'Can add review table',14,'add_reviewtable'),
(54,'Can change review table',14,'change_reviewtable'),
(55,'Can delete review table',14,'delete_reviewtable'),
(56,'Can view review table',14,'view_reviewtable'),
(57,'Can add pre booking table',15,'add_prebookingtable'),
(58,'Can change pre booking table',15,'change_prebookingtable'),
(59,'Can delete pre booking table',15,'delete_prebookingtable'),
(60,'Can view pre booking table',15,'view_prebookingtable'),
(61,'Can add payment table',16,'add_paymenttable'),
(62,'Can change payment table',16,'change_paymenttable'),
(63,'Can delete payment table',16,'delete_paymenttable'),
(64,'Can view payment table',16,'view_paymenttable'),
(65,'Can add orders table',17,'add_orderstable'),
(66,'Can change orders table',17,'change_orderstable'),
(67,'Can delete orders table',17,'delete_orderstable'),
(68,'Can view orders table',17,'view_orderstable'),
(69,'Can add order items table',18,'add_orderitemstable'),
(70,'Can change order items table',18,'change_orderitemstable'),
(71,'Can delete order items table',18,'delete_orderitemstable'),
(72,'Can view order items table',18,'view_orderitemstable'),
(73,'Can add offers table',19,'add_offerstable'),
(74,'Can change offers table',19,'change_offerstable'),
(75,'Can delete offers table',19,'delete_offerstable'),
(76,'Can view offers table',19,'view_offerstable'),
(77,'Can add feedback table',20,'add_feedbacktable'),
(78,'Can change feedback table',20,'change_feedbacktable'),
(79,'Can delete feedback table',20,'delete_feedbacktable'),
(80,'Can view feedback table',20,'view_feedbacktable'),
(81,'Can add bookstall table',21,'add_bookstalltable'),
(82,'Can change bookstall table',21,'change_bookstalltable'),
(83,'Can delete bookstall table',21,'delete_bookstalltable'),
(84,'Can view bookstall table',21,'view_bookstalltable');

/*Table structure for table `auth_user` */

DROP TABLE IF EXISTS `auth_user`;

CREATE TABLE `auth_user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(150) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `auth_user` */

/*Table structure for table `auth_user_groups` */

DROP TABLE IF EXISTS `auth_user_groups`;

CREATE TABLE `auth_user_groups` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `group_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`),
  CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `auth_user_groups` */

/*Table structure for table `auth_user_user_permissions` */

DROP TABLE IF EXISTS `auth_user_user_permissions`;

CREATE TABLE `auth_user_user_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `auth_user_user_permissions` */

/*Table structure for table `django_admin_log` */

DROP TABLE IF EXISTS `django_admin_log`;

CREATE TABLE `django_admin_log` (
  `id` int NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint unsigned NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int DEFAULT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `django_admin_log_chk_1` CHECK ((`action_flag` >= 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `django_admin_log` */

/*Table structure for table `django_content_type` */

DROP TABLE IF EXISTS `django_content_type`;

CREATE TABLE `django_content_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `django_content_type` */

insert  into `django_content_type`(`id`,`app_label`,`model`) values 
(1,'admin','logentry'),
(3,'auth','group'),
(2,'auth','permission'),
(4,'auth','user'),
(5,'contenttypes','contenttype'),
(7,'libraryapp','booknumbertable'),
(8,'libraryapp','bookstallbookstable'),
(21,'libraryapp','bookstalltable'),
(20,'libraryapp','feedbacktable'),
(9,'libraryapp','issuetable'),
(10,'libraryapp','librarytable'),
(11,'libraryapp','libraybooktable'),
(12,'libraryapp','logintable'),
(19,'libraryapp','offerstable'),
(18,'libraryapp','orderitemstable'),
(17,'libraryapp','orderstable'),
(16,'libraryapp','paymenttable'),
(15,'libraryapp','prebookingtable'),
(14,'libraryapp','reviewtable'),
(13,'libraryapp','usertable'),
(6,'sessions','session');

/*Table structure for table `django_migrations` */

DROP TABLE IF EXISTS `django_migrations`;

CREATE TABLE `django_migrations` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `django_migrations` */

insert  into `django_migrations`(`id`,`app`,`name`,`applied`) values 
(1,'contenttypes','0001_initial','2023-12-14 11:26:06.445519'),
(2,'auth','0001_initial','2023-12-14 11:26:07.040991'),
(3,'admin','0001_initial','2023-12-14 11:26:07.179684'),
(4,'admin','0002_logentry_remove_auto_add','2023-12-14 11:26:07.188806'),
(5,'admin','0003_logentry_add_action_flag_choices','2023-12-14 11:26:07.196809'),
(6,'contenttypes','0002_remove_content_type_name','2023-12-14 11:26:07.271437'),
(7,'auth','0002_alter_permission_name_max_length','2023-12-14 11:26:07.336498'),
(8,'auth','0003_alter_user_email_max_length','2023-12-14 11:26:07.357169'),
(9,'auth','0004_alter_user_username_opts','2023-12-14 11:26:07.365166'),
(10,'auth','0005_alter_user_last_login_null','2023-12-14 11:26:07.410111'),
(11,'auth','0006_require_contenttypes_0002','2023-12-14 11:26:07.412441'),
(12,'auth','0007_alter_validators_add_error_messages','2023-12-14 11:26:07.421750'),
(13,'auth','0008_alter_user_username_max_length','2023-12-14 11:26:07.462588'),
(14,'auth','0009_alter_user_last_name_max_length','2023-12-14 11:26:07.507802'),
(15,'auth','0010_alter_group_name_max_length','2023-12-14 11:26:07.525715'),
(16,'auth','0011_update_proxy_permissions','2023-12-14 11:26:07.534144'),
(17,'auth','0012_alter_user_first_name_max_length','2023-12-14 11:26:07.606049'),
(18,'libraryapp','0001_initial','2023-12-14 11:26:08.867003'),
(19,'sessions','0001_initial','2023-12-14 11:26:08.905425'),
(20,'libraryapp','0002_bookstallbookstable_language','2024-02-14 11:24:37.852954'),
(21,'libraryapp','0003_alter_orderstable_total','2024-02-28 10:15:18.303120');

/*Table structure for table `django_session` */

DROP TABLE IF EXISTS `django_session`;

CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `django_session` */

insert  into `django_session`(`session_key`,`session_data`,`expire_date`) values 
('0u7xr9ucakhsoehyrqcwo3ttsunmwsjt','eyJsaWQiOjIsImJpZCI6MiwiYnNpZCI6M30:1rOFwE:6VC-5uKw1FfZN6N6jY8CR75sYQgRDDXeDEpILrJNnc8','2024-01-26 11:43:02.016615'),
('71opfx0kz4yy0orm9qdd7xd1n4fxthjd','eyJsaWQiOjYsImJzaWQiOjV9:1rKy9w:ZL5iMXnrck4TIIXIZyTDy6InqeTsyNVG-qmYHhf0sVU','2024-01-17 10:07:36.811831'),
('c9y3cjeecvz4rh5kzjgyog5jt6hgipat','eyJsaWQiOjJ9:1rERCd:mAqpp1ZioGTQM2B5r8iH9daIsapfg6ta-JIh-c5JBco','2023-12-30 09:43:23.434238'),
('k6xhzinlfc0eazf5bv8gfpthwsuptugs','eyJic2lkIjozfQ:1raDJV:iwmCiA0YxVsdUNC728X2LJ1wGz6YeMj8lekmlfhVeuQ','2024-02-28 11:20:29.463651'),
('migd326vfsjvei0i5868lvuovsubez3o','eyJsaWQiOjIsImJpZCI6MiwiYnNpZCI6M30:1rKapv:3ujyXzbyHFl_0rx8voWS0DQw7t0Y7DXmY3N0aYVoJFo','2024-01-16 09:13:23.589326'),
('zlkjzfk317tqs64h4ociju326v57vxlb','eyJsaWQiOjJ9:1rOYX6:uFDyOVA_GjHMezfxIHfgWH6QHLkFxaDsL8x_ALruXbI','2024-01-27 07:34:20.631115');

/*Table structure for table `libraryapp_booknumbertable` */

DROP TABLE IF EXISTS `libraryapp_booknumbertable`;

CREATE TABLE `libraryapp_booknumbertable` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `bookId` varchar(10) NOT NULL,
  `LIBRARY_BOOK_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `libraryapp_booknumbe_LIBRARY_BOOK_id_cb0e8e0a_fk_libraryap` (`LIBRARY_BOOK_id`),
  CONSTRAINT `libraryapp_booknumbe_LIBRARY_BOOK_id_cb0e8e0a_fk_libraryap` FOREIGN KEY (`LIBRARY_BOOK_id`) REFERENCES `libraryapp_libraybooktable` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `libraryapp_booknumbertable` */

insert  into `libraryapp_booknumbertable`(`id`,`bookId`,`LIBRARY_BOOK_id`) values 
(3,'1',2),
(4,'2',3),
(5,'3',4),
(6,'4',5),
(7,'5',6),
(8,'6',8);

/*Table structure for table `libraryapp_bookstallbookstable` */

DROP TABLE IF EXISTS `libraryapp_bookstallbookstable`;

CREATE TABLE `libraryapp_bookstallbookstable` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `genre` varchar(12) NOT NULL,
  `name` varchar(12) NOT NULL,
  `author` varchar(12) NOT NULL,
  `rate` double NOT NULL,
  `stock` varchar(100) NOT NULL,
  `BOOKSTALL_id` bigint NOT NULL,
  `language` varchar(12) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `libraryapp_bookstall_BOOKSTALL_id_4789153c_fk_libraryap` (`BOOKSTALL_id`),
  CONSTRAINT `libraryapp_bookstall_BOOKSTALL_id_4789153c_fk_libraryap` FOREIGN KEY (`BOOKSTALL_id`) REFERENCES `libraryapp_bookstalltable` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `libraryapp_bookstallbookstable` */

insert  into `libraryapp_bookstallbookstable`(`id`,`genre`,`name`,`author`,`rate`,`stock`,`BOOKSTALL_id`,`language`) values 
(2,'color','rose','pink',300,'28',1,'malayalam'),
(4,'Laptop','Lap','Lapies',5000,'50',1,'malayalam'),
(5,'MALAR','maj','jfjwi',768,'6356',1,'malayalam'),
(6,'Tech','Phone','foner',700,'89',1,'Eng');

/*Table structure for table `libraryapp_bookstalltable` */

DROP TABLE IF EXISTS `libraryapp_bookstalltable`;

CREATE TABLE `libraryapp_bookstalltable` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(12) NOT NULL,
  `place` varchar(12) NOT NULL,
  `ownerName` varchar(12) NOT NULL,
  `phone` bigint NOT NULL,
  `date` date NOT NULL,
  `email` varchar(24) NOT NULL,
  `post` varchar(24) NOT NULL,
  `pin` varchar(10) NOT NULL,
  `lattitude` double NOT NULL,
  `longitude` double NOT NULL,
  `photo` varchar(100) NOT NULL,
  `LOGIN_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `libraryapp_bookstall_LOGIN_id_5b674b60_fk_libraryap` (`LOGIN_id`),
  CONSTRAINT `libraryapp_bookstall_LOGIN_id_5b674b60_fk_libraryap` FOREIGN KEY (`LOGIN_id`) REFERENCES `libraryapp_logintable` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `libraryapp_bookstalltable` */

insert  into `libraryapp_bookstalltable`(`id`,`name`,`place`,`ownerName`,`phone`,`date`,`email`,`post`,`pin`,`lattitude`,`longitude`,`photo`,`LOGIN_id`) values 
(1,'bsName','libPlace','bsOwner',1111,'2023-12-14','libMail@gmail.com','LibPost','11',2222,22222,'Screenshot (1)_IeWCNsq.png',3),
(2,'ifherohg','gosber','seorhge\'ar',95859459,'2024-01-03','mak@gierh','kallai','95850',85858,585585,'Screenshot (1)_IJKSIIU.png',5),
(3,'mq','kal','hqhi',97474,'2024-01-07','aoerj','756','494',74467,4484,'aa1_bmvfhVO.png',9),
(4,'Bs','BsP','BsO',499,'2024-01-07','34','BsoI','48',89,89,'aa1_vENavDT.png',11),
(5,'slainen','qwert','dfnie',123451,'2024-01-09','5464747','12344','gfgfhfh',1234,1234,'Screenshot (1)_bn2JetU.png',12),
(6,'fgdgd','ffumtr','ggtyu',123456,'2024-01-09','mghi','jghi','ttyy',12345,12345,'Screenshot (1)_GeWZxZK.png',13),
(7,'123456','123456','123456',2345,'2024-01-09','1234','12345','23456',234,2345,'Screenshot (1)_jocFg2x.png',14),
(8,'123456','1234','12345',12345,'2024-01-09','12345','12345','12345',1234,12345,'Screenshot (1)_Vm9zrMi.png',16),
(9,'1234','234','1234',234,'2024-01-09','2345','2345','2345',345,12345,'Screenshot (1)_sw5iSdT.png',18),
(10,'123','123','123',23,'2024-01-09','123','23','23',123,123,'Screenshot (1)_z9dvD7w.png',19),
(11,'123','123','123',1234,'2024-01-09','123','123','123',123,123,'aa1_f2sHeQy.png',20),
(12,'1234','1234','1234',1234,'2024-01-09','12','1234','1234',1234,1234,'aa1_gJfyoDO.png',21);

/*Table structure for table `libraryapp_feedbacktable` */

DROP TABLE IF EXISTS `libraryapp_feedbacktable`;

CREATE TABLE `libraryapp_feedbacktable` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `feedback` varchar(120) NOT NULL,
  `date` date NOT NULL,
  `rating` double NOT NULL,
  `LOGIN_id` bigint NOT NULL,
  `USER_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `libraryapp_feedbackt_LOGIN_id_7c2f0693_fk_libraryap` (`LOGIN_id`),
  KEY `libraryapp_feedbackt_USER_id_79df2b13_fk_libraryap` (`USER_id`),
  CONSTRAINT `libraryapp_feedbackt_LOGIN_id_7c2f0693_fk_libraryap` FOREIGN KEY (`LOGIN_id`) REFERENCES `libraryapp_logintable` (`id`),
  CONSTRAINT `libraryapp_feedbackt_USER_id_79df2b13_fk_libraryap` FOREIGN KEY (`USER_id`) REFERENCES `libraryapp_usertable` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `libraryapp_feedbacktable` */

/*Table structure for table `libraryapp_issuetable` */

DROP TABLE IF EXISTS `libraryapp_issuetable`;

CREATE TABLE `libraryapp_issuetable` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `date` date NOT NULL,
  `returnDate` date NOT NULL,
  `status` varchar(100) NOT NULL,
  `fineAmount` double NOT NULL,
  `BOOKNUMBER_id` bigint NOT NULL,
  `LIBRARYBOOK_id` bigint NOT NULL,
  `USER_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `libraryapp_issuetabl_LIBRARYBOOK_id_f360d072_fk_libraryap` (`LIBRARYBOOK_id`),
  KEY `libraryapp_issuetabl_USER_id_1af8f607_fk_libraryap` (`USER_id`),
  KEY `libraryapp_issuetabl_BOOKNUMBER_id_cc850fb2_fk_libraryap` (`BOOKNUMBER_id`),
  CONSTRAINT `libraryapp_issuetabl_BOOKNUMBER_id_cc850fb2_fk_libraryap` FOREIGN KEY (`BOOKNUMBER_id`) REFERENCES `libraryapp_booknumbertable` (`id`),
  CONSTRAINT `libraryapp_issuetabl_LIBRARYBOOK_id_f360d072_fk_libraryap` FOREIGN KEY (`LIBRARYBOOK_id`) REFERENCES `libraryapp_libraybooktable` (`id`),
  CONSTRAINT `libraryapp_issuetabl_USER_id_1af8f607_fk_libraryap` FOREIGN KEY (`USER_id`) REFERENCES `libraryapp_usertable` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `libraryapp_issuetable` */

insert  into `libraryapp_issuetable`(`id`,`date`,`returnDate`,`status`,`fineAmount`,`BOOKNUMBER_id`,`LIBRARYBOOK_id`,`USER_id`) values 
(2,'2023-12-22','2023-12-28','issued',500,3,2,1),
(7,'2023-12-19','2023-12-30','Rejected',500,3,2,1),
(9,'2023-12-19','2023-12-30','issued',600,3,2,2),
(10,'2024-01-07','2024-01-16','issued',7879,3,2,2),
(11,'2024-02-13','2024-02-23','issued',454,3,2,10),
(12,'2024-02-14','2024-02-14','pending',569,7,8,10);

/*Table structure for table `libraryapp_librarytable` */

DROP TABLE IF EXISTS `libraryapp_librarytable`;

CREATE TABLE `libraryapp_librarytable` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(12) NOT NULL,
  `place` varchar(12) NOT NULL,
  `phone` bigint NOT NULL,
  `date` date NOT NULL,
  `email` varchar(24) NOT NULL,
  `post` varchar(12) NOT NULL,
  `pin` varchar(12) NOT NULL,
  `photo` varchar(100) NOT NULL,
  `LOGIN_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `libraryapp_libraryta_LOGIN_id_1d64932a_fk_libraryap` (`LOGIN_id`),
  CONSTRAINT `libraryapp_libraryta_LOGIN_id_1d64932a_fk_libraryap` FOREIGN KEY (`LOGIN_id`) REFERENCES `libraryapp_logintable` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `libraryapp_librarytable` */

insert  into `libraryapp_librarytable`(`id`,`name`,`place`,`phone`,`date`,`email`,`post`,`pin`,`photo`,`LOGIN_id`) values 
(1,'libName','libPlace',114579,'2023-12-14','libMail@gmail.com','LibPost','11','Screenshot (1)_3oDOpbQ.png',2),
(2,'anel','mankave',696969696,'2024-01-03','anel@gmail.com','mankave','46747','Screenshot (1)_W2pf3bm.png',6),
(3,'lol','calicut',49749947,'2024-01-05','lol@gmail,com','6869','67695','Screenshot (1)_5NmPF1S.png',7),
(4,'qwerty','sdfgh',9876543210,'2024-01-07','nbvc@qwer.ewq','jhgfd','654321','aa1_OVBHHJK.png',10),
(5,'123456','123456',123456,'2024-01-09','23456','23456','23456','Screenshot (1)_8DYpzmD.png',15),
(6,'2345','12345',1234,'2024-01-09','12345','1234','1234 ','Screenshot (1)_dhxvACR.png',17),
(7,'123','123',123,'2024-01-09','23','123','234','aa1_QSLotyO.png',22),
(8,'123','123',123,'2024-01-09','aa','123','123','aa1_NJhqr4t.png',23),
(9,'123','123',123,'2024-01-09','b&&*&#$','234','1234','aa1_bBMsFEq.png',24);

/*Table structure for table `libraryapp_libraybooktable` */

DROP TABLE IF EXISTS `libraryapp_libraybooktable`;

CREATE TABLE `libraryapp_libraybooktable` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `genre` varchar(24) NOT NULL,
  `bookName` varchar(12) NOT NULL,
  `author` varchar(24) NOT NULL,
  `quantity` bigint NOT NULL,
  `language` varchar(24) NOT NULL,
  `LIBRARY_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `libraryapp_librayboo_LIBRARY_id_dd7114a6_fk_libraryap` (`LIBRARY_id`),
  CONSTRAINT `libraryapp_librayboo_LIBRARY_id_dd7114a6_fk_libraryap` FOREIGN KEY (`LIBRARY_id`) REFERENCES `libraryapp_librarytable` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `libraryapp_libraybooktable` */

insert  into `libraryapp_libraybooktable`(`id`,`genre`,`bookName`,`author`,`quantity`,`language`,`LIBRARY_id`) values 
(2,'comedy','haunted','anirud',2,'mal',1),
(3,'superhero','AA','green',59,'english',1),
(4,'B1Genre','B1Name','B1Author',26,'Malayalam',1),
(5,'B2Genre','B2Name','B2Author',13,'English',1),
(6,'B3Genre','B3Name','B3Author',45,'HIndi\\',1),
(8,'maths','circles','charles',11,'english',1),
(10,'comedy','Hello','maurh',946,'mrirh',1),
(11,'superhero','what if ','green',2,'english',1),
(12,'ouherovh','aihr','hrogerh',1,'marhgo',1);

/*Table structure for table `libraryapp_logintable` */

DROP TABLE IF EXISTS `libraryapp_logintable`;

CREATE TABLE `libraryapp_logintable` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `username` varchar(12) NOT NULL,
  `password` varchar(12) NOT NULL,
  `type` varchar(12) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `libraryapp_logintable` */

insert  into `libraryapp_logintable`(`id`,`username`,`password`,`type`) values 
(1,'admin','admin','admin'),
(2,'library','library','library'),
(3,'bookstall','bookstall','bookstall'),
(4,'user','user','user'),
(5,'ani','6969','bookstall'),
(6,'anel','1234','library'),
(7,'library1','library1','library'),
(8,'qwr','123','pending'),
(9,'qwr','123','bookstall'),
(10,'qwerty','qwerty','library'),
(11,'aa','bb','bookstall'),
(12,'anirud','1234','pending'),
(13,'1234','1234','pending'),
(14,'123456','1234','pending'),
(15,'123456','123456','rejected'),
(16,'1234','1234','pending'),
(17,'123451234','12345','library'),
(18,'123','1234','pending'),
(19,'123','123','pending'),
(20,'123','1234','pending'),
(21,'12','12','pending'),
(22,'aa','bb','rejected'),
(23,'123','1234','rejected'),
(24,'aa','bb','rejected'),
(32,'ali','ali','user'),
(33,'a','a','user'),
(34,'','','user'),
(35,'bbb','Aa123456','user');

/*Table structure for table `libraryapp_offerstable` */

DROP TABLE IF EXISTS `libraryapp_offerstable`;

CREATE TABLE `libraryapp_offerstable` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `offers` varchar(100) NOT NULL,
  `offerDetails` varchar(100) NOT NULL,
  `offerPeriod` date NOT NULL,
  `BOOKSTALL_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `libraryapp_offerstab_BOOKSTALL_id_41acfb0f_fk_libraryap` (`BOOKSTALL_id`),
  CONSTRAINT `libraryapp_offerstab_BOOKSTALL_id_41acfb0f_fk_libraryap` FOREIGN KEY (`BOOKSTALL_id`) REFERENCES `libraryapp_bookstallbookstable` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `libraryapp_offerstable` */

/*Table structure for table `libraryapp_orderitemstable` */

DROP TABLE IF EXISTS `libraryapp_orderitemstable`;

CREATE TABLE `libraryapp_orderitemstable` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `quantity` varchar(100) NOT NULL,
  `BOOKSTALLBOOKS_id` bigint NOT NULL,
  `ORDER_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `libraryapp_orderitem_BOOKSTALLBOOKS_id_19c26f2c_fk_libraryap` (`BOOKSTALLBOOKS_id`),
  KEY `libraryapp_orderitem_ORDER_id_d1a8ad4c_fk_libraryap` (`ORDER_id`),
  CONSTRAINT `libraryapp_orderitem_BOOKSTALLBOOKS_id_19c26f2c_fk_libraryap` FOREIGN KEY (`BOOKSTALLBOOKS_id`) REFERENCES `libraryapp_bookstallbookstable` (`id`),
  CONSTRAINT `libraryapp_orderitem_ORDER_id_d1a8ad4c_fk_libraryap` FOREIGN KEY (`ORDER_id`) REFERENCES `libraryapp_orderstable` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `libraryapp_orderitemstable` */

insert  into `libraryapp_orderitemstable`(`id`,`quantity`,`BOOKSTALLBOOKS_id`,`ORDER_id`) values 
(4,'34',2,5),
(5,'45',6,4);

/*Table structure for table `libraryapp_orderstable` */

DROP TABLE IF EXISTS `libraryapp_orderstable`;

CREATE TABLE `libraryapp_orderstable` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `date` date NOT NULL,
  `total` decimal(10,2) NOT NULL,
  `status` varchar(30) NOT NULL,
  `USER_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `libraryapp_orderstab_USER_id_699f26cd_fk_libraryap` (`USER_id`),
  CONSTRAINT `libraryapp_orderstab_USER_id_699f26cd_fk_libraryap` FOREIGN KEY (`USER_id`) REFERENCES `libraryapp_usertable` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `libraryapp_orderstable` */

insert  into `libraryapp_orderstable`(`id`,`date`,`total`,`status`,`USER_id`) values 
(1,'2023-12-20',10.00,'cart',1),
(2,'2024-02-01',11.00,'cart',2),
(3,'2024-02-14',200.00,'cart',11),
(4,'2024-02-01',10.00,'cart',10),
(5,'2024-02-28',700.00,'cart',10),
(34,'2024-02-28',20000.00,'cart',10);

/*Table structure for table `libraryapp_paymenttable` */

DROP TABLE IF EXISTS `libraryapp_paymenttable`;

CREATE TABLE `libraryapp_paymenttable` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `amount` double NOT NULL,
  `date` date NOT NULL,
  `status` varchar(102) NOT NULL,
  `ISSUE_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `libraryapp_paymentta_ISSUE_id_b757be0b_fk_libraryap` (`ISSUE_id`),
  CONSTRAINT `libraryapp_paymentta_ISSUE_id_b757be0b_fk_libraryap` FOREIGN KEY (`ISSUE_id`) REFERENCES `libraryapp_issuetable` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `libraryapp_paymenttable` */

insert  into `libraryapp_paymenttable`(`id`,`amount`,`date`,`status`,`ISSUE_id`) values 
(2,500,'2023-12-19','pending',7);

/*Table structure for table `libraryapp_prebookingtable` */

DROP TABLE IF EXISTS `libraryapp_prebookingtable`;

CREATE TABLE `libraryapp_prebookingtable` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `date` date NOT NULL,
  `status` varchar(100) NOT NULL,
  `LIBRARYBOOK_id` bigint NOT NULL,
  `USER_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `libraryapp_prebookin_LIBRARYBOOK_id_5fe672b9_fk_libraryap` (`LIBRARYBOOK_id`),
  KEY `libraryapp_prebookin_USER_id_a2f1c094_fk_libraryap` (`USER_id`),
  CONSTRAINT `libraryapp_prebookin_LIBRARYBOOK_id_5fe672b9_fk_libraryap` FOREIGN KEY (`LIBRARYBOOK_id`) REFERENCES `libraryapp_libraybooktable` (`id`),
  CONSTRAINT `libraryapp_prebookin_USER_id_a2f1c094_fk_libraryap` FOREIGN KEY (`USER_id`) REFERENCES `libraryapp_usertable` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `libraryapp_prebookingtable` */

insert  into `libraryapp_prebookingtable`(`id`,`date`,`status`,`LIBRARYBOOK_id`,`USER_id`) values 
(1,'2023-12-16','Pending',5,1),
(2,'2024-02-28','pending',3,10);

/*Table structure for table `libraryapp_reviewtable` */

DROP TABLE IF EXISTS `libraryapp_reviewtable`;

CREATE TABLE `libraryapp_reviewtable` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `review` varchar(120) NOT NULL,
  `rating` double NOT NULL,
  `date` date NOT NULL,
  `BOOK_id` bigint NOT NULL,
  `USER_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `libraryapp_reviewtab_BOOK_id_b89e3371_fk_libraryap` (`BOOK_id`),
  KEY `libraryapp_reviewtab_USER_id_41bbdd8a_fk_libraryap` (`USER_id`),
  CONSTRAINT `libraryapp_reviewtab_BOOK_id_b89e3371_fk_libraryap` FOREIGN KEY (`BOOK_id`) REFERENCES `libraryapp_bookstallbookstable` (`id`),
  CONSTRAINT `libraryapp_reviewtab_USER_id_41bbdd8a_fk_libraryap` FOREIGN KEY (`USER_id`) REFERENCES `libraryapp_usertable` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `libraryapp_reviewtable` */

/*Table structure for table `libraryapp_usertable` */

DROP TABLE IF EXISTS `libraryapp_usertable`;

CREATE TABLE `libraryapp_usertable` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(12) NOT NULL,
  `place` varchar(12) NOT NULL,
  `post` varchar(12) NOT NULL,
  `pin` varchar(10) NOT NULL,
  `phone` bigint NOT NULL,
  `email` varchar(12) NOT NULL,
  `photo` varchar(100) NOT NULL,
  `LOGIN_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `libraryapp_usertable_LOGIN_id_4b0c06f5_fk_libraryap` (`LOGIN_id`),
  CONSTRAINT `libraryapp_usertable_LOGIN_id_4b0c06f5_fk_libraryap` FOREIGN KEY (`LOGIN_id`) REFERENCES `libraryapp_logintable` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `libraryapp_usertable` */

insert  into `libraryapp_usertable`(`id`,`name`,`place`,`post`,`pin`,`phone`,`email`,`photo`,`LOGIN_id`) values 
(1,'user','us','uspost','67974',573957,'u@.gmail','ak.png',4),
(2,'U2','UK','U2Post','6969',919191,'i.@gmail','uk.png',4),
(9,'ali','alii','356','4466',2344,'alima','20240213-151254.jpg',32),
(10,'anel','ghgg','kdgh','1356',4445,'an@','20240213-151421.jpg',33),
(11,'anel','ghgg','kdgh','1356',4445,'an@','20240218-170118.jpg',34),
(12,'aa','aa','aaa','673467',9911111111,'afgh@gh.cn','20240228-181209.jpg',35);

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
