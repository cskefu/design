/*
 Navicat MySQL Data Transfer

 Source Server         : localhost
 Source Server Type    : MySQL
 Source Server Version : 50740 (5.7.40-log)
 Source Host           : localhost:3306
 Source Schema         : cskefu_v8_design

 Target Server Type    : MySQL
 Target Server Version : 50740 (5.7.40-log)
 File Encoding         : 65001

 Date: 28/12/2022 16:14:35
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for cs_group_users
-- ----------------------------
DROP TABLE IF EXISTS `cs_group_users`;
CREATE TABLE `cs_group_users`  (
  `id` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `groupid` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT 'Group Id',
  `userid` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT 'User Id',
  `createtime` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Create time',
  `updatetime` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Update time',
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
  `name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT 'Group name',
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL COMMENT 'Group Description',
  `createtime` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT 'CURRENT_TIMESTAMP' COMMENT 'Create time',
  `updatetime` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT 'CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP' COMMENT 'Update time',
  `deleted` tinyint(1) NULL DEFAULT 0,
  `creator` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
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
  `groupid` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT 'Group Id',
  `resourceoperationid` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT 'Resource Operation Id',
  `enabled` tinyint(1) NULL DEFAULT NULL COMMENT '1',
  `createtime` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updatetime` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `FKEY_USERID`(`groupid`) USING BTREE,
  INDEX `FKEY_RESPATTERNID`(`resourceoperationid`) USING BTREE,
  CONSTRAINT `cs_permission_groups_ibfk_1` FOREIGN KEY (`resourceoperationid`) REFERENCES `cs_resource_operations` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `cs_permission_groups_ibfk_2` FOREIGN KEY (`groupid`) REFERENCES `cs_groups` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = 'Permission for each group against Resource Operations' ROW_FORMAT = Dynamic;

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
  CONSTRAINT `FKEY_RESPATTERNID` FOREIGN KEY (`resourcepatternid`) REFERENCES `cs_resource_operations` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FKEY_USERID` FOREIGN KEY (`userid`) REFERENCES `cs_users` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = 'Permission for user against Resource Operations' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for cs_plugins
-- ----------------------------
DROP TABLE IF EXISTS `cs_plugins`;
CREATE TABLE `cs_plugins`  (
  `id` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT 'Plugin name',
  `groupid` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT 'Plugin group id\r\n',
  `artifactid` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT 'Plugin artifact id',
  `version` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT 'Plugin version\r\n',
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL COMMENT 'Plugin description',
  `gridfsfileidweb` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT 'Plugin Web file for frontend on GridFS',
  `gridfsfileidjar` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT 'Plugin install file id on GridFS',
  `pluginjson` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL COMMENT 'plugin.json as Metadata',
  `state` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT 'Plugin state, e.g. installed, activated, disabled, expired',
  `installerid` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT 'Installed by who',
  `vendor` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT 'Author, Provider name, e.g. company name, developer name',
  `officialsite` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT 'Plugin Public Official Site, URL',
  `vendoremail` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT 'Email contact address of vendor',
  `createtime` datetime NULL DEFAULT CURRENT_TIMESTAMP,
  `updatetime` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted` tinyint(1) NULL DEFAULT 0 COMMENT 'Is this plugin deleted or not',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `INDEX_GROUP_ART_VERSION`(`groupid`, `artifactid`, `version`) USING BTREE,
  INDEX `FKEY_INSTALLER`(`installerid`) USING BTREE,
  CONSTRAINT `FKEY_INSTALLER` FOREIGN KEY (`installerid`) REFERENCES `cs_users` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = 'Plugins' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for cs_plugins_config_global
-- ----------------------------
DROP TABLE IF EXISTS `cs_plugins_config_global`;
CREATE TABLE `cs_plugins_config_global`  (
  `id` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `plugingroupid` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT 'Plugin group id',
  `pluginartifactid` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT 'Plugin artifact id',
  `pluginversion` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT 'Plugin version',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT 'Property name',
  `value` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL COMMENT 'Property value',
  `type` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT 'Property type, e.g. string, int, json, float',
  `help` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL COMMENT 'Tooltip to users to fill in value',
  `required` tinyint(1) NULL DEFAULT NULL COMMENT 'This property is required or not to use this plugin',
  `lastmodifieduserid` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT 'Property last updated by who',
  `createtime` datetime NULL DEFAULT CURRENT_TIMESTAMP,
  `updatetime` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `KEY_GROUP_ART_VERSION_NAME`(`plugingroupid`, `pluginartifactid`, `pluginversion`, `name`) USING BTREE,
  INDEX `FKEY_LAST_MODIFIED_BY_G`(`lastmodifieduserid`) USING BTREE,
  CONSTRAINT `FKEY_LAST_MODIFIED_BY_G` FOREIGN KEY (`lastmodifieduserid`) REFERENCES `cs_users` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = 'Plugin Configurations globally' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for cs_plugins_config_space
-- ----------------------------
DROP TABLE IF EXISTS `cs_plugins_config_space`;
CREATE TABLE `cs_plugins_config_space`  (
  `id` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `plugingroupid` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT 'Plugin group id',
  `pluginartifactid` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT 'Plugin artifact id',
  `pluginversion` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT 'Plugin version',
  `spaceid` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT 'Space id',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT 'Property name',
  `type` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT 'Property type',
  `value` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL COMMENT 'Property value',
  `help` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL COMMENT 'Tooltip to users to fill in value',
  `required` tinyint(1) NULL DEFAULT NULL COMMENT 'This property is required or not to use this plugin',
  `lastmodifieduserid` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT 'Property last updated by who',
  `createtime` datetime NULL DEFAULT CURRENT_TIMESTAMP,
  `updatetime` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `FKEY_SPACE_ID`(`spaceid`) USING BTREE,
  INDEX `KEY_GROUP_ART_VERSION_SPACE_NAME`(`plugingroupid`, `pluginartifactid`, `pluginversion`, `spaceid`, `name`) USING BTREE,
  INDEX `FKEY_LAST_MODIFIED_BY`(`lastmodifieduserid`) USING BTREE,
  CONSTRAINT `FKEY_SPACE_ID` FOREIGN KEY (`spaceid`) REFERENCES `cs_spaces` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FKEY_LAST_MODIFIED_BY` FOREIGN KEY (`lastmodifieduserid`) REFERENCES `cs_users` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = 'Plugin Configurations by per Space' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for cs_resource_operations
-- ----------------------------
DROP TABLE IF EXISTS `cs_resource_operations`;
CREATE TABLE `cs_resource_operations`  (
  `id` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT 'Describe the operation with short chars, e.g. read, create, update, delete, admin',
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT 'A tooltip to describe the operation in details',
  `resourceid` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT 'Resource Id',
  `pattern` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT 'URL Path Pattern, e.g. /chat/*, /workorder/*',
  `method` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT 'HTTP Method: Get, Post, Put, Delete, etc.',
  `pluginid` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT 'Plugin provide this operation',
  `createtime` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updatetime` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `FKEY_RESOURCE_ID`(`resourceid`) USING BTREE,
  INDEX `FKEY_PLUGIN_ID`(`pluginid`) USING BTREE,
  CONSTRAINT `FKEY_RESOURCE_ID` FOREIGN KEY (`resourceid`) REFERENCES `cs_resources` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FKEY_PLUGIN_ID` FOREIGN KEY (`pluginid`) REFERENCES `cs_plugins` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = 'Operations upon Resources' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for cs_resources
-- ----------------------------
DROP TABLE IF EXISTS `cs_resources`;
CREATE TABLE `cs_resources`  (
  `id` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `spacekey` varchar(300) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT 'Short name of this resource, e.g. workorder.',
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT 'Describe the resource in detail',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `FKEY_SPACEKEY`(`spacekey`) USING BTREE,
  CONSTRAINT `FKEY_SPACEKEY` FOREIGN KEY (`spacekey`) REFERENCES `cs_spaces` (`spacekey`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = 'Resources' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for cs_spaces
-- ----------------------------
DROP TABLE IF EXISTS `cs_spaces`;
CREATE TABLE `cs_spaces`  (
  `id` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `spacename` varchar(300) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `spacekey` varchar(300) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `creator` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `createtime` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updatetime` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
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
  `email` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `emailverified` tinyint(1) NULL DEFAULT 0,
  `password` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `identitytype` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT 'Identiry File Type -  ID card, passport, etc.',
  `identitynumber` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT 'Identity File Sn.',
  `identityverified` tinyint(1) NULL DEFAULT 0 COMMENT 'Identity File Verified or not',
  `identityverifydate` datetime NULL DEFAULT NULL,
  `blocked` tinyint(1) NULL DEFAULT 0,
  `deleted` tinyint(1) NULL DEFAULT NULL,
  `createtime` datetime NULL DEFAULT CURRENT_TIMESTAMP,
  `updatetime` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `username_UNIQUE`(`username`) USING BTREE,
  UNIQUE INDEX `EMAIL`(`email`) USING BTREE,
  UNIQUE INDEX `PHONENUMBER`(`phonecountrycode`, `phonenumber`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = 'Users' ROW_FORMAT = Dynamic;

SET FOREIGN_KEY_CHECKS = 1;
