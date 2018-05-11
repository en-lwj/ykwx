/*
Navicat MySQL Data Transfer

Source Server         : 127.0.0.1_3306
Source Server Version : 50714
Source Host           : 127.0.0.1:3306
Source Database       : bysj

Target Server Type    : MYSQL
Target Server Version : 50714
File Encoding         : 65001

Date: 2018-05-12 00:54:14
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for activity
-- ----------------------------
DROP TABLE IF EXISTS `activity`;
CREATE TABLE `activity` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `activity_column_id` int(11) NOT NULL DEFAULT '1',
  `name` varchar(50) NOT NULL COMMENT '活动名称',
  `is_publish` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0:未发布，1已发布',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `start_time` timestamp NOT NULL,
  `end_time` timestamp NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of activity
-- ----------------------------
INSERT INTO `activity` VALUES ('1', '1', '活动征稿2', '1', '2018-01-17 17:08:27', '0000-00-00 00:00:00', '0000-00-00 00:00:00');
INSERT INTO `activity` VALUES ('2', '1', '活动征稿1', '1', '2018-01-17 17:10:03', '2018-01-01 17:10:14', '2018-01-04 17:10:23');
INSERT INTO `activity` VALUES ('3', '2', '侨苑杂志第50期', '0', '2018-04-20 10:25:56', '2018-04-20 10:25:38', '2018-06-01 10:25:47');
INSERT INTO `activity` VALUES ('4', '2', '侨苑杂志第49期', '0', '2017-04-20 10:31:59', '2017-04-01 10:32:24', '2017-07-01 10:32:37');

-- ----------------------------
-- Table structure for activity_column
-- ----------------------------
DROP TABLE IF EXISTS `activity_column`;
CREATE TABLE `activity_column` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of activity_column
-- ----------------------------
INSERT INTO `activity_column` VALUES ('1', '日常');
INSERT INTO `activity_column` VALUES ('2', '期刊');

-- ----------------------------
-- Table structure for activity_score
-- ----------------------------
DROP TABLE IF EXISTS `activity_score`;
CREATE TABLE `activity_score` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `article_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `score` float(9,6) NOT NULL,
  PRIMARY KEY (`id`,`user_id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of activity_score
-- ----------------------------
INSERT INTO `activity_score` VALUES ('1', '80', '8', '60.000000');
INSERT INTO `activity_score` VALUES ('2', '80', '1', '30.000000');

-- ----------------------------
-- Table structure for article
-- ----------------------------
DROP TABLE IF EXISTS `article`;
CREATE TABLE `article` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `category_id` int(11) DEFAULT '0' COMMENT '日常分类id',
  `activity_id` int(11) DEFAULT '0' COMMENT '活动id',
  `name` varchar(50) NOT NULL COMMENT '文章名称',
  `user_id` int(11) NOT NULL COMMENT '作者id',
  `article_content_id` int(11) NOT NULL COMMENT '对应文章内容表id',
  `day_click` int(11) DEFAULT '0',
  `all_click` int(11) DEFAULT '0' COMMENT '总阅读量',
  `like_num` int(11) DEFAULT '0' COMMENT '点赞数',
  `score` decimal(7,4) DEFAULT NULL,
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `is_show` tinyint(1) NOT NULL DEFAULT '0' COMMENT '-1不通过，0待审核，1通过',
  `is_delete` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`id`,`update_time`)
) ENGINE=InnoDB AUTO_INCREMENT=94 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of article
-- ----------------------------
INSERT INTO `article` VALUES ('1', '1', '0', 'name1', '0', '1', '0', '89', '0', null, '2018-01-17 10:28:15', '2018-04-24 17:38:37', '1', null);
INSERT INTO `article` VALUES ('4', '1', '0', 'name4', '0', '3', '0', '2', '0', null, '2018-01-01 13:04:12', '2018-04-24 12:11:51', '1', null);
INSERT INTO `article` VALUES ('5', '1', '0', 'name5', '0', '4', '0', '1', '0', null, '2018-01-16 10:41:24', '2018-05-05 00:11:02', '1', null);
INSERT INTO `article` VALUES ('6', '1', '0', 'name6', '14', '5', '0', '3', '0', null, '2018-01-16 10:41:28', '2018-05-05 00:11:02', '1', null);
INSERT INTO `article` VALUES ('7', '1', '0', 'name7', '14', '6', '0', '2', '0', null, '2018-01-16 10:41:32', '2018-04-14 15:02:06', '1', null);
INSERT INTO `article` VALUES ('8', '1', '0', 'name8', '14', '7', '0', '4', '0', null, '2018-01-16 10:41:35', '2018-04-22 21:07:16', '1', null);
INSERT INTO `article` VALUES ('9', '1', '0', 'name9', '14', '8', '0', '69', '0', null, '2018-01-16 10:41:39', '2018-05-07 16:21:14', '1', null);
INSERT INTO `article` VALUES ('10', '1', '0', 'name10', '14', '9', '0', '3', '0', null, '2018-01-16 10:41:42', '2018-05-06 08:48:49', '1', null);
INSERT INTO `article` VALUES ('11', '2', '2', 'name11', '14', '9', '0', '1', '0', null, '2018-01-16 12:58:19', '2018-05-07 18:49:23', '1', null);
INSERT INTO `article` VALUES ('12', '2', '2', 'name12', '14', '9', '0', '1', '0', null, '2018-01-16 12:58:19', '2018-05-07 18:49:23', '1', null);
INSERT INTO `article` VALUES ('13', '2', '2', 'name13', '14', '9', '0', '5', '0', null, '2018-01-16 12:58:20', '2018-05-07 18:49:23', '1', null);
INSERT INTO `article` VALUES ('14', '2', '2', 'name14', '14', '9', '0', '2', '0', null, '2018-01-16 12:58:20', '2018-05-07 18:49:23', '1', null);
INSERT INTO `article` VALUES ('15', '2', '2', 'name15', '14', '9', '0', '0', '0', null, '2018-01-16 12:58:20', '2018-05-07 18:49:23', '1', null);
INSERT INTO `article` VALUES ('16', '2', '2', 'name16', '14', '9', '0', '1', '1', null, '2018-01-16 12:58:20', '2018-05-07 18:49:23', '1', null);
INSERT INTO `article` VALUES ('17', '2', '2', 'name17', '14', '9', '0', '0', '0', null, '2018-01-16 12:58:20', '2018-05-07 18:49:23', '1', null);
INSERT INTO `article` VALUES ('18', '3', '2', 'name18', '14', '9', '0', '0', '0', null, '2018-01-16 12:58:30', '2018-05-07 18:49:23', '1', null);
INSERT INTO `article` VALUES ('19', '3', '2', 'name19', '14', '9', '0', '1', '0', null, '2018-01-16 12:58:30', '2018-05-07 18:49:23', '1', null);
INSERT INTO `article` VALUES ('20', '3', '0', 'name20', '14', '9', '0', '3', '0', null, '2018-01-16 12:58:30', '2018-04-14 15:02:06', '1', null);
INSERT INTO `article` VALUES ('21', '3', '0', 'name21', '8', '9', '0', '0', '0', null, '2018-01-16 12:58:30', '2018-04-14 15:02:06', '1', null);
INSERT INTO `article` VALUES ('22', '3', '0', 'name22', '8', '9', '0', '2', '0', null, '2018-01-16 12:58:30', '2018-04-14 15:02:06', '1', null);
INSERT INTO `article` VALUES ('23', '3', '0', 'name23', '8', '9', '0', '1', '0', null, '2018-01-16 12:58:30', '2018-04-14 15:02:06', '1', null);
INSERT INTO `article` VALUES ('24', '3', '0', 'name24', '8', '9', '0', '24', '0', null, '2018-01-16 12:58:30', '2018-04-14 15:02:06', '1', null);
INSERT INTO `article` VALUES ('25', '4', '0', 'name25', '8', '9', '0', '1', '0', null, '2018-01-16 12:58:40', '2018-04-22 22:33:17', '1', null);
INSERT INTO `article` VALUES ('26', '4', '0', 'name26', '8', '9', '0', '0', '0', null, '2018-01-16 12:58:40', '2018-04-14 15:02:06', '1', null);
INSERT INTO `article` VALUES ('27', '4', '0', 'name27', '8', '9', '0', '0', '0', null, '2018-01-16 12:58:40', '2018-04-14 15:02:06', '1', null);
INSERT INTO `article` VALUES ('28', '4', '0', 'name28', '8', '9', '0', '0', '0', null, '2018-01-16 12:58:40', '2018-04-14 15:02:06', '1', null);
INSERT INTO `article` VALUES ('29', '4', '0', 'name29', '8', '9', '0', '1', '0', null, '2018-01-16 12:58:40', '2018-04-14 15:02:06', '1', null);
INSERT INTO `article` VALUES ('30', '4', '0', 'name30', '8', '9', '0', '0', '0', null, '2018-01-16 12:58:40', '2018-04-14 15:02:06', '1', null);
INSERT INTO `article` VALUES ('31', '4', '0', 'name31', '8', '9', '0', '5', '0', null, '2018-01-16 12:58:40', '2018-04-22 20:33:55', '1', null);
INSERT INTO `article` VALUES ('32', '5', '0', 'name32', '8', '9', '0', '0', '0', null, '2018-01-16 12:58:50', '2018-04-14 15:02:06', '1', null);
INSERT INTO `article` VALUES ('33', '5', '0', 'name33', '8', '9', '0', '0', '0', null, '2018-01-16 12:58:50', '2018-04-14 15:02:06', '1', null);
INSERT INTO `article` VALUES ('34', '5', '0', 'name34', '8', '9', '0', '0', '0', null, '2018-01-16 12:58:50', '2018-04-14 15:02:06', '1', null);
INSERT INTO `article` VALUES ('35', '5', '0', 'name35', '8', '9', '0', '2', '0', null, '2018-01-16 12:58:51', '2018-04-19 16:50:14', '1', null);
INSERT INTO `article` VALUES ('36', '5', '0', 'name36', '8', '9', '0', '0', '0', null, '2018-01-16 12:58:51', '2018-04-14 15:02:06', '1', null);
INSERT INTO `article` VALUES ('37', '5', '0', 'name37', '8', '9', '0', '0', '0', null, '2018-01-16 12:58:51', '2018-04-14 15:02:06', '1', null);
INSERT INTO `article` VALUES ('38', '5', '0', 'name38', '8', '9', '0', '0', '0', null, '2018-01-16 12:58:51', '2018-04-14 15:02:06', '1', null);
INSERT INTO `article` VALUES ('39', '6', '0', 'name39', '8', '9', '0', '3', '0', null, '2018-01-16 12:59:01', '2018-05-05 22:46:43', '1', null);
INSERT INTO `article` VALUES ('40', '6', '0', 'name40', '8', '9', '0', '2', '0', null, '2018-01-16 12:59:01', '2018-04-19 16:50:14', '1', null);
INSERT INTO `article` VALUES ('41', '6', '0', 'name41', '8', '9', '0', '0', '0', null, '2018-01-16 12:59:01', '2018-04-14 15:02:06', '1', null);
INSERT INTO `article` VALUES ('42', '6', '0', 'name42', '8', '9', '0', '1', '0', null, '2018-01-16 12:59:01', '2018-04-19 16:50:14', '1', null);
INSERT INTO `article` VALUES ('43', '6', '0', 'name43', '8', '9', '0', '5', '0', null, '2018-01-16 12:59:01', '2018-04-22 20:33:55', '1', null);
INSERT INTO `article` VALUES ('44', '6', '0', 'name44', '8', '9', '0', '0', '0', null, '2018-01-16 12:59:02', '2018-04-14 15:02:06', '1', null);
INSERT INTO `article` VALUES ('45', '6', '0', 'name45', '8', '9', '0', '0', '0', null, '2018-01-16 12:59:02', '2018-04-14 15:02:06', '1', null);
INSERT INTO `article` VALUES ('46', '7', '0', 'name46', '8', '9', '0', '0', '0', null, '2018-01-16 12:59:11', '2018-04-14 15:02:06', '1', null);
INSERT INTO `article` VALUES ('47', '7', '0', 'name47', '8', '9', '0', '41', '0', null, '2018-01-16 12:59:11', '2018-05-04 23:54:37', '1', null);
INSERT INTO `article` VALUES ('48', '7', '0', 'name48', '8', '9', '0', '0', '0', null, '2018-01-16 12:59:11', '2018-04-14 15:02:06', '1', null);
INSERT INTO `article` VALUES ('49', '7', '0', 'name49', '8', '9', '0', '0', '0', null, '2018-01-16 12:59:11', '2018-04-14 15:02:06', '1', null);
INSERT INTO `article` VALUES ('50', '7', '0', 'name50', '8', '9', '0', '0', '0', null, '2018-01-16 12:59:11', '2018-04-14 15:02:06', '1', null);
INSERT INTO `article` VALUES ('51', '7', '0', 'name51', '8', '9', '0', '0', '0', null, '2018-01-16 12:59:11', '2018-04-14 15:02:06', '1', null);
INSERT INTO `article` VALUES ('52', '7', '0', 'name52', '8', '9', '0', '0', '0', null, '2018-01-16 12:59:11', '2018-04-14 15:02:06', '1', null);
INSERT INTO `article` VALUES ('53', '8', '0', 'name53', '8', '9', '0', '0', '0', null, '2018-01-16 12:59:21', '2018-04-14 15:02:06', '1', null);
INSERT INTO `article` VALUES ('54', '8', '0', 'name54', '8', '9', '0', '0', '0', null, '2018-01-16 12:59:21', '2018-04-14 15:02:06', '1', null);
INSERT INTO `article` VALUES ('55', '8', '0', 'name55', '8', '9', '0', '0', '0', null, '2018-01-16 12:59:21', '2018-04-14 15:02:06', '1', null);
INSERT INTO `article` VALUES ('56', '8', '0', 'name56', '8', '9', '0', '0', '0', null, '2018-01-16 12:59:21', '2018-04-14 15:02:06', '1', null);
INSERT INTO `article` VALUES ('57', '8', '0', 'name57', '8', '9', '0', '0', '0', null, '2018-01-16 12:59:21', '2018-04-14 15:02:06', '1', null);
INSERT INTO `article` VALUES ('58', '8', '0', 'name58', '8', '9', '0', '2', '0', null, '2018-01-16 12:59:22', '2018-04-22 21:46:22', '1', null);
INSERT INTO `article` VALUES ('59', '8', '0', 'name59', '8', '9', '0', '0', '0', null, '2018-01-16 12:59:22', '2018-04-14 15:02:06', '1', null);
INSERT INTO `article` VALUES ('60', '8', '0', 'name60', '8', '9', '0', '0', '0', null, '2016-05-06 00:00:00', '2018-04-14 15:02:06', '1', null);
INSERT INTO `article` VALUES ('61', '0', '1', 'name61', '8', '18', '0', '0', '0', null, '2018-01-18 17:31:55', '2018-05-07 18:38:08', '0', null);
INSERT INTO `article` VALUES ('62', '0', '1', 'name62', '8', '19', '0', '0', '0', null, '2018-01-18 17:35:58', '2018-05-07 18:38:08', '0', null);
INSERT INTO `article` VALUES ('63', '2', '0', 'name63', '8', '20', '0', '1', '0', null, '2018-01-18 17:36:34', '2018-04-19 16:50:14', '1', null);
INSERT INTO `article` VALUES ('64', '0', '1', 'name64', '8', '21', '0', '0', '0', null, '2018-01-18 17:46:15', '2018-05-07 18:38:08', '0', null);
INSERT INTO `article` VALUES ('65', '0', '1', 'name65', '8', '22', '0', '0', '0', null, '2018-01-18 17:46:34', '2018-05-07 18:38:08', '0', null);
INSERT INTO `article` VALUES ('66', '1', '0', 'name66', '8', '23', '0', '0', '0', null, '2018-01-18 17:47:03', '2018-04-14 15:02:06', '1', null);
INSERT INTO `article` VALUES ('67', '1', '0', 'name67', '8', '24', '0', '1', '0', null, '2018-01-18 17:47:07', '2018-04-19 16:50:14', '1', null);
INSERT INTO `article` VALUES ('68', '0', '1', 'name68', '8', '25', '0', '4', '0', null, '2018-01-22 10:04:52', '2018-05-07 18:38:08', '0', null);
INSERT INTO `article` VALUES ('69', '0', '1', 'name69', '8', '26', '0', '0', '0', null, '2018-01-22 10:08:58', '2018-05-07 18:38:08', '0', null);
INSERT INTO `article` VALUES ('70', '0', '1', 'name70', '8', '27', '0', '0', '0', null, '2018-01-22 11:15:02', '2018-05-07 18:38:08', '0', null);
INSERT INTO `article` VALUES ('71', '0', '1', 'name71', '8', '28', '0', '2', '0', null, '2018-01-22 11:37:32', '2018-05-07 18:38:08', '0', null);
INSERT INTO `article` VALUES ('72', '0', '1', 'name72', '8', '29', '0', '4', '0', null, '2018-01-22 17:47:49', '2018-05-07 18:38:08', '0', null);
INSERT INTO `article` VALUES ('73', '0', '1', 'name73', '8', '30', '0', '1', '0', null, '2018-01-22 17:47:51', '2018-05-07 18:38:08', '0', null);
INSERT INTO `article` VALUES ('74', '0', '1', 'name74', '8', '31', '0', '97', '0', null, '2018-01-23 10:41:35', '2018-05-07 18:38:08', '0', null);
INSERT INTO `article` VALUES ('76', '0', '1', 'name76', '8', '33', '0', '0', '0', null, '2018-01-23 14:05:00', '2018-05-07 18:38:08', '0', null);
INSERT INTO `article` VALUES ('77', '0', '1', 'name77', '8', '34', '0', '0', '0', null, '2018-01-23 14:06:39', '2018-05-07 18:38:08', '0', null);
INSERT INTO `article` VALUES ('78', '0', '1', 'name78', '8', '35', '0', '0', '0', null, '2018-01-23 14:08:55', '2018-05-07 18:38:08', '0', null);
INSERT INTO `article` VALUES ('79', '0', '1', 'name79', '8', '36', '0', '0', '0', null, '2018-01-23 14:12:01', '2018-05-07 18:38:08', '0', null);
INSERT INTO `article` VALUES ('80', '0', '1', 'name80', '14', '37', '0', '2', '0', null, '2018-02-07 17:19:01', '2018-05-07 18:49:44', '0', null);
INSERT INTO `article` VALUES ('81', '1', '0', 'name81', '14', '38', '0', '8', '0', null, '2018-02-07 17:30:37', '2018-05-05 20:25:28', '1', null);
INSERT INTO `article` VALUES ('82', '2', '0', 'name82', '14', '39', '0', '22', '0', null, '2018-02-07 17:34:39', '2018-05-05 20:27:52', '1', null);
INSERT INTO `article` VALUES ('83', '1', '0', 'qweqwe', '1', '40', '0', '16', '0', null, '2018-03-05 14:28:11', '2018-05-05 20:26:50', '-1', null);
INSERT INTO `article` VALUES ('84', '3', '0', 'qweqwe', '1', '41', '0', '3', '0', null, '2018-03-05 14:36:35', '2018-04-22 21:07:16', '1', null);
INSERT INTO `article` VALUES ('85', '1', '0', 'qweqwe', '1', '42', '0', '68', '0', null, '2018-03-05 14:37:46', '2018-05-05 20:21:55', '1', null);
INSERT INTO `article` VALUES ('86', '5', '0', '孤儿', '8', '43', '0', '10', '0', null, '2018-04-14 14:28:10', '2018-05-05 20:17:51', '1', null);
INSERT INTO `article` VALUES ('87', '2', '0', '懒', '14', '44', '0', '3', '0', null, '2018-04-24 10:20:41', '2018-05-01 23:50:23', '1', null);
INSERT INTO `article` VALUES ('88', '2', '0', '自由与责任', '8', '45', '0', '16', '0', null, '2018-04-24 10:23:42', '2018-05-05 18:50:08', '1', null);
INSERT INTO `article` VALUES ('89', '7', '0', '浅谈我对幸福的定义和感受', '8', '46', '0', '42', '0', null, '2018-04-24 10:27:55', '2018-05-06 09:53:41', '1', null);
INSERT INTO `article` VALUES ('92', '7', '0', '浅谈对“年例”习俗的认识和看法', '8', '49', '0', '24', '0', null, '2018-04-24 12:07:10', '2018-05-07 16:21:14', '1', null);
INSERT INTO `article` VALUES ('93', '7', '0', '浅谈对“年例”习俗的认识和看法', '8', '50', '0', '0', '0', null, '2018-04-24 12:10:20', '2018-04-24 12:10:20', '0', null);

-- ----------------------------
-- Table structure for article_click
-- ----------------------------
DROP TABLE IF EXISTS `article_click`;
CREATE TABLE `article_click` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `article_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `day_click` int(11) NOT NULL,
  PRIMARY KEY (`id`,`create_time`),
  KEY `create_time` (`create_time`)
) ENGINE=MyISAM AUTO_INCREMENT=207 DEFAULT CHARSET=utf8
/*!50100 PARTITION BY RANGE (UNIX_TIMESTAMP(create_time))
(PARTITION p_201801 VALUES LESS THAN (1517414400) ENGINE = MyISAM,
 PARTITION p_201802 VALUES LESS THAN (1519833600) ENGINE = MyISAM,
 PARTITION p_201803 VALUES LESS THAN (1522512000) ENGINE = MyISAM,
 PARTITION p_201804 VALUES LESS THAN (1525363200) ENGINE = MyISAM,
 PARTITION p_201805 VALUES LESS THAN (1527782400) ENGINE = MyISAM) */;

