/*
 Navicat Premium Data Transfer

 Source Server         : node1
 Source Server Type    : MySQL
 Source Server Version : 50610
 Source Host           : localhost:3306
 Source Schema         : my_db

 Target Server Type    : MySQL
 Target Server Version : 50610
 File Encoding         : 65001

 Date: 15/05/2022 14:35:34
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for access
-- ----------------------------
DROP TABLE IF EXISTS `access`;
CREATE TABLE `access` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of access
-- ----------------------------
BEGIN;
INSERT INTO `access` (`id`, `name`) VALUES (1, 'access_import');
INSERT INTO `access` (`id`, `name`) VALUES (2, 'access_export');
INSERT INTO `access` (`id`, `name`) VALUES (3, 'access_approval');
INSERT INTO `access` (`id`, `name`) VALUES (4, 'access_template');
INSERT INTO `access` (`id`, `name`) VALUES (5, 'access_user');
INSERT INTO `access` (`id`, `name`) VALUES (6, 'access_role');
COMMIT;

-- ----------------------------
-- Table structure for account
-- ----------------------------
DROP TABLE IF EXISTS `account`;
CREATE TABLE `account` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(255) DEFAULT NULL COMMENT '编号',
  `title` varchar(255) DEFAULT NULL COMMENT '抬头',
  `specification` varchar(255) DEFAULT NULL COMMENT '规格',
  `price` decimal(10,2) DEFAULT NULL COMMENT '单价',
  `count` int(11) DEFAULT NULL COMMENT '数量',
  `start_date` datetime DEFAULT NULL COMMENT '出场日期',
  `trade_date` datetime DEFAULT NULL COMMENT '交易日期',
  `total_amount` decimal(65,0) DEFAULT NULL COMMENT '总价',
  `status` int(255) DEFAULT NULL COMMENT '状态',
  `signature` varchar(255) DEFAULT NULL COMMENT '签名',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of account
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for article
-- ----------------------------
DROP TABLE IF EXISTS `article`;
CREATE TABLE `article` (
  `id` int(50) unsigned zerofill NOT NULL AUTO_INCREMENT,
  `title` varchar(255) CHARACTER SET utf8 NOT NULL,
  `content` varchar(255) CHARACTER SET utf8 NOT NULL,
  `cover_img` varchar(255) NOT NULL,
  `pub_date` datetime NOT NULL,
  `state` varchar(255) CHARACTER SET utf8 NOT NULL,
  `is_delete` tinyint(1) unsigned zerofill NOT NULL,
  `cate_id` int(11) NOT NULL,
  `author_id` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of article
-- ----------------------------
BEGIN;
INSERT INTO `article` (`id`, `title`, `content`, `cover_img`, `pub_date`, `state`, `is_delete`, `cate_id`, `author_id`) VALUES (00000000000000000000000000000000000000000000000001, '小王子', '222', '22', '2022-02-07 17:08:39', '1', 0, 1, 1);
INSERT INTO `article` (`id`, `title`, `content`, `cover_img`, `pub_date`, `state`, `is_delete`, `cate_id`, `author_id`) VALUES (00000000000000000000000000000000000000000000000002, 'pride and prejudise', '123141245', '', '0000-00-00 00:00:00', '??', 0, 2, 0);
INSERT INTO `article` (`id`, `title`, `content`, `cover_img`, `pub_date`, `state`, `is_delete`, `cate_id`, `author_id`) VALUES (00000000000000000000000000000000000000000000000003, 'pride and prejudise', '123141245', '\\uploads\\888bb8d7c79855759404d5fb74b67e30', '2022-02-07 17:36:16', '??', 0, 2, 10);
INSERT INTO `article` (`id`, `title`, `content`, `cover_img`, `pub_date`, `state`, `is_delete`, `cate_id`, `author_id`) VALUES (00000000000000000000000000000000000000000000000004, 'pride and prejudise', '123141245', '\\uploads\\6465d000fc9234d9ecf70da5d5cee3da', '2022-02-07 17:36:35', '草稿', 0, 2, 10);
INSERT INTO `article` (`id`, `title`, `content`, `cover_img`, `pub_date`, `state`, `is_delete`, `cate_id`, `author_id`) VALUES (00000000000000000000000000000000000000000000000005, 'pride and prejudise', '123141245', '\\uploads\\d1847038e6f3be67eb4b6fff217ffb64', '2022-02-07 17:36:56', '已发布', 0, 2, 10);
COMMIT;

-- ----------------------------
-- Table structure for article_cate
-- ----------------------------
DROP TABLE IF EXISTS `article_cate`;
CREATE TABLE `article_cate` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `alias` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `is_delete` tinyint(1) unsigned zerofill DEFAULT NULL COMMENT '0 未被删除 1被删除',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT COMMENT='文章分类数据表';

-- ----------------------------
-- Records of article_cate
-- ----------------------------
BEGIN;
INSERT INTO `article_cate` (`id`, `name`, `alias`, `is_delete`) VALUES (1, '科技', 'keji', 0);
INSERT INTO `article_cate` (`id`, `name`, `alias`, `is_delete`) VALUES (2, '教育', 'jiaoyu', 0);
INSERT INTO `article_cate` (`id`, `name`, `alias`, `is_delete`) VALUES (3, '文化', 'wenhua', 1);
COMMIT;

-- ----------------------------
-- Table structure for business
-- ----------------------------
DROP TABLE IF EXISTS `business`;
CREATE TABLE `business` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  `contact` varchar(20) DEFAULT NULL,
  `contact_phone` char(11) DEFAULT NULL,
  `address` varchar(50) DEFAULT NULL,
  `type` varchar(50) DEFAULT NULL,
  `orderCount` int(50) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of business
-- ----------------------------
BEGIN;
INSERT INTO `business` (`id`, `name`, `contact`, `contact_phone`, `address`, `type`, `orderCount`) VALUES (1, '杭州金点子有限公司', '林先生', '13956563434', '浙江省杭州市临安区科创大厦', '1', 10);
INSERT INTO `business` (`id`, `name`, `contact`, `contact_phone`, `address`, `type`, `orderCount`) VALUES (2, '思聪', 'Gert', '19858185202', '浙江省杭州市', '技术服务', 11);
COMMIT;

-- ----------------------------
-- Table structure for dict
-- ----------------------------
DROP TABLE IF EXISTS `dict`;
CREATE TABLE `dict` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of dict
-- ----------------------------
BEGIN;
INSERT INTO `dict` (`id`, `name`) VALUES (1, NULL);
COMMIT;

-- ----------------------------
-- Table structure for form
-- ----------------------------
DROP TABLE IF EXISTS `form`;
CREATE TABLE `form` (
  `id` int(50) NOT NULL AUTO_INCREMENT,
  `form_name` varchar(50) DEFAULT NULL,
  `form_date` varchar(50) DEFAULT NULL,
  `form_json` text,
  `form_temp_id` int(50) DEFAULT NULL,
  `approval` int(10) DEFAULT '0' COMMENT '审批 0：未审批；1：已审批',
  `commit` int(10) DEFAULT '0' COMMENT '0: 未提交； 1：已提交',
  `release` int(10) DEFAULT '0' COMMENT '0: 未发布；2：已发布',
  `status` int(2) DEFAULT '1',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of form
-- ----------------------------
BEGIN;
INSERT INTO `form` (`id`, `form_name`, `form_date`, `form_json`, `form_temp_id`, `approval`, `commit`, `release`, `status`) VALUES (1, '设备流水', '2022-05-15', NULL, NULL, 0, 0, 0, 1);
INSERT INTO `form` (`id`, `form_name`, `form_date`, `form_json`, `form_temp_id`, `approval`, `commit`, `release`, `status`) VALUES (2, '材料', '2022-05-03T16:00:00.000Z', NULL, 6, 0, 0, 0, 1);
COMMIT;

-- ----------------------------
-- Table structure for form_temp
-- ----------------------------
DROP TABLE IF EXISTS `form_temp`;
CREATE TABLE `form_temp` (
  `id` int(255) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  `form_json` text,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of form_temp
-- ----------------------------
BEGIN;
INSERT INTO `form_temp` (`id`, `name`, `form_json`) VALUES (1, '设备', NULL);
INSERT INTO `form_temp` (`id`, `name`, `form_json`) VALUES (2, '设备1', '{\"list\": [{\"key\": \"input_1651052163688\", \"help\": \"\", \"type\": \"input\", \"label\": \"订单号\", \"model\": \"input_1651052163688\", \"rules\": [{\"message\": \"必填项\", \"required\": false}], \"options\": {\"type\": \"text\", \"width\": \"100%\", \"hidden\": false, \"disabled\": false, \"clearable\": false, \"maxLength\": null, \"addonAfter\": \"\", \"addonBefore\": \"\", \"placeholder\": \"请输入\", \"defaultValue\": \"\"}}, {\"key\": \"textarea_1651052165210\", \"help\": \"\", \"type\": \"textarea\", \"label\": \"文本框\", \"model\": \"textarea_1651052165210\", \"rules\": [{\"message\": \"必填项\", \"required\": false}], \"options\": {\"width\": \"100%\", \"hidden\": false, \"maxRows\": 6, \"minRows\": 4, \"disabled\": false, \"clearable\": false, \"maxLength\": null, \"placeholder\": \"请输入\", \"defaultValue\": \"\"}}], \"config\": {\"layout\": \"horizontal\", \"labelCol\": {\"lg\": 4, \"md\": 4, \"sm\": 4, \"xl\": 4, \"xs\": 4, \"xxl\": 4}, \"labelWidth\": 100, \"wrapperCol\": {\"lg\": 18, \"md\": 18, \"sm\": 18, \"xl\": 18, \"xs\": 18, \"xxl\": 18}, \"customStyle\": \"\", \"labelLayout\": \"flex\", \"hideRequiredMark\": false}}');
INSERT INTO `form_temp` (`id`, `name`, `form_json`) VALUES (4, '设备3', '{\"list\": [{\"key\": \"input_1651057815239\", \"help\": \"\", \"type\": \"input\", \"label\": \"输入框\", \"model\": \"input_1651057815239\", \"rules\": [{\"message\": \"必填项\", \"required\": false}], \"options\": {\"type\": \"text\", \"width\": \"100%\", \"hidden\": false, \"disabled\": false, \"clearable\": false, \"maxLength\": null, \"addonAfter\": \"\", \"addonBefore\": \"\", \"placeholder\": \"请输入\", \"defaultValue\": \"\"}}], \"config\": {\"layout\": \"horizontal\", \"labelCol\": {\"lg\": 4, \"md\": 4, \"sm\": 4, \"xl\": 4, \"xs\": 4, \"xxl\": 4}, \"labelWidth\": 100, \"wrapperCol\": {\"lg\": 18, \"md\": 18, \"sm\": 18, \"xl\": 18, \"xs\": 18, \"xxl\": 18}, \"customStyle\": \"\", \"labelLayout\": \"flex\", \"hideRequiredMark\": false}}');
INSERT INTO `form_temp` (`id`, `name`, `form_json`) VALUES (5, '模板2', '{\"list\": [{\"key\": \"input_1651328555040\", \"help\": \"\", \"type\": \"input\", \"label\": \"输入框\", \"model\": \"input_1651328555040\", \"rules\": [{\"message\": \"必填项\", \"required\": false}], \"options\": {\"type\": \"text\", \"width\": \"100%\", \"hidden\": false, \"disabled\": false, \"clearable\": false, \"maxLength\": null, \"addonAfter\": \"\", \"addonBefore\": \"\", \"placeholder\": \"请输入\", \"defaultValue\": \"\"}}, {\"key\": \"input_1651328556741\", \"help\": \"\", \"type\": \"input\", \"label\": \"输入框\", \"model\": \"input_1651328556741\", \"rules\": [{\"message\": \"必填项\", \"required\": false}], \"options\": {\"type\": \"text\", \"width\": \"100%\", \"hidden\": false, \"disabled\": false, \"clearable\": false, \"maxLength\": null, \"addonAfter\": \"\", \"addonBefore\": \"\", \"placeholder\": \"请输入\", \"defaultValue\": \"\"}}, {\"key\": \"input_1651328555857\", \"help\": \"\", \"type\": \"input\", \"label\": \"输入框\", \"model\": \"input_1651328555857\", \"rules\": [{\"message\": \"必填项\", \"required\": false}], \"options\": {\"type\": \"text\", \"width\": \"100%\", \"hidden\": false, \"disabled\": false, \"clearable\": false, \"maxLength\": null, \"addonAfter\": \"\", \"addonBefore\": \"\", \"placeholder\": \"请输入\", \"defaultValue\": \"\"}}, {\"key\": \"input_1651328557757\", \"help\": \"\", \"type\": \"input\", \"label\": \"输入框\", \"model\": \"input_1651328557757\", \"rules\": [{\"message\": \"必填项\", \"required\": false}], \"options\": {\"type\": \"text\", \"width\": \"100%\", \"hidden\": false, \"disabled\": false, \"clearable\": false, \"maxLength\": null, \"addonAfter\": \"\", \"addonBefore\": \"\", \"placeholder\": \"请输入\", \"defaultValue\": \"\"}}, {\"key\": \"textarea_1651328559107\", \"help\": \"\", \"type\": \"textarea\", \"label\": \"文本框\", \"model\": \"textarea_1651328559107\", \"rules\": [{\"message\": \"必填项\", \"required\": false}], \"options\": {\"width\": \"100%\", \"hidden\": false, \"maxRows\": 6, \"minRows\": 4, \"disabled\": false, \"clearable\": false, \"maxLength\": null, \"placeholder\": \"请输入\", \"defaultValue\": \"\"}}, {\"key\": \"date_1651328560990\", \"help\": \"\", \"type\": \"date\", \"label\": \"日期选择框\", \"model\": \"date_1651328560990\", \"rules\": [{\"message\": \"必填项\", \"required\": false}], \"options\": {\"range\": false, \"width\": \"100%\", \"format\": \"YYYY-MM-DD\", \"hidden\": false, \"disabled\": false, \"showTime\": false, \"clearable\": false, \"placeholder\": \"请选择\", \"defaultValue\": \"\", \"rangePlaceholder\": [\"开始时间\", \"结束时间\"], \"rangeDefaultValue\": []}}], \"config\": {\"layout\": \"horizontal\", \"labelCol\": {\"lg\": 4, \"md\": 4, \"sm\": 4, \"xl\": 4, \"xs\": 4, \"xxl\": 4}, \"labelWidth\": 100, \"wrapperCol\": {\"lg\": 18, \"md\": 18, \"sm\": 18, \"xl\": 18, \"xs\": 18, \"xxl\": 18}, \"customStyle\": \"\", \"labelLayout\": \"flex\", \"hideRequiredMark\": false}}');
INSERT INTO `form_temp` (`id`, `name`, `form_json`) VALUES (6, 'test', '{\"list\":[{\"type\":\"input\",\"label\":\"姓名\",\"options\":{\"type\":\"text\",\"width\":\"100%\",\"defaultValue\":\"123\",\"placeholder\":\"请输入\",\"clearable\":false,\"maxLength\":null,\"addonBefore\":\"\",\"addonAfter\":\"\",\"hidden\":false,\"disabled\":false},\"model\":\"小红\",\"key\":\"input_1651754809279\",\"help\":\"\",\"rules\":[{\"required\":false,\"message\":\"必填项\"}]},{\"type\":\"input\",\"label\":\"输入框\",\"options\":{\"type\":\"text\",\"width\":\"100%\",\"defaultValue\":\"\",\"placeholder\":\"请输入\",\"clearable\":false,\"maxLength\":null,\"addonBefore\":\"\",\"addonAfter\":\"\",\"hidden\":false,\"disabled\":false},\"model\":\"input_1651754868868\",\"key\":\"input_1651754868868\",\"help\":\"\",\"rules\":[{\"required\":false,\"message\":\"必填项\"}]},{\"type\":\"input\",\"label\":\"输入框\",\"options\":{\"type\":\"text\",\"width\":\"100%\",\"defaultValue\":\"\",\"placeholder\":\"请输入\",\"clearable\":false,\"maxLength\":null,\"addonBefore\":\"\",\"addonAfter\":\"\",\"hidden\":false,\"disabled\":false},\"model\":\"input_1651754882823\",\"key\":\"input_1651754882823\",\"help\":\"\",\"rules\":[{\"required\":false,\"message\":\"必填项\"}]},{\"type\":\"input\",\"label\":\"输入框\",\"options\":{\"type\":\"text\",\"width\":\"100%\",\"defaultValue\":\"\",\"placeholder\":\"请输入\",\"clearable\":false,\"maxLength\":null,\"addonBefore\":\"\",\"addonAfter\":\"\",\"hidden\":false,\"disabled\":false},\"model\":\"input_1651754884904\",\"key\":\"input_1651754884904\",\"help\":\"\",\"rules\":[{\"required\":false,\"message\":\"必填项\"}]},{\"type\":\"input\",\"label\":\"输入框\",\"options\":{\"type\":\"text\",\"width\":\"100%\",\"defaultValue\":\"\",\"placeholder\":\"请输入\",\"clearable\":false,\"maxLength\":null,\"addonBefore\":\"\",\"addonAfter\":\"\",\"hidden\":false,\"disabled\":false},\"model\":\"input_1651754886752\",\"key\":\"input_1651754886752\",\"help\":\"\",\"rules\":[{\"required\":false,\"message\":\"必填项\"}]}],\"config\":{\"layout\":\"inline\",\"labelCol\":{\"xs\":4,\"sm\":4,\"md\":4,\"lg\":4,\"xl\":4,\"xxl\":4},\"labelWidth\":100,\"labelLayout\":\"flex\",\"wrapperCol\":{\"xs\":18,\"sm\":18,\"md\":18,\"lg\":18,\"xl\":18,\"xxl\":18},\"hideRequiredMark\":false,\"customStyle\":\"\"}}');
INSERT INTO `form_temp` (`id`, `name`, `form_json`) VALUES (7, '台账1', '{\"list\":[{\"type\":\"grid\",\"label\":\"栅格布局\",\"icon\":\"icon-zhage\",\"columns\":[{\"span\":12,\"list\":[{\"type\":\"input\",\"label\":\"单号\",\"options\":{\"type\":\"text\",\"width\":\"100%\",\"defaultValue\":\"\",\"placeholder\":\"请输入\",\"clearable\":false,\"maxLength\":null,\"addonBefore\":\"\",\"addonAfter\":\"\",\"hidden\":false,\"disabled\":false},\"model\":\"input_1652581597759\",\"key\":\"input_1652581597759\",\"help\":\"\",\"rules\":[{\"required\":false,\"message\":\"必填项\"}]}]},{\"span\":12,\"list\":[{\"type\":\"input\",\"label\":\"名称\",\"options\":{\"type\":\"text\",\"width\":\"100%\",\"defaultValue\":\"\",\"placeholder\":\"请输入\",\"clearable\":false,\"maxLength\":null,\"addonBefore\":\"\",\"addonAfter\":\"\",\"hidden\":false,\"disabled\":false},\"model\":\"input_1652581600594\",\"key\":\"input_1652581600594\",\"help\":\"\",\"rules\":[{\"required\":false,\"message\":\"必填项\"}]}]}],\"options\":{\"gutter\":0},\"key\":\"grid_1652581636803\"},{\"type\":\"grid\",\"label\":\"栅格布局\",\"icon\":\"icon-zhage\",\"columns\":[{\"span\":12,\"list\":[{\"type\":\"input\",\"label\":\"单位名称\",\"options\":{\"type\":\"text\",\"width\":\"100%\",\"defaultValue\":\"\",\"placeholder\":\"请输入\",\"clearable\":false,\"maxLength\":null,\"addonBefore\":\"\",\"addonAfter\":\"\",\"hidden\":false,\"disabled\":false},\"model\":\"input_1652581645269\",\"key\":\"input_1652581645269\",\"help\":\"\",\"rules\":[{\"required\":false,\"message\":\"必填项\"}]}]},{\"span\":12,\"list\":[{\"type\":\"input\",\"label\":\"规格\",\"icon\":\"icon-write\",\"options\":{\"type\":\"text\",\"width\":\"100%\",\"defaultValue\":\"\",\"placeholder\":\"请输入\",\"clearable\":false,\"maxLength\":null,\"addonBefore\":\"\",\"addonAfter\":\"\",\"hidden\":false,\"disabled\":false},\"model\":\"input_1652581704672\",\"key\":\"input_1652581704672\",\"help\":\"\",\"rules\":[{\"required\":false,\"message\":\"必填项\"}]}]}],\"options\":{\"gutter\":0},\"key\":\"grid_1652581699409\"}],\"config\":{\"layout\":\"horizontal\",\"labelCol\":{\"xs\":4,\"sm\":4,\"md\":4,\"lg\":4,\"xl\":4,\"xxl\":4},\"labelWidth\":100,\"labelLayout\":\"flex\",\"wrapperCol\":{\"xs\":18,\"sm\":18,\"md\":18,\"lg\":18,\"xl\":18,\"xxl\":18},\"hideRequiredMark\":false,\"customStyle\":\"\"}}');
COMMIT;

-- ----------------------------
-- Table structure for menu
-- ----------------------------
DROP TABLE IF EXISTS `menu`;
CREATE TABLE `menu` (
  `id` int(50) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `url` varchar(255) DEFAULT NULL,
  `icon` varchar(255) DEFAULT NULL,
  `parent_id` int(50) DEFAULT '0',
  `enable` tinyint(1) DEFAULT NULL COMMENT '是否启用',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of menu
-- ----------------------------
BEGIN;
INSERT INTO `menu` (`id`, `name`, `url`, `icon`, `parent_id`, `enable`) VALUES (1, '用户管理', '/user', 'el-icon-user-solid', 0, 1);
INSERT INTO `menu` (`id`, `name`, `url`, `icon`, `parent_id`, `enable`) VALUES (2, '角色管理', '/role', 'el-icon-s-check', 0, 1);
INSERT INTO `menu` (`id`, `name`, `url`, `icon`, `parent_id`, `enable`) VALUES (3, '权限管理', '/menu', 'el-icon-menu', 0, 0);
INSERT INTO `menu` (`id`, `name`, `url`, `icon`, `parent_id`, `enable`) VALUES (4, '模板管理', '/template', 'el-icon-s-tools', 0, 1);
INSERT INTO `menu` (`id`, `name`, `url`, `icon`, `parent_id`, `enable`) VALUES (5, '任务管理', '/tasks', 'el-icon-s-flag', 0, 1);
INSERT INTO `menu` (`id`, `name`, `url`, `icon`, `parent_id`, `enable`) VALUES (6, '字典管理', '/dict', 'el-icon-info', 0, 1);
INSERT INTO `menu` (`id`, `name`, `url`, `icon`, `parent_id`, `enable`) VALUES (7, '业务单位管理', '/business', 'el-icon-s-cooperation', 0, 1);
INSERT INTO `menu` (`id`, `name`, `url`, `icon`, `parent_id`, `enable`) VALUES (8, '归档管理', '/archives', 'el-icon-s-management', 0, 1);
INSERT INTO `menu` (`id`, `name`, `url`, `icon`, `parent_id`, `enable`) VALUES (9, '台账管理', '/accounts', 'el-icon-s-order', 0, 1);
COMMIT;

-- ----------------------------
-- Table structure for menu_role
-- ----------------------------
DROP TABLE IF EXISTS `menu_role`;
CREATE TABLE `menu_role` (
  `id` int(50) NOT NULL,
  `menu_id` int(50) DEFAULT NULL,
  `role_id` int(50) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `menu_id` (`menu_id`) USING BTREE,
  KEY `menu_role_ibfk_2` (`role_id`) USING BTREE,
  CONSTRAINT `menu_role_ibfk_1` FOREIGN KEY (`menu_id`) REFERENCES `menu` (`id`),
  CONSTRAINT `menu_role_ibfk_2` FOREIGN KEY (`role_id`) REFERENCES `role` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of menu_role
-- ----------------------------
BEGIN;
INSERT INTO `menu_role` (`id`, `menu_id`, `role_id`) VALUES (1, 1, 1);
INSERT INTO `menu_role` (`id`, `menu_id`, `role_id`) VALUES (2, 2, 1);
INSERT INTO `menu_role` (`id`, `menu_id`, `role_id`) VALUES (3, 3, 1);
INSERT INTO `menu_role` (`id`, `menu_id`, `role_id`) VALUES (4, 4, 1);
INSERT INTO `menu_role` (`id`, `menu_id`, `role_id`) VALUES (5, 5, 1);
INSERT INTO `menu_role` (`id`, `menu_id`, `role_id`) VALUES (6, 7, 1);
INSERT INTO `menu_role` (`id`, `menu_id`, `role_id`) VALUES (7, 8, 1);
INSERT INTO `menu_role` (`id`, `menu_id`, `role_id`) VALUES (8, 9, 1);
COMMIT;

-- ----------------------------
-- Table structure for role
-- ----------------------------
DROP TABLE IF EXISTS `role`;
CREATE TABLE `role` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of role
-- ----------------------------
BEGIN;
INSERT INTO `role` (`id`, `name`) VALUES (1, '管理员');
INSERT INTO `role` (`id`, `name`) VALUES (2, '审批单位');
INSERT INTO `role` (`id`, `name`) VALUES (3, '下属单位');
COMMIT;

-- ----------------------------
-- Table structure for role_access
-- ----------------------------
DROP TABLE IF EXISTS `role_access`;
CREATE TABLE `role_access` (
  `id` int(11) NOT NULL,
  `role_id` int(11) DEFAULT NULL,
  `access_id` int(50) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `access_id` (`access_id`) USING BTREE,
  KEY `role_access_ibfk_3` (`role_id`) USING BTREE,
  CONSTRAINT `role_access_ibfk_2` FOREIGN KEY (`access_id`) REFERENCES `access` (`id`),
  CONSTRAINT `role_access_ibfk_3` FOREIGN KEY (`role_id`) REFERENCES `role` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of role_access
-- ----------------------------
BEGIN;
INSERT INTO `role_access` (`id`, `role_id`, `access_id`) VALUES (1, 1, 5);
INSERT INTO `role_access` (`id`, `role_id`, `access_id`) VALUES (2, 1, 6);
INSERT INTO `role_access` (`id`, `role_id`, `access_id`) VALUES (3, 2, 3);
INSERT INTO `role_access` (`id`, `role_id`, `access_id`) VALUES (4, 2, 4);
INSERT INTO `role_access` (`id`, `role_id`, `access_id`) VALUES (5, 3, 1);
INSERT INTO `role_access` (`id`, `role_id`, `access_id`) VALUES (6, 3, 2);
COMMIT;

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(255) CHARACTER SET utf8 NOT NULL,
  `password` varchar(255) DEFAULT NULL,
  `realName` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `phone` varchar(50) DEFAULT NULL,
  `user_picture` varchar(255) DEFAULT NULL,
  `nickname` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=42 DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of user
-- ----------------------------
BEGIN;
INSERT INTO `user` (`id`, `username`, `password`, `realName`, `email`, `phone`, `user_picture`, `nickname`) VALUES (1, 'tyt', '123456', '童烨韬', 'tyt@gamil.com', '13946764452', '1', '22');
INSERT INTO `user` (`id`, `username`, `password`, `realName`, `email`, `phone`, `user_picture`, `nickname`) VALUES (40, 'asdf', '123123', '童烨韬', '601728814@qq.com', '13953534343', NULL, NULL);
INSERT INTO `user` (`id`, `username`, `password`, `realName`, `email`, `phone`, `user_picture`, `nickname`) VALUES (41, 'gert', '123123', '童烨韬', 'gertyt@foxmail.com', '13858185202', NULL, NULL);
COMMIT;

-- ----------------------------
-- Table structure for user_role
-- ----------------------------
DROP TABLE IF EXISTS `user_role`;
CREATE TABLE `user_role` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(255) DEFAULT NULL,
  `role_id` int(11) DEFAULT '3',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `user_role_ibfk_1` (`user_id`) USING BTREE,
  KEY `user_role_ibfk_2` (`role_id`) USING BTREE,
  CONSTRAINT `user_role_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`),
  CONSTRAINT `user_role_ibfk_2` FOREIGN KEY (`role_id`) REFERENCES `role` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=53 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of user_role
-- ----------------------------
BEGIN;
INSERT INTO `user_role` (`id`, `user_id`, `role_id`) VALUES (44, 1, 3);
INSERT INTO `user_role` (`id`, `user_id`, `role_id`) VALUES (45, 1, 2);
INSERT INTO `user_role` (`id`, `user_id`, `role_id`) VALUES (47, 41, 1);
INSERT INTO `user_role` (`id`, `user_id`, `role_id`) VALUES (50, 40, 2);
INSERT INTO `user_role` (`id`, `user_id`, `role_id`) VALUES (51, 40, 3);
INSERT INTO `user_role` (`id`, `user_id`, `role_id`) VALUES (52, 40, 1);
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;
