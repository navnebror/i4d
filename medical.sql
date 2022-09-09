/*
 Navicat Premium Data Transfer

 Source Server         : MariaDB - Docker
 Source Server Type    : MariaDB
 Source Server Version : 100604
 Source Host           : 172.17.0.3:3306
 Source Schema         : medical

 Target Server Type    : MariaDB
 Target Server Version : 100604
 File Encoding         : 65001

 Date: 08/09/2022 20:41:34
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for blood_count
-- ----------------------------
DROP TABLE IF EXISTS `blood_count`;
CREATE TABLE `blood_count`  (
  `patient_id_type` varchar(2) CHARACTER SET latin1 COLLATE latin1_general_cs NOT NULL,
  `patient_id` varchar(20) CHARACTER SET latin1 COLLATE latin1_general_cs NOT NULL,
  `topic_id` varchar(20) CHARACTER SET latin1 COLLATE latin1_general_cs NOT NULL,
  `level_date` datetime(0) NOT NULL DEFAULT current_timestamp(),
  `level_value` double(4, 1) NOT NULL,
  PRIMARY KEY (`patient_id_type`, `patient_id`, `topic_id`, `level_date`) USING BTREE,
  INDEX `topic_id`(`topic_id`) USING BTREE,
  CONSTRAINT `blood_count_ibfk_1` FOREIGN KEY (`patient_id_type`, `patient_id`) REFERENCES `patients` (`id_type`, `id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `blood_count_ibfk_2` FOREIGN KEY (`topic_id`) REFERENCES `topics` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of blood_count
-- ----------------------------
INSERT INTO `blood_count` VALUES ('CC', '12345', 'FAT', '2022-07-01 20:49:15', 45.0);
INSERT INTO `blood_count` VALUES ('CC', '12345', 'FAT', '2022-09-02 20:49:15', 45.0);
INSERT INTO `blood_count` VALUES ('CC', '12345', 'OXYGEN', '2022-07-01 20:49:15', 90.0);
INSERT INTO `blood_count` VALUES ('CC', '12345', 'OXYGEN', '2022-09-02 20:49:15', 90.0);
INSERT INTO `blood_count` VALUES ('CC', '12345', 'SUGAR', '2022-07-01 20:49:15', 40.0);
INSERT INTO `blood_count` VALUES ('CC', '12345', 'SUGAR', '2022-09-02 20:49:15', 40.0);
INSERT INTO `blood_count` VALUES ('CC', '55555', 'FAT', '2022-09-02 20:50:20', 70.0);
INSERT INTO `blood_count` VALUES ('CC', '55555', 'OXYGEN', '2022-09-02 20:50:20', 80.0);
INSERT INTO `blood_count` VALUES ('CC', '55555', 'SUGAR', '2022-09-02 20:50:20', 60.0);
INSERT INTO `blood_count` VALUES ('CE', '22222', 'FAT', '2022-09-03 01:51:17', 90.0);
INSERT INTO `blood_count` VALUES ('CE', '22222', 'OXYGEN', '2022-09-03 01:51:17', 50.0);
INSERT INTO `blood_count` VALUES ('CE', '22222', 'SUGAR', '2022-09-03 01:51:17', 90.0);
INSERT INTO `blood_count` VALUES ('CE', '33333', 'FAT', '2022-09-03 20:52:16', 40.0);
INSERT INTO `blood_count` VALUES ('CE', '33333', 'OXYGEN', '2022-09-03 01:52:33', 40.0);
INSERT INTO `blood_count` VALUES ('CE', '33333', 'SUGAR', '2022-09-03 01:51:48', 40.0);
INSERT INTO `blood_count` VALUES ('CE', '44444', 'FAT', '2022-09-03 01:53:09', 30.0);
INSERT INTO `blood_count` VALUES ('CE', '44444', 'OXYGEN', '2022-09-03 01:53:18', 30.0);
INSERT INTO `blood_count` VALUES ('CE', '44444', 'SUGAR', '2022-09-03 01:52:51', 90.0);

-- ----------------------------
-- Table structure for illness
-- ----------------------------
DROP TABLE IF EXISTS `illness`;
CREATE TABLE `illness`  (
  `id` varchar(20) CHARACTER SET latin1 COLLATE latin1_general_cs NOT NULL,
  `description` varchar(255) CHARACTER SET latin1 COLLATE latin1_general_cs NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of illness
-- ----------------------------
INSERT INTO `illness` VALUES ('SARS-CoV-2', 'COVID-19');

-- ----------------------------
-- Table structure for patients
-- ----------------------------
DROP TABLE IF EXISTS `patients`;
CREATE TABLE `patients`  (
  `id_type` varchar(2) CHARACTER SET latin1 COLLATE latin1_general_cs NOT NULL,
  `id` varchar(20) CHARACTER SET latin1 COLLATE latin1_general_cs NOT NULL,
  `first_name` varchar(255) CHARACTER SET latin1 COLLATE latin1_general_cs NOT NULL,
  `last_name` varchar(255) CHARACTER SET latin1 COLLATE latin1_general_cs NOT NULL,
  `birth_date` date NOT NULL,
  PRIMARY KEY (`id_type`, `id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of patients
-- ----------------------------
INSERT INTO `patients` VALUES ('CC', '12345', 'SELENA', 'GOMEZ', '1992-07-22');
INSERT INTO `patients` VALUES ('CC', '55555', 'LINA', 'TEJEIRO', '1991-10-08');
INSERT INTO `patients` VALUES ('CE', '22222', 'BILL', 'GATES', '1955-10-28');
INSERT INTO `patients` VALUES ('CE', '33333', 'ELON', 'MUSK', '1972-07-28');
INSERT INTO `patients` VALUES ('CE', '44444', 'MARIE', 'CURIE', '1867-11-07');

-- ----------------------------
-- Table structure for risk_factors
-- ----------------------------
DROP TABLE IF EXISTS `risk_factors`;
CREATE TABLE `risk_factors`  (
  `illness_id` varchar(20) CHARACTER SET latin1 COLLATE latin1_general_cs NOT NULL,
  `topic_id` varchar(15) CHARACTER SET latin1 COLLATE latin1_general_cs NOT NULL,
  `risk_factor` varchar(15) CHARACTER SET latin1 COLLATE latin1_general_cs NOT NULL,
  `min_level` double(4, 1) NOT NULL,
  `max_level` double(4, 1) NOT NULL,
  PRIMARY KEY (`illness_id`, `topic_id`, `risk_factor`) USING BTREE,
  INDEX `topic_id`(`topic_id`) USING BTREE,
  CONSTRAINT `risk_factors_ibfk_1` FOREIGN KEY (`topic_id`) REFERENCES `topics` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `risk_factors_ibfk_2` FOREIGN KEY (`illness_id`) REFERENCES `illness` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of risk_factors
-- ----------------------------
INSERT INTO `risk_factors` VALUES ('SARS-CoV-2', 'FAT', 'HIGH', 88.5, 100.0);
INSERT INTO `risk_factors` VALUES ('SARS-CoV-2', 'FAT', 'LOW', 0.0, 62.2);
INSERT INTO `risk_factors` VALUES ('SARS-CoV-2', 'FAT', 'MEDIUM', 62.2, 88.5);
INSERT INTO `risk_factors` VALUES ('SARS-CoV-2', 'OXYGEN', 'HIGH', 0.0, 60.0);
INSERT INTO `risk_factors` VALUES ('SARS-CoV-2', 'OXYGEN', 'LOW', 70.0, 100.0);
INSERT INTO `risk_factors` VALUES ('SARS-CoV-2', 'OXYGEN', 'MEDIUM', 60.0, 70.0);
INSERT INTO `risk_factors` VALUES ('SARS-CoV-2', 'SUGAR', 'HIGH', 70.0, 100.0);
INSERT INTO `risk_factors` VALUES ('SARS-CoV-2', 'SUGAR', 'LOW', 0.0, 50.0);
INSERT INTO `risk_factors` VALUES ('SARS-CoV-2', 'SUGAR', 'MEDIUM', 50.0, 70.0);

-- ----------------------------
-- Table structure for topics
-- ----------------------------
DROP TABLE IF EXISTS `topics`;
CREATE TABLE `topics`  (
  `id` varchar(20) CHARACTER SET latin1 COLLATE latin1_general_cs NOT NULL,
  `description` varchar(255) CHARACTER SET latin1 COLLATE latin1_general_cs NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of topics
-- ----------------------------
INSERT INTO `topics` VALUES ('FAT', 'GRASA EN LA SANGRE');
INSERT INTO `topics` VALUES ('OXYGEN', 'OXIGENO EN LA SANGRE');
INSERT INTO `topics` VALUES ('SUGAR', 'AZUCAR EN LA SANGRE');

SET FOREIGN_KEY_CHECKS = 1;