-- ----------------------------
-- Records of article_click
-- ----------------------------
INSERT INTO `article_click` VALUES ('6', '23', '8', '2018-03-01 15:59:48', '10');
INSERT INTO `article_click` VALUES ('11', '23', '8', '2018-03-02 15:56:28', '1');
INSERT INTO `article_click` VALUES ('10', '22', '8', '2018-03-02 15:56:28', '1');
INSERT INTO `article_click` VALUES ('9', '20', '14', '2018-03-02 15:56:28', '1');
INSERT INTO `article_click` VALUES ('8', '13', '14', '2018-03-02 15:56:28', '1');
INSERT INTO `article_click` VALUES ('7', '1', '0', '2018-03-02 15:56:28', '2');
INSERT INTO `article_click` VALUES ('12', '1', '0', '2018-03-02 16:50:35', '2');
INSERT INTO `article_click` VALUES ('13', '24', '8', '2018-03-02 17:13:29', '17');
INSERT INTO `article_click` VALUES ('14', '1', '0', '2018-03-05 09:48:14', '1');
INSERT INTO `article_click` VALUES ('15', '9', '14', '2018-03-05 09:48:14', '5');
INSERT INTO `article_click` VALUES ('16', '24', '8', '2018-03-05 09:48:14', '3');
INSERT INTO `article_click` VALUES ('17', '9', '14', '2018-03-05 10:02:14', '9');
INSERT INTO `article_click` VALUES ('18', '13', '14', '2018-03-05 10:02:14', '1');
INSERT INTO `article_click` VALUES ('19', '20', '14', '2018-03-05 10:02:14', '1');
INSERT INTO `article_click` VALUES ('20', '9', '14', '2018-03-05 10:24:05', '1');
INSERT INTO `article_click` VALUES ('21', '13', '14', '2018-03-05 10:24:05', '1');
INSERT INTO `article_click` VALUES ('22', '22', '8', '2018-03-05 11:29:59', '1');
INSERT INTO `article_click` VALUES ('23', '9', '14', '2018-03-06 11:45:16', '2');
INSERT INTO `article_click` VALUES ('24', '1', '0', '2018-03-09 16:43:36', '7');
INSERT INTO `article_click` VALUES ('25', '24', '8', '2018-03-09 16:43:36', '2');
INSERT INTO `article_click` VALUES ('26', '1', '0', '2018-03-12 09:40:34', '3');
INSERT INTO `article_click` VALUES ('27', '1', '0', '2018-03-26 10:29:24', '60');
INSERT INTO `article_click` VALUES ('28', '8', '14', '2018-03-26 10:29:24', '2');
INSERT INTO `article_click` VALUES ('29', '9', '14', '2018-03-26 10:29:24', '40');
INSERT INTO `article_click` VALUES ('30', '24', '8', '2018-03-26 10:29:24', '1');
INSERT INTO `article_click` VALUES ('31', '72', '8', '2018-03-26 10:29:24', '1');
INSERT INTO `article_click` VALUES ('32', '74', '8', '2018-03-26 10:29:24', '7');
INSERT INTO `article_click` VALUES ('33', '9', '14', '2018-03-26 11:40:12', '2');
INSERT INTO `article_click` VALUES ('34', '29', '8', '2018-03-26 11:40:12', '1');
INSERT INTO `article_click` VALUES ('35', '31', '8', '2018-03-26 11:40:12', '3');
INSERT INTO `article_click` VALUES ('36', '71', '8', '2018-03-26 11:40:12', '1');
INSERT INTO `article_click` VALUES ('37', '72', '8', '2018-03-26 11:40:12', '1');
INSERT INTO `article_click` VALUES ('38', '73', '8', '2018-03-26 11:40:12', '1');
INSERT INTO `article_click` VALUES ('39', '74', '8', '2018-03-26 11:40:12', '2');
INSERT INTO `article_click` VALUES ('40', '83', '1', '2018-03-26 11:40:12', '1');
INSERT INTO `article_click` VALUES ('41', '7', '14', '2018-03-31 01:42:07', '1');
INSERT INTO `article_click` VALUES ('42', '9', '14', '2018-03-31 01:42:07', '1');
INSERT INTO `article_click` VALUES ('43', '71', '8', '2018-03-31 01:42:07', '1');
INSERT INTO `article_click` VALUES ('44', '72', '8', '2018-03-31 01:42:07', '2');
INSERT INTO `article_click` VALUES ('45', '74', '8', '2018-03-31 01:42:07', '4');
INSERT INTO `article_click` VALUES ('46', '9', '14', '2018-04-04 10:07:22', '1');
INSERT INTO `article_click` VALUES ('47', '40', '8', '2018-04-04 10:07:22', '1');
INSERT INTO `article_click` VALUES ('48', '74', '8', '2018-04-04 10:07:22', '1');
INSERT INTO `article_click` VALUES ('49', '1', '0', '2018-04-04 16:52:59', '1');
INSERT INTO `article_click` VALUES ('50', '85', '1', '2018-04-04 16:52:59', '2');
INSERT INTO `article_click` VALUES ('51', '9', '14', '2018-04-08 15:01:42', '1');
INSERT INTO `article_click` VALUES ('52', '74', '8', '2018-04-08 15:01:42', '1');
INSERT INTO `article_click` VALUES ('53', '6', '14', '2018-04-08 16:05:41', '1');
INSERT INTO `article_click` VALUES ('54', '85', '1', '2018-04-08 16:05:41', '1');
INSERT INTO `article_click` VALUES ('55', '10', '14', '2018-04-09 14:09:19', '1');
INSERT INTO `article_click` VALUES ('56', '74', '8', '2018-04-09 14:09:19', '5');
INSERT INTO `article_click` VALUES ('57', '81', '14', '2018-04-09 14:09:19', '1');
INSERT INTO `article_click` VALUES ('58', '85', '1', '2018-04-09 14:09:19', '2');
INSERT INTO `article_click` VALUES ('59', '74', '8', '2018-04-09 16:54:56', '1');
INSERT INTO `article_click` VALUES ('60', '47', '8', '2018-04-10 14:06:16', '22');
INSERT INTO `article_click` VALUES ('61', '47', '8', '2018-04-10 15:55:29', '13');
INSERT INTO `article_click` VALUES ('62', '47', '8', '2018-04-10 16:14:38', '4');
INSERT INTO `article_click` VALUES ('63', '47', '8', '2018-04-11 11:17:08', '1');
INSERT INTO `article_click` VALUES ('64', '74', '8', '2018-04-11 11:21:27', '1');
INSERT INTO `article_click` VALUES ('65', '74', '8', '2018-04-11 11:24:08', '2');
INSERT INTO `article_click` VALUES ('66', '74', '8', '2018-04-11 11:26:26', '1');
INSERT INTO `article_click` VALUES ('67', '74', '8', '2018-04-11 11:52:15', '8');
INSERT INTO `article_click` VALUES ('68', '74', '8', '2018-04-11 11:57:29', '4');
INSERT INTO `article_click` VALUES ('69', '74', '8', '2018-04-11 11:59:06', '1');
INSERT INTO `article_click` VALUES ('70', '74', '8', '2018-04-11 17:12:03', '11');
INSERT INTO `article_click` VALUES ('71', '85', '1', '2018-04-11 17:12:03', '2');
INSERT INTO `article_click` VALUES ('72', '74', '8', '2018-04-11 17:19:58', '1');
INSERT INTO `article_click` VALUES ('73', '74', '8', '2018-04-11 17:23:46', '4');
INSERT INTO `article_click` VALUES ('74', '74', '8', '2018-04-11 17:47:12', '1');
INSERT INTO `article_click` VALUES ('75', '74', '8', '2018-04-11 17:55:39', '9');
INSERT INTO `article_click` VALUES ('76', '74', '8', '2018-04-11 18:07:47', '4');
INSERT INTO `article_click` VALUES ('77', '74', '8', '2018-04-11 18:08:56', '1');
INSERT INTO `article_click` VALUES ('78', '74', '8', '2018-04-11 18:14:13', '5');
INSERT INTO `article_click` VALUES ('79', '74', '8', '2018-04-11 18:14:51', '1');
INSERT INTO `article_click` VALUES ('80', '74', '8', '2018-04-13 15:26:43', '4');
INSERT INTO `article_click` VALUES ('81', '81', '14', '2018-04-13 15:36:48', '1');
INSERT INTO `article_click` VALUES ('82', '85', '1', '2018-04-13 15:36:48', '7');
INSERT INTO `article_click` VALUES ('83', '1', '0', '2018-04-13 16:22:48', '1');
INSERT INTO `article_click` VALUES ('84', '81', '14', '2018-04-13 16:22:48', '1');
INSERT INTO `article_click` VALUES ('85', '83', '1', '2018-04-13 16:22:48', '3');
INSERT INTO `article_click` VALUES ('86', '85', '1', '2018-04-13 16:22:48', '27');
INSERT INTO `article_click` VALUES ('87', '1', '0', '2018-04-13 17:18:23', '8');
INSERT INTO `article_click` VALUES ('88', '81', '14', '2018-04-13 17:18:23', '2');
INSERT INTO `article_click` VALUES ('89', '85', '1', '2018-04-13 17:18:23', '2');
INSERT INTO `article_click` VALUES ('90', '39', '8', '2018-04-14 14:29:57', '1');
INSERT INTO `article_click` VALUES ('91', '74', '8', '2018-04-14 14:29:57', '2');
INSERT INTO `article_click` VALUES ('92', '85', '1', '2018-04-14 14:29:57', '8');
INSERT INTO `article_click` VALUES ('93', '85', '1', '2018-04-16 16:37:28', '1');
INSERT INTO `article_click` VALUES ('94', '85', '1', '2018-04-16 16:37:50', '1');
INSERT INTO `article_click` VALUES ('95', '85', '1', '2018-04-17 09:53:51', '2');
INSERT INTO `article_click` VALUES ('96', '10', '14', '2018-04-19 10:02:22', '2');
INSERT INTO `article_click` VALUES ('97', '81', '14', '2018-04-19 10:02:22', '1');
INSERT INTO `article_click` VALUES ('98', '83', '1', '2018-04-19 10:02:22', '1');
INSERT INTO `article_click` VALUES ('99', '85', '1', '2018-04-19 10:02:22', '2');
INSERT INTO `article_click` VALUES ('100', '1', '0', '2018-04-19 16:50:14', '1');
INSERT INTO `article_click` VALUES ('101', '8', '14', '2018-04-19 16:50:14', '1');
INSERT INTO `article_click` VALUES ('102', '9', '14', '2018-04-19 16:50:14', '4');
INSERT INTO `article_click` VALUES ('103', '14', '14', '2018-04-19 16:50:14', '1');
INSERT INTO `article_click` VALUES ('104', '31', '8', '2018-04-19 16:50:14', '1');
INSERT INTO `article_click` VALUES ('105', '35', '8', '2018-04-19 16:50:14', '2');
INSERT INTO `article_click` VALUES ('106', '39', '8', '2018-04-19 16:50:14', '1');
INSERT INTO `article_click` VALUES ('107', '40', '8', '2018-04-19 16:50:14', '1');
INSERT INTO `article_click` VALUES ('108', '42', '8', '2018-04-19 16:50:14', '1');
INSERT INTO `article_click` VALUES ('109', '63', '8', '2018-04-19 16:50:14', '1');
INSERT INTO `article_click` VALUES ('110', '67', '8', '2018-04-19 16:50:14', '1');
INSERT INTO `article_click` VALUES ('111', '74', '8', '2018-04-19 16:50:14', '3');
INSERT INTO `article_click` VALUES ('112', '82', '14', '2018-04-19 16:50:14', '21');
INSERT INTO `article_click` VALUES ('113', '83', '1', '2018-04-19 16:50:14', '1');
INSERT INTO `article_click` VALUES ('114', '85', '1', '2018-04-19 16:50:14', '1');
INSERT INTO `article_click` VALUES ('115', '86', '8', '2018-04-19 16:50:14', '1');
INSERT INTO `article_click` VALUES ('116', '85', '1', '2018-04-20 22:39:33', '1');
INSERT INTO `article_click` VALUES ('117', '14', '14', '2018-04-22 20:33:55', '1');
INSERT INTO `article_click` VALUES ('118', '31', '8', '2018-04-22 20:33:55', '1');
INSERT INTO `article_click` VALUES ('119', '43', '8', '2018-04-22 20:33:55', '5');
INSERT INTO `article_click` VALUES ('120', '74', '8', '2018-04-22 20:33:55', '4');
INSERT INTO `article_click` VALUES ('121', '86', '8', '2018-04-22 20:33:55', '1');
INSERT INTO `article_click` VALUES ('122', '8', '14', '2018-04-22 21:07:16', '1');
INSERT INTO `article_click` VALUES ('123', '58', '8', '2018-04-22 21:07:16', '1');
INSERT INTO `article_click` VALUES ('124', '74', '8', '2018-04-22 21:07:16', '1');
INSERT INTO `article_click` VALUES ('125', '84', '1', '2018-04-22 21:07:16', '3');
INSERT INTO `article_click` VALUES ('126', '58', '8', '2018-04-22 21:46:22', '1');
INSERT INTO `article_click` VALUES ('127', '25', '8', '2018-04-22 22:33:17', '1');
INSERT INTO `article_click` VALUES ('128', '85', '1', '2018-04-22 22:33:17', '1');
INSERT INTO `article_click` VALUES ('129', '1', '0', '2018-04-22 22:56:21', '1');
INSERT INTO `article_click` VALUES ('130', '4', '0', '2018-04-22 22:56:21', '1');
INSERT INTO `article_click` VALUES ('131', '11', '14', '2018-04-23 11:06:33', '1');
INSERT INTO `article_click` VALUES ('132', '85', '1', '2018-04-23 11:06:33', '1');
INSERT INTO `article_click` VALUES ('133', '12', '14', '2018-04-23 16:21:52', '1');
INSERT INTO `article_click` VALUES ('134', '85', '1', '2018-04-24 09:55:20', '1');
INSERT INTO `article_click` VALUES ('135', '16', '14', '2018-04-24 10:05:06', '1');
INSERT INTO `article_click` VALUES ('136', '19', '14', '2018-04-24 10:05:06', '1');
INSERT INTO `article_click` VALUES ('137', '86', '8', '2018-04-24 10:05:06', '1');
INSERT INTO `article_click` VALUES ('138', '74', '8', '2018-04-24 10:56:38', '1');
INSERT INTO `article_click` VALUES ('139', '83', '1', '2018-04-24 10:56:38', '1');
INSERT INTO `article_click` VALUES ('140', '86', '8', '2018-04-24 10:56:38', '2');
INSERT INTO `article_click` VALUES ('141', '4', '0', '2018-04-24 12:11:51', '1');
INSERT INTO `article_click` VALUES ('142', '88', '8', '2018-04-24 12:11:51', '1');
INSERT INTO `article_click` VALUES ('143', '85', '1', '2018-04-24 14:30:51', '1');
INSERT INTO `article_click` VALUES ('144', '88', '8', '2018-04-24 14:30:51', '1');
INSERT INTO `article_click` VALUES ('145', '89', '8', '2018-04-24 14:30:51', '14');
INSERT INTO `article_click` VALUES ('146', '92', '8', '2018-04-24 14:30:51', '7');
INSERT INTO `article_click` VALUES ('147', '89', '8', '2018-04-24 14:31:57', '1');
INSERT INTO `article_click` VALUES ('148', '89', '8', '2018-04-24 14:33:04', '1');
INSERT INTO `article_click` VALUES ('149', '74', '8', '2018-04-24 16:42:01', '2');
INSERT INTO `article_click` VALUES ('150', '81', '14', '2018-04-24 16:42:01', '1');
INSERT INTO `article_click` VALUES ('151', '85', '1', '2018-04-24 16:42:01', '1');
INSERT INTO `article_click` VALUES ('152', '88', '8', '2018-04-24 16:42:01', '4');
INSERT INTO `article_click` VALUES ('153', '89', '8', '2018-04-24 16:42:01', '4');
INSERT INTO `article_click` VALUES ('154', '92', '8', '2018-04-24 16:42:01', '5');
INSERT INTO `article_click` VALUES ('155', '88', '8', '2018-04-24 16:43:54', '1');
INSERT INTO `article_click` VALUES ('156', '88', '8', '2018-04-24 17:33:55', '2');
INSERT INTO `article_click` VALUES ('157', '86', '8', '2018-04-24 17:35:41', '1');
INSERT INTO `article_click` VALUES ('158', '1', '0', '2018-04-24 17:38:37', '1');
INSERT INTO `article_click` VALUES ('159', '74', '8', '2018-04-24 17:38:37', '1');
INSERT INTO `article_click` VALUES ('160', '83', '1', '2018-04-24 17:38:37', '1');
INSERT INTO `article_click` VALUES ('161', '85', '1', '2018-04-24 17:38:37', '3');
INSERT INTO `article_click` VALUES ('162', '86', '8', '2018-04-24 17:38:37', '1');
INSERT INTO `article_click` VALUES ('163', '83', '1', '2018-04-24 17:40:59', '2');
INSERT INTO `article_click` VALUES ('164', '83', '1', '2018-04-24 17:42:03', '1');
INSERT INTO `article_click` VALUES ('165', '83', '1', '2018-04-24 17:46:30', '4');
INSERT INTO `article_click` VALUES ('166', '83', '1', '2018-04-24 17:49:47', '1');
INSERT INTO `article_click` VALUES ('167', '68', '8', '2018-05-01 23:50:23', '4');
INSERT INTO `article_click` VALUES ('168', '74', '8', '2018-05-01 23:50:23', '1');
INSERT INTO `article_click` VALUES ('169', '86', '8', '2018-05-01 23:50:23', '1');
INSERT INTO `article_click` VALUES ('170', '87', '14', '2018-05-01 23:50:23', '3');
INSERT INTO `article_click` VALUES ('171', '88', '8', '2018-05-01 23:50:23', '1');
INSERT INTO `article_click` VALUES ('172', '89', '8', '2018-05-01 23:50:23', '8');
INSERT INTO `article_click` VALUES ('173', '92', '8', '2018-05-01 23:50:23', '1');
INSERT INTO `article_click` VALUES ('174', '81', '14', '2018-05-02 17:15:10', '1');
INSERT INTO `article_click` VALUES ('175', '86', '8', '2018-05-02 17:15:10', '2');
INSERT INTO `article_click` VALUES ('176', '82', '14', '2018-05-03 21:24:29', '1');
INSERT INTO `article_click` VALUES ('177', '88', '8', '2018-05-03 21:24:29', '2');
INSERT INTO `article_click` VALUES ('178', '92', '8', '2018-05-03 21:24:29', '1');
INSERT INTO `article_click` VALUES ('179', '88', '8', '2018-05-04 17:06:10', '1');
INSERT INTO `article_click` VALUES ('180', '92', '8', '2018-05-04 17:06:10', '1');
INSERT INTO `article_click` VALUES ('181', '47', '8', '2018-05-04 23:54:37', '1');
INSERT INTO `article_click` VALUES ('182', '74', '8', '2018-05-04 23:54:37', '1');
INSERT INTO `article_click` VALUES ('183', '88', '8', '2018-05-04 23:54:37', '3');
INSERT INTO `article_click` VALUES ('184', '89', '8', '2018-05-04 23:54:37', '1');
INSERT INTO `article_click` VALUES ('185', '92', '8', '2018-05-04 23:54:37', '1');
INSERT INTO `article_click` VALUES ('186', '5', '0', '2018-05-05 00:11:02', '1');
INSERT INTO `article_click` VALUES ('187', '6', '14', '2018-05-05 00:11:02', '2');
INSERT INTO `article_click` VALUES ('188', '89', '8', '2018-05-05 00:11:02', '1');
INSERT INTO `article_click` VALUES ('189', '92', '8', '2018-05-05 00:11:02', '1');
INSERT INTO `article_click` VALUES ('190', '85', '1', '2018-05-05 11:27:41', '1');
INSERT INTO `article_click` VALUES ('191', '89', '8', '2018-05-05 11:27:41', '3');
INSERT INTO `article_click` VALUES ('192', '89', '8', '2018-05-05 11:32:03', '3');
INSERT INTO `article_click` VALUES ('193', '89', '8', '2018-05-05 11:32:24', '1');
INSERT INTO `article_click` VALUES ('194', '89', '8', '2018-05-05 11:33:02', '1');
INSERT INTO `article_click` VALUES ('195', '89', '8', '2018-05-05 11:34:42', '1');
INSERT INTO `article_click` VALUES ('196', '89', '8', '2018-05-05 11:41:37', '2');
INSERT INTO `article_click` VALUES ('197', '92', '8', '2018-05-05 12:53:37', '4');
INSERT INTO `article_click` VALUES ('198', '9', '14', '2018-05-05 22:46:43', '1');
INSERT INTO `article_click` VALUES ('199', '39', '8', '2018-05-05 22:46:43', '1');
INSERT INTO `article_click` VALUES ('200', '74', '8', '2018-05-05 22:46:43', '1');
INSERT INTO `article_click` VALUES ('201', '92', '8', '2018-05-05 22:46:43', '2');
INSERT INTO `article_click` VALUES ('202', '89', '8', '2018-05-06 09:53:41', '1');
INSERT INTO `article_click` VALUES ('203', '9', '14', '2018-05-07 16:21:14', '1');
INSERT INTO `article_click` VALUES ('204', '74', '8', '2018-05-07 16:21:14', '1');
INSERT INTO `article_click` VALUES ('205', '92', '8', '2018-05-07 16:21:14', '1');
INSERT INTO `article_click` VALUES ('206', '80', '14', '2018-05-07 18:47:17', '2');

