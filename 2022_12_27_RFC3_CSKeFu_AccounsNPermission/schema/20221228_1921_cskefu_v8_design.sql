/*
 Navicat MySQL Data Transfer

 Source Server         : inspiron16
 Source Server Type    : MySQL
 Source Server Version : 50740 (5.7.40-log)
 Source Host           : localhost:3306
 Source Schema         : cskefu_v8_design

 Target Server Type    : MySQL
 Target Server Version : 50740 (5.7.40-log)
 File Encoding         : 65001

 Date: 27/12/2022 19:23:45
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for cs_group_users
-- ----------------------------
DROP TABLE IF EXISTS `cs_group_users`;
CREATE TABLE `cs_group_users`  (
  `id` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `groupid` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `userid` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `createtime` datetime NULL DEFAULT CURRENT_TIMESTAMP,
  `updatetime` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `INDEX_USERID_GROUPID`(`groupid`, `userid`) USING BTREE,
  INDEX `FKEY_USER_ID`(`userid`) USING BTREE,
  CONSTRAINT `FKEY_GROUP_ID` FOREIGN KEY (`groupid`) REFERENCES `cs_groups` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FKEY_USER_ID` FOREIGN KEY (`userid`) REFERENCES `cs_users` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = 'Users in Group' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for cs_groups
-- ----------------------------
DROP TABLE IF EXISTS `cs_groups`;
CREATE TABLE `cs_groups`  (
  `id` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `description` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `createtime` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT 'CURRENT_TIMESTAMP',
  `updatetime` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT 'CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP',
  `deleted` tinyint(1) NULL DEFAULT 0,
  `creator` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `name_UNIQUE`(`name`) USING BTREE,
  INDEX `FKEY_GROUPS_USERS_CREATOR`(`creator`) USING BTREE,
  CONSTRAINT `FKEY_GROUPS_USERS_CREATOR` FOREIGN KEY (`creator`) REFERENCES `cs_users` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = 'Groups' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for cs_permission_groups
-- ----------------------------
DROP TABLE IF EXISTS `cs_permission_groups`;
CREATE TABLE `cs_permission_groups`  (
  `id` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `groupid` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `resourcepatternid` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `enabled` tinyint(1) NULL DEFAULT NULL,
  `createtime` datetime NULL DEFAULT CURRENT_TIMESTAMP,
  `updatetime` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `FKEY_USERID`(`groupid`) USING BTREE,
  INDEX `FKEY_RESPATTERNID`(`resourcepatternid`) USING BTREE,
  CONSTRAINT `cs_permission_groups_ibfk_1` FOREIGN KEY (`resourcepatternid`) REFERENCES `cs_resource_patterns` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `cs_permission_groups_ibfk_2` FOREIGN KEY (`groupid`) REFERENCES `cs_groups` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for cs_permission_users
-- ----------------------------
DROP TABLE IF EXISTS `cs_permission_users`;
CREATE TABLE `cs_permission_users`  (
  `id` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `userid` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `resourcepatternid` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `enabled` tinyint(1) NULL DEFAULT NULL,
  `createtime` datetime NULL DEFAULT CURRENT_TIMESTAMP,
  `updatetime` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `FKEY_USERID`(`userid`) USING BTREE,
  INDEX `FKEY_RESPATTERNID`(`resourcepatternid`) USING BTREE,
  CONSTRAINT `FKEY_USERID` FOREIGN KEY (`userid`) REFERENCES `cs_users` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FKEY_RESPATTERNID` FOREIGN KEY (`resourcepatternid`) REFERENCES `cs_resource_patterns` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for cs_resource_patterns
-- ----------------------------
DROP TABLE IF EXISTS `cs_resource_patterns`;
CREATE TABLE `cs_resource_patterns`  (
  `id` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `resourceid` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `pattern` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT 'URL Pattern',
  `method` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT 'HTTP Method: Post, Put, Delete, etc.',
  `pluginid` int(11) NULL DEFAULT NULL,
  `pluginversion` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `createtime` datetime NULL DEFAULT CURRENT_TIMESTAMP,
  `updatetime` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `FKEY_RESOURCE_ID`(`resourceid`) USING BTREE,
  CONSTRAINT `FKEY_RESOURCE_ID` FOREIGN KEY (`resourceid`) REFERENCES `cs_resources` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for cs_resources
-- ----------------------------
DROP TABLE IF EXISTS `cs_resources`;
CREATE TABLE `cs_resources`  (
  `id` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `spacekey` varchar(300) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `description` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `FKEY_SPACEKEY`(`spacekey`) USING BTREE,
  CONSTRAINT `FKEY_SPACEKEY` FOREIGN KEY (`spacekey`) REFERENCES `cs_spaces` (`spacekey`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for cs_spaces
-- ----------------------------
DROP TABLE IF EXISTS `cs_spaces`;
CREATE TABLE `cs_spaces`  (
  `id` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `spacename` varchar(300) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `spacekey` varchar(300) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `creator` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL,
  `createtime` datetime NULL DEFAULT CURRENT_TIMESTAMP,
  `updatetime` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `groupname_UNIQUE`(`spacename`) USING BTREE,
  UNIQUE INDEX `groupkey_UNIQUE`(`spacekey`) USING BTREE,
  INDEX `FKEY_SPACES_USERS_CREATOR`(`creator`) USING BTREE,
  CONSTRAINT `FKEY_SPACES_USERS_CREATOR` FOREIGN KEY (`creator`) REFERENCES `cs_users` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = 'Spaces' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for cs_users
-- ----------------------------
DROP TABLE IF EXISTS `cs_users`;
CREATE TABLE `cs_users`  (
  `id` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `lastname` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `username` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `firstname` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `realname` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `englishname` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `phonenumber` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `phonecountrycode` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `phoneverified` tinyint(1) NULL DEFAULT 0,
  `birthday` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `country` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `province` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `city` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `street` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `avatarurl` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `sex` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `birthyear` int(11) NULL DEFAULT NULL,
  `primarylanguage` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT 'Primary Language, locale code, zh_CN, zh_TW, en_US, etc.',
  `bio` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL,
  `email` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `emailverified` tinyint(1) NULL DEFAULT 0,
  `password` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `deleted` tinyint(1) NULL DEFAULT NULL,
  `identitytype` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT 'Identiry File Type -  ID card, passport, etc.',
  `identitynumber` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT 'Identity File Sn.',
  `identityverified` tinyint(1) NULL DEFAULT 0 COMMENT 'Identity File Verified or not',
  `identityverifydate` datetime NULL DEFAULT NULL,
  `createtime` datetime NULL DEFAULT CURRENT_TIMESTAMP,
  `updatetime` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `username_UNIQUE`(`username`) USING BTREE,
  UNIQUE INDEX `EMAIL`(`email`) USING BTREE,
  UNIQUE INDEX `PHONENUMBER`(`phonecountrycode`, `phonenumber`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = 'Users' ROW_FORMAT = Dynamic;

SET FOREIGN_KEY_CHECKS = 1;
