/*
Navicat MySQL Data Transfer

Source Server         : xmshop
Source Server Version : 50527
Source Host           : localhost:3306
Source Database       : xmgjshop

Target Server Type    : MYSQL
Target Server Version : 50527
File Encoding         : 65001

Date: 2019-05-16 17:55:10
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for newlaunch
-- ----------------------------
DROP TABLE IF EXISTS `newlaunch`;
CREATE TABLE `newlaunch` (
  `id` bigint(20) NOT NULL,
  `createdDate` datetime DEFAULT NULL,
  `lastModifiedDate` datetime DEFAULT NULL,
  `version` bigint(20) DEFAULT NULL,
  `SerialNumber` varchar(255) DEFAULT NULL,
  `StereotypeTime` varchar(255) DEFAULT NULL,
  `creatTime` datetime DEFAULT NULL,
  `creatUser` varchar(255) DEFAULT NULL,
  `flag` int(11) DEFAULT NULL,
  `hits` bigint(20) DEFAULT NULL,
  `introduction` longtext,
  `isTop` bit(1) DEFAULT NULL,
  `itemNo` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `price` decimal(21,6) DEFAULT NULL,
  `productImages` varchar(4000) DEFAULT NULL,
  `releaseFlag` varchar(255) DEFAULT NULL,
  `typeNorms` varchar(255) DEFAULT NULL,
  `unit` varchar(255) DEFAULT NULL,
  `updateTime` varchar(255) DEFAULT NULL,
  `updateUser` varchar(255) DEFAULT NULL,
  `weight` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK_18ipyq7o9oy32jqgdfpuqfaqu` (`itemNo`),
  UNIQUE KEY `UK_k8y4odh8aq11py16ij08fep4j` (`typeNorms`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