-- ----------------------------
-- Table structure for article_content
-- ----------------------------
DROP TABLE IF EXISTS `article_content`;
CREATE TABLE `article_content` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `content` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=51 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of article_content
-- ----------------------------
INSERT INTO `article_content` VALUES ('1', 'hahah什么鬼');
INSERT INTO `article_content` VALUES ('3', 'lalal小辣鸡');
INSERT INTO `article_content` VALUES ('4', 'lalal小辣鸡');
INSERT INTO `article_content` VALUES ('5', 'lalal小辣鸡');
INSERT INTO `article_content` VALUES ('6', 'lalal小辣鸡');
INSERT INTO `article_content` VALUES ('7', 'lalal小辣鸡');
INSERT INTO `article_content` VALUES ('8', 'lalal小辣鸡');
INSERT INTO `article_content` VALUES ('9', 'lalal小辣鸡');
INSERT INTO `article_content` VALUES ('10', 'lalal小辣鸡');
INSERT INTO `article_content` VALUES ('11', 'lalal小辣鸡');
INSERT INTO `article_content` VALUES ('12', 'lalal小辣鸡');
INSERT INTO `article_content` VALUES ('13', 'lalal小辣鸡');
INSERT INTO `article_content` VALUES ('14', 'lalal小辣鸡');
INSERT INTO `article_content` VALUES ('15', 'lalal小辣鸡');
INSERT INTO `article_content` VALUES ('16', 'qweqwe');
INSERT INTO `article_content` VALUES ('18', '1');
INSERT INTO `article_content` VALUES ('19', '1');
INSERT INTO `article_content` VALUES ('20', '1qwwqeqweqew');
INSERT INTO `article_content` VALUES ('21', '诗啊');
INSERT INTO `article_content` VALUES ('22', '诗啊');
INSERT INTO `article_content` VALUES ('23', '诗啊');
INSERT INTO `article_content` VALUES ('24', '诗啊');
INSERT INTO `article_content` VALUES ('25', '<p>eww<strong>wwww</strong>wwwwwww哈啊哈哈哈哈哈哈哈哈哈哈哈哈哈aaasssssssssssssssaaaedaaeww<strong>wwww</strong>wwwwwww哈啊哈哈哈哈哈哈哈哈哈哈哈哈哈aaasssssssssssssssaaaedaaeww<strong>wwww</strong>wwwwwww哈eww<strong>wwww</strong>wwwwwww哈啊哈哈哈哈哈哈哈哈哈哈哈哈哈aaasssssssssssssssaaaedaaeww<strong>wwww</strong>wwwwwww哈啊哈哈哈哈哈哈哈哈哈哈哈哈哈aaasssssssssssssssaaaedaaeww<strong>wwww</strong>wwwwwww哈eww<strong>wwww</strong>wwwwwww哈啊哈哈哈哈哈哈哈哈哈哈哈哈哈aaasssssssssssssssaaaedaaeww<strong>wwww</strong>wwwwwww哈啊哈哈哈哈哈哈哈哈哈哈哈哈哈aaasssssssssssssssaaaedaaeww<strong>wwww</strong>wwwwwww哈eww<strong>wwww</strong>wwwwwww哈啊哈哈哈哈哈哈哈哈哈哈哈哈哈aaasssssssssssssssaaaedaaeww<strong>wwww</strong>wwwwwww哈啊哈哈哈哈哈哈哈哈哈哈哈哈哈aaasssssssssssssssaaaedaaeww<strong>wwww</strong>wwwwwww哈eww<strong>wwww</strong>wwwwwww哈啊哈哈哈哈哈哈哈哈哈哈哈哈哈aaasssssssssssssssaaaedaaeww<strong>wwww</strong>wwwwwww哈啊哈哈哈哈哈哈哈哈哈哈哈哈哈aaasssssssssssssssaaaedaaeww<strong>wwww</strong>wwwwwww哈eww<strong>wwww</strong>wwwwwww哈啊哈哈哈哈哈哈哈哈哈哈哈哈哈aaasssssssssssssssaaaedaaeww<strong>wwww</strong>wwwwwww哈啊哈哈哈哈哈哈哈哈哈哈哈哈哈aaasssssssssssssssaaaedaaeww<strong>wwww</strong>wwwwwww哈</p><p><br/></p>');
INSERT INTO `article_content` VALUES ('26', '<p>eww<strong>wwww</strong>wwwwwww哈啊哈哈哈哈哈哈哈哈哈哈哈哈哈aaasssssssssssssssaaaedaaeww<strong>wwww</strong>wwwwwww哈啊哈哈哈哈哈哈哈哈哈哈哈哈哈aaasssssssssssssssaaaedaaeww<strong>wwww</strong>wwwwwww哈eww<strong>wwww</strong>wwwwwww哈啊哈哈哈哈哈哈哈哈哈哈哈哈哈aaasssssssssssssssaaaedaaeww<strong>wwww</strong>wwwwwww哈啊哈哈哈哈哈哈哈哈哈哈哈哈哈aaasssssssssssssssaaaedaaeww<strong>wwww</strong>wwwwwww哈eww<strong>wwww</strong>wwwwwww哈啊哈哈哈哈哈哈哈哈哈哈哈哈哈aaasssssssssssssssaaaedaaeww<strong>wwww</strong>wwwwwww哈啊哈哈哈哈哈哈哈哈哈哈哈哈哈aaasssssssssssssssaaaedaaeww<strong>wwww</strong>wwwwwww哈eww<strong>wwww</strong>wwwwwww哈啊哈哈哈哈哈哈哈哈哈哈哈哈哈aaasssssssssssssssaaaedaaeww<strong>wwww</strong>wwwwwww哈啊哈哈哈哈哈哈哈哈哈哈哈哈哈aaasssssssssssssssaaaedaaeww<strong>wwww</strong>wwwwwww哈eww<strong>wwww</strong>wwwwwww哈啊哈哈哈哈哈哈哈哈哈哈哈哈哈aaasssssssssssssssaaaedaaeww<strong>wwww</strong>wwwwwww哈啊哈哈哈哈哈哈哈哈哈哈哈哈哈aaasssssssssssssssaaaedaaeww<strong>wwww</strong>wwwwwww哈eww<strong>wwww</strong>wwwwwww哈啊哈哈哈哈哈哈哈哈哈哈哈哈哈aaasssssssssssssssaaaedaaeww<strong>wwww</strong>wwwwwww哈啊哈哈哈哈哈哈哈哈哈哈哈哈哈aaasssssssssssssssaaaedaaeww<strong>wwww</strong>wwwwwww哈</p><p><br/></p>');
INSERT INTO `article_content` VALUES ('27', '<p>1<br/></p>');
INSERT INTO `article_content` VALUES ('28', '<p>sasdsd</p>');
INSERT INTO `article_content` VALUES ('29', '<p>我<br/>我1 我2 &nbsp; &nbsp; &nbsp; 我3 我 4<br/>哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈</p>');
INSERT INTO `article_content` VALUES ('30', '<p>我<br/>我1 我2 &nbsp; &nbsp; &nbsp; 我3 我 4<br/>哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈</p>');
INSERT INTO `article_content` VALUES ('31', '<p>活该你失恋</p><p>这世界每天都会有人失恋，有一些是遇人不淑，有一些是咎由自取。遇人不淑的我只能劝你长点心眼，咎由自取的我只能对你说，你活该。(论点)</p><p>你不自爱又何必奢求别人能爱你。（分论点1）</p><p>有一女，初中时盛气凌人，吸烟，喝酒，打架，骂脏话，一正宗小太妹的样儿。在初三时和某一社会青年在一起，初中毕业后便没读书，十八岁未到已做人母。生完孩子后被男友抛弃，因为没结婚，女的什么都没有，连孩子也没了。于是她整天上微博哭诉，骂那渣男，骂那渣男的家人，如何薄情，如何抢走她的青春、她的孩子。起先我对她像很多人一样还有所同情，毕竟是个女子，可是，她每天在骂呀，在哭诉呀，随着一个个“死贱男”、“死贱人”，一个又一个的粗俗而又恶毒字眼、一个又一个诅咒的出现，我突然想明白了。妹子，你真的活该如此。（事例1）</p><p>或许那男的真的是个渣男，但你也好不到哪儿去。你喜爱夜蒲，你放纵不懂自爱，你一大堆狐朋狗友，你对男友吆喝来吆喝去，你还对男友的家人吆喝来吆喝去，恶言相对，谁能忍你？谁会真心爱你？要是不改，“遇渣男，受伤害”这噩梦似的经历也许将会在你一生里以不同的形式循环往复。（议论1）</p><p>你不自重又何必奢求别人能尊重你。（分论点2）</p><p>高中同学小芳，性格豪爽，乐意帮助别人，因此在高中人缘挺好，并且在高二时与一音乐生在一起，那是她的初恋。那男的两个前女友都在我们班，可谓见一个爱一个。她本就无心学习，从那以后满心思都放在恋爱上，并且家庭里的读书无用论颇为严重，于是，高中毕业后就断了学业之路。她说话粗鲁且大大咧咧，没啥深刻的思想，但这不影响当时的他们相恋。小芳很用心经营着这份恋情，什么好的都给他留着，处处维护他。女为悦己者容，她为他学会了穿着打扮。在高二下学期那男的去广州学习一年的日子里，大家都猜想那男的必定偷腥，可是没有。同样，小芳也拒绝了她的追求者，依旧天天在电话里恩恩爱爱。于是，很多人都认为他们肯定不会分手了。但是我一直认为，他们必定分手，只是时间未到。</p><p>果不其然，高中毕业后，男的去了广州读大学，女的直接去打工了，从此，两个世界。开学以来，争吵不断、冷战不断。终于，两周前，男方提出了分手。她伤心，她痛苦，她挽回。他不理，他不听，他决绝。小芳一直想不懂，为什么他们会弄到这地步，之前一直好好的不是吗。（事例2）我只能说，是你把他看得太重，以至于你把自己给忘了，他也把你忘了，只记得他自己。你以为你有了他，你便有了全世界，殊不知，如今在他心里，甩了你，他会拥有更大的世界。是的，他嫌弃你了。你不自重，你不珍惜自己，你放弃了自己的塑造，于是，落得他的嫌弃。这不能全怪那男人，怪就怪你太天真，这社会太现实。现在你仍然还在等他回心转意，而他却在大学里乐不思蜀。（议论2）</p><p>你没有品质内在又何必奢求别人能珍惜你一辈子。（分论点3）</p><p>老黄，我的高中同学兼好朋友，高中毕业后去了一间较大的商场去做收银员。有一天，她跟我吐槽，她根本无法理解她的某些同事的想法。明明跟她差不多年纪，顶多就是22岁，整天开口闭口都是八卦、男人、衣服首饰，好像除了这些便无东西可讲。一次，她的某位同事失恋，其他同事便顺势展开了对男人的讨论。A女：“早就该分了，每次看到那男的现在的男人那么多(??不通顺)，你不怕找不到啊！”B女：“就是，那男的月薪才那五千多，不到七千我还看不上呢。”C女：“对啊，你年纪还小，不怕没机会啊！”失恋女：“可是我都22岁了，都快变剩女了。”（事例3）</p><p>听完老黄的转述，我深感无语。其实这些想法（什么想法？谁的想法？A?B?C?没说明白）很多女生都会有，受过所谓高等教育的大学生也不例外。这些女生大多有那么一点姿色，没什么思想，被那么几个追求者哄哄便以为自己有多么吸引人，认为优秀的男生才配得上她们，她们能靠这男人过上无忧的生活。（这句与上文事例3有什么关联？）可是，别忘了一句话：“长得漂亮是优势，活得漂亮才是本事。”你现在吸引男人，只因你有那么几分姿色，但是等你老了呢，你靠什么来留住他的心。没有独立的能力，你只能一辈子靠别人，依赖别人，但是别人愿意一直被你这只有皮囊没有内在的人依赖吗？别傻了，别人凭什么这么做。到时候，你失恋了，你怨，你恨，但是你活该。（议论3）</p><p>别人说：“人丑就该多读书。”其实不然，应该是：“人人都该多读书。”永远都别放弃学习，即使你已经没上学。如老黄，她虽然没上大学，但是她在写小说、学吉他、自学英语，我一点儿也不觉得她比我们这些大学生差。所以，女生们，就算是谈恋爱了，结婚了，都要自爱自重，注意内在修养和独立能力的培养。到时候，就算容颜变老，就算没有男人又怎样？依然活得美丽。（总论）</p><p>优点：全文以第一段为总论点，以3个how为分论点（要自重、要自爱、要追求品质）三足鼎立，观点清晰，结构清晰，最重要是+1写的，满分。</p><p>不足：事例本身真实度不强，故说服力不强，希望用比如新闻报道过的，越广为人知越好。否则如同事例3会给人一种为说明论点3而造出来的赶脚。还有我感觉你以你的水平议论还能更深刻点。我读完的感觉是：嗯，我认同这种观点，却没有我被你完全说服的感觉。</p>');
INSERT INTO `article_content` VALUES ('32', '<p>&nbsp;<span style=\"text-indent: 2em;\">小亮亮傻逼</span></p>');
INSERT INTO `article_content` VALUES ('33', '<p>&nbsp;<span style=\"text-indent: 2em;\">小亮亮傻逼</span></p>');
INSERT INTO `article_content` VALUES ('34', '<p>小亮亮傻逼啊！！！</p>');
INSERT INTO `article_content` VALUES ('35', '<p>小亮亮傻逼啊！！！</p>');
INSERT INTO `article_content` VALUES ('36', '<p>小亮亮傻逼啊</p>');
INSERT INTO `article_content` VALUES ('37', '<p>123</p>');
INSERT INTO `article_content` VALUES ('38', '<p>123</p>');
INSERT INTO `article_content` VALUES ('39', '<p>使用js模拟用户选择和Ctrl+C（复制表格可以在excel粘贴）</p><p>function copy(id,tempUrl){</p><p>tempUrl=null||&quot;other/tableTemp.html&quot;</p><p>try{</p><p>//把表格数据提取出来</p><p>var table=$(&quot;#&quot;+id);</p><p>var new_table=document.createElement(&quot;table&quot;);</p><p>new_table.id=&quot;tableTemp001&quot;</p><p>$(new_table).html(table.html());</p><p></p><p>if(document.body.createTextRange){</p><p>//IE</p><p>var iframe=document.createElement(&quot;iframe&quot;);</p><p>iframe.style.height=0;</p><p>iframe.style.width=0;</p><p>iframe.src=tempUrl;</p><p>document.body.appendChild(iframe);</p><p>$(iframe).load(function(){</p><p>iframe.contentDocument.body.appendChild(new_table)</p><p>var txt=iframe.contentDocument.body.createTextRange()</p><p>  txt.moveToElementText(iframe.contentDocument.getElementById(\'tableTemp001\'));</p><p>txt.select();</p><p>iframe.contentDocument.execCommand(&quot;Copy&quot;);</p><p>iframe.remove()</p><p>})</p><p></p><p>}else if(document.createRange&amp;&amp;window.getSelection){</p><p>//火狐复制不带样式</p><p>//由于浏览器安全机制，火狐只能通过显示页面手动点击复制按钮触发copy</p><p>var tableTamp=window.open(tempUrl)</p><p>$(tableTamp).load(function(){</p><p>tableTamp.document.body.appendChild(new_table)</p><p>})</p><p>tableTamp.focus();</p><p></p><p>}else if(document.queryCommandEnabled(\'selectAll\')){</p><p>//使用onload谷歌拒绝使用copy,但ready没样式</p><p>var iframe=document.createElement(&quot;iframe&quot;);</p><p>iframe.style.height=0;</p><p>iframe.style.width=0;</p><p>iframe.src=tempUrl;</p><p>document.body.appendChild(iframe);</p><p>$(iframe).ready(function(){</p><p>iframe.contentDocument.body.innerHTML=&quot;&quot;</p><p>iframe.contentDocument.body.appendChild(new_table);</p><p>iframe.contentDocument.execCommand(&quot;selectAll&quot;)</p><p>iframe.contentDocument.execCommand(&quot;copy&quot;)</p><p>iframe.remove()</p><p>layer.msg(&quot;复制完成&quot;)</p><p>})</p><p>}else{</p><p>layer.msg(&quot;该浏览器不支持复制功能，建议使用谷歌、360、ie8以上版本浏览器&quot;,{icon:2})</p><p>}</p><p>}catch(e){</p><p>console.log(e)</p><p>layer.msg(&quot;出错，复制失败&quot;,{icon:2})</p><p>}</p><p>}</p>');
INSERT INTO `article_content` VALUES ('40', '<p>获取Token</p><p>小程序通过wx.login 获取 code,</p><p>小程序申请后可以获得 app_id 和 app_secret </p><p>通过这三个参数用get的方式传递到微信服务器指定的url （通过后台服务器转发）</p><p>微信服务器返回session_key（对用户数据进行加密签名的密钥）和openid（用户标识）</p><p>为了防止session_key和openid在客户端传输，后台服务器通过生成Token（随机字符串+毫秒数级时间戳+固定字符串， 然后MD5加密生成），返回给客户端，且通过Token为key,session_key和openid为value设置有过期时间的缓存用来验证用户</p>');
INSERT INTO `article_content` VALUES ('41', '<p>获取Token</p><p>小程序通过wx.login 获取 code,</p><p>小程序申请后可以获得 app_id 和 app_secret </p><p>通过这三个参数用get的方式传递到微信服务器指定的url （通过后台服务器转发）</p><p>微信服务器返回session_key（对用户数据进行加密签名的密钥）和openid（用户标识）</p><p>为了防止session_key和openid在客户端传输，后台服务器通过生成Token（随机字符串+毫秒数级时间戳+固定字符串， 然后MD5加密生成），返回给客户端，且通过Token为key,session_key和openid为value设置有过期时间的缓存用来验证用户</p>');
INSERT INTO `article_content` VALUES ('42', '<p>获取Token</p><p>小程序通过wx.login 获取 code,</p><p>小程序申请后可以获得 app_id 和 app_secret </p><p>通过这三个参数用get的方式传递到微信服务器指定的url （通过后台服务器转发）</p><p>微信服务器返回session_key（对用户数据进行加密签名的密钥）和openid（用户标识）</p><p>为了防止session_key和openid在客户端传输，后台服务器通过生成Token（随机字符串+毫秒数级时间戳+固定字符串， 然后MD5加密生成），返回给客户端，且通过Token为key,session_key和openid为value设置有过期时间的缓存用来验证用户</p>');
INSERT INTO `article_content` VALUES ('43', '<p>我是一个“孤儿”</p><p>传说世间每个人也会有一位天使护荫/纵使渺小彷如微尘仍可栖身当爱人呼吸/可惜像我这一种人圣母永远不肯给予怜悯/每天如像苦儿祈求谁可真心的逗我开心/谁说会与我骑木马天黑透了伴我一起归家/是我或你犯错了吗人被半路撇下/受那风吹雨打...</p><p>——《孤儿仔》</p><p>因为爸爸妈妈的原因，我一直活在黑暗中。从小到大，家里战火不断，可笑的是，并没有赢家，每个人都是受害者。我常常在想，是不是我做错了什么，为什么我的爸爸妈妈不像其他小朋友的爸爸妈妈那样相亲相爱。我羡慕他们，我妒忌他们。</p><p>从小就清楚知道，妈妈脾气不好，爸爸喜欢吃喝玩乐，于是家里也是争吵不断。每当他们准备有大争吵，我就会被他们送来送去，姑姑家，伯伯家，外婆家……吵完了再接我回家。到后来，他们都懒得送了，直接就当着我的面开始吵架。</p><p>天真的我以为这样的家已经够令人伤心的了，直到那一次，我才发现，还会有更令人伤心的事会发生。那一次，我吃饭太慢，他们又在吵架，妈妈一生气“啪”一声打掉了我的筷子，我吓得躲在墙角大哭起来。爸爸很生气，他直接打了妈妈一巴掌，随后他们撕打了起来。于是，我亲眼目睹了爸爸妈妈的第一次打架，拳打脚踢，我分不开他们。我撕心裂肺地大哭，我想死。后来邻居来了，把他们分开，爸爸离家了一个月，没人知道他的消息。</p><p>我问奶奶，爸爸去哪儿了，为什么不回来。奶奶说他在外面工作，很快回来了。可是我好想他，我感觉自己要失去他了。一个月后，爸爸满脸伤痕地出现了，我紧紧地抱着他:“爸爸！不要再离开我！我好想你！你去哪儿了，我以为你不要我了！”爸爸哭了。后来才知道，爸爸离家那天去喝了很多酒，出了车祸。我们谁也没提起之前的事，总算过了一段平和的日子。</p><p>但是不知从几年级开始，我家附近出现了赌场，爸爸妈妈学会了赌博，于是，黑暗的日子再次来临。</p><p>他们整天为了钱吵架，动不动就打架，甚至出动了凳子等工具，弄得家不是家；他们很多晚都为了赌博彻夜不归，留我和弟弟在家彼此安慰；他们过年的时候赌得最凶，吵得最凶，打得最频繁，我讨厌新年；他们输了钱甚至会拿我们出气。我讨厌回家，学校多好，什么烦恼都没有。身体上和心灵上的伤痕告诉我，他们不爱我，根本就不在乎我。我从来都不明白为什么其他同学会想早点回家。</p><p>其实不是没尝试过劝他们，可是劝了又怎样，最终伤心的还是自己，只有自己。</p><p>有一次我看到已经晚上十一点了，妈妈还在外面赌博，我异想天开得鼓起勇气去赌场拉拉妈妈，说：“妈妈，回家好不好？”妈妈狠狠地甩开我的手，不耐烦地给了我一个字——滚。纠结了半小时难得鼓起的勇气收到的却是一句刻薄的“滚”。呵呵，哭了一晚后，我总算彻底对她死心了。</p><p>而爸爸，他还会听听我的劝。可是，每次，叫爸爸回家，爸爸总会说，玩完这一局先，于是，我冷着脸，在别的赌徒异样的眼光下，陪着爸爸，看着他，又玩了一局。爸爸永远都不会理解我站在赌场时的感受，那些赌徒的眼神，就像在看一个安静的小丑。直到有次，我憋不住，眼泪掉了下来，别人看到了，戏谑地对爸爸说：“啊宁，你的宝贝女儿哭了，快回家吧，不要再来了，哈哈。”爸爸看了我一眼，立马带我回家。但是，一个星期后，他又出现在赌场，我彻底绝望。从此死心，没再去劝过他们，也没再叫过一声“爸爸”、“妈妈”。</p><p>升初中后，他们争吵打骂的频率越来越高，基本上已经到了一见面就吵的程度，而我也越来越恨他们。我想，堕落就是对他们最好的报复。于是，不学习，不听话，迟到早退，说谎，骂老师，作弊，打架斗殴，说脏话，早恋，成为大人眼中的坏孩子。他们对我很失望，所有人都对我很失望，我又何尝不是。可是又有谁知道，我为何要放弃自己？</p><p>初三的那个元旦，他们终于离了婚。而元旦前一夜，他们进行了最为严重的一次打架，那一夜，我以为我们一家四口起码会死一个人。爸爸抓着妈妈的头撞楼梯，我以为妈妈会死；妈妈拿起菜刀，我以为爸爸会死；我拦着妈妈，我以为我会死；弟弟挡着喝醉的爸爸接近妈妈，我以为弟弟会死。所幸，不幸中大幸，我们都没死。哈哈，居然没死。</p><p>离了婚后，我归爸爸，弟弟归妈妈，很多人都以为我会很伤心、很痛苦，其实不是的，这么多年，我终于解脱了，真好。那天妈妈躺在床上，对我说:“你好好跟着你爸。”我哈哈大笑。</p><p>从此，沉默寡言，冷漠带刺。</p><p>有一天，爸爸跟我说了句:“你恨我吗？”我惊讶了一下，默然点了点头。你害我没了家，没了妈妈。他悲凉地笑了笑，我也悲凉地笑了笑。</p><p>我就是一个父母还健在的孤儿。</p>');
INSERT INTO `article_content` VALUES ('44', '<p>只要是跟我有点熟悉的人都知道，我很懒。</p><p>不仅在生活方面是个懒人，而且在为人处世方面方面也是个懒人。</p><p>因为，很多时候我都懒得动脑子去想。比如写作文时，老师说了自由发挥，那我就会随自己的心去写，而不会去想怎么迎合老师的想法；别人真正需要我帮忙时，我都会尽力去帮，而不会去想会有什么得失；选专业时，我就按自己喜好选了我的专业，而不会去想这专业是否热门，是否会有前途；别人误会我了，那我就解释呗，解释完就雨过天晴了，而不会去想那人“怎么这样，怎么可以这样想我，明明我就没干过”什么的耿耿于怀。我的脑子还有更重要的事要思考，我思考人生，我思考人性，我思考自己的路，怎么能因为那些虚无缥缈而又无聊无趣的事浪费脑力呢。</p><p>我是个很懒的人，我懒得去想怎么迎合别人，我只有一颗真诚的心，若你也有，那我们一定是好友，若你没有，那便注定是陌路人，没啥可惜。我懒得去想别人的动机，别人接近自己，肯定是因为自己有值得别人吸引的地方，这是好事，日久见人心，何必想动机，整天想着别人接近自己是不是为了得到什么好处的人不是自恋狂就是神经病。我懒得去想别人对自己的看法，人生是自己的，为什么要被别人言语左右，自己活得问心无愧、开心快乐就好，何必去想那些无谓又无聊的东西。</p><p>借我东西，无所谓啊，那就借呗，记得还回来就行，我借给你不是因为想你欠我人情，而是我知道你真的需要我的帮助。不小心弄坏了我的东西，没关系啊，毕竟你也不是故意的，尽力修好就行，修不好也无所谓啦，尽力了就行。自己弄丢了东西怎么找也找不到怎么办，凉拌呗，丢都丢了，重新开始吧，又不是天塌下来，若是因为丢了这些东西而整天闷闷不乐反而更可悲。</p><p>我看得开身外之物并不是因为我是有钱人，我只是一个来自普通家庭的女孩。但是我知道，什么是值得放在心上的，什么是不值得的。亲爱的家人、可爱的朋友、美味的食物、美丽的风景、自己的修养与思想等，这些才是值得我放在心上的东西。其他那些都是些鸡毛蒜皮的小事情，不值一提，我可不希望自己会因为鸡毛蒜皮的小事而影响到我宝贵的心情。</p><p>也许就是因为我这么懒，让我烦心的事少之又少，于是每天都嘻嘻哈哈、快快乐乐而又充实，即使明天要考试了，我还没复习过，我也能晚上十一点半准时上床睡觉。</p><p>我今天做了一个调查，让跟我比较熟悉的人用一个字来评价我，其中的评价有“傻、逗、二、癫、疯”等，完全没有正面字眼，但是有什么所谓呢，在他们心里我就是制造快乐的人，而给大家带来快乐就是我的快乐。</p><p>做一个快乐的懒人又何妨？</p><p><br/></p><p><br/></p>');
INSERT INTO `article_content` VALUES ('45', '<p>为期四周的人生之旅课程快要结束了，但通过其中的三节课我获益匪浅，也深有感触。我时常在想我们是否获得了我们该有的自由，我们是否尽到了为人子，为学生的责任。</p><p>&nbsp;&nbsp;&nbsp;&nbsp;于我而言，自由其实真的是很难获得的东西。在家里，父母做任何事前几乎都不会问及我的意见和感受，他们会把他们认为是好的的东西都留给我。比如妈妈会经常给我买她喜欢的衣服，但也只限于她喜欢，而我只能默默接受。再比如家里晚上有门禁，只要一到晚上不管我愿不愿意也只能呆在家里，尽管我已经成年了。每当晚上有同学聚会的时候，我只能找一个又一个借口来推脱从而来掩饰家里有门禁这条荒唐的理由，然后一个人独自感伤。</p><p>&nbsp;&nbsp;&nbsp;&nbsp;我佩服他们的能够跨省甚至于跨国骑行、能够去到子弹蚁部落挑战自己、能够放弃高额年薪去感受世界。当然尽管对我来说自由难能可贵，我也有自己的自由。我喜欢打游戏，也交到一群喜欢打游戏的死党。于是乎我最大的乐趣便是周末时约上几个死党去网吧组队打游戏打上一整个下午，这与我而言更胜于骑行或者去感受世界，因为这就是我的爱好，同时也是我的自由。</p><p>&nbsp;&nbsp;&nbsp;&nbsp;当然，自由是建立在责任的基础上的。我不会也不可能像郭沫若和徐志摩一样为了所谓的追求自由而抛妻弃子，放弃自己的责任。真正的自由与责任是离不开的，否则自由就不再是自由，而是放纵了。因此，尽管我经常打游戏，但我不会忘记自己是学生的身份，我还是要学习，不能把功课落下。而且身为人子，我也不能让父母失望。但我绝对不会只为学习而抛弃我喜欢的游戏，也绝对不会认同游戏如毒药的说法，这是以偏概全的，并不能代表所有人都会沉迷而不可自拔。正如超级课程表的创始人余佳文不相信90后就是颓废的，扶不起的一代一样。</p><p>&nbsp;&nbsp;&nbsp;&nbsp;现在我发现一个很有趣的现象，我的朋友们都喜欢问我——你天天打游戏为何成绩还比我高。我想这或许就是自由与责任平衡后双赢的结果吧。在学到知识感到充实之余还收获打游戏的快乐，这就是我，这就是我现在的状态。</p><p><br/></p>');
INSERT INTO `article_content` VALUES ('46', '<p>幸福，这是每个人一生中都或多或少会接触到的一个词。我们常说幸福幸福，那么我们幸福了吗？</p><p>雷锋说过“我是广大劳苦大众当中的一员，我能帮助人民克服一点困难，是最幸福的。”雷锋认为助人便是最大的幸福。那么我们呢？我们都一样吗？其实每个人对幸福的定义都是不一样的。一颗糖，一个雪糕也许对于小朋友们来说是幸福，但对于一个成年人来说可就不一定了。他们的幸福或在于金钱、跑车，或在于身体健康、家庭和睦……</p><p>我对于幸福的定义是分两方面的：短期的幸福和长期的幸福。</p><p>所谓短期的幸福也就是个人短时间内的生活状态。它很容易受心情影响。比如说你考试得了全班第一，或者你因助人为乐受到了他人的赞扬……这会让你得到幸福，而这种幸福是短时间的。如果你现在问我：“你幸福吗？”我会以我对短期幸福的理解来回答你：“幸福”。原因是自我步入大学以来，我发现现实的大学与我想象中上完课就会回宿舍打机睡觉的大学生活不同，现实的大学更加的积极，我能参加各类社团，各类活动，能与部门，班级聚会玩耍，还有各类学术竞赛。我为我能过上这样积极的大学生活感到幸福。</p><p>虽然短期的幸福很重要，但我认为长期的幸福更重要。</p><p>长期的幸福的时间段我把它定义为自出生到现在，也可以认为是一生。我认为只有对你自己的人生感到幸福才是真正的幸福。如果你以这种长期幸福的定义来问我是否幸福，那么我还会回答：“幸福”。尽管小时候我因为成绩不好经常挨到父母的打骂，但我却有着更多任何人也无法比拟的快来时光，因此我拥有一个精彩难忘的童年。初高中以及大学时期也因为成绩不够理想而与进自己想要去的学校失之交臂，但却因此遇到了众多小伙伴并一起快来的生活着。如果上天再给我一次机会让我去我想去的学校开启一条新的人生路但条件是失去你现在的人生，即失去了自己认识自己结交到的小伙伴以及与他们相处的回忆，那么我想我会忍不住爆粗：“去你MGLB”。所以，可以说我拥有一个精彩无憾的人生。在这条人生路上，我有过开心愉悦的经历，有过不堪回首的往事，也有过众多平淡无趣的时候，但正因为这些看似平常的经历、回忆的交织，形成了我独特精彩的人生。那么我还有什么理由说自己不幸福呢？</p><p>穆尼尔纳素夫说过“真正的幸福只有当你真实地认识到人生的价值时，才能体会到。”如果我认同这样的定义，那么我想我的人生价值便在于我那精彩独特的人生吧。这便是我眼中的幸福。</p>');
INSERT INTO `article_content` VALUES ('50', '<p>摘要：</p><p>“年例”作为粤西地区的一个独特的汉族传统民俗节日，由来已久。其有着不同来由故事，多样的举办方式，体现了多样文化的交融共进。“年例”在粤西农民心中的地位不可动摇，对我们有着极其重要的意义。“年例”这个在粤西农村地区最为大型的民俗节日应该广泛地被人们认知。</p><p>关键词：   年例；粤西；湛江；民俗；文化 </p><p>在一次与大学同学的交谈中，我们聊着聊着聊到了家乡的传统节日，于是我便说起了我们独有的“年例”。只是在我们的交谈中，我发现有些同学对粤西地区“年例”习俗了解甚少，甚至有几个同学对“年例”习俗一无所知。离开家乡的游子总是忆乡情切，情感强烈的游子也总希望家乡能为人所了解。于是，我便决心写文把家乡的“年例”习俗带到人们的视野。</p><p>年例虽是粤西地区的传统节日，但我只对湛江地区的年例较为了解，这里便只要从湛江年例的角度开始聊。</p><p>一.年例的重要性。</p><p>年例，汉族民间岁时习俗。春节前后，湛江各地的年例活动如百花竞放，遍及广大城镇乡村。在汉族众多传统节日中，春节可算是最为热闹的。然而在湛江农村地区，年例才是最为重要的节日。</p><p> 在市区里，越来越多的人们慢慢将春节转化为自己一年中最重要的传统节日。不过在农村，为人乐道的还是年例，做“年例”，探“年例”，吃“年例”是农村人不变的节目，许许多多的小孩子也在盼年例。</p><p>春节时分的相聚是一家一家拜访的相聚。与之相比，年例时的相聚却是所有亲朋好友聚集在一场的相聚，规模及其重要性可见一般。</p><p>每每到了村里的年例节日，从学校走回家里的的时间总是要多花一倍，路上的交通状况让人惨不忍睹，堵死了的马路上，尽管总有5,6名交警管理交通，可是交通状况却是丝毫没有好转，已经到了近乎瘫痪的地步。路上的小车早已是寸步难行，也唯有步行的人们能够勉强通过，而这种交通状况可要持续好几个小时，一直到下午时分，各家的亲朋好友们用过饭离开了一些才有好转。</p><p>上午到中午的这个时间段，每家每户都会在门前摆好祭神台，点上几根香，放上几捆鞭炮来保佑今年家人能够顺顺利利，开开心心。可这却是让放学回家的学生们心惊胆跳了，学生们好不容易穿过拥挤的车群，却又遇上好几户人家在路上放鞭炮，生怕哪个不长眼的鞭炮飞过来炸到自己，那场景我却是深有体会了。不过学生们却也不见怪，毕竟这也算是一种欢迎仪式吧。</p><p>二.年例的由来</p><p>经专家探究，人们普遍认同的来由故事有三种。</p><p>第一种说法是：湛江的“年例”也是由元宵节衍化而来。自汉唐以来，中原文化习俗逐渐渗透粤西大地，过年和元宵节持灯嬉游的习惯也被接受，与本地习俗庆祝丰收、祈祷祭祀日子结合后，逐步演变成现今隆重热烈、极受村民重视的民俗节日。</p><p>第二种说法是：年例和冼太夫人有一定的关联。年例活动由粤西冼氏家族祭祀祈福而兴起，长期演化后成为今天的年例。</p><p>第三种说法是：做年例是为了驱瘟逐疫。据说古时候有一个瘟神，常常作恶粤西人民，搞得民不聊生，于是，粤西人民自发开展驱瘟逐疫活动，但瘟神十分狡猾，当一个地方驱赶它的时候，它就跑到另一个地方，为此，智慧无穷的粤西地区人民便采取各地各村有“年例期”的做法驱逐瘟疫。</p><p>但以上三种说法都没有充足的史料予以考证。</p><p>为了解决我的疑惑我便专门问过好些个大人，他们给我的说法是年例的日子实际上就是各个村子的农历生日。那么说来年例就是庆生的日子了。这也很好的说明了为什么各个村子的年例时间都不一样。只是这样的说法是不是适用于所有的地区我却是不得而知了。不过正是这种不得而知，正是有着多种的来由故事，年例也便充满了迷幻的色彩。</p><p>三.年例的内容</p><p>每年的年例，家里的大人们总是要凌晨4，5点便起身准备。于是乎各种杀鸡，杀鸭声，走动声齐鸣，这对于还没睡醒的小孩子来说最为头疼了。“怕是上课又要睡觉了”每年我都会有这样的想法，既期待又无奈。可到了课堂上却是有睡不着的，因为太过于期待兴奋了，毕竟一年才有一次，而且一想到满桌子的菜我们便总是忍不住咽口水。</p><p>作为主要内容之一的聚餐早已迷得学生们神魂颠倒。</p><p>网络上有一种对年例聚餐的说法甚是贴切：“在年例这一天，村子就是饭桶的天堂”。农村的房子里大多都有院落，那么年例时，院落便成了摆法饭桌最佳的位置，当当就我家而言，每到年例都会摆上8，9桌，从不例外，聚餐时吵杂的玩笑声交织成一片，虽说别家的玩闹声也是很大，但却是淹没己家客人发玩闹声中。一杯酒尽述一生欢快悲愁，一年未见的亲戚友人又岂是一杯酒的诉说所能打发的。大人们常常都是大鱼大虾，觥筹交错，诉说着一年来的快事，诉说着一年未见想说的话语，常常一语便到深夜。</p><p>年例除了聚餐之外，还有一项很重要的标志性活动——游神。</p><p>在湛江地区，无论是市区还是乡村，新年游神都十分热闹。湛江地区几乎每个村庄都有游神的风俗。游神的种类各式各样，热闹非凡。有些村庄的游神时间比较长，白天游完本村，晚上接着游神。湛江市及周边地区在每年年例都会组织游神，当地俗称“游神舞狮大会”。</p><p>游神的队伍除了一些必要的组织者，大多都是村里人自愿去参加的。每当游神的队伍经过家门口，家里有意愿的大人或者小孩们都可以加入到游神的队伍，他们要扛着游神的大旗，游遍整条村子才能回来。游神的队伍里有着高难度有急剧观赏性的活人飘色活动，又有着充满传统迷幻色彩嘴穿针活动（用锥子穿透嘴巴，不痛不痒，拔出后没有伤口，可怕却又无法解释的活动）。每当游神队伍到来，每家每户都会献上红包，表达对新一年村子过得顺顺利利的祝福和对合家欢庆的祈祷。伴随着游神队伍的是不停的鼓声和喇叭声，鞭炮声。</p><p>当然，每年的年例都少不了粤剧表演，辛苦了一整年的粤剧表演者们终于又有了登台表演的机会，从上一年的年例结束开始，他们便要努力编排新的曲目，等待来年的登台。每年的年例粤剧表演老人们都看得津津乐道，可是小孩子们确都大多看不懂。但这并不妨碍孩子们的玩耍，他们或是在舞台的后台追逐打闹，或是在拥挤的人群中玩捉迷藏，又或是要来几块钱在舞台旁的小摊上惬意地享受咖啡，油条等各类小吃去了。</p><p>除了聚餐，游神和粤剧表演外，还有着舞龙、舞狮、杂剧以及各种各样的文化活动，可见年例的活动的丰富多样。 </p><p>四.年例的影响</p><p>年例传为一种传统习俗，在传承和发展过程中虽说免不了封建迷信，铺张浪费，但也融汇了健康向上的内容，促进了消费增长。</p><p>有民俗专家认为：“年例是以习俗的力量让民众自动在集中的时间段经历相同的活动,在相同的仪式中体验相同的价值,一个共同的社会就这么让人们和谐地延续下来。这就是传统节日最经济、最有效的生活文化再生产功能。”</p><p>年例过程中，亲朋好友们都带着他们的礼物和祝福从各方赶来，促进了亲情和友情的交流，是一次亲情和友情的回归。有一些商界精英们的回归后，对村子的建设大力支持，他们都主动出资出力为村子修路，建学校，促进了村子的发展。</p><p>“年例”作为粤西影响力最大，范围最广的节日，也具有经济功能。由于年例集中，物价不但没降，反而有上升，特别是年例中主要的菜式原料如鸡、猪肚、白鸽、海虾、鱿鱼等每年都比平常升幅超过20%以上，而其它菜式佐料也有一定升幅。年例期间由于食品及相关物品需求量空前增大，一些日常没有经营的居民也做起了商贩，走街串巷觅商机，甚至一些外地群众闻讯也来到湛江地区做起年例生意。</p><p>在年例的带动下，各村人名和睦发展，各村的文化也得以交融。人们在这一天里都收获了满满的祝福，对未来的发展充满自信。同时在政府的引导下，其推动了粤西人民的精神文明建设，让文化、思想在农村蓬勃发展。</p>');
INSERT INTO `article_content` VALUES ('49', '<p>摘要：</p><p>“年例”作为粤西地区的一个独特的汉族传统民俗节日，由来已久。其有着不同来由故事，多样的举办方式，体现了多样文化的交融共进。“年例”在粤西农民心中的地位不可动摇，对我们有着极其重要的意义。“年例”这个在粤西农村地区最为大型的民俗节日应该广泛地被人们认知。</p><p>关键词：   年例；粤西；湛江；民俗；文化 </p><p>在一次与大学同学的交谈中，我们聊着聊着聊到了家乡的传统节日，于是我便说起了我们独有的“年例”。只是在我们的交谈中，我发现有些同学对粤西地区“年例”习俗了解甚少，甚至有几个同学对“年例”习俗一无所知。离开家乡的游子总是忆乡情切，情感强烈的游子也总希望家乡能为人所了解。于是，我便决心写文把家乡的“年例”习俗带到人们的视野。</p><p>年例虽是粤西地区的传统节日，但我只对湛江地区的年例较为了解，这里便只要从湛江年例的角度开始聊。</p><p>一.年例的重要性。</p><p>年例，汉族民间岁时习俗。春节前后，湛江各地的年例活动如百花竞放，遍及广大城镇乡村。在汉族众多传统节日中，春节可算是最为热闹的。然而在湛江农村地区，年例才是最为重要的节日。</p><p> 在市区里，越来越多的人们慢慢将春节转化为自己一年中最重要的传统节日。不过在农村，为人乐道的还是年例，做“年例”，探“年例”，吃“年例”是农村人不变的节目，许许多多的小孩子也在盼年例。</p><p>春节时分的相聚是一家一家拜访的相聚。与之相比，年例时的相聚却是所有亲朋好友聚集在一场的相聚，规模及其重要性可见一般。</p><p>每每到了村里的年例节日，从学校走回家里的的时间总是要多花一倍，路上的交通状况让人惨不忍睹，堵死了的马路上，尽管总有5,6名交警管理交通，可是交通状况却是丝毫没有好转，已经到了近乎瘫痪的地步。路上的小车早已是寸步难行，也唯有步行的人们能够勉强通过，而这种交通状况可要持续好几个小时，一直到下午时分，各家的亲朋好友们用过饭离开了一些才有好转。</p><p>上午到中午的这个时间段，每家每户都会在门前摆好祭神台，点上几根香，放上几捆鞭炮来保佑今年家人能够顺顺利利，开开心心。可这却是让放学回家的学生们心惊胆跳了，学生们好不容易穿过拥挤的车群，却又遇上好几户人家在路上放鞭炮，生怕哪个不长眼的鞭炮飞过来炸到自己，那场景我却是深有体会了。不过学生们却也不见怪，毕竟这也算是一种欢迎仪式吧。</p><p>二.年例的由来</p><p>经专家探究，人们普遍认同的来由故事有三种。</p><p>第一种说法是：湛江的“年例”也是由元宵节衍化而来。自汉唐以来，中原文化习俗逐渐渗透粤西大地，过年和元宵节持灯嬉游的习惯也被接受，与本地习俗庆祝丰收、祈祷祭祀日子结合后，逐步演变成现今隆重热烈、极受村民重视的民俗节日。</p><p>第二种说法是：年例和冼太夫人有一定的关联。年例活动由粤西冼氏家族祭祀祈福而兴起，长期演化后成为今天的年例。</p><p>第三种说法是：做年例是为了驱瘟逐疫。据说古时候有一个瘟神，常常作恶粤西人民，搞得民不聊生，于是，粤西人民自发开展驱瘟逐疫活动，但瘟神十分狡猾，当一个地方驱赶它的时候，它就跑到另一个地方，为此，智慧无穷的粤西地区人民便采取各地各村有“年例期”的做法驱逐瘟疫。</p><p>但以上三种说法都没有充足的史料予以考证。</p><p>为了解决我的疑惑我便专门问过好些个大人，他们给我的说法是年例的日子实际上就是各个村子的农历生日。那么说来年例就是庆生的日子了。这也很好的说明了为什么各个村子的年例时间都不一样。只是这样的说法是不是适用于所有的地区我却是不得而知了。不过正是这种不得而知，正是有着多种的来由故事，年例也便充满了迷幻的色彩。</p><p>三.年例的内容</p><p>每年的年例，家里的大人们总是要凌晨4，5点便起身准备。于是乎各种杀鸡，杀鸭声，走动声齐鸣，这对于还没睡醒的小孩子来说最为头疼了。“怕是上课又要睡觉了”每年我都会有这样的想法，既期待又无奈。可到了课堂上却是有睡不着的，因为太过于期待兴奋了，毕竟一年才有一次，而且一想到满桌子的菜我们便总是忍不住咽口水。</p><p>作为主要内容之一的聚餐早已迷得学生们神魂颠倒。</p><p>网络上有一种对年例聚餐的说法甚是贴切：“在年例这一天，村子就是饭桶的天堂”。农村的房子里大多都有院落，那么年例时，院落便成了摆法饭桌最佳的位置，当当就我家而言，每到年例都会摆上8，9桌，从不例外，聚餐时吵杂的玩笑声交织成一片，虽说别家的玩闹声也是很大，但却是淹没己家客人发玩闹声中。一杯酒尽述一生欢快悲愁，一年未见的亲戚友人又岂是一杯酒的诉说所能打发的。大人们常常都是大鱼大虾，觥筹交错，诉说着一年来的快事，诉说着一年未见想说的话语，常常一语便到深夜。</p><p>年例除了聚餐之外，还有一项很重要的标志性活动——游神。</p><p>在湛江地区，无论是市区还是乡村，新年游神都十分热闹。湛江地区几乎每个村庄都有游神的风俗。游神的种类各式各样，热闹非凡。有些村庄的游神时间比较长，白天游完本村，晚上接着游神。湛江市及周边地区在每年年例都会组织游神，当地俗称“游神舞狮大会”。</p><p>游神的队伍除了一些必要的组织者，大多都是村里人自愿去参加的。每当游神的队伍经过家门口，家里有意愿的大人或者小孩们都可以加入到游神的队伍，他们要扛着游神的大旗，游遍整条村子才能回来。游神的队伍里有着高难度有急剧观赏性的活人飘色活动，又有着充满传统迷幻色彩嘴穿针活动（用锥子穿透嘴巴，不痛不痒，拔出后没有伤口，可怕却又无法解释的活动）。每当游神队伍到来，每家每户都会献上红包，表达对新一年村子过得顺顺利利的祝福和对合家欢庆的祈祷。伴随着游神队伍的是不停的鼓声和喇叭声，鞭炮声。</p><p>当然，每年的年例都少不了粤剧表演，辛苦了一整年的粤剧表演者们终于又有了登台表演的机会，从上一年的年例结束开始，他们便要努力编排新的曲目，等待来年的登台。每年的年例粤剧表演老人们都看得津津乐道，可是小孩子们确都大多看不懂。但这并不妨碍孩子们的玩耍，他们或是在舞台的后台追逐打闹，或是在拥挤的人群中玩捉迷藏，又或是要来几块钱在舞台旁的小摊上惬意地享受咖啡，油条等各类小吃去了。</p><p>除了聚餐，游神和粤剧表演外，还有着舞龙、舞狮、杂剧以及各种各样的文化活动，可见年例的活动的丰富多样。 </p><p>四.年例的影响</p><p>年例传为一种传统习俗，在传承和发展过程中虽说免不了封建迷信，铺张浪费，但也融汇了健康向上的内容，促进了消费增长。</p><p>有民俗专家认为：“年例是以习俗的力量让民众自动在集中的时间段经历相同的活动,在相同的仪式中体验相同的价值,一个共同的社会就这么让人们和谐地延续下来。这就是传统节日最经济、最有效的生活文化再生产功能。”</p><p>年例过程中，亲朋好友们都带着他们的礼物和祝福从各方赶来，促进了亲情和友情的交流，是一次亲情和友情的回归。有一些商界精英们的回归后，对村子的建设大力支持，他们都主动出资出力为村子修路，建学校，促进了村子的发展。</p><p>“年例”作为粤西影响力最大，范围最广的节日，也具有经济功能。由于年例集中，物价不但没降，反而有上升，特别是年例中主要的菜式原料如鸡、猪肚、白鸽、海虾、鱿鱼等每年都比平常升幅超过20%以上，而其它菜式佐料也有一定升幅。年例期间由于食品及相关物品需求量空前增大，一些日常没有经营的居民也做起了商贩，走街串巷觅商机，甚至一些外地群众闻讯也来到湛江地区做起年例生意。</p><p>在年例的带动下，各村人名和睦发展，各村的文化也得以交融。人们在这一天里都收获了满满的祝福，对未来的发展充满自信。同时在政府的引导下，其推动了粤西人民的精神文明建设，让文化、思想在农村蓬勃发展。</p>');

