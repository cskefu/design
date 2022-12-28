/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 50740
Source Host           : localhost:3306
Source Database       : cskefu_v8_design

Target Server Type    : MYSQL
Target Server Version : 50740
File Encoding         : 65001

Date: 2022-12-28 11:01:04
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for cs_groups
-- ----------------------------
DROP TABLE IF EXISTS `cs_groups`;
CREATE TABLE `cs_groups` (
  `id` varchar(45) COLLATE utf8mb4_bin NOT NULL,
  `name` varchar(200) COLLATE utf8mb4_bin NOT NULL COMMENT 'Group name',
  `description` text COLLATE utf8mb4_bin COMMENT 'Group Description',
  `createtime` varchar(45) COLLATE utf8mb4_bin NOT NULL DEFAULT 'CURRENT_TIMESTAMP' COMMENT 'Create time',
  `updatetime` varchar(45) COLLATE utf8mb4_bin NOT NULL DEFAULT 'CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP' COMMENT 'Update time',
  `deleted` tinyint(1) DEFAULT '0',
  `creator` varchar(45) COLLATE utf8mb4_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name_UNIQUE` (`name`),
  KEY `FKEY_GROUPS_USERS_CREATOR` (`creator`),
  CONSTRAINT `FKEY_GROUPS_USERS_CREATOR` FOREIGN KEY (`creator`) REFERENCES `cs_users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='Groups';

-- ----------------------------
-- Table structure for cs_group_users
-- ----------------------------
DROP TABLE IF EXISTS `cs_group_users`;
CREATE TABLE `cs_group_users` (
  `id` varchar(45) COLLATE utf8mb4_bin NOT NULL,
  `groupid` varchar(45) COLLATE utf8mb4_bin NOT NULL COMMENT 'Group Id',
  `userid` varchar(45) COLLATE utf8mb4_bin NOT NULL COMMENT 'User Id',
  `createtime` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Create time',
  `updatetime` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Update time',
  PRIMARY KEY (`id`),
  UNIQUE KEY `INDEX_USERID_GROUPID` (`groupid`,`userid`),
  KEY `FKEY_USER_ID` (`userid`),
  CONSTRAINT `FKEY_GROUP_ID` FOREIGN KEY (`groupid`) REFERENCES `cs_groups` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FKEY_USER_ID` FOREIGN KEY (`userid`) REFERENCES `cs_users` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='Users in Group';

-- ----------------------------
-- Table structure for cs_permission_groups
-- ----------------------------
DROP TABLE IF EXISTS `cs_permission_groups`;
CREATE TABLE `cs_permission_groups` (
  `id` varchar(45) COLLATE utf8mb4_bin NOT NULL,
  `groupid` varchar(45) COLLATE utf8mb4_bin NOT NULL COMMENT 'Group Id',
  `resourceoperationid` varchar(45) COLLATE utf8mb4_bin NOT NULL COMMENT 'Resource Operation Id',
  `enabled` tinyint(1) DEFAULT NULL COMMENT '1',
  `createtime` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updatetime` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `FKEY_USERID` (`groupid`),
  KEY `FKEY_RESPATTERNID` (`resourceoperationid`),
  CONSTRAINT `cs_permission_groups_ibfk_1` FOREIGN KEY (`resourceoperationid`) REFERENCES `cs_resource_operations` (`id`),
  CONSTRAINT `cs_permission_groups_ibfk_2` FOREIGN KEY (`groupid`) REFERENCES `cs_groups` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- ----------------------------
-- Table structure for cs_permission_users
-- ----------------------------
DROP TABLE IF EXISTS `cs_permission_users`;
CREATE TABLE `cs_permission_users` (
  `id` varchar(45) COLLATE utf8mb4_bin NOT NULL,
  `userid` varchar(45) COLLATE utf8mb4_bin NOT NULL,
  `resourcepatternid` varchar(45) COLLATE utf8mb4_bin NOT NULL,
  `enabled` tinyint(1) DEFAULT NULL,
  `createtime` datetime DEFAULT CURRENT_TIMESTAMP,
  `updatetime` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `FKEY_USERID` (`userid`),
  KEY `FKEY_RESPATTERNID` (`resourcepatternid`),
  CONSTRAINT `FKEY_RESPATTERNID` FOREIGN KEY (`resourcepatternid`) REFERENCES `cs_resource_operations` (`id`),
  CONSTRAINT `FKEY_USERID` FOREIGN KEY (`userid`) REFERENCES `cs_users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- ----------------------------
-- Table structure for cs_resources
-- ----------------------------
DROP TABLE IF EXISTS `cs_resources`;
CREATE TABLE `cs_resources` (
  `id` varchar(45) COLLATE utf8mb4_bin NOT NULL,
  `spacekey` varchar(300) COLLATE utf8mb4_bin NOT NULL,
  `name` varchar(30) COLLATE utf8mb4_bin NOT NULL COMMENT 'Short name of this resource, e.g. workorder.',
  `description` text COLLATE utf8mb4_bin NOT NULL COMMENT 'Describe the resource in detail',
  PRIMARY KEY (`id`),
  KEY `FKEY_SPACEKEY` (`spacekey`),
  CONSTRAINT `FKEY_SPACEKEY` FOREIGN KEY (`spacekey`) REFERENCES `cs_spaces` (`spacekey`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- ----------------------------
-- Table structure for cs_resource_operations
-- ----------------------------
DROP TABLE IF EXISTS `cs_resource_operations`;
CREATE TABLE `cs_resource_operations` (
  `id` varchar(45) COLLATE utf8mb4_bin NOT NULL,
  `name` varchar(30) COLLATE utf8mb4_bin NOT NULL COMMENT 'Describe the operation with short chars, e.g. read, create, update, delete, admin',
  `description` varchar(1000) COLLATE utf8mb4_bin NOT NULL COMMENT 'A tooltip to describe the operation in details',
  `resourceid` varchar(45) COLLATE utf8mb4_bin NOT NULL COMMENT 'Resource Id',
  `pattern` varchar(500) COLLATE utf8mb4_bin NOT NULL COMMENT 'URL Path Pattern, e.g. /chat/*, /workorder/*',
  `method` varchar(255) COLLATE utf8mb4_bin NOT NULL COMMENT 'HTTP Method: Get, Post, Put, Delete, etc.',
  `pluginid` int(11) DEFAULT NULL COMMENT 'Plugin provide this operation',
  `pluginversion` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL COMMENT 'Plugin version of pluginid',
  `createtime` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updatetime` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `FKEY_RESOURCE_ID` (`resourceid`),
  CONSTRAINT `FKEY_RESOURCE_ID` FOREIGN KEY (`resourceid`) REFERENCES `cs_resources` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- ----------------------------
-- Table structure for cs_spaces
-- ----------------------------
DROP TABLE IF EXISTS `cs_spaces`;
CREATE TABLE `cs_spaces` (
  `id` varchar(45) COLLATE utf8mb4_bin NOT NULL,
  `spacename` varchar(300) COLLATE utf8mb4_bin NOT NULL,
  `spacekey` varchar(300) COLLATE utf8mb4_bin NOT NULL,
  `creator` varchar(45) COLLATE utf8mb4_bin NOT NULL,
  `description` text COLLATE utf8mb4_bin NOT NULL,
  `createtime` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updatetime` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `groupname_UNIQUE` (`spacename`),
  UNIQUE KEY `groupkey_UNIQUE` (`spacekey`),
  KEY `FKEY_SPACES_USERS_CREATOR` (`creator`),
  CONSTRAINT `FKEY_SPACES_USERS_CREATOR` FOREIGN KEY (`creator`) REFERENCES `cs_users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='Spaces';

-- ----------------------------
-- Table structure for cs_users
-- ----------------------------
DROP TABLE IF EXISTS `cs_users`;
CREATE TABLE `cs_users` (
  `id` varchar(45) COLLATE utf8mb4_bin NOT NULL,
  `lastname` varchar(200) COLLATE utf8mb4_bin DEFAULT NULL,
  `username` varchar(200) COLLATE utf8mb4_bin NOT NULL,
  `firstname` varchar(100) COLLATE utf8mb4_bin DEFAULT NULL,
  `realname` varchar(200) COLLATE utf8mb4_bin DEFAULT NULL,
  `englishname` varchar(200) COLLATE utf8mb4_bin DEFAULT NULL,
  `phonenumber` varchar(45) COLLATE utf8mb4_bin DEFAULT NULL,
  `phonecountrycode` varchar(45) COLLATE utf8mb4_bin DEFAULT NULL,
  `phoneverified` tinyint(1) DEFAULT '0',
  `birthday` varchar(45) COLLATE utf8mb4_bin DEFAULT NULL,
  `country` varchar(45) COLLATE utf8mb4_bin DEFAULT NULL,
  `province` varchar(45) COLLATE utf8mb4_bin DEFAULT NULL,
  `city` varchar(45) COLLATE utf8mb4_bin DEFAULT NULL,
  `street` varchar(500) COLLATE utf8mb4_bin DEFAULT NULL,
  `avatarurl` varchar(500) COLLATE utf8mb4_bin DEFAULT NULL,
  `sex` varchar(45) COLLATE utf8mb4_bin DEFAULT NULL,
  `birthyear` int(11) DEFAULT NULL,
  `primarylanguage` varchar(45) COLLATE utf8mb4_bin DEFAULT NULL COMMENT 'Primary Language, locale code, zh_CN, zh_TW, en_US, etc.',
  `bio` text COLLATE utf8mb4_bin,
  `email` varchar(200) COLLATE utf8mb4_bin NOT NULL,
  `emailverified` tinyint(1) DEFAULT '0',
  `password` varchar(200) COLLATE utf8mb4_bin DEFAULT NULL,
  `identitytype` varchar(45) COLLATE utf8mb4_bin DEFAULT NULL COMMENT 'Identiry File Type -  ID card, passport, etc.',
  `identitynumber` varchar(100) COLLATE utf8mb4_bin DEFAULT NULL COMMENT 'Identity File Sn.',
  `identityverified` tinyint(1) DEFAULT '0' COMMENT 'Identity File Verified or not',
  `identityverifydate` datetime DEFAULT NULL,
  `blocked` tinyint(1) DEFAULT '0',
  `deleted` tinyint(1) DEFAULT NULL,
  `createtime` datetime DEFAULT CURRENT_TIMESTAMP,
  `updatetime` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username_UNIQUE` (`username`),
  UNIQUE KEY `EMAIL` (`email`),
  UNIQUE KEY `PHONENUMBER` (`phonecountrycode`,`phonenumber`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='Users';
