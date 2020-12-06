/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 50703
Source Host           : localhost:3306
Source Database       : xinmengshop

Target Server Type    : MYSQL
Target Server Version : 50703
File Encoding         : 65001

Date: 2019-05-13 10:29:02
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for wiki
-- ----------------------------
DROP TABLE IF EXISTS `wiki`;
CREATE TABLE `wiki` (
  `id` bigint(20) NOT NULL,
  `createdDate` datetime NOT NULL,
  `lastModifiedDate` datetime NOT NULL,
  `version` bigint(20) NOT NULL,
  `author` varchar(255) DEFAULT NULL,
  `content` longtext,
  `hits` bigint(20) NOT NULL,
  `isPublication` bit(1) NOT NULL,
  `isTop` bit(1) NOT NULL,
  `seoDescription` varchar(255) DEFAULT NULL,
  `seoKeywords` varchar(255) DEFAULT NULL,
  `seoTitle` varchar(255) DEFAULT NULL,
  `title` varchar(255) NOT NULL,
  `wikiCategory_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `ind_Wiki_wikiCategory_id` (`wikiCategory_id`),
  CONSTRAINT `FK8mesllslt1ex5yjh8cqnsmdq4` FOREIGN KEY (`wikiCategory_id`) REFERENCES `wikicategory` (`id`),
  CONSTRAINT `FK20190509184738` FOREIGN KEY (`wikiCategory_id`) REFERENCES `wikicategory` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wiki
-- ----------------------------
INSERT INTO `wiki` VALUES ('1', '2019-05-09 19:05:14', '2019-05-10 14:21:38', '1', '百度云', '<p style=\"font-family: -apple-system, BlinkMacSystemFont, &quot;SF Pro SC&quot;, &quot;SF Pro Text&quot;, &quot;Helvetica Neue&quot;, Helvetica, &quot;PingFang SC&quot;, &quot;Segoe UI&quot;, Roboto, &quot;Hiragino Sans GB&quot;, arial, &quot;microsoft yahei ui&quot;, &quot;Microsoft YaHei&quot;, SimSun, sans-serif; -webkit-font-smoothing: antialiased; margin-top: 14px; margin-bottom: 14px; word-wrap: break-word; color: rgba(0, 0, 0, 0.85); font-size: 14px; white-space: normal; background-color: rgb(255, 255, 255);\">云服务器BCC（Baidu Cloud Compute）是一种简单高效、安全可靠、处理能力可弹性伸缩的计算服务。用户无需提前购买硬件，即可迅速创建或释放任意多台云服务器，有效降低IT成本，提升运维效率，为用户快速构建稳定可靠的应用，降低网络规模计算的难度，使用户更专注于核心业务创新。</p><p style=\"font-family: -apple-system, BlinkMacSystemFont, &quot;SF Pro SC&quot;, &quot;SF Pro Text&quot;, &quot;Helvetica Neue&quot;, Helvetica, &quot;PingFang SC&quot;, &quot;Segoe UI&quot;, Roboto, &quot;Hiragino Sans GB&quot;, arial, &quot;microsoft yahei ui&quot;, &quot;Microsoft YaHei&quot;, SimSun, sans-serif; -webkit-font-smoothing: antialiased; margin-top: 14px; margin-bottom: 14px; word-wrap: break-word; color: rgba(0, 0, 0, 0.85); font-size: 14px; white-space: normal; background-color: rgb(255, 255, 255);\">基本概念：</p><ul style=\"font-family: -apple-system, BlinkMacSystemFont, &quot;SF Pro SC&quot;, &quot;SF Pro Text&quot;, &quot;Helvetica Neue&quot;, Helvetica, &quot;PingFang SC&quot;, &quot;Segoe UI&quot;, Roboto, &quot;Hiragino Sans GB&quot;, arial, &quot;microsoft yahei ui&quot;, &quot;Microsoft YaHei&quot;, SimSun, sans-serif; -webkit-font-smoothing: antialiased; margin-top: 5px; margin-bottom: 5px; padding: 0px 0px 0px 18px; list-style-position: outside; list-style-image: initial; color: rgba(0, 0, 0, 0.85); font-size: 14px; white-space: normal; background-color: rgb(255, 255, 255);\" class=\" list-paddingleft-2\"><li><p style=\"-webkit-font-smoothing: antialiased; word-wrap: break-word;\">实例：在百度智能云中作为虚拟服务器运行的系统映像的副本。</p></li><li><p style=\"-webkit-font-smoothing: antialiased; word-wrap: break-word;\">镜像：即包含了软件及必要配置的云服务器模板。这里提到的镜像分为两种，一种是百度智能云提供的“系统镜像”，包括多种Linux、Windows操作系统。另一种是“自定义镜像”，是用户根据云服务器的快照来自行创建的。</p></li><li><p style=\"-webkit-font-smoothing: antialiased; word-wrap: break-word;\">快照：是指云服务器或云磁盘在某一特定时间点的完整内容及结构的副本。用户可以随时按快照点进行数据恢复，从而实现包括增量备份等各种形式的备份服务。</p></li><li><p style=\"-webkit-font-smoothing: antialiased; word-wrap: break-word;\">安全组：是对云服务器实例所应用的通信方向、网络协议、端口、源IP规则的集合。</p></li></ul><p><br/></p>', '0', '', '\0', null, null, '云服务器 BCC', '云服务器 BCC', '1');

-- ----------------------------
-- Table structure for wiki_wikitag
-- ----------------------------
DROP TABLE IF EXISTS `wiki_wikitag`;
CREATE TABLE `wiki_wikitag` (
  `wikis_id` bigint(20) NOT NULL,
  `wikiTags_id` bigint(20) NOT NULL,
  PRIMARY KEY (`wikis_id`,`wikiTags_id`),
  KEY `FKjwtqwx8awalj2o8ea664geout` (`wikiTags_id`),
  CONSTRAINT `FK5myteo8cpl7xsypknl3jch0gk` FOREIGN KEY (`wikis_id`) REFERENCES `wiki` (`id`),
  CONSTRAINT `FKjwtqwx8awalj2o8ea664geout` FOREIGN KEY (`wikiTags_id`) REFERENCES `wikitag` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wiki_wikitag
-- ----------------------------

-- ----------------------------
-- Table structure for wikicategory
-- ----------------------------
DROP TABLE IF EXISTS `wikicategory`;
CREATE TABLE `wikicategory` (
  `id` bigint(20) NOT NULL,
  `createdDate` datetime NOT NULL,
  `lastModifiedDate` datetime NOT NULL,
  `version` bigint(20) NOT NULL,
  `orders` int(11) DEFAULT NULL,
  `grade` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `seoDescription` varchar(255) DEFAULT NULL,
  `seoKeywords` varchar(255) DEFAULT NULL,
  `seoTitle` varchar(255) DEFAULT NULL,
  `treePath` varchar(255) NOT NULL,
  `parent_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ind_WikiCategory_parent_id` (`parent_id`),
  CONSTRAINT `FKbm3eolukbucxyb4bns0t4p3b0` FOREIGN KEY (`parent_id`) REFERENCES `wikicategory` (`id`),
  CONSTRAINT `FK20190509184731` FOREIGN KEY (`parent_id`) REFERENCES `wikicategory` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wikicategory
-- ----------------------------
INSERT INTO `wikicategory` VALUES ('1', '2019-05-09 19:04:51', '2019-05-10 14:40:55', '1', '1', '0', '知识库', null, null, '知识库', ',', null);

-- ----------------------------
-- Table structure for wikitag
-- ----------------------------
DROP TABLE IF EXISTS `wikitag`;
CREATE TABLE `wikitag` (
  `id` bigint(20) NOT NULL,
  `createdDate` datetime NOT NULL,
  `lastModifiedDate` datetime NOT NULL,
  `version` bigint(20) NOT NULL,
  `orders` int(11) DEFAULT NULL,
  `memo` varchar(255) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wikitag
-- ----------------------------
INSERT INTO `wikitag` VALUES ('1', '2019-05-09 19:04:07', '2019-05-10 15:34:39', '1', null, null, '热门');
INSERT INTO `wikitag` VALUES ('52', '2019-05-10 15:34:53', '2019-05-10 15:34:53', '0', null, null, '推荐');