-- ----------------------------
-- Table structure for category
-- ----------------------------
DROP TABLE IF EXISTS `category`;
CREATE TABLE `category` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `img` varchar(100) NOT NULL,
  `describe` varchar(200) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of category
-- ----------------------------
INSERT INTO `category` VALUES ('1', '诗歌', '/img/theme/1.jpg', '<p>诗歌是一种大的文学样式，它要求高度、集中地概括、反映社会生活，饱含着丰富的思想感情和想象，语言精炼而形象性强，并具有一定的节奏韵律，一般分行排列,它在各种文学体裁中出现最早。诗歌是一种抒情言志的文学体裁。《毛诗-大序》载：“诗者，志之所之也。在心为志，发言为诗”。南宋严羽《沧浪诗话》云：“诗者，吟咏性情也”。只有一种用言语表达的艺术就\r\n是诗歌。</p>');
INSERT INTO `category` VALUES ('2', '散文', '/img/theme/2.jpg', '<p>散文是一种抒发作者真情实感、写作方式灵活的记叙类文学体裁。“散文”一词大概出现在北宋太平兴国(976年12月-984年11月)时期。 《辞海》认为：中国六朝以来，为区别韵文与骈文，把凡不押韵、不重排偶的散体文章(包括经传史书)，统称“散文”。后又泛指诗歌以外的所有文学体裁。 随着时间的发展，散文的概念由广义向狭义转变，并受到西方文化的影响。</p>');
INSERT INTO `category` VALUES ('3', '小说', '/img/theme/3.jpg', '<p>小说，以刻画人物形象为中心，通过完整的故事情节和环境描写来反映社会生活的文学体裁。人物、情节、环境是小说的三要素。情节一般包括开端、发展、高潮、结局四部分，有的包括序幕、尾声。环境包括自然环境和社会环境。</p>');
INSERT INTO `category` VALUES ('4', '戏剧', '/img/theme/4.jpg', '<p>戏剧，指以语言、动作、舞蹈、音乐、木偶等形式达到叙事目的的舞台表演艺术的总称。文学上的戏剧概念是指为戏剧表演所创作的脚本，即剧本。戏剧的表演形式多种多样，常见的包括话剧、歌剧、舞剧、音乐剧、木偶戏等。戏剧是由演员扮演角色在舞台上当众表演故事的一种综合艺术。');
INSERT INTO `category` VALUES ('5', '记叙', '/img/theme/5.jpg', '<p>记叙是写作中最基本、最常见的一种表达方式，它是作者对人物的经历和事件的发展变化过程以及场景、空间的转换所作的叙说和交待。它是写作中最基本、最常见、也是最主要的表达方式。在写事文章中应用较为广泛。</p>');
INSERT INTO `category` VALUES ('6', '说明', '/img/theme/6.jpg', '<p>说明文是一种以说明为主要表达方式的文章体裁 [1]  。它通过对实体事物科学地解说，对客观事物做出说明或对抽象事理的阐释，使人们对事物的形态、构造、性质、种类、成因、功能、关系或对事理的概念、特点、来源、演变、异同等能有科学的认识，从而获得有关的知识。说明文的中心鲜明突出，文章具有科学性，条理性，语言确切生动。它通过揭示概念来说明事物特征、本质及其规律性。</p>');
INSERT INTO `category` VALUES ('7', '议论', '/img/theme/7.jpg', '<p>议论文是以议论为主要表达方式，通过摆事实，讲道理，直接表达作者的观点和主张的常用文体。它不同于记叙文以形象生动的记叙来间接地表达作者的思想感情，也不同于说明文侧重介绍或解释事物的形状、性质、成因、功能等。总而言之，议论文是以理服人的文章，记叙文和说明文则是以事感人，以知授人的文章。</p>');
INSERT INTO `category` VALUES ('8', '校闻', '/img/theme/8.jpg', '<p>校闻顾名思义，既校内的新闻，用来记录新近听到的事件，校园里新近发生的事件。</p>');

-- ----------------------------
-- Table structure for comment
-- ----------------------------
DROP TABLE IF EXISTS `comment`;
CREATE TABLE `comment` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `type` tinyint(4) NOT NULL DEFAULT '0' COMMENT '0：文章，1：消息',
  `type_id` int(11) NOT NULL DEFAULT '0' COMMENT '0表示该条为作者回复评论',
  `reply_id` int(11) NOT NULL DEFAULT '0' COMMENT 'reply_id对应comment_id',
  `content` varchar(250) NOT NULL,
  `like_num` int(11) DEFAULT '0' COMMENT '点赞数',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `is_show` tinyint(1) DEFAULT '1' COMMENT '0不显示，1显示',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=31 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of comment
-- ----------------------------
INSERT INTO `comment` VALUES ('6', '1', '0', '47', '0', '评论咯', '0', '2018-04-10 16:15:01', '1');
INSERT INTO `comment` VALUES ('7', '8', '0', '74', '0', '啦啦啦我又来了', '3', '2018-04-11 11:18:09', '1');
INSERT INTO `comment` VALUES ('8', '1', '0', '74', '0', 'hahaha', '3', '2018-04-11 11:53:33', '1');
INSERT INTO `comment` VALUES ('9', '8', '0', '0', '7', 'haha', '0', '2018-04-11 11:59:20', '1');
INSERT INTO `comment` VALUES ('10', '8', '0', '0', '7', 'lala', '0', '2018-04-11 11:59:54', '1');
INSERT INTO `comment` VALUES ('11', '1', '0', '85', '0', '看看', '1', '2018-04-13 15:29:18', '1');
INSERT INTO `comment` VALUES ('12', '1', '0', '0', '11', '自己回复自己', '0', '2018-04-13 15:29:48', '1');
INSERT INTO `comment` VALUES ('13', '8', '0', '0', '11', 'haha', '0', '2018-04-13 15:31:21', '1');
INSERT INTO `comment` VALUES ('14', '1', '0', '0', '11', '啦啦啦', '0', '2018-04-13 15:38:04', '1');
INSERT INTO `comment` VALUES ('15', '1', '0', '81', '0', '1', '0', '2018-04-13 16:31:09', '1');
INSERT INTO `comment` VALUES ('16', '14', '0', '82', '0', '666666', '0', '2018-04-19 10:55:51', '1');
INSERT INTO `comment` VALUES ('17', '14', '0', '82', '0', '哈哈', '0', '2018-04-19 10:58:08', '1');
INSERT INTO `comment` VALUES ('18', '14', '0', '82', '0', '可以的', '2', '2018-04-19 11:00:02', '1');
INSERT INTO `comment` VALUES ('19', '8', '0', '82', '0', '很强啊', '2', '2018-04-19 11:02:12', '1');
INSERT INTO `comment` VALUES ('20', '14', '0', '0', '19', '谢谢夸奖哈哈哈哈哈哈！', '0', '2018-04-19 11:12:17', '1');
INSERT INTO `comment` VALUES ('21', '14', '0', '0', '18', '好玩', '0', '2018-04-19 11:13:43', '1');
INSERT INTO `comment` VALUES ('22', '14', '0', '0', '17', '哈哈哈哈哈哈', '0', '2018-04-19 11:18:10', '1');
INSERT INTO `comment` VALUES ('23', '14', '0', '0', '16', '坏笑', '0', '2018-04-19 11:20:59', '1');
INSERT INTO `comment` VALUES ('24', '14', '0', '0', '19', '我又来了', '0', '2018-04-19 11:22:35', '1');
INSERT INTO `comment` VALUES ('25', '8', '0', '0', '8', '大佬来了！', '0', '2018-04-21 22:45:14', '1');
INSERT INTO `comment` VALUES ('26', '1', '0', '83', '0', '看看', '2', '2018-04-24 17:39:00', '1');
INSERT INTO `comment` VALUES ('27', '1', '0', '0', '26', '你再看试试！', '0', '2018-04-24 17:41:31', '1');
INSERT INTO `comment` VALUES ('28', '1', '1', '1', '0', '欢迎大家参加', '2', '2018-04-24 18:02:04', '1');
INSERT INTO `comment` VALUES ('29', '14', '1', '1', '0', '猴', '0', '2018-04-30 00:30:29', '1');
INSERT INTO `comment` VALUES ('30', '1', '0', '74', '0', 'cvb', '1', '2018-05-06 10:11:50', '1');

-- ----------------------------
-- Table structure for news
-- ----------------------------
DROP TABLE IF EXISTS `news`;
CREATE TABLE `news` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `news_content_id` int(11) NOT NULL,
  `all_click` int(11) NOT NULL DEFAULT '0',
  `name` varchar(20) NOT NULL,
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of news
-- ----------------------------
INSERT INTO `news` VALUES ('1', '1', '27', '第五十期《侨苑》面向全校征稿啦！', '2018-04-24 16:32:13', '1');
INSERT INTO `news` VALUES ('10', '13', '10', 'hahaha', '2018-05-03 16:48:43', '8');

-- ----------------------------
-- Table structure for news_content
-- ----------------------------
DROP TABLE IF EXISTS `news_content`;
CREATE TABLE `news_content` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `content` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of news_content
-- ----------------------------
INSERT INTO `news_content` VALUES ('1', '<p><strong>亲爱的小伙伴们，第五十期《侨苑》面向全校征稿啦！</strong></p><p><span style=\"text-indent: 2em;\">想让自己笔下的文字变成印刷品吗？想体验文章被刊登的成就感吗？想与别人分享生活的点点滴滴吗？想寻觅一个文字的知音吗？还等什么！第五十期《侨苑》欢迎你！</span></p><p><strong>活动时间：</strong> 2018-06-01截稿<br/></p><p><strong>征稿对象：</strong> 五邑大学全体同学</p><p><strong>体裁：</strong>散文，小说，诗歌，杂文，评论。<span style=\"text-indent: 2em;\">&nbsp;诗歌不限字数，其余1000字以上.主题不限。</span></p><p><span style=\"text-indent: 2em;\"></span></p><p><strong>联系电话：</strong>610057李文丹&nbsp; QQ：137054382</p><p>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;613548董俊均&nbsp; QQ; 373126374</p><p><strong>地址：</strong>北主楼1510</p><p><strong>微信公众号：</strong>qywxs1989</p><p><span style=\"text-indent: 2em;\"><br/></span><br/></p><p><br/></p>');
INSERT INTO `news_content` VALUES ('13', '<p>lalala</p><p>ass</p>');

-- ----------------------------
-- Table structure for praise
-- ----------------------------
DROP TABLE IF EXISTS `praise`;
CREATE TABLE `praise` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0：文章，1：消息',
  `type_id` int(11) NOT NULL,
  `comment_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=23 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of praise
-- ----------------------------
INSERT INTO `praise` VALUES ('6', '0', '74', '8', '1', '2018-04-11 18:14:25');
INSERT INTO `praise` VALUES ('5', '0', '74', '8', '1', '2018-04-11 18:11:01');
INSERT INTO `praise` VALUES ('7', '0', '74', '8', '1', '2018-04-11 18:15:03');
INSERT INTO `praise` VALUES ('8', '0', '74', '8', '8', '2018-04-11 18:15:38');
INSERT INTO `praise` VALUES ('9', '0', '85', '11', '1', '2018-04-13 15:29:46');
INSERT INTO `praise` VALUES ('10', '0', '74', '8', '14', '2018-04-19 10:48:16');
INSERT INTO `praise` VALUES ('11', '0', '74', '7', '14', '2018-04-19 10:48:18');
INSERT INTO `praise` VALUES ('12', '0', '82', '18', '8', '2018-04-19 11:02:04');
INSERT INTO `praise` VALUES ('13', '0', '82', '19', '8', '2018-04-19 11:08:36');
INSERT INTO `praise` VALUES ('14', '0', '82', '19', '14', '2018-04-19 11:09:12');
INSERT INTO `praise` VALUES ('15', '0', '82', '18', '14', '2018-04-19 11:13:33');
INSERT INTO `praise` VALUES ('16', '0', '74', '7', '1', '2018-04-21 22:44:40');
INSERT INTO `praise` VALUES ('17', '0', '74', '7', '8', '2018-04-21 22:45:02');
INSERT INTO `praise` VALUES ('18', '0', '83', '26', '1', '2018-04-24 17:42:17');
INSERT INTO `praise` VALUES ('19', '0', '83', '26', '8', '2018-04-24 17:42:35');
INSERT INTO `praise` VALUES ('20', '1', '1', '28', '1', '2018-04-24 18:02:06');
INSERT INTO `praise` VALUES ('21', '1', '1', '28', '14', '2018-04-30 00:30:16');
INSERT INTO `praise` VALUES ('22', '0', '74', '30', '1', '2018-05-06 10:11:57');

-- ----------------------------
-- Table structure for prize
-- ----------------------------
DROP TABLE IF EXISTS `prize`;
CREATE TABLE `prize` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `activity_id` int(11) NOT NULL,
  `article_id` int(11) NOT NULL,
  `prize_type` int(11) NOT NULL DEFAULT '0' COMMENT '0：无，10：特等奖，11：一等奖，12：二等奖，13：三等级，233：优秀奖',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of prize
-- ----------------------------
INSERT INTO `prize` VALUES ('1', '2', '11', '10');
INSERT INTO `prize` VALUES ('2', '2', '12', '11');
INSERT INTO `prize` VALUES ('3', '2', '13', '11');
INSERT INTO `prize` VALUES ('4', '2', '14', '12');
INSERT INTO `prize` VALUES ('5', '2', '15', '12');
INSERT INTO `prize` VALUES ('6', '2', '16', '12');
INSERT INTO `prize` VALUES ('7', '2', '17', '13');
INSERT INTO `prize` VALUES ('8', '2', '18', '13');
INSERT INTO `prize` VALUES ('9', '2', '19', '13');
INSERT INTO `prize` VALUES ('10', '1', '80', '10');

-- ----------------------------
-- Table structure for recommend
-- ----------------------------
DROP TABLE IF EXISTS `recommend`;
CREATE TABLE `recommend` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `article_id` int(11) NOT NULL,
  `describe` varchar(150) NOT NULL COMMENT '推荐语',
  `show` tinyint(1) NOT NULL DEFAULT '1' COMMENT '展示 1：展示  0：不展示',
  `rank` int(11) NOT NULL DEFAULT '1000' COMMENT '显示顺序，数值由低到高',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of recommend
-- ----------------------------
INSERT INTO `recommend` VALUES ('1', '74', '这世界每天都会有人失恋，有一些是遇人不淑，有一些是咎由自取。遇人不淑的我只能劝你长点心眼，咎由自取的我只能对你说，你活该。', '1', '6', '2018-04-24 10:15:54');
INSERT INTO `recommend` VALUES ('2', '86', '传说世间每个人也会有一位天使护荫/纵使渺小彷如微尘仍可栖身当爱人呼吸/可惜像我这一种人圣母永远不肯给予怜悯...', '1', '5', '2018-04-24 10:18:39');
INSERT INTO `recommend` VALUES ('3', '87', '做一个快乐的懒人又何妨？', '1', '4', '2018-04-24 10:21:27');
INSERT INTO `recommend` VALUES ('4', '88', '真正的自由与责任是离不开的，否则自由就不再是自由，而是放纵了。', '1', '3', '2018-04-24 10:25:40');
INSERT INTO `recommend` VALUES ('5', '89', '穆尼尔纳素夫说过“真正的幸福只有当你真实地认识到人生的价值时，才能体会到。”', '1', '2', '2018-04-24 10:28:38');
INSERT INTO `recommend` VALUES ('6', '92', '“年例”作为粤西地区的一个独特的汉族传统民俗节日，由来已久。其有着不同来由故事，多样的举办方式，体现了多样文化的交融共进。“年例”在粤西农民心中的地位不可动摇，对我们有着极其重要的意义。', '1', '1', '2018-04-24 10:34:25');
INSERT INTO `recommend` VALUES ('7', '23', '', '1', '1000', '2018-05-03 22:22:20');
INSERT INTO `recommend` VALUES ('8', '79', 'haha', '1', '1000', '2018-05-05 11:14:51');
INSERT INTO `recommend` VALUES ('9', '78', 'hahah', '1', '1000', '2018-05-05 11:16:12');
INSERT INTO `recommend` VALUES ('10', '77', 'haha', '1', '1000', '2018-05-05 11:16:45');

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `account` varchar(100) NOT NULL,
  `password` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `sno` varchar(20) DEFAULT NULL COMMENT '学号',
  `img` varchar(100) NOT NULL,
  `sex` tinyint(1) NOT NULL DEFAULT '1' COMMENT '1男，0女',
  `student` tinyint(1) NOT NULL DEFAULT '0',
  `admin` int(11) NOT NULL DEFAULT '0' COMMENT '0普通用户，10编辑，100成绩管理员',
  PRIMARY KEY (`id`,`account`,`name`),
  UNIQUE KEY `account` (`account`),
  UNIQUE KEY `name` (`name`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES ('1', '管理员大佬', 'admin', '21232f297a57a5a743894a0e4a801fc3', '', null, null, '/uploads/1/img/1525442105677.jpg', '1', '0', '100');
INSERT INTO `user` VALUES ('8', 'wulixpy', 'llxpy', 'e10adc3949ba59abbe56e057f20f883e', '806918604@qq.com', '18219111630', '', '/uploads/8/img/1524045053072.jpg', '1', '1', '10');
INSERT INTO `user` VALUES ('14', '会飞的小辣鸡', 'qwe', 'e10adc3949ba59abbe56e057f20f883e', '576175351@qq.com', '18219111630', '3114002562', '/uploads/14/img/1524106013926.jpg', '1', '1', '0');
INSERT INTO `user` VALUES ('17', 'fjs', 'fjs', 'e10adc3949ba59abbe56e057f20f883e', '1479676948@qq.com', '', '', '/uploads/17/img/1524236011547.jpg', '1', '0', '0');

-- ----------------------------
-- Table structure for user_action
-- ----------------------------
DROP TABLE IF EXISTS `user_action`;
CREATE TABLE `user_action` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `article_id` int(11) NOT NULL,
  `read_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `category_id` int(11) NOT NULL,
  `activity_id` int(11) NOT NULL,
  `article_name` varchar(20) NOT NULL,
  PRIMARY KEY (`id`,`read_time`)
) ENGINE=MyISAM AUTO_INCREMENT=327 DEFAULT CHARSET=utf8
/*!50100 PARTITION BY RANGE (UNIX_TIMESTAMP(read_time))
(PARTITION p_201801 VALUES LESS THAN (1517414400) ENGINE = MyISAM,
 PARTITION p_201802 VALUES LESS THAN (1519833600) ENGINE = MyISAM,
 PARTITION p_201803 VALUES LESS THAN (1522598400) ENGINE = MyISAM,
 PARTITION p_201804 VALUES LESS THAN (1525363200) ENGINE = MyISAM,
 PARTITION p_201805 VALUES LESS THAN (1527955200) ENGINE = MyISAM) */;

-- ----------------------------
-- Records of user_action
-- ----------------------------
INSERT INTO `user_action` VALUES ('16', '14', '24', '2018-02-12 16:13:33', '3', '0', '');
INSERT INTO `user_action` VALUES ('17', '14', '9', '2018-02-12 16:36:42', '1', '0', '');
INSERT INTO `user_action` VALUES ('18', '14', '19', '2018-02-12 16:37:40', '3', '0', '');
INSERT INTO `user_action` VALUES ('19', '14', '22', '2018-03-02 14:38:20', '3', '0', 'hahah');
INSERT INTO `user_action` VALUES ('20', '14', '1', '2018-03-02 14:38:41', '1', '0', 'test1');
INSERT INTO `user_action` VALUES ('21', '14', '1', '2018-03-02 14:38:52', '1', '0', 'test1');
INSERT INTO `user_action` VALUES ('22', '14', '23', '2018-03-02 14:39:12', '3', '0', 'hahah');
INSERT INTO `user_action` VALUES ('23', '14', '24', '2018-03-02 17:12:19', '3', '0', 'name24');
INSERT INTO `user_action` VALUES ('24', '14', '24', '2018-03-02 17:12:27', '3', '0', 'name24');
INSERT INTO `user_action` VALUES ('25', '14', '24', '2018-03-02 17:12:27', '3', '0', 'name24');
INSERT INTO `user_action` VALUES ('26', '14', '24', '2018-03-02 17:12:28', '3', '0', 'name24');
INSERT INTO `user_action` VALUES ('27', '14', '24', '2018-03-02 17:12:28', '3', '0', 'name24');
INSERT INTO `user_action` VALUES ('28', '14', '24', '2018-03-02 17:12:28', '3', '0', 'name24');
INSERT INTO `user_action` VALUES ('29', '14', '24', '2018-03-02 17:12:28', '3', '0', 'name24');
INSERT INTO `user_action` VALUES ('30', '14', '24', '2018-03-02 17:12:28', '3', '0', 'name24');
INSERT INTO `user_action` VALUES ('31', '14', '24', '2018-03-02 17:12:28', '3', '0', 'name24');
INSERT INTO `user_action` VALUES ('32', '14', '24', '2018-03-02 17:12:28', '3', '0', 'name24');
INSERT INTO `user_action` VALUES ('33', '14', '24', '2018-03-02 17:12:29', '3', '0', 'name24');
INSERT INTO `user_action` VALUES ('34', '14', '24', '2018-03-02 17:12:29', '3', '0', 'name24');
INSERT INTO `user_action` VALUES ('35', '14', '24', '2018-03-02 17:12:29', '3', '0', 'name24');
INSERT INTO `user_action` VALUES ('36', '14', '24', '2018-03-02 17:12:29', '3', '0', 'name24');
INSERT INTO `user_action` VALUES ('37', '14', '24', '2018-03-02 17:12:29', '3', '0', 'name24');
INSERT INTO `user_action` VALUES ('38', '14', '24', '2018-03-02 17:12:30', '3', '0', 'name24');
INSERT INTO `user_action` VALUES ('39', '14', '9', '2018-03-05 09:51:29', '1', '0', 'name9');
INSERT INTO `user_action` VALUES ('40', '14', '9', '2018-03-05 09:51:35', '1', '0', 'name9');
INSERT INTO `user_action` VALUES ('41', '14', '9', '2018-03-05 09:51:39', '1', '0', 'name9');
INSERT INTO `user_action` VALUES ('42', '14', '9', '2018-03-05 09:51:48', '1', '0', 'name9');
INSERT INTO `user_action` VALUES ('43', '14', '9', '2018-03-05 09:51:57', '1', '0', 'name9');
INSERT INTO `user_action` VALUES ('44', '14', '9', '2018-03-05 09:54:17', '1', '0', 'name9');
INSERT INTO `user_action` VALUES ('45', '1', '9', '2018-03-06 09:43:27', '1', '0', 'name9');
INSERT INTO `user_action` VALUES ('46', '14', '9', '2018-03-06 09:43:46', '1', '0', 'name9');
INSERT INTO `user_action` VALUES ('47', '1', '9', '2018-03-20 11:10:54', '1', '0', 'name9');
INSERT INTO `user_action` VALUES ('48', '1', '1', '2018-03-20 11:11:24', '1', '0', 'name1');
INSERT INTO `user_action` VALUES ('49', '1', '1', '2018-03-20 11:11:41', '1', '0', 'name1');
INSERT INTO `user_action` VALUES ('50', '1', '9', '2018-03-20 12:03:05', '1', '0', 'name9');
INSERT INTO `user_action` VALUES ('51', '1', '9', '2018-03-20 12:03:10', '1', '0', 'name9');
INSERT INTO `user_action` VALUES ('52', '1', '9', '2018-03-20 14:10:10', '1', '0', 'name9');
INSERT INTO `user_action` VALUES ('53', '1', '9', '2018-03-20 14:10:33', '1', '0', 'name9');
INSERT INTO `user_action` VALUES ('54', '1', '9', '2018-03-20 14:11:22', '1', '0', 'name9');
INSERT INTO `user_action` VALUES ('55', '1', '9', '2018-03-20 14:11:45', '1', '0', 'name9');
INSERT INTO `user_action` VALUES ('56', '1', '9', '2018-03-20 14:14:41', '1', '0', 'name9');
INSERT INTO `user_action` VALUES ('57', '1', '9', '2018-03-20 14:14:51', '1', '0', 'name9');
INSERT INTO `user_action` VALUES ('58', '1', '9', '2018-03-20 14:15:32', '1', '0', 'name9');
INSERT INTO `user_action` VALUES ('59', '1', '9', '2018-03-20 14:18:56', '1', '0', 'name9');
INSERT INTO `user_action` VALUES ('60', '1', '9', '2018-03-20 14:19:27', '1', '0', 'name9');
INSERT INTO `user_action` VALUES ('61', '1', '9', '2018-03-20 14:21:31', '1', '0', 'name9');
INSERT INTO `user_action` VALUES ('62', '1', '9', '2018-03-20 14:22:07', '1', '0', 'name9');
INSERT INTO `user_action` VALUES ('63', '1', '9', '2018-03-20 14:23:18', '1', '0', 'name9');
INSERT INTO `user_action` VALUES ('64', '1', '9', '2018-03-20 14:24:35', '1', '0', 'name9');
INSERT INTO `user_action` VALUES ('65', '1', '9', '2018-03-20 14:25:13', '1', '0', 'name9');
INSERT INTO `user_action` VALUES ('66', '1', '9', '2018-03-20 14:26:03', '1', '0', 'name9');
INSERT INTO `user_action` VALUES ('67', '1', '9', '2018-03-20 14:26:16', '1', '0', 'name9');
INSERT INTO `user_action` VALUES ('68', '1', '9', '2018-03-20 14:30:09', '1', '0', 'name9');
INSERT INTO `user_action` VALUES ('69', '1', '9', '2018-03-20 14:30:58', '1', '0', 'name9');
INSERT INTO `user_action` VALUES ('70', '1', '9', '2018-03-20 14:33:05', '1', '0', 'name9');
INSERT INTO `user_action` VALUES ('71', '1', '9', '2018-03-20 14:34:22', '1', '0', 'name9');
INSERT INTO `user_action` VALUES ('72', '1', '9', '2018-03-20 14:36:17', '1', '0', 'name9');
INSERT INTO `user_action` VALUES ('73', '1', '9', '2018-03-20 14:36:19', '1', '0', 'name9');
INSERT INTO `user_action` VALUES ('74', '1', '9', '2018-03-20 14:36:30', '1', '0', 'name9');
INSERT INTO `user_action` VALUES ('75', '1', '9', '2018-03-20 14:36:36', '1', '0', 'name9');
INSERT INTO `user_action` VALUES ('76', '1', '9', '2018-03-20 14:36:48', '1', '0', 'name9');
INSERT INTO `user_action` VALUES ('77', '1', '9', '2018-03-20 14:36:57', '1', '0', 'name9');
INSERT INTO `user_action` VALUES ('78', '1', '9', '2018-03-20 14:37:29', '1', '0', 'name9');
INSERT INTO `user_action` VALUES ('79', '1', '9', '2018-03-20 14:38:16', '1', '0', 'name9');
INSERT INTO `user_action` VALUES ('80', '1', '9', '2018-03-20 14:40:25', '1', '0', 'name9');
INSERT INTO `user_action` VALUES ('81', '1', '9', '2018-03-20 14:54:37', '1', '0', 'name9');
INSERT INTO `user_action` VALUES ('82', '1', '1', '2018-03-20 15:03:45', '1', '0', 'name1');
INSERT INTO `user_action` VALUES ('83', '1', '1', '2018-03-20 15:12:54', '1', '0', 'name1');
INSERT INTO `user_action` VALUES ('84', '1', '1', '2018-03-20 15:13:19', '1', '0', 'name1');
INSERT INTO `user_action` VALUES ('85', '1', '1', '2018-03-20 15:14:06', '1', '0', 'name1');
INSERT INTO `user_action` VALUES ('86', '1', '1', '2018-03-20 15:16:10', '1', '0', 'name1');
INSERT INTO `user_action` VALUES ('87', '1', '1', '2018-03-20 15:17:03', '1', '0', 'name1');
INSERT INTO `user_action` VALUES ('88', '1', '1', '2018-03-20 15:18:14', '1', '0', 'name1');
INSERT INTO `user_action` VALUES ('89', '1', '1', '2018-03-20 15:19:04', '1', '0', 'name1');
INSERT INTO `user_action` VALUES ('90', '1', '1', '2018-03-20 15:19:23', '1', '0', 'name1');
INSERT INTO `user_action` VALUES ('91', '1', '1', '2018-03-20 15:20:25', '1', '0', 'name1');
INSERT INTO `user_action` VALUES ('92', '1', '1', '2018-03-20 15:20:59', '1', '0', 'name1');
INSERT INTO `user_action` VALUES ('93', '1', '1', '2018-03-20 15:22:17', '1', '0', 'name1');
INSERT INTO `user_action` VALUES ('94', '1', '1', '2018-03-20 15:31:21', '1', '0', 'name1');
INSERT INTO `user_action` VALUES ('95', '1', '1', '2018-03-20 15:33:32', '1', '0', 'name1');
INSERT INTO `user_action` VALUES ('96', '1', '1', '2018-03-20 15:37:54', '1', '0', 'name1');
INSERT INTO `user_action` VALUES ('97', '1', '1', '2018-03-20 15:38:18', '1', '0', 'name1');
INSERT INTO `user_action` VALUES ('98', '1', '1', '2018-03-20 15:41:19', '1', '0', 'name1');
INSERT INTO `user_action` VALUES ('99', '1', '1', '2018-03-20 15:42:01', '1', '0', 'name1');
INSERT INTO `user_action` VALUES ('100', '1', '1', '2018-03-20 15:42:29', '1', '0', 'name1');
INSERT INTO `user_action` VALUES ('101', '1', '1', '2018-03-20 15:43:16', '1', '0', 'name1');
INSERT INTO `user_action` VALUES ('102', '1', '1', '2018-03-20 15:43:51', '1', '0', 'name1');
INSERT INTO `user_action` VALUES ('103', '1', '1', '2018-03-20 15:44:42', '1', '0', 'name1');
INSERT INTO `user_action` VALUES ('104', '1', '1', '2018-03-20 15:45:08', '1', '0', 'name1');
INSERT INTO `user_action` VALUES ('105', '1', '1', '2018-03-20 15:45:24', '1', '0', 'name1');
INSERT INTO `user_action` VALUES ('106', '1', '1', '2018-03-20 15:48:10', '1', '0', 'name1');
INSERT INTO `user_action` VALUES ('107', '1', '1', '2018-03-20 15:48:47', '1', '0', 'name1');
INSERT INTO `user_action` VALUES ('108', '1', '1', '2018-03-20 15:50:44', '1', '0', 'name1');
INSERT INTO `user_action` VALUES ('109', '1', '1', '2018-03-20 15:53:10', '1', '0', 'name1');
INSERT INTO `user_action` VALUES ('110', '1', '1', '2018-03-20 15:55:56', '1', '0', 'name1');
INSERT INTO `user_action` VALUES ('111', '1', '1', '2018-03-20 15:56:59', '1', '0', 'name1');
INSERT INTO `user_action` VALUES ('112', '1', '1', '2018-03-20 15:58:35', '1', '0', 'name1');
INSERT INTO `user_action` VALUES ('113', '1', '1', '2018-03-20 15:59:11', '1', '0', 'name1');
INSERT INTO `user_action` VALUES ('114', '1', '1', '2018-03-20 15:59:22', '1', '0', 'name1');
INSERT INTO `user_action` VALUES ('115', '1', '1', '2018-03-20 16:00:48', '1', '0', 'name1');
INSERT INTO `user_action` VALUES ('116', '1', '1', '2018-03-20 16:01:30', '1', '0', 'name1');
INSERT INTO `user_action` VALUES ('117', '1', '1', '2018-03-20 16:02:45', '1', '0', 'name1');
INSERT INTO `user_action` VALUES ('118', '1', '1', '2018-03-20 16:03:14', '1', '0', 'name1');
INSERT INTO `user_action` VALUES ('119', '1', '1', '2018-03-20 16:03:52', '1', '0', 'name1');
INSERT INTO `user_action` VALUES ('120', '1', '1', '2018-03-20 16:04:34', '1', '0', 'name1');
INSERT INTO `user_action` VALUES ('121', '1', '1', '2018-03-20 16:06:07', '1', '0', 'name1');
INSERT INTO `user_action` VALUES ('122', '1', '1', '2018-03-20 16:06:52', '1', '0', 'name1');
INSERT INTO `user_action` VALUES ('123', '1', '1', '2018-03-20 16:07:14', '1', '0', 'name1');
INSERT INTO `user_action` VALUES ('124', '1', '1', '2018-03-20 16:07:29', '1', '0', 'name1');
INSERT INTO `user_action` VALUES ('125', '1', '1', '2018-03-20 16:08:39', '1', '0', 'name1');
INSERT INTO `user_action` VALUES ('126', '1', '1', '2018-03-20 16:09:32', '1', '0', 'name1');
INSERT INTO `user_action` VALUES ('127', '1', '1', '2018-03-20 16:13:31', '1', '0', 'name1');
INSERT INTO `user_action` VALUES ('128', '1', '1', '2018-03-20 16:14:58', '1', '0', 'name1');
INSERT INTO `user_action` VALUES ('129', '1', '1', '2018-03-20 16:16:29', '1', '0', 'name1');
INSERT INTO `user_action` VALUES ('130', '1', '1', '2018-03-20 16:18:18', '1', '0', 'name1');
INSERT INTO `user_action` VALUES ('131', '1', '1', '2018-03-20 16:18:32', '1', '0', 'name1');
INSERT INTO `user_action` VALUES ('132', '1', '1', '2018-03-20 16:18:43', '1', '0', 'name1');
INSERT INTO `user_action` VALUES ('133', '1', '1', '2018-03-20 16:19:34', '1', '0', 'name1');
INSERT INTO `user_action` VALUES ('134', '1', '1', '2018-03-20 16:21:50', '1', '0', 'name1');
INSERT INTO `user_action` VALUES ('135', '1', '1', '2018-03-20 16:23:10', '1', '0', 'name1');
INSERT INTO `user_action` VALUES ('136', '1', '1', '2018-03-20 16:23:20', '1', '0', 'name1');
INSERT INTO `user_action` VALUES ('137', '1', '1', '2018-03-20 16:24:07', '1', '0', 'name1');
INSERT INTO `user_action` VALUES ('138', '1', '1', '2018-03-20 16:24:21', '1', '0', 'name1');
INSERT INTO `user_action` VALUES ('139', '1', '1', '2018-03-20 16:24:47', '1', '0', 'name1');
INSERT INTO `user_action` VALUES ('140', '1', '24', '2018-03-20 16:28:05', '3', '0', 'name24');
INSERT INTO `user_action` VALUES ('141', '1', '72', '2018-03-20 16:28:12', '0', '1', 'name72');
INSERT INTO `user_action` VALUES ('142', '1', '9', '2018-03-20 16:29:45', '1', '0', 'name9');
INSERT INTO `user_action` VALUES ('143', '1', '74', '2018-03-20 16:30:53', '0', '1', 'name74');
INSERT INTO `user_action` VALUES ('144', '1', '74', '2018-03-20 16:31:57', '0', '1', 'name74');
INSERT INTO `user_action` VALUES ('145', '1', '74', '2018-03-20 16:31:58', '0', '1', 'name74');
INSERT INTO `user_action` VALUES ('146', '1', '74', '2018-03-20 16:33:31', '0', '1', 'name74');
INSERT INTO `user_action` VALUES ('147', '1', '74', '2018-03-20 16:33:54', '0', '1', 'name74');
INSERT INTO `user_action` VALUES ('148', '1', '74', '2018-03-20 16:38:28', '0', '1', 'name74');
INSERT INTO `user_action` VALUES ('149', '1', '9', '2018-03-20 16:39:37', '1', '0', 'name9');
INSERT INTO `user_action` VALUES ('150', '1', '9', '2018-03-20 16:39:38', '1', '0', 'name9');
INSERT INTO `user_action` VALUES ('151', '1', '9', '2018-03-20 16:41:55', '1', '0', 'name9');
INSERT INTO `user_action` VALUES ('152', '1', '9', '2018-03-20 16:42:38', '1', '0', 'name9');
INSERT INTO `user_action` VALUES ('153', '1', '8', '2018-03-20 17:01:24', '1', '0', 'name8');
INSERT INTO `user_action` VALUES ('154', '1', '8', '2018-03-20 17:04:01', '1', '0', 'name8');
INSERT INTO `user_action` VALUES ('155', '1', '9', '2018-03-20 17:14:22', '1', '0', 'name9');
INSERT INTO `user_action` VALUES ('156', '1', '9', '2018-03-20 17:15:20', '1', '0', 'name9');
INSERT INTO `user_action` VALUES ('157', '1', '74', '2018-03-20 17:15:27', '0', '1', 'name74');
INSERT INTO `user_action` VALUES ('158', '1', '83', '2018-03-26 11:21:50', '1', '0', 'qweqwe');
INSERT INTO `user_action` VALUES ('159', '1', '9', '2018-03-26 11:22:02', '1', '0', 'name9');
INSERT INTO `user_action` VALUES ('160', '1', '40', '2018-03-31 01:45:16', '6', '0', 'name40');
INSERT INTO `user_action` VALUES ('161', '1', '1', '2018-04-04 15:03:49', '1', '0', 'name1');
INSERT INTO `user_action` VALUES ('162', '1', '85', '2018-04-04 15:04:01', '1', '0', 'qweqwe');
INSERT INTO `user_action` VALUES ('163', '1', '85', '2018-04-04 15:04:11', '1', '0', 'qweqwe');
INSERT INTO `user_action` VALUES ('164', '1', '47', '2018-04-10 16:04:52', '7', '0', 'name47');
INSERT INTO `user_action` VALUES ('165', '1', '74', '2018-04-11 11:53:27', '0', '1', 'name74');
INSERT INTO `user_action` VALUES ('166', '1', '74', '2018-04-11 11:53:37', '0', '1', 'name74');
INSERT INTO `user_action` VALUES ('167', '8', '74', '2018-04-11 11:53:53', '0', '1', 'name74');
INSERT INTO `user_action` VALUES ('168', '8', '74', '2018-04-11 11:59:12', '0', '1', 'name74');
INSERT INTO `user_action` VALUES ('169', '8', '74', '2018-04-11 11:59:36', '0', '1', 'name74');
INSERT INTO `user_action` VALUES ('170', '8', '74', '2018-04-11 11:59:48', '0', '1', 'name74');
INSERT INTO `user_action` VALUES ('171', '8', '74', '2018-04-11 11:59:56', '0', '1', 'name74');
INSERT INTO `user_action` VALUES ('172', '8', '74', '2018-04-11 12:05:34', '0', '1', 'name74');
INSERT INTO `user_action` VALUES ('173', '8', '74', '2018-04-11 12:14:30', '0', '1', 'name74');
INSERT INTO `user_action` VALUES ('174', '8', '74', '2018-04-11 12:15:28', '0', '1', 'name74');
INSERT INTO `user_action` VALUES ('175', '8', '74', '2018-04-11 12:51:43', '0', '1', 'name74');
INSERT INTO `user_action` VALUES ('176', '8', '85', '2018-04-11 14:02:41', '1', '0', 'qweqwe');
INSERT INTO `user_action` VALUES ('177', '8', '85', '2018-04-11 14:02:55', '1', '0', 'qweqwe');
INSERT INTO `user_action` VALUES ('178', '8', '74', '2018-04-11 14:03:00', '0', '1', 'name74');
INSERT INTO `user_action` VALUES ('179', '8', '74', '2018-04-11 14:03:04', '0', '1', 'name74');
INSERT INTO `user_action` VALUES ('180', '8', '74', '2018-04-11 14:03:21', '0', '1', 'name74');
INSERT INTO `user_action` VALUES ('181', '1', '74', '2018-04-11 17:54:10', '0', '1', 'name74');
INSERT INTO `user_action` VALUES ('182', '1', '74', '2018-04-11 17:55:17', '0', '1', 'name74');
INSERT INTO `user_action` VALUES ('183', '1', '74', '2018-04-11 17:56:55', '0', '1', 'name74');
INSERT INTO `user_action` VALUES ('184', '1', '74', '2018-04-11 17:56:58', '0', '1', 'name74');
INSERT INTO `user_action` VALUES ('185', '1', '74', '2018-04-11 17:57:07', '0', '1', 'name74');
INSERT INTO `user_action` VALUES ('186', '1', '74', '2018-04-11 18:09:18', '0', '1', 'name74');
INSERT INTO `user_action` VALUES ('187', '1', '74', '2018-04-11 18:10:28', '0', '1', 'name74');
INSERT INTO `user_action` VALUES ('188', '1', '74', '2018-04-11 18:10:47', '0', '1', 'name74');
INSERT INTO `user_action` VALUES ('189', '1', '74', '2018-04-11 18:10:58', '0', '1', 'name74');
INSERT INTO `user_action` VALUES ('190', '1', '74', '2018-04-11 18:15:13', '0', '1', 'name74');
INSERT INTO `user_action` VALUES ('191', '8', '74', '2018-04-11 18:15:35', '0', '1', 'name74');
INSERT INTO `user_action` VALUES ('192', '8', '74', '2018-04-11 18:15:40', '0', '1', 'name74');
INSERT INTO `user_action` VALUES ('193', '1', '85', '2018-04-13 15:29:23', '1', '0', 'qweqwe');
INSERT INTO `user_action` VALUES ('194', '8', '85', '2018-04-13 15:30:14', '1', '0', 'qweqwe');
INSERT INTO `user_action` VALUES ('195', '8', '81', '2018-04-13 15:30:27', '1', '0', 'name81');
INSERT INTO `user_action` VALUES ('196', '8', '85', '2018-04-13 15:30:34', '1', '0', 'qweqwe');
INSERT INTO `user_action` VALUES ('197', '1', '85', '2018-04-13 15:30:45', '1', '0', 'qweqwe');
INSERT INTO `user_action` VALUES ('198', '1', '85', '2018-04-13 15:31:04', '1', '0', 'qweqwe');
INSERT INTO `user_action` VALUES ('199', '8', '85', '2018-04-13 15:31:24', '1', '0', 'qweqwe');
INSERT INTO `user_action` VALUES ('200', '1', '85', '2018-04-13 15:37:03', '1', '0', 'qweqwe');
INSERT INTO `user_action` VALUES ('201', '8', '85', '2018-04-13 15:38:40', '1', '0', 'qweqwe');
INSERT INTO `user_action` VALUES ('202', '8', '1', '2018-04-13 16:04:14', '1', '0', 'name1');
INSERT INTO `user_action` VALUES ('203', '1', '81', '2018-04-13 16:31:06', '1', '0', 'name81');
INSERT INTO `user_action` VALUES ('204', '1', '81', '2018-04-13 16:31:13', '1', '0', 'name81');
INSERT INTO `user_action` VALUES ('205', '1', '1', '2018-04-13 16:39:51', '1', '0', 'name1');
INSERT INTO `user_action` VALUES ('206', '8', '85', '2018-04-16 16:36:02', '1', '0', 'qweqwe');
INSERT INTO `user_action` VALUES ('207', '8', '85', '2018-04-16 16:39:45', '1', '0', 'qweqwe');
INSERT INTO `user_action` VALUES ('208', '1', '85', '2018-04-19 09:36:48', '1', '0', 'qweqwe');
INSERT INTO `user_action` VALUES ('209', '1', '10', '2018-04-19 09:44:55', '1', '0', 'name10');
INSERT INTO `user_action` VALUES ('210', '1', '10', '2018-04-19 09:45:04', '1', '0', 'name10');
INSERT INTO `user_action` VALUES ('211', '1', '85', '2018-04-19 09:45:09', '1', '0', 'qweqwe');
INSERT INTO `user_action` VALUES ('212', '1', '81', '2018-04-19 09:45:12', '1', '0', 'name81');
INSERT INTO `user_action` VALUES ('213', '14', '83', '2018-04-19 10:47:36', '1', '0', 'qweqwe');
INSERT INTO `user_action` VALUES ('214', '14', '82', '2018-04-19 10:47:41', '2', '0', 'name82');
INSERT INTO `user_action` VALUES ('215', '14', '82', '2018-04-19 10:47:48', '2', '0', 'name82');
INSERT INTO `user_action` VALUES ('216', '14', '63', '2018-04-19 10:47:57', '2', '0', 'name63');
INSERT INTO `user_action` VALUES ('217', '14', '14', '2018-04-19 10:48:02', '2', '0', 'name14');
INSERT INTO `user_action` VALUES ('218', '14', '74', '2018-04-19 10:48:05', '0', '1', 'name74');
INSERT INTO `user_action` VALUES ('219', '14', '74', '2018-04-19 10:48:32', '0', '1', 'name74');
INSERT INTO `user_action` VALUES ('220', '14', '9', '2018-04-19 10:51:50', '1', '0', 'name9');
INSERT INTO `user_action` VALUES ('221', '14', '35', '2018-04-19 10:52:14', '5', '0', 'name35');
INSERT INTO `user_action` VALUES ('222', '14', '35', '2018-04-19 10:55:12', '5', '0', 'name35');
INSERT INTO `user_action` VALUES ('223', '14', '74', '2018-04-19 10:55:23', '0', '1', 'name74');
INSERT INTO `user_action` VALUES ('224', '14', '82', '2018-04-19 10:55:42', '2', '0', 'name82');
INSERT INTO `user_action` VALUES ('225', '14', '82', '2018-04-19 10:56:03', '2', '0', 'name82');
INSERT INTO `user_action` VALUES ('226', '14', '82', '2018-04-19 10:58:02', '2', '0', 'name82');
INSERT INTO `user_action` VALUES ('227', '14', '82', '2018-04-19 10:59:33', '2', '0', 'name82');
INSERT INTO `user_action` VALUES ('228', '14', '82', '2018-04-19 11:01:39', '2', '0', 'name82');
INSERT INTO `user_action` VALUES ('229', '8', '82', '2018-04-19 11:02:01', '2', '0', 'name82');
INSERT INTO `user_action` VALUES ('230', '8', '82', '2018-04-19 11:04:24', '2', '0', 'name82');
INSERT INTO `user_action` VALUES ('231', '8', '82', '2018-04-19 11:04:33', '2', '0', 'name82');
INSERT INTO `user_action` VALUES ('232', '8', '82', '2018-04-19 11:04:59', '2', '0', 'name82');
INSERT INTO `user_action` VALUES ('233', '8', '82', '2018-04-19 11:06:35', '2', '0', 'name82');
INSERT INTO `user_action` VALUES ('234', '8', '82', '2018-04-19 11:08:17', '2', '0', 'name82');
INSERT INTO `user_action` VALUES ('235', '8', '82', '2018-04-19 11:08:38', '2', '0', 'name82');
INSERT INTO `user_action` VALUES ('236', '14', '82', '2018-04-19 11:09:04', '2', '0', 'name82');
INSERT INTO `user_action` VALUES ('237', '14', '82', '2018-04-19 11:09:13', '2', '0', 'name82');
INSERT INTO `user_action` VALUES ('238', '14', '82', '2018-04-19 11:11:58', '2', '0', 'name82');
INSERT INTO `user_action` VALUES ('239', '14', '82', '2018-04-19 11:13:28', '2', '0', 'name82');
INSERT INTO `user_action` VALUES ('240', '14', '82', '2018-04-19 11:17:59', '2', '0', 'name82');
INSERT INTO `user_action` VALUES ('241', '14', '82', '2018-04-19 11:20:04', '2', '0', 'name82');
INSERT INTO `user_action` VALUES ('242', '14', '82', '2018-04-19 11:22:23', '2', '0', 'name82');
INSERT INTO `user_action` VALUES ('243', '1', '67', '2018-04-19 16:40:45', '1', '0', 'name67');
INSERT INTO `user_action` VALUES ('244', '1', '31', '2018-04-19 16:41:06', '4', '0', 'name31');
INSERT INTO `user_action` VALUES ('245', '1', '42', '2018-04-19 16:41:14', '6', '0', 'name42');
INSERT INTO `user_action` VALUES ('246', '1', '1', '2018-04-19 16:41:17', '1', '0', 'name1');
INSERT INTO `user_action` VALUES ('247', '1', '8', '2018-04-19 16:41:19', '1', '0', 'name8');
INSERT INTO `user_action` VALUES ('248', '1', '9', '2018-04-19 16:41:22', '1', '0', 'name9');
INSERT INTO `user_action` VALUES ('249', '1', '40', '2018-04-19 16:41:25', '6', '0', 'name40');
INSERT INTO `user_action` VALUES ('250', '1', '39', '2018-04-19 16:41:27', '6', '0', 'name39');
INSERT INTO `user_action` VALUES ('251', '1', '9', '2018-04-19 16:41:30', '1', '0', 'name9');
INSERT INTO `user_action` VALUES ('252', '1', '9', '2018-04-19 16:41:32', '1', '0', 'name9');
INSERT INTO `user_action` VALUES ('253', '1', '86', '2018-04-19 16:42:46', '5', '0', '孤儿');
INSERT INTO `user_action` VALUES ('254', '1', '74', '2018-04-21 22:44:32', '0', '1', 'name74');
INSERT INTO `user_action` VALUES ('255', '8', '74', '2018-04-21 22:44:55', '0', '1', 'name74');
INSERT INTO `user_action` VALUES ('256', '8', '74', '2018-04-21 22:45:25', '0', '1', 'name74');
INSERT INTO `user_action` VALUES ('257', '1', '85', '2018-04-23 00:12:19', '1', '0', 'qweqwe');
INSERT INTO `user_action` VALUES ('258', '1', '85', '2018-04-23 18:19:44', '1', '0', 'qweqwe');
INSERT INTO `user_action` VALUES ('259', '14', '19', '2018-04-24 09:59:39', '3', '0', 'name19');
INSERT INTO `user_action` VALUES ('260', '14', '86', '2018-04-24 09:59:47', '5', '0', '孤儿');
INSERT INTO `user_action` VALUES ('261', '14', '86', '2018-04-24 10:06:07', '5', '0', '孤儿');
INSERT INTO `user_action` VALUES ('262', '14', '83', '2018-04-24 10:06:40', '1', '0', 'qweqwe');
INSERT INTO `user_action` VALUES ('263', '14', '74', '2018-04-24 10:10:06', '0', '1', 'name74');
INSERT INTO `user_action` VALUES ('264', '14', '86', '2018-04-24 10:17:40', '5', '0', '孤儿');
INSERT INTO `user_action` VALUES ('265', '1', '88', '2018-04-24 15:46:28', '2', '0', '自由与责任');
INSERT INTO `user_action` VALUES ('266', '1', '85', '2018-04-24 16:01:24', '1', '0', 'qweqwe');
INSERT INTO `user_action` VALUES ('267', '1', '85', '2018-04-24 17:36:22', '1', '0', 'qweqwe');
INSERT INTO `user_action` VALUES ('268', '1', '85', '2018-04-24 17:36:25', '1', '0', 'qweqwe');
INSERT INTO `user_action` VALUES ('269', '1', '83', '2018-04-24 17:36:39', '1', '0', 'qweqwe');
INSERT INTO `user_action` VALUES ('270', '1', '83', '2018-04-24 17:38:53', '1', '0', 'qweqwe');
INSERT INTO `user_action` VALUES ('271', '1', '83', '2018-04-24 17:41:08', '1', '0', 'qweqwe');
INSERT INTO `user_action` VALUES ('272', '1', '83', '2018-04-24 17:42:16', '1', '0', 'qweqwe');
INSERT INTO `user_action` VALUES ('273', '8', '83', '2018-04-24 17:42:30', '1', '0', 'qweqwe');
INSERT INTO `user_action` VALUES ('274', '8', '83', '2018-04-24 17:42:42', '1', '0', 'qweqwe');
INSERT INTO `user_action` VALUES ('275', '8', '89', '2018-04-24 18:12:37', '7', '0', '浅谈我对幸福的定义和感受');
INSERT INTO `user_action` VALUES ('276', '8', '89', '2018-04-24 18:12:39', '7', '0', '浅谈我对幸福的定义和感受');
INSERT INTO `user_action` VALUES ('277', '8', '89', '2018-04-24 18:12:41', '7', '0', '浅谈我对幸福的定义和感受');
INSERT INTO `user_action` VALUES ('278', '8', '89', '2018-04-24 18:12:44', '7', '0', '浅谈我对幸福的定义和感受');
INSERT INTO `user_action` VALUES ('279', '8', '89', '2018-04-24 18:12:44', '7', '0', '浅谈我对幸福的定义和感受');
INSERT INTO `user_action` VALUES ('280', '8', '89', '2018-04-24 18:13:07', '7', '0', '浅谈我对幸福的定义和感受');
INSERT INTO `user_action` VALUES ('281', '8', '87', '2018-04-24 18:13:22', '2', '0', '懒');
INSERT INTO `user_action` VALUES ('282', '14', '87', '2018-04-30 00:22:42', '2', '0', '懒');
INSERT INTO `user_action` VALUES ('283', '14', '92', '2018-04-30 00:23:01', '7', '0', '浅谈对“年例”习俗的认识和看法');
INSERT INTO `user_action` VALUES ('284', '14', '89', '2018-04-30 00:24:30', '7', '0', '浅谈我对幸福的定义和感受');
INSERT INTO `user_action` VALUES ('285', '14', '88', '2018-04-30 00:24:38', '2', '0', '自由与责任');
INSERT INTO `user_action` VALUES ('286', '14', '87', '2018-04-30 00:25:09', '2', '0', '懒');
INSERT INTO `user_action` VALUES ('287', '14', '68', '2018-04-30 00:25:17', '0', '1', 'name68');
INSERT INTO `user_action` VALUES ('288', '14', '89', '2018-04-30 00:25:42', '7', '0', '浅谈我对幸福的定义和感受');
INSERT INTO `user_action` VALUES ('289', '14', '68', '2018-04-30 00:25:44', '0', '1', 'name68');
INSERT INTO `user_action` VALUES ('290', '14', '68', '2018-04-30 00:26:04', '0', '1', 'name68');
INSERT INTO `user_action` VALUES ('291', '14', '68', '2018-04-30 00:29:09', '0', '1', 'name68');
INSERT INTO `user_action` VALUES ('292', '14', '86', '2018-04-30 00:29:15', '5', '0', '孤儿');
INSERT INTO `user_action` VALUES ('293', '14', '74', '2018-04-30 00:29:21', '0', '1', 'name74');
INSERT INTO `user_action` VALUES ('294', '1', '88', '2018-05-03 21:05:30', '2', '0', '自由与责任');
INSERT INTO `user_action` VALUES ('295', '1', '92', '2018-05-03 21:05:34', '7', '0', '浅谈对“年例”习俗的认识和看法');
INSERT INTO `user_action` VALUES ('296', '1', '88', '2018-05-04 00:12:50', '2', '0', '自由与责任');
INSERT INTO `user_action` VALUES ('297', '1', '92', '2018-05-04 00:12:53', '7', '0', '浅谈对“年例”习俗的认识和看法');
INSERT INTO `user_action` VALUES ('298', '1', '88', '2018-05-04 21:55:43', '2', '0', '自由与责任');
INSERT INTO `user_action` VALUES ('299', '1', '92', '2018-05-04 21:57:00', '7', '0', '浅谈对“年例”习俗的认识和看法');
INSERT INTO `user_action` VALUES ('300', '1', '6', '2018-05-05 00:02:56', '1', '0', 'name6');
INSERT INTO `user_action` VALUES ('301', '1', '5', '2018-05-05 00:03:05', '1', '0', 'name5');
INSERT INTO `user_action` VALUES ('302', '1', '6', '2018-05-05 00:03:20', '1', '0', 'name6');
INSERT INTO `user_action` VALUES ('303', '1', '92', '2018-05-05 00:03:45', '7', '0', '浅谈对“年例”习俗的认识和看法');
INSERT INTO `user_action` VALUES ('304', '1', '89', '2018-05-05 00:03:49', '7', '0', '浅谈我对幸福的定义和感受');
INSERT INTO `user_action` VALUES ('305', '1', '89', '2018-05-05 11:24:39', '7', '0', '浅谈我对幸福的定义和感受');
INSERT INTO `user_action` VALUES ('306', '1', '89', '2018-05-05 11:24:50', '7', '0', '浅谈我对幸福的定义和感受');
INSERT INTO `user_action` VALUES ('307', '1', '85', '2018-05-05 11:25:02', '1', '0', 'qweqwe');
INSERT INTO `user_action` VALUES ('308', '1', '89', '2018-05-05 11:25:45', '7', '0', '浅谈我对幸福的定义和感受');
INSERT INTO `user_action` VALUES ('309', '1', '89', '2018-05-05 11:27:50', '7', '0', '浅谈我对幸福的定义和感受');
INSERT INTO `user_action` VALUES ('310', '1', '89', '2018-05-05 11:28:05', '7', '0', '浅谈我对幸福的定义和感受');
INSERT INTO `user_action` VALUES ('311', '1', '89', '2018-05-05 11:29:39', '7', '0', '浅谈我对幸福的定义和感受');
INSERT INTO `user_action` VALUES ('312', '1', '89', '2018-05-05 11:35:00', '7', '0', '浅谈我对幸福的定义和感受');
INSERT INTO `user_action` VALUES ('313', '1', '92', '2018-05-05 11:45:25', '7', '0', '浅谈对“年例”习俗的认识和看法');
INSERT INTO `user_action` VALUES ('314', '1', '92', '2018-05-05 11:45:30', '7', '0', '浅谈对“年例”习俗的认识和看法');
INSERT INTO `user_action` VALUES ('315', '1', '92', '2018-05-05 11:47:22', '7', '0', '浅谈对“年例”习俗的认识和看法');
INSERT INTO `user_action` VALUES ('316', '1', '92', '2018-05-05 11:47:28', '7', '0', '浅谈对“年例”习俗的认识和看法');
INSERT INTO `user_action` VALUES ('317', '8', '9', '2018-05-05 20:06:24', '1', '0', 'name9');
INSERT INTO `user_action` VALUES ('318', '8', '92', '2018-05-05 20:32:42', '7', '0', '浅谈对“年例”习俗的认识和看法');
INSERT INTO `user_action` VALUES ('319', '8', '92', '2018-05-05 20:57:31', '7', '0', '浅谈对“年例”习俗的认识和看法');
INSERT INTO `user_action` VALUES ('320', '8', '39', '2018-05-05 20:59:40', '6', '0', 'name39');
INSERT INTO `user_action` VALUES ('321', '8', '74', '2018-05-05 21:03:54', '0', '1', 'name74');
INSERT INTO `user_action` VALUES ('322', '1', '89', '2018-05-06 09:50:07', '7', '0', '浅谈我对幸福的定义和感受');
INSERT INTO `user_action` VALUES ('323', '1', '92', '2018-05-06 10:05:57', '7', '0', '浅谈对“年例”习俗的认识和看法');
INSERT INTO `user_action` VALUES ('324', '1', '9', '2018-05-06 10:11:28', '1', '0', 'name9');
INSERT INTO `user_action` VALUES ('325', '1', '74', '2018-05-06 10:11:37', '0', '1', 'name74');
INSERT INTO `user_action` VALUES ('326', '1', '80', '2018-05-07 17:54:10', '0', '1', 'name80');
