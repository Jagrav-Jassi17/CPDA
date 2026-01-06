-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jan 06, 2026 at 05:26 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `clg`
--
CREATE DATABASE IF NOT EXISTS `clg` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `clg`;

-- --------------------------------------------------------

--
-- Table structure for table `accounts_balance`
--

CREATE TABLE `accounts_balance` (
  `balance_id` int(11) NOT NULL,
  `application_id` int(11) NOT NULL,
  `total_requested_amount` decimal(10,2) DEFAULT NULL,
  `available_balance` decimal(10,2) DEFAULT NULL,
  `budget_head` varchar(100) DEFAULT NULL,
  `balance_confirmed` tinyint(1) DEFAULT 0,
  `confirmed_by` varchar(200) DEFAULT NULL,
  `confirmation_date` datetime DEFAULT NULL,
  `remarks` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `application_attachments`
--

CREATE TABLE `application_attachments` (
  `attachment_id` int(11) NOT NULL,
  `application_id` int(11) NOT NULL,
  `file_name` varchar(255) DEFAULT NULL,
  `file_path` varchar(500) DEFAULT NULL,
  `file_type` varchar(50) DEFAULT NULL,
  `file_size` int(11) DEFAULT NULL,
  `uploaded_by` varchar(200) DEFAULT NULL,
  `uploaded_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `application_timeline_messages`
--

CREATE TABLE `application_timeline_messages` (
  `id` int(11) NOT NULL,
  `ref_number` varchar(100) NOT NULL,
  `message_sequence` int(11) NOT NULL,
  `message` text NOT NULL,
  `sender_identifier` varchar(255) NOT NULL,
  `recipient_identifier` varchar(255) DEFAULT NULL,
  `message_time` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `application_timeline_messages`
--

INSERT INTO `application_timeline_messages` (`id`, `ref_number`, `message_sequence`, `message`, `sender_identifier`, `recipient_identifier`, `message_time`) VALUES
(1, 'CPDA-693BD2441D4B4', 1, '[APPROVED] yo you o', '1110', '1119', '2025-12-12 14:06:24'),
(2, 'CPDA-EVT-25-000003', 1, '[APPROVED] iuyiyiu', '1110', '1119', '2025-12-12 14:06:59'),
(3, 'F4/2025/00007', 1, '[APPROVED] 65645654', '1110', '1114', '2025-12-12 14:07:11'),
(4, 'CPDA/F5/2025/693bd358c3bbb', 1, '[APPROVED] 98645-+-+', '1110', '1114', '2025-12-12 14:07:20'),
(5, 'CPDA-693BD2441D4B4', 2, '[DA-RECOMMENDED] iuomn', '1119', '1117', '2025-12-12 14:07:49'),
(6, 'CPDA-EVT-25-000003', 2, '[DA-SEND-BACK] 2145982323', '1119', '1110', '2025-12-12 14:08:07'),
(7, 'CPDA-EVT-25-000003', 3, '[APPROVED] 8745++-+', '1110', '1119', '2025-12-12 14:08:30'),
(8, 'CPDA-EVT-25-000003', 4, '[DA-RECOMMENDED] 45487', '1119', '1117', '2025-12-12 14:08:51'),
(9, 'CPDA-693BD2441D4B4', 3, '[ASSoc dean-RECOMMENDED] 8745', '1117', '1118', '2025-12-12 14:09:21'),
(10, 'CPDA-EVT-25-000003', 5, '[ASSoc dean-RECOMMENDED] tygfhg', '1117', '1118', '2025-12-12 14:09:31'),
(11, 'CPDA-693BD2441D4B4', 4, '[DFW-RECOMMENDED] krta yrr', '1118', '1120', '2025-12-12 14:10:14'),
(12, 'CPDA-EVT-25-000003', 6, '[DFW-RECOMMENDED] khush reh', '1118', '1120', '2025-12-12 14:10:27'),
(13, 'CPDA-693BD2441D4B4', 5, '[Director-SEND-BACK] ghat ke paise', '1120', '1118', '2025-12-12 14:25:04'),
(14, 'CPDA-EVT-25-000003', 7, '[Director-REJECTED] dfffa ho( ene paise)', '1120', '1101', '2025-12-12 14:25:24'),
(15, 'CPDA-693BD2441D4B4', 6, '[DFW-RECOMMENDED] krte ji', '1118', '1120', '2025-12-12 14:25:52'),
(16, 'CPDA-693BD2441D4B4', 7, '[Director-RECOMMENDED] aish kr', '1120', '1101', '2025-12-12 14:26:14'),
(17, 'CPDA-EVT-25-000002', 1, '[APPROVED] lkkl', '1110', '1119', '2025-12-12 14:31:15'),
(18, 'CPDA-EVT-25-000002', 2, '[DA-RECOMMENDED] dff', '1119', '1117', '2025-12-12 14:32:03'),
(19, 'CPDA-EVT-25-000002', 3, '[ASSoc dean-RECOMMENDED] df', '1117', '1118', '2025-12-12 14:33:05'),
(20, 'CPDA-EVT-25-000002', 4, '[DFW-RECOMMENDED] kj', '1118', '1120', '2025-12-12 14:41:05'),
(21, 'CPDA-EVT-25-000002', 5, '[Director-SEND-BACK] nm', '1120', '1118', '2025-12-12 14:58:16'),
(22, 'CPDA-EVT-25-000002', 6, '[DFW-RECOMMENDED] 564', '1118', '1120', '2025-12-12 15:00:12'),
(23, 'CPDA-EVT-25-000002', 7, '[Director-RECOMMENDED] kr mje', '1120', '1101', '2025-12-12 15:03:34');

-- --------------------------------------------------------

--
-- Table structure for table `approval_workflow`
--

CREATE TABLE `approval_workflow` (
  `workflow_id` int(11) NOT NULL,
  `application_id` int(11) NOT NULL,
  `approver_role` enum('HOD','ASSISTANT_REGISTRAR_ACCOUNTS','DEALING_ASSISTANT','SUPERINTENDENT_ACCOUNTS','ASSOCIATE_DEAN_FW','DEAN_FW','DIRECTOR') DEFAULT NULL,
  `approver_name` varchar(200) DEFAULT NULL,
  `action` enum('SUBMITTED','RECOMMENDED','NOT_RECOMMENDED','APPROVED','NOT_APPROVED','BALANCE_CONFIRMED','EXAMINED','PENDING') DEFAULT NULL,
  `comments` text DEFAULT NULL,
  `action_date` datetime DEFAULT NULL,
  `signature_captured` tinyint(1) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `approval_workflow`
--

INSERT INTO `approval_workflow` (`workflow_id`, `application_id`, `approver_role`, `approver_name`, `action`, `comments`, `action_date`, `signature_captured`, `created_at`) VALUES
(1, 4, 'HOD', 'Prof. Alok Jain', '', 'okk', '2025-10-29 14:07:32', 0, '2025-10-29 08:37:32'),
(2, 24, 'HOD', 'Prof. Alok Jain', '', 'hjkhj', '2025-10-29 15:05:34', 0, '2025-10-29 09:35:34'),
(3, 17, 'HOD', 'Prof. Alok Jain', '', 'jk', '2025-10-29 15:05:40', 0, '2025-10-29 09:35:40'),
(4, 23, 'HOD', 'Prof. Alok Jain', '', '', '2025-10-29 16:10:37', 0, '2025-10-29 10:40:37'),
(5, 24, 'DEALING_ASSISTANT', 'Ms. Juhi Saini', 'BALANCE_CONFIRMED', 'Expenditure data saved by DA and forwarded to Superintendent', '2025-10-30 00:18:42', 0, '2025-10-29 18:48:42'),
(6, 23, 'DEALING_ASSISTANT', 'Ms. Juhi Saini', 'BALANCE_CONFIRMED', 'Expenditure data saved by DA and forwarded to Superintendent', '2025-10-30 00:20:16', 0, '2025-10-29 18:50:16'),
(7, 4, 'DEALING_ASSISTANT', 'Ms. Juhi Saini', 'BALANCE_CONFIRMED', 'Expenditure data saved by DA and forwarded to Superintendent', '2025-10-30 00:21:15', 0, '2025-10-29 18:51:15'),
(8, 6, 'HOD', 'Prof. Alok Jain', '', '', '2025-10-30 10:13:48', 0, '2025-10-30 04:43:48'),
(9, 9, 'HOD', 'Prof. Alok Jain', '', '', '2025-10-31 11:47:08', 0, '2025-10-31 06:17:08'),
(10, 3, 'HOD', 'Prof. Alok Jain', '', 'sd', '2025-10-31 18:42:21', 0, '2025-10-31 13:12:21'),
(11, 2, 'HOD', 'Prof. Alok Jain', '', 'jk', '2025-10-31 19:42:31', 0, '2025-10-31 14:12:31'),
(12, 5, 'HOD', 'Prof. Alok Jain', '', 'sd', '2025-10-31 23:11:45', 0, '2025-10-31 17:41:45'),
(13, 5, 'HOD', 'Prof. Alok Jain', '', 'xsd', '2025-10-31 23:11:56', 0, '2025-10-31 17:41:56'),
(14, 5, 'HOD', 'Prof. Alok Jain', '', 'dsf', '2025-10-31 23:12:01', 0, '2025-10-31 17:42:01');

-- --------------------------------------------------------

--
-- Table structure for table `conference_expenditure`
--

CREATE TABLE `conference_expenditure` (
  `expenditure_id` int(11) NOT NULL,
  `application_id` int(11) NOT NULL,
  `block_year` int(11) NOT NULL,
  `financial_year` varchar(10) DEFAULT NULL,
  `events_attended_working_days` int(11) DEFAULT 0,
  `amount_spent` decimal(10,2) DEFAULT 0.00,
  `amount_committed` decimal(10,2) DEFAULT 0.00,
  `limit_applicable` decimal(10,2) DEFAULT 210000.00,
  `balance_amount` decimal(10,2) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `consumable_items`
--

CREATE TABLE `consumable_items` (
  `item_id` int(11) NOT NULL,
  `application_id` int(11) NOT NULL,
  `serial_number` int(11) DEFAULT NULL,
  `article_name` varchar(500) NOT NULL,
  `amount` decimal(10,2) NOT NULL,
  `item_category` enum('CHEMICALS','LABORATORY_GLASSWARE','SYNTHESIS_CHARGES','ANALYSIS_CHARGES','STATIONARY','BOOKS','COMPUTER_CONSUMABLES','EXTERNAL_STORAGE','CARTRIDGES','PATENT','OTHER') DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `consumable_items`
--

INSERT INTO `consumable_items` (`item_id`, `application_id`, `serial_number`, `article_name`, `amount`, `item_category`, `created_at`) VALUES
(1, 4, 0, 'sad', 324.00, 'CHEMICALS', '2025-10-28 14:04:29'),
(2, 4, 0, 'adsf234', 234.00, 'BOOKS', '2025-10-28 14:04:29'),
(3, 4, 0, 'tr', 56.00, 'EXTERNAL_STORAGE', '2025-10-28 14:04:29'),
(4, 4, 0, 'ert', 564.00, 'CARTRIDGES', '2025-10-28 14:04:29'),
(5, 6, 0, 'fds', 989.00, 'CARTRIDGES', '2025-10-29 08:26:16'),
(6, 7, 0, 'a', 33.00, 'CHEMICALS', '2025-10-29 08:29:06'),
(7, 17, 0, 'a', 23.00, 'CHEMICALS', '2025-10-29 09:00:40'),
(8, 17, 0, 'g', 232.00, 'PATENT', '2025-10-29 09:00:40'),
(9, 17, 0, 'as', 12.00, 'EXTERNAL_STORAGE', '2025-10-29 09:00:40'),
(10, 23, 1, 'd', 323.00, 'CHEMICALS', '2025-10-29 09:33:20'),
(11, 24, 1, 'jkkj', 15165.00, 'CHEMICALS', '2025-10-29 09:34:19'),
(12, 24, 2, 'hih', 78.00, 'CHEMICALS', '2025-10-29 09:34:19'),
(13, 26, 1, 'i', 78.00, 'CHEMICALS', '2025-12-12 06:12:18'),
(14, 27, 1, 'uoixv', 456.00, 'CHEMICALS', '2025-12-12 08:28:52');

-- --------------------------------------------------------

--
-- Table structure for table `contingent_expenditure`
--

CREATE TABLE `contingent_expenditure` (
  `expenditure_id` int(11) NOT NULL,
  `application_id` int(11) NOT NULL,
  `expenditure_type` enum('CONSUMABLES','SYNTHESIS_TESTING','STATIONARY','BOOKS','COMPUTER_CONSUMABLES') DEFAULT NULL,
  `block_year` int(11) NOT NULL,
  `financial_year` varchar(10) DEFAULT NULL,
  `amount_spent` decimal(10,2) DEFAULT 0.00,
  `amount_committed` decimal(10,2) DEFAULT 0.00,
  `limit_applicable` decimal(10,2) DEFAULT NULL,
  `balance_amount` decimal(10,2) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `cpda_applications`
--

CREATE TABLE `cpda_applications` (
  `application_id` int(11) NOT NULL,
  `ref_number` varchar(100) DEFAULT NULL,
  `dated` date DEFAULT NULL,
  `employee_code` varchar(50) NOT NULL,
  `faculty_name` varchar(200) NOT NULL,
  `email` varchar(100) DEFAULT NULL,
  `mobile_number` varchar(15) DEFAULT NULL,
  `designation` varchar(100) DEFAULT NULL,
  `department` varchar(100) DEFAULT NULL,
  `pay_level` varchar(50) DEFAULT NULL,
  `date_of_joining` date DEFAULT NULL,
  `purpose_of_purchase` text DEFAULT NULL,
  `technical_specification` text DEFAULT NULL,
  `source_of_information` text DEFAULT NULL,
  `remarks` text DEFAULT NULL,
  `applicant_signature_date` datetime DEFAULT NULL,
  `status` enum('DRAFT','SUBMITTED','HOD_APPROVED','HOD_REJECTED','ACCOUNTS_APPROVED','ACCOUNTS_REJECTED','DFW_APPROVED','DFW_REJECTED','DIRECTOR_APPROVED','DIRECTOR_REJECTED','COMPLETED') DEFAULT 'DRAFT',
  `pda_block_start_year` int(11) DEFAULT NULL,
  `pda_block_end_year` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `current_stage` enum('HOD_REVIEW','DA_REVIEW','ASS_REVIEW','DFW_REVIEW','DIRECTOR_REVIEW','COMPLETED') DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `cpda_applications`
--

INSERT INTO `cpda_applications` (`application_id`, `ref_number`, `dated`, `employee_code`, `faculty_name`, `email`, `mobile_number`, `designation`, `department`, `pay_level`, `date_of_joining`, `purpose_of_purchase`, `technical_specification`, `source_of_information`, `remarks`, `applicant_signature_date`, `status`, `pda_block_start_year`, `pda_block_end_year`, `created_at`, `updated_at`, `current_stage`) VALUES
(1, 'CPDA-6900C6ED21BE6', '2025-10-28', '1105', 'Dr. Aman Singh', 'aman.singh@nitj.ac.in', '7696124875', 'faculty', 'Mechanical Engineering', '13', '2025-10-22', 'trip', 'i9', NULL, '', NULL, 'SUBMITTED', NULL, NULL, '2025-10-28 13:36:45', '2025-12-12 07:35:29', 'HOD_REVIEW'),
(2, 'CPDA-6900CAB0C4730', '2025-10-28', '1101', 'Dr. Priya Sharma', 'priya.sharma@nitj.ac.in', '987654321', 'faculty', 'Computer Science & Engg.', '13A2', '2012-09-01', 'sdaljkf', 'sf', NULL, 'skldf', NULL, 'HOD_REJECTED', NULL, NULL, '2025-10-28 13:52:48', '2025-12-12 07:35:29', 'COMPLETED'),
(3, 'CPDA-6900CCF539F1A', '2025-10-28', '1101', 'Dr. Priya Sharma', 'priya.sharma@nitj.ac.in', '987654321', 'faculty', 'Computer Science & Engg.', '13A2', '2012-09-01', 'sdfsdf', 'fsd', NULL, '', NULL, 'SUBMITTED', NULL, NULL, '2025-10-28 14:02:29', '2025-12-12 07:35:29', 'HOD_REVIEW'),
(4, 'CPDA-6900CD6DE78B4', '2025-10-28', '1101', 'Dr. Priya Sharma', 'priya.sharma@nitj.ac.in', '987654321', 'faculty', 'Computer Science & Engg.', '13A2', '2012-09-01', 'asd', 'asd', NULL, 'we', NULL, 'SUBMITTED', NULL, NULL, '2025-10-28 14:04:29', '2025-12-12 07:35:29', 'HOD_REVIEW'),
(5, 'CPDA-6901CF0C2D694', '2025-10-29', '1101', 'Dr. Priya Sharma', 'priya.sharma@nitj.ac.in', '987654321', 'faculty', 'Computer Science & Engg.', '13A2', '2012-09-01', 'm', ' n', NULL, '', NULL, 'HOD_REJECTED', NULL, NULL, '2025-10-29 08:23:40', '2025-12-12 07:35:29', 'COMPLETED'),
(6, 'CPDA-6901CFA87EE48', '2025-10-29', '1101', 'Dr. Priya Sharma', 'priya.sharma@nitj.ac.in', '987654321', 'faculty', 'Computer Science & Engg.', '13A2', '2012-09-01', 'zasf', 'er', NULL, 'g', '0000-00-00 00:00:00', 'SUBMITTED', NULL, NULL, '2025-10-29 08:26:16', '2025-12-12 07:36:54', 'HOD_REVIEW'),
(7, 'CPDA-6901D0523648A', '2025-10-29', '1105', 'Dr. Aman Singh', 'aman.singh@nitj.ac.in', '987654325', 'faculty', 'Mechanical Engineering', '13A2', '2012-09-01', 'a', 'a', NULL, '', NULL, 'SUBMITTED', NULL, NULL, '2025-10-29 08:29:06', '2025-12-12 07:37:00', 'HOD_REVIEW'),
(8, 'CPDA-6901D3F80E738', '2025-10-29', '1105', 'Dr. Aman Singh', 'aman.singh@nitj.ac.in', '987654325', 'faculty', 'Mechanical Engineering', '13A2', '2012-09-01', 'as', 's', NULL, '', NULL, 'SUBMITTED', NULL, NULL, '2025-10-29 08:44:40', '2025-12-12 07:37:07', 'HOD_REVIEW'),
(9, 'CPDA-6901D4F6AE3FF', '2025-10-29', '1101', 'Dr. Priya Sharma', 'priya.sharma@nitj.ac.in', '987654321', 'faculty', 'Computer Science & Engg.', '13A2', '2012-09-01', 'a', 'q', NULL, '', NULL, 'SUBMITTED', NULL, NULL, '2025-10-29 08:48:54', '2025-12-12 07:37:13', 'HOD_REVIEW'),
(17, 'CPDA-6901D7B87F2F5', '2025-10-29', '1101', 'Dr. Priya Sharma', 'priya.sharma@nitj.ac.in', '987654321', 'faculty', 'Computer Science & Engg.', '13A2', '2012-09-01', 'sd', 's', NULL, '', NULL, 'HOD_REJECTED', NULL, NULL, '2025-10-29 09:00:40', '2025-12-12 07:37:21', 'COMPLETED'),
(23, 'CPDA-6901DF60AFD7C', '2025-10-29', '1101', 'Dr. Priya Sharma', 'priya.sharma@nitj.ac.in', '987654321', 'faculty', 'Computer Science & Engg.', '13A2', '2012-09-01', 'saa', 'a', NULL, '', NULL, 'DRAFT', NULL, NULL, '2025-10-29 09:33:20', '2025-12-12 09:27:35', NULL),
(24, 'CPDA-6901DF9B34794', '2025-10-29', '1101', 'Dr. Priya Sharma', 'priya.sharma@nitj.ac.in', '987654321', 'faculty', 'Computer Science & Engg.', '13A2', '2012-09-01', 'jhhj', 'bb\r\n', NULL, '', NULL, 'DRAFT', NULL, NULL, '2025-10-29 09:34:19', '2025-12-12 09:26:38', NULL),
(25, 'CPDA-6904F2D295F91', '2025-10-31', '1101', 'Dr. Priya Sharma', 'priya.sharma@nitj.ac.in', '987654321', 'faculty', 'Computer Science & Engg.', '13A2', '2012-09-01', 'a', '', NULL, '', NULL, 'SUBMITTED', NULL, NULL, '2025-10-31 17:33:06', '2025-12-12 07:37:38', 'HOD_REVIEW'),
(26, 'CPDA-693BB2420B501', '2025-12-12', '1101', 'Dr. Priya Sharma', 'priya.sharma@nitj.ac.in', '987654321', 'faculty', 'Computer Science & Engg.', '13A2', '2012-09-01', 'k', 'h', NULL, 'g', NULL, 'SUBMITTED', NULL, NULL, '2025-12-12 06:12:18', '2025-12-12 07:37:45', 'HOD_REVIEW'),
(27, 'CPDA-693BD2441D4B4', '2025-12-12', '1101', 'Dr. Priya Sharma', 'priya.sharma@nitj.ac.in', '987654321', 'faculty', 'Computer Science & Engg.', '13A2', '2012-09-01', 'fin', 'sin', NULL, 'weroiewroi', NULL, 'DIRECTOR_APPROVED', NULL, NULL, '2025-12-12 08:28:52', '2025-12-12 08:56:14', 'COMPLETED'),
(28, 'CPDA-693D7814E167C', '2025-12-13', '1101', 'Dr. Priya Sharma', 'priya.sharma@nitj.ac.in', '987654321', 'faculty', 'Computer Science & Engg.', '13A2', '2012-09-01', 'important', '', NULL, '', NULL, 'SUBMITTED', NULL, NULL, '2025-12-13 14:28:36', '2025-12-13 14:28:36', 'HOD_REVIEW'),
(29, 'CPDA-693D7BF0484F3', '2025-12-13', '1101', 'Dr. Priya Sharma', 'priya.sharma@nitj.ac.in', '987654321', 'faculty', 'Computer Science & Engg.', '13A2', '2012-09-01', 'imp', '', NULL, '', NULL, 'SUBMITTED', NULL, NULL, '2025-12-13 14:45:04', '2025-12-13 14:45:04', 'HOD_REVIEW'),
(30, 'CPDA-693D83E0EE42A', '2025-12-13', '1101', 'Dr. Priya Sharma', 'priya.sharma@nitj.ac.in', '987654321', 'faculty', 'Computer Science & Engg.', '13A2', '2012-09-01', 'imp', '', NULL, '', NULL, 'SUBMITTED', NULL, NULL, '2025-12-13 15:18:56', '2025-12-13 15:18:56', 'HOD_REVIEW');

-- --------------------------------------------------------

--
-- Table structure for table `cpda_balance_blocked`
--

CREATE TABLE `cpda_balance_blocked` (
  `block_id` int(11) NOT NULL,
  `faculty_id` varchar(50) NOT NULL,
  `application_id` int(11) NOT NULL,
  `amount` decimal(10,2) NOT NULL,
  `status` enum('BLOCKED','CONSUMED','RELEASED') DEFAULT 'BLOCKED',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `cpda_balance_master`
--

CREATE TABLE `cpda_balance_master` (
  `faculty_id` varchar(50) NOT NULL,
  `total_allocated` decimal(10,2) NOT NULL DEFAULT 300000.00,
  `utilized_amount` decimal(10,2) NOT NULL DEFAULT 0.00,
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `cpda_balance_snapshot`
--

CREATE TABLE `cpda_balance_snapshot` (
  `id` int(11) NOT NULL,
  `faculty_id` varchar(50) NOT NULL,
  `form_type` varchar(5) NOT NULL,
  `form_id` int(11) NOT NULL,
  `approved_balance` decimal(12,2) NOT NULL,
  `temporary_balance` decimal(12,2) NOT NULL,
  `status` enum('TEMP','APPROVED') DEFAULT 'TEMP',
  `approved_by` varchar(50) DEFAULT NULL,
  `approved_at` datetime DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `cpda_balance_snapshot`
--

INSERT INTO `cpda_balance_snapshot` (`id`, `faculty_id`, `form_type`, `form_id`, `approved_balance`, `temporary_balance`, `status`, `approved_by`, `approved_at`, `created_at`) VALUES
(1, '1101', 'F1', 28, 300000.00, 290000.00, 'TEMP', NULL, NULL, '2025-12-13 14:28:36'),
(2, '', 'F1', 28, 290000.00, 290000.00, 'APPROVED', '1114', '2025-12-13 20:00:15', '2025-12-13 14:30:15'),
(3, '1101', 'F1', 29, 300000.00, 295000.00, 'TEMP', NULL, NULL, '2025-12-13 14:45:04'),
(4, '1101', 'F1', 30, 300000.00, 0.00, 'TEMP', NULL, NULL, '2025-12-13 15:18:56');

-- --------------------------------------------------------

--
-- Table structure for table `cpda_event_applications`
--

CREATE TABLE `cpda_event_applications` (
  `application_id` int(11) NOT NULL,
  `ref_number` varchar(50) NOT NULL,
  `employee_code` int(11) NOT NULL,
  `faculty_name` varchar(255) NOT NULL,
  `designation_hag` tinyint(1) DEFAULT 0,
  `designation_professor` tinyint(1) DEFAULT 0,
  `designation_associate_professor` tinyint(1) DEFAULT 0,
  `designation_assistant_professor` tinyint(1) DEFAULT 0,
  `pay_level` varchar(20) NOT NULL,
  `department` varchar(255) NOT NULL,
  `date_of_joining` date NOT NULL,
  `nature_of_event` varchar(255) NOT NULL,
  `title_of_event` text NOT NULL,
  `period_of_event` varchar(255) NOT NULL,
  `working_days_involved` int(11) NOT NULL,
  `venue_of_event` text NOT NULL,
  `paper_title` text DEFAULT NULL,
  `paper_authors` text DEFAULT NULL,
  `no_objection_details` text DEFAULT NULL,
  `abstract_attachment` varchar(255) DEFAULT NULL,
  `expense_registration_fee` decimal(10,2) DEFAULT 0.00,
  `expense_visa_fee` decimal(10,2) DEFAULT 0.00,
  `expense_insurance_fee` decimal(10,2) DEFAULT 0.00,
  `expense_air_fare` decimal(10,2) DEFAULT 0.00,
  `expense_local_travel` decimal(10,2) DEFAULT 0.00,
  `expense_da_per_diem` decimal(10,2) DEFAULT 0.00,
  `expense_boarding_lodging` decimal(10,2) DEFAULT 0.00,
  `expense_other_details` text DEFAULT NULL,
  `expense_other_amount` decimal(10,2) DEFAULT 0.00,
  `expense_total` decimal(10,2) DEFAULT 0.00,
  `event_during_holidays` enum('YES','NO') NOT NULL,
  `institute_arrangement_attachment` varchar(255) DEFAULT NULL,
  `attended_abroad_current_block` enum('YES','NO') NOT NULL,
  `previous_event_name` text DEFAULT NULL,
  `previous_event_dates` varchar(255) DEFAULT NULL,
  `previous_event_venues` text DEFAULT NULL,
  `application_status` enum('DRAFT','SUBMITTED','HOD_APPROVED','HOD_REJECTED','ACCOUNTS_APPROVED','ACCOUNTS_REJECTED','DFW_APPROVED','DFW_REJECTED','DIRECTOR_APPROVED','DIRECTOR_REJECTED','COMPLETED') DEFAULT 'DRAFT',
  `submission_date` datetime DEFAULT NULL,
  `last_updated` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `sanctioned_amount` decimal(10,2) DEFAULT NULL,
  `disbursement_status` enum('PENDING','PARTIAL','COMPLETED') DEFAULT 'PENDING',
  `disbursed_amount` decimal(10,2) DEFAULT 0.00,
  `disbursement_date` datetime DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `current_stage` enum('HOD_REVIEW','DA_REVIEW','ASS_REVIEW','DFW_REVIEW','DIRECTOR_REVIEW','COMPLETED') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `cpda_event_applications`
--

INSERT INTO `cpda_event_applications` (`application_id`, `ref_number`, `employee_code`, `faculty_name`, `designation_hag`, `designation_professor`, `designation_associate_professor`, `designation_assistant_professor`, `pay_level`, `department`, `date_of_joining`, `nature_of_event`, `title_of_event`, `period_of_event`, `working_days_involved`, `venue_of_event`, `paper_title`, `paper_authors`, `no_objection_details`, `abstract_attachment`, `expense_registration_fee`, `expense_visa_fee`, `expense_insurance_fee`, `expense_air_fare`, `expense_local_travel`, `expense_da_per_diem`, `expense_boarding_lodging`, `expense_other_details`, `expense_other_amount`, `expense_total`, `event_during_holidays`, `institute_arrangement_attachment`, `attended_abroad_current_block`, `previous_event_name`, `previous_event_dates`, `previous_event_venues`, `application_status`, `submission_date`, `last_updated`, `sanctioned_amount`, `disbursement_status`, `disbursed_amount`, `disbursement_date`, `created_at`, `updated_at`, `current_stage`) VALUES
(1, 'CPDA-EVT-25-000001', 1101, 'Dr. Priya Sharma', 0, 0, 0, 0, '13A2', 'Computer Science & Engg.', '2012-09-01', 'd', 'f', '34', 3, 'f', '', '', '', NULL, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, '', 0.00, 0.00, 'YES', NULL, 'NO', '', '', '', 'HOD_APPROVED', '2025-10-31 18:06:48', '2025-12-12 13:10:51', NULL, 'PENDING', 0.00, NULL, '2025-10-31 12:36:48', '2025-12-12 07:40:51', 'DA_REVIEW'),
(2, 'CPDA-EVT-25-000002', 1101, 'Dr. Priya Sharma', 0, 0, 0, 0, '13A2', 'Computer Science & Engg.', '2012-09-01', 'harry', 'sik', 'js', 98, 'jk', 'sss', 's', 'ss', 'CPDA-EVT-25-000002_abstract_1761914346.pdf', 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, '', 6767676.00, 6767676.00, 'NO', 'CPDA-EVT-25-000002_arrangement_1761914346.pdf', 'YES', 'z', '1u', 'bat', 'DIRECTOR_APPROVED', '2025-10-31 18:09:06', '2025-12-12 15:03:34', 897.00, 'PENDING', 0.00, NULL, '2025-10-31 12:39:06', '2025-12-12 09:33:34', 'COMPLETED'),
(3, 'CPDA-EVT-25-000003', 1101, 'Dr. Priya Sharma', 0, 0, 0, 1, '13A2', 'Computer Science & Engg.', '2012-09-01', 'kjhh', 'mn', '5-6 dec', 5, 'mnb', 'hj', 'yugu', 'tyc', 'CPDA-EVT-25-000003_abstract_1765528308.pdf', 564.00, 64.00, 513.00, 98.00, 132.00, 87.00, 32.00, '', 65.00, 1555.00, 'YES', NULL, 'NO', 'nb', 'nm', '', 'COMPLETED', '2025-12-12 14:01:48', '2025-12-12 14:54:37', 7878.00, 'PENDING', 0.00, NULL, '2025-12-12 08:31:48', '2025-12-12 09:24:37', 'COMPLETED');

-- --------------------------------------------------------

--
-- Table structure for table `cpda_event_attachments`
--

CREATE TABLE `cpda_event_attachments` (
  `id` int(11) NOT NULL,
  `application_id` int(11) NOT NULL,
  `attachment_type` enum('ABSTRACT','INSTITUTE_ARRANGEMENT','NO_OBJECTION_CERTIFICATE','ACCEPTANCE_LETTER','OTHER') NOT NULL,
  `file_name` varchar(255) NOT NULL,
  `file_path` varchar(500) NOT NULL,
  `file_size` int(11) DEFAULT NULL,
  `file_type` varchar(100) DEFAULT NULL,
  `uploaded_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `uploaded_by` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `cpda_event_attachments`
--

INSERT INTO `cpda_event_attachments` (`id`, `application_id`, `attachment_type`, `file_name`, `file_path`, `file_size`, `file_type`, `uploaded_at`, `uploaded_by`) VALUES
(1, 2, 'ABSTRACT', 'F-2.pdf', 'CPDA-EVT-25-000002_abstract_1761914346.pdf', 444303, 'application/pdf', '2025-10-31 12:39:06', '1101'),
(2, 2, 'INSTITUTE_ARRANGEMENT', 'F-4.pdf', 'CPDA-EVT-25-000002_arrangement_1761914346.pdf', 229514, 'application/pdf', '2025-10-31 12:39:06', '1101'),
(3, 3, 'ABSTRACT', 'F-5.pdf', 'CPDA-EVT-25-000003_abstract_1765528308.pdf', 298045, 'application/pdf', '2025-12-12 08:31:48', '1101');

-- --------------------------------------------------------

--
-- Table structure for table `cpda_recommendation`
--

CREATE TABLE `cpda_recommendation` (
  `recommendation_id` int(11) NOT NULL,
  `application_ref_number` varchar(100) NOT NULL,
  `amount_available` decimal(12,2) DEFAULT NULL,
  `amount_recommended` decimal(12,2) DEFAULT NULL,
  `recommendation_date` datetime DEFAULT current_timestamp(),
  `comments` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `cpda_recommendation`
--

INSERT INTO `cpda_recommendation` (`recommendation_id`, `application_ref_number`, `amount_available`, `amount_recommended`, `recommendation_date`, `comments`) VALUES
(1, 'CPDA-693BD2441D4B4', 879.00, 544.00, '2025-12-12 14:10:14', NULL),
(2, 'CPDA-693BD2441D4B4', 5654.00, 78.00, '2025-12-12 14:25:52', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `cpda_register_entries`
--

CREATE TABLE `cpda_register_entries` (
  `register_id` int(11) NOT NULL,
  `application_id` int(11) NOT NULL,
  `register_page_number` int(11) DEFAULT NULL,
  `register_serial_number` int(11) DEFAULT NULL,
  `entry_date` date DEFAULT NULL,
  `entered_by` varchar(200) DEFAULT NULL,
  `dealing_assistant_signature` tinyint(1) DEFAULT 0,
  `private_secretary_signature` tinyint(1) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `f4_professional_memberships`
--

CREATE TABLE `f4_professional_memberships` (
  `id` int(11) NOT NULL,
  `application_id` int(11) NOT NULL,
  `professional_body_name` varchar(255) NOT NULL,
  `membership_amount` decimal(10,2) NOT NULL,
  `membership_type` enum('NATIONAL','INTERNATIONAL') NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `f4_professional_memberships`
--

INSERT INTO `f4_professional_memberships` (`id`, `application_id`, `professional_body_name`, `membership_amount`, `membership_type`, `created_at`) VALUES
(1, 1, 'd', 34.00, 'NATIONAL', '2025-10-31 17:18:37'),
(2, 1, 'dsf', 324.00, 'INTERNATIONAL', '2025-10-31 17:18:37'),
(3, 2, 'dfsssss', 1111.00, 'NATIONAL', '2025-10-31 17:21:45'),
(4, 4, 'da', 33.00, 'INTERNATIONAL', '2025-10-31 17:22:49');

-- --------------------------------------------------------

--
-- Table structure for table `f4_reimbursement_applications`
--

CREATE TABLE `f4_reimbursement_applications` (
  `application_id` int(11) NOT NULL,
  `ref_number` varchar(50) NOT NULL,
  `employee_code` int(11) NOT NULL,
  `faculty_name` varchar(255) NOT NULL,
  `designation_hag` tinyint(1) DEFAULT 0,
  `designation_professor` tinyint(1) DEFAULT 0,
  `designation_associate_professor` tinyint(1) DEFAULT 0,
  `designation_assistant_professor` tinyint(1) DEFAULT 0,
  `pay_level` varchar(20) NOT NULL,
  `department` varchar(255) NOT NULL,
  `total_amount` decimal(10,2) DEFAULT 0.00,
  `expense_books` decimal(10,2) DEFAULT 0.00,
  `expense_stationary` decimal(10,2) DEFAULT 0.00,
  `expense_patent` decimal(10,2) DEFAULT 0.00,
  `expense_computer_consumables` decimal(10,2) DEFAULT 0.00,
  `expense_consumables` decimal(10,2) DEFAULT 0.00,
  `expense_synthesis_analysis` decimal(10,2) DEFAULT 0.00,
  `remarks` text DEFAULT NULL,
  `application_status` enum('DRAFT','SUBMITTED','UNDER_REVIEW','HOD_APPROVED','HOD_REJECTED','AR_APPROVED','AR_REJECTED') DEFAULT 'DRAFT',
  `submission_date` datetime DEFAULT NULL,
  `last_updated` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `hod_approval_status` enum('PENDING','APPROVED','REJECTED') DEFAULT 'PENDING',
  `hod_approval_date` datetime DEFAULT NULL,
  `hod_remarks` text DEFAULT NULL,
  `hod_approved_by` varchar(50) DEFAULT NULL,
  `ar_approval_status` enum('PENDING','APPROVED','REJECTED') DEFAULT 'PENDING',
  `ar_approval_date` datetime DEFAULT NULL,
  `ar_remarks` text DEFAULT NULL,
  `ar_approved_by` varchar(50) DEFAULT NULL,
  `sanctioned_amount` decimal(10,2) DEFAULT NULL,
  `disbursement_status` enum('PENDING','PARTIAL','COMPLETED') DEFAULT 'PENDING',
  `disbursed_amount` decimal(10,2) DEFAULT 0.00,
  `disbursement_date` datetime DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `f4_reimbursement_applications`
--

INSERT INTO `f4_reimbursement_applications` (`application_id`, `ref_number`, `employee_code`, `faculty_name`, `designation_hag`, `designation_professor`, `designation_associate_professor`, `designation_assistant_professor`, `pay_level`, `department`, `total_amount`, `expense_books`, `expense_stationary`, `expense_patent`, `expense_computer_consumables`, `expense_consumables`, `expense_synthesis_analysis`, `remarks`, `application_status`, `submission_date`, `last_updated`, `hod_approval_status`, `hod_approval_date`, `hod_remarks`, `hod_approved_by`, `ar_approval_status`, `ar_approval_date`, `ar_remarks`, `ar_approved_by`, `sanctioned_amount`, `disbursement_status`, `disbursed_amount`, `disbursement_date`, `created_at`, `updated_at`) VALUES
(1, 'F4/2025/00001', 1101, 'Dr. Priya Sharma', 0, 0, 0, 0, '13', 'Computer Science & Engg.', 43588.00, 340.00, 550.00, 33330.00, 230.00, 3240.00, 5540.00, '', 'SUBMITTED', '2025-10-31 22:48:37', '2025-10-31 22:48:37', 'PENDING', NULL, NULL, NULL, 'PENDING', NULL, NULL, NULL, NULL, 'PENDING', 0.00, NULL, '2025-10-31 17:18:37', '2025-10-31 17:18:37'),
(2, 'F4/2025/00002', 1101, 'Dr. Priya Sharma', 0, 0, 0, 0, '13', 'Computer Science & Engg.', 44341.00, 340.00, 550.00, 33330.00, 230.00, 3240.00, 5540.00, '', 'AR_APPROVED', '2025-10-31 22:51:45', '2025-11-04 20:50:39', 'APPROVED', '2025-11-04 20:48:51', 'd', '1110', 'APPROVED', '2025-11-04 20:50:39', 'hj', '1114', 44341.00, 'PENDING', 0.00, NULL, '2025-10-31 17:21:45', '2025-11-04 15:20:39'),
(3, 'F4/2025/00003', 1101, 'Dr. Priya Sharma', 0, 0, 0, 0, '13', 'Computer Science & Engg.', 43230.00, 340.00, 550.00, 33330.00, 230.00, 3240.00, 5540.00, '', 'AR_APPROVED', '2025-10-31 22:52:32', '2025-10-31 23:55:00', 'APPROVED', '2025-10-31 23:30:41', 'm', '1110', 'APPROVED', '2025-10-31 23:55:00', 'okk', '1114', 43230.00, 'PENDING', 0.00, NULL, '2025-10-31 17:22:32', '2025-10-31 18:25:00'),
(4, 'F4/2025/00004', 1101, 'Dr. Priya Sharma', 0, 0, 0, 0, '13', 'Computer Science & Engg.', 43263.00, 340.00, 550.00, 33330.00, 230.00, 3240.00, 5540.00, '', 'SUBMITTED', '2025-10-31 22:52:49', '2025-10-31 22:52:49', 'PENDING', NULL, NULL, NULL, 'PENDING', NULL, NULL, NULL, NULL, 'PENDING', 0.00, NULL, '2025-10-31 17:22:49', '2025-10-31 17:22:49'),
(5, 'F4/2025/00005', 1101, 'Dr. Priya Sharma', 0, 0, 0, 0, '13', 'Computer Science & Engg.', 43230.00, 340.00, 550.00, 33330.00, 230.00, 3240.00, 5540.00, '', 'AR_REJECTED', '2025-10-31 22:53:17', '2025-10-31 23:55:56', 'APPROVED', '2025-10-31 23:30:27', 'm', '1110', 'REJECTED', '2025-10-31 23:55:56', 'z', '1114', 0.00, 'PENDING', 0.00, NULL, '2025-10-31 17:23:17', '2025-10-31 18:25:56'),
(6, 'F4/2025/00006', 1101, 'Dr. Priya Sharma', 0, 0, 0, 0, '13', 'Computer Science & Engg.', 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, '', 'SUBMITTED', '2025-10-31 23:02:55', '2025-10-31 23:02:55', 'PENDING', NULL, NULL, NULL, 'PENDING', NULL, NULL, NULL, NULL, 'PENDING', 0.00, NULL, '2025-10-31 17:32:55', '2025-10-31 17:32:55'),
(7, 'F4/2025/00007', 1101, 'Dr. Priya Sharma', 0, 0, 0, 0, '13', 'Computer Science & Engg.', 247.00, 75.00, 98.00, 32.00, 0.00, 32.00, 10.00, 'mnb', 'HOD_APPROVED', '2025-12-12 14:02:27', '2025-12-12 14:07:11', 'APPROVED', '2025-12-12 14:07:11', '65645654', '1110', 'PENDING', NULL, NULL, NULL, NULL, 'PENDING', 0.00, NULL, '2025-12-12 08:32:27', '2025-12-12 08:37:11');

-- --------------------------------------------------------

--
-- Table structure for table `f4_reimbursement_attachments`
--

CREATE TABLE `f4_reimbursement_attachments` (
  `id` int(11) NOT NULL,
  `application_id` int(11) NOT NULL,
  `attachment_type` enum('BILL','RECEIPT','INVOICE','MEMBERSHIP_PROOF','BOOK_INVOICE','PATENT_DOCUMENT','OTHER') NOT NULL,
  `file_name` varchar(255) NOT NULL,
  `file_path` varchar(500) NOT NULL,
  `file_size` int(11) DEFAULT NULL,
  `file_type` varchar(100) DEFAULT NULL,
  `description` varchar(500) DEFAULT NULL,
  `uploaded_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `uploaded_by` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `f4_reimbursement_attachments`
--

INSERT INTO `f4_reimbursement_attachments` (`id`, `application_id`, `attachment_type`, `file_name`, `file_path`, `file_size`, `file_type`, `description`, `uploaded_at`, `uploaded_by`) VALUES
(1, 6, 'RECEIPT', 'F-5.pdf', '../uploads/f4/2025/F4_2025_00006_1761931975_0.pdf', 298045, 'application/pdf', '', '2025-10-31 17:32:55', '1101'),
(2, 7, 'RECEIPT', 'F-1.pdf', '../uploads/f4/2025/F4_2025_00007_1765528347_0.pdf', 512754, 'application/pdf', '564', '2025-12-12 08:32:27', '1101');

-- --------------------------------------------------------

--
-- Table structure for table `f5_attachments`
--

CREATE TABLE `f5_attachments` (
  `id` int(11) NOT NULL,
  `reimbursement_id` int(11) NOT NULL,
  `attachment_type` enum('REGISTRATION_RECEIPT','VISA_RECEIPT','INSURANCE_RECEIPT','FLIGHT_TICKET','TRAVEL_RECEIPT','HOTEL_BILL','BOARDING_LODGING','CONFERENCE_CERTIFICATE','OTHER') NOT NULL,
  `file_name` varchar(255) NOT NULL,
  `file_path` varchar(500) NOT NULL,
  `file_size` int(11) NOT NULL,
  `file_type` varchar(100) NOT NULL,
  `description` text DEFAULT NULL,
  `uploaded_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `f5_attachments`
--

INSERT INTO `f5_attachments` (`id`, `reimbursement_id`, `attachment_type`, `file_name`, `file_path`, `file_size`, `file_type`, `description`, `uploaded_at`) VALUES
(2, 2, 'REGISTRATION_RECEIPT', 'F-2.pdf', '../uploads/f5_attachments/2_1762268402_0.pdf', 444303, 'application/pdf', '', '2025-11-04 15:00:02'),
(3, 3, 'REGISTRATION_RECEIPT', 'F-5.pdf', '../uploads/f5_attachments/3_1765528408_0.pdf', 298045, 'application/pdf', '', '2025-12-12 08:33:28');

-- --------------------------------------------------------

--
-- Table structure for table `f5_conference_reimbursements`
--

CREATE TABLE `f5_conference_reimbursements` (
  `application_id` int(11) NOT NULL,
  `ref_number` varchar(100) DEFAULT NULL,
  `employee_code` int(11) NOT NULL,
  `faculty_name` varchar(200) NOT NULL,
  `designation` varchar(100) NOT NULL,
  `pay_level` varchar(10) NOT NULL,
  `department` varchar(200) NOT NULL,
  `activity_nature` enum('International Conference','National Conference','Workshop','Short Term Course','Seminar','Symposium') NOT NULL,
  `activity_name` varchar(500) NOT NULL,
  `activity_start_date` date NOT NULL,
  `activity_end_date` date NOT NULL,
  `activity_venue` varchar(300) NOT NULL,
  `location_type` enum('India','Abroad') NOT NULL,
  `expense_registration` decimal(10,2) DEFAULT 0.00,
  `expense_visa` decimal(10,2) DEFAULT 0.00,
  `expense_insurance` decimal(10,2) DEFAULT 0.00,
  `expense_air_fare` decimal(10,2) DEFAULT 0.00,
  `expense_local_travel` decimal(10,2) DEFAULT 0.00,
  `expense_da_per_diem` decimal(10,2) DEFAULT 0.00,
  `expense_boarding_lodging` decimal(10,2) DEFAULT 0.00,
  `expense_other` decimal(10,2) DEFAULT 0.00,
  `expense_other_description` text DEFAULT NULL,
  `total_amount` decimal(10,2) NOT NULL,
  `remarks` text DEFAULT NULL,
  `status` enum('PENDING','HOD_APPROVED','HOD_REJECTED','ACCOUNTS_APPROVED','ACCOUNTS_REJECTED','COMPLETED') DEFAULT 'PENDING',
  `hod_status` enum('PENDING','APPROVED','REJECTED') DEFAULT 'PENDING',
  `hod_approved_by` varchar(50) DEFAULT NULL,
  `hod_approved_at` datetime DEFAULT NULL,
  `hod_comments` text DEFAULT NULL,
  `accounts_status` enum('PENDING','APPROVED','REJECTED') DEFAULT 'PENDING',
  `accounts_approved_by` varchar(50) DEFAULT NULL,
  `accounts_approved_at` datetime DEFAULT NULL,
  `accounts_comments` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `f5_conference_reimbursements`
--

INSERT INTO `f5_conference_reimbursements` (`application_id`, `ref_number`, `employee_code`, `faculty_name`, `designation`, `pay_level`, `department`, `activity_nature`, `activity_name`, `activity_start_date`, `activity_end_date`, `activity_venue`, `location_type`, `expense_registration`, `expense_visa`, `expense_insurance`, `expense_air_fare`, `expense_local_travel`, `expense_da_per_diem`, `expense_boarding_lodging`, `expense_other`, `expense_other_description`, `total_amount`, `remarks`, `status`, `hod_status`, `hod_approved_by`, `hod_approved_at`, `hod_comments`, `accounts_status`, `accounts_approved_by`, `accounts_approved_at`, `accounts_comments`, `created_at`, `updated_at`) VALUES
(2, 'CPDA/F5/2025/690a14f2c1de0', 1101, 'Dr. Priya Sharma', 'faculty', '13A2', 'Computer Science & Engg.', 'Workshop', 'dsf', '2025-11-28', '2025-11-29', 'asd', 'India', 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, '', 0.00, '', 'ACCOUNTS_REJECTED', 'APPROVED', '1110', '2025-11-04 20:55:19', 'sd', 'REJECTED', '1114', '2025-11-04 20:58:29', 'd', '2025-11-04 15:00:02', '2025-11-04 15:28:29'),
(3, 'CPDA/F5/2025/693bd358c3bbb', 1101, 'Dr. Priya Sharma', 'faculty', '13A2', 'Computer Science & Engg.', 'National Conference', 'oiuu', '2025-12-04', '2025-12-10', 'n', 'India', 650.00, 8.00, 45.00, 89.00, 78.00, 21.00, 78.00, 98.00, '', 1067.00, '564', 'HOD_APPROVED', 'APPROVED', '1110', '2025-12-12 14:07:20', '98645-+-+', 'PENDING', NULL, NULL, NULL, '2025-12-12 08:33:28', '2025-12-12 08:37:20');

-- --------------------------------------------------------

--
-- Table structure for table `fdx_electronic_devices`
--

CREATE TABLE `fdx_electronic_devices` (
  `Device_ID` int(11) NOT NULL,
  `Application_ID` varchar(50) NOT NULL,
  `S_No` varchar(10) NOT NULL,
  `Item_Description` varchar(255) NOT NULL,
  `Date_of_Issue` date DEFAULT NULL,
  `Cost_at_Time_of_Issue` decimal(10,2) DEFAULT NULL,
  `Created_At` timestamp NOT NULL DEFAULT current_timestamp(),
  `Updated_At` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `fdx_electronic_devices`
--

INSERT INTO `fdx_electronic_devices` (`Device_ID`, `Application_ID`, `S_No`, `Item_Description`, `Date_of_Issue`, `Cost_at_Time_of_Issue`, `Created_At`, `Updated_At`) VALUES
(3, '4', '1', 'gfd', '2025-10-24', 3545.00, '2025-10-29 18:51:15', '2025-10-29 18:51:15'),
(4, '4', '2', 'fhgh', '2025-10-14', 5646.00, '2025-10-29 18:51:15', '2025-10-29 18:51:15');

-- --------------------------------------------------------

--
-- Table structure for table `fdx_expenditure_main`
--

CREATE TABLE `fdx_expenditure_main` (
  `Application_ID` varchar(50) NOT NULL,
  `P1_Conferences_Y1_2021_22_Num_Events` int(11) DEFAULT NULL,
  `P1_Conferences_Y1_2021_22_Amt_Spent` decimal(10,2) DEFAULT NULL,
  `P1_Conferences_Y1_2021_22_Amt_Committed` decimal(10,2) DEFAULT NULL,
  `P1_Conferences_Y1_2021_22_Balance` decimal(10,2) DEFAULT NULL,
  `P1_Conferences_Y2_2022_23_Num_Events` int(11) DEFAULT NULL,
  `P1_Conferences_Y2_2022_23_Amt_Spent` decimal(10,2) DEFAULT NULL,
  `P1_Conferences_Y2_2022_23_Amt_Committed` decimal(10,2) DEFAULT NULL,
  `P1_Conferences_Y2_2022_23_Balance` decimal(10,2) DEFAULT NULL,
  `P1_Conferences_Y3_2023_24_Num_Events` int(11) DEFAULT NULL,
  `P1_Conferences_Y3_2023_24_Amt_Spent` decimal(10,2) DEFAULT NULL,
  `P1_Conferences_Y3_2023_24_Amt_Committed` decimal(10,2) DEFAULT NULL,
  `P1_Conferences_Y3_2023_24_Balance` decimal(10,2) DEFAULT NULL,
  `P2_Membership_Y1_2021_22_Num_Availed` int(11) DEFAULT NULL,
  `P2_Membership_Y1_2021_22_Amt_Spent` decimal(10,2) DEFAULT NULL,
  `P2_Membership_Y1_2021_22_Amt_Committed` decimal(10,2) DEFAULT NULL,
  `P2_Membership_Y1_2021_22_Balance` decimal(10,2) DEFAULT NULL,
  `P2_Membership_Y2_2022_23_Num_Availed` int(11) DEFAULT NULL,
  `P2_Membership_Y2_2022_23_Amt_Spent` decimal(10,2) DEFAULT NULL,
  `P2_Membership_Y2_2022_23_Amt_Committed` decimal(10,2) DEFAULT NULL,
  `P2_Membership_Y2_2022_23_Balance` decimal(10,2) DEFAULT NULL,
  `P2_Membership_Y3_2023_24_Num_Availed` int(11) DEFAULT NULL,
  `P2_Membership_Y3_2023_24_Amt_Spent` decimal(10,2) DEFAULT NULL,
  `P2_Membership_Y3_2023_24_Amt_Committed` decimal(10,2) DEFAULT NULL,
  `P2_Membership_Y3_2023_24_Balance` decimal(10,2) DEFAULT NULL,
  `P3a_Consumables_Num_Availed` int(11) DEFAULT NULL,
  `P3a_Consumables_Amt_Spent` decimal(10,2) DEFAULT NULL,
  `P3a_Consumables_Amt_Committed` decimal(10,2) DEFAULT NULL,
  `P3a_Consumables_Balance` decimal(10,2) DEFAULT NULL,
  `P3b_Synthesis_Testing_Num_Availed` int(11) DEFAULT NULL,
  `P3b_Synthesis_Testing_Amt_Spent` decimal(10,2) DEFAULT NULL,
  `P3b_Synthesis_Testing_Amt_Committed` decimal(10,2) DEFAULT NULL,
  `P3b_Synthesis_Testing_Balance` decimal(10,2) DEFAULT NULL,
  `P3c_i_Stationary_Num_Availed` int(11) DEFAULT NULL,
  `P3c_i_Stationary_Amt_Spent` decimal(10,2) DEFAULT NULL,
  `P3c_i_Stationary_Amt_Committed` decimal(10,2) DEFAULT NULL,
  `P3c_i_Stationary_Balance` decimal(10,2) DEFAULT NULL,
  `P3c_ii_Books_Num_Availed` int(11) DEFAULT NULL,
  `P3c_ii_Books_Amt_Spent` decimal(10,2) DEFAULT NULL,
  `P3c_ii_Books_Amt_Committed` decimal(10,2) DEFAULT NULL,
  `P3c_ii_Books_Balance` decimal(10,2) DEFAULT NULL,
  `P3d_Computer_Consumables_Num_Availed` int(11) DEFAULT NULL,
  `P3d_Computer_Consumables_Amt_Spent` decimal(10,2) DEFAULT NULL,
  `P3d_Computer_Consumables_Amt_Committed` decimal(10,2) DEFAULT NULL,
  `P3d_Computer_Consumables_Balance` decimal(10,2) DEFAULT NULL,
  `Created_At` timestamp NOT NULL DEFAULT current_timestamp(),
  `Updated_At` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `fdx_expenditure_main`
--

INSERT INTO `fdx_expenditure_main` (`Application_ID`, `P1_Conferences_Y1_2021_22_Num_Events`, `P1_Conferences_Y1_2021_22_Amt_Spent`, `P1_Conferences_Y1_2021_22_Amt_Committed`, `P1_Conferences_Y1_2021_22_Balance`, `P1_Conferences_Y2_2022_23_Num_Events`, `P1_Conferences_Y2_2022_23_Amt_Spent`, `P1_Conferences_Y2_2022_23_Amt_Committed`, `P1_Conferences_Y2_2022_23_Balance`, `P1_Conferences_Y3_2023_24_Num_Events`, `P1_Conferences_Y3_2023_24_Amt_Spent`, `P1_Conferences_Y3_2023_24_Amt_Committed`, `P1_Conferences_Y3_2023_24_Balance`, `P2_Membership_Y1_2021_22_Num_Availed`, `P2_Membership_Y1_2021_22_Amt_Spent`, `P2_Membership_Y1_2021_22_Amt_Committed`, `P2_Membership_Y1_2021_22_Balance`, `P2_Membership_Y2_2022_23_Num_Availed`, `P2_Membership_Y2_2022_23_Amt_Spent`, `P2_Membership_Y2_2022_23_Amt_Committed`, `P2_Membership_Y2_2022_23_Balance`, `P2_Membership_Y3_2023_24_Num_Availed`, `P2_Membership_Y3_2023_24_Amt_Spent`, `P2_Membership_Y3_2023_24_Amt_Committed`, `P2_Membership_Y3_2023_24_Balance`, `P3a_Consumables_Num_Availed`, `P3a_Consumables_Amt_Spent`, `P3a_Consumables_Amt_Committed`, `P3a_Consumables_Balance`, `P3b_Synthesis_Testing_Num_Availed`, `P3b_Synthesis_Testing_Amt_Spent`, `P3b_Synthesis_Testing_Amt_Committed`, `P3b_Synthesis_Testing_Balance`, `P3c_i_Stationary_Num_Availed`, `P3c_i_Stationary_Amt_Spent`, `P3c_i_Stationary_Amt_Committed`, `P3c_i_Stationary_Balance`, `P3c_ii_Books_Num_Availed`, `P3c_ii_Books_Amt_Spent`, `P3c_ii_Books_Amt_Committed`, `P3c_ii_Books_Balance`, `P3d_Computer_Consumables_Num_Availed`, `P3d_Computer_Consumables_Amt_Spent`, `P3d_Computer_Consumables_Amt_Committed`, `P3d_Computer_Consumables_Balance`, `Created_At`, `Updated_At`) VALUES
('12', 12, 34.00, 23.00, 9.00, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-10-29 18:24:42', '2025-10-29 18:24:42'),
('23', 0, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, '2025-10-29 18:49:40', '2025-10-29 18:50:16'),
('24', 0, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, '2025-10-29 18:48:36', '2025-10-29 18:48:42'),
('4', 211, 0.00, 0.00, 0.00, 545, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, '2025-10-29 18:51:15', '2025-10-29 18:51:15');

-- --------------------------------------------------------

--
-- Table structure for table `issued_devices`
--

CREATE TABLE `issued_devices` (
  `device_id` int(11) NOT NULL,
  `application_id` int(11) NOT NULL,
  `employee_code` varchar(50) NOT NULL,
  `item_name` varchar(200) NOT NULL,
  `device_type` enum('LAPTOP','TABLET','NOTEBOOK','OTHER_ELECTRONIC') DEFAULT NULL,
  `date_of_issue` date DEFAULT NULL,
  `cost_at_issue` decimal(10,2) DEFAULT NULL,
  `serial_number` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `membership_expenditure`
--

CREATE TABLE `membership_expenditure` (
  `expenditure_id` int(11) NOT NULL,
  `application_id` int(11) NOT NULL,
  `block_year` int(11) NOT NULL,
  `financial_year` varchar(10) DEFAULT NULL,
  `number_availed` int(11) DEFAULT 0,
  `amount_spent` decimal(10,2) DEFAULT 0.00,
  `amount_committed` decimal(10,2) DEFAULT 0.00,
  `max_memberships_per_year` int(11) DEFAULT 3,
  `balance_amount` decimal(10,2) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `notifications`
--

CREATE TABLE `notifications` (
  `notification_id` int(11) NOT NULL,
  `application_id` int(11) NOT NULL,
  `recipient_role` varchar(100) DEFAULT NULL,
  `recipient_email` varchar(100) DEFAULT NULL,
  `notification_type` enum('SUBMISSION','APPROVAL_REQUIRED','APPROVED','REJECTED','REMINDER') DEFAULT NULL,
  `message` text DEFAULT NULL,
  `is_read` tinyint(1) DEFAULT 0,
  `sent_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `pda_expenditure_tracking`
--

CREATE TABLE `pda_expenditure_tracking` (
  `id` int(11) NOT NULL,
  `application_id` int(11) DEFAULT NULL,
  `employee_code` varchar(50) NOT NULL,
  `block_year` varchar(15) NOT NULL,
  `category` varchar(100) NOT NULL,
  `number_availed` int(11) DEFAULT 0,
  `no_of_events` int(11) DEFAULT 0,
  `amount_spent` decimal(12,2) DEFAULT 0.00,
  `amount_committed` decimal(12,2) DEFAULT 0.00,
  `balance_as_on_date` decimal(12,2) DEFAULT 0.00,
  `created_by` varchar(50) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `professional_memberships`
--

CREATE TABLE `professional_memberships` (
  `membership_id` int(11) NOT NULL,
  `application_id` int(11) NOT NULL,
  `professional_body_name` varchar(300) NOT NULL,
  `amount` decimal(10,2) NOT NULL,
  `membership_type` enum('NATIONAL','INTERNATIONAL','BOTH') DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `professional_memberships`
--

INSERT INTO `professional_memberships` (`membership_id`, `application_id`, `professional_body_name`, `amount`, `membership_type`, `created_at`) VALUES
(1, 4, 'sd', 2.00, 'NATIONAL', '2025-10-28 14:04:29'),
(2, 4, 'afds', 24.00, 'INTERNATIONAL', '2025-10-28 14:04:29'),
(3, 6, 'd', 33.00, 'NATIONAL', '2025-10-29 08:26:16'),
(4, 7, 'a', 44.00, 'BOTH', '2025-10-29 08:29:06'),
(5, 26, 'j', 665.00, 'NATIONAL', '2025-12-12 06:12:18'),
(6, 27, 'xcv', 45.00, 'NATIONAL', '2025-12-12 08:28:52'),
(7, 27, 'sfdljk', 98.00, 'INTERNATIONAL', '2025-12-12 08:28:52'),
(8, 28, '34c6j274', 10000.00, 'NATIONAL', '2025-12-13 14:28:36'),
(9, 29, 'trh4w', 5000.00, 'NATIONAL', '2025-12-13 14:45:04'),
(10, 30, 'fwc', 300000.00, 'NATIONAL', '2025-12-13 15:18:56');

-- --------------------------------------------------------

--
-- Table structure for table `status_history`
--

CREATE TABLE `status_history` (
  `history_id` int(11) NOT NULL,
  `application_id` int(11) NOT NULL,
  `previous_status` varchar(50) DEFAULT NULL,
  `new_status` varchar(50) DEFAULT NULL,
  `changed_by` varchar(200) DEFAULT NULL,
  `change_reason` text DEFAULT NULL,
  `changed_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `employee_code` int(11) NOT NULL,
  `name` varchar(100) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `role` varchar(50) DEFAULT NULL,
  `department` varchar(100) DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `mobile_number` varchar(15) DEFAULT NULL,
  `pay_level` varchar(10) DEFAULT NULL,
  `date_of_joining` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`employee_code`, `name`, `email`, `password`, `role`, `department`, `created_at`, `mobile_number`, `pay_level`, `date_of_joining`) VALUES
(1101, 'Dr. Priya Sharma', 'priya.sharma@nitj.ac.in', 'Ps@2025', 'faculty', 'Computer Science & Engg.', '2025-10-23 21:02:16', '987654321', '13A2', '2012-09-01'),
(1102, 'Dr. Vivek Soni', 'vivek.soni@nitj.ac.in', 'Vs#2025', 'faculty', 'Computer Science & Engg.', '2025-10-23 21:02:16', '987654322', '13A2', '2012-09-01'),
(1103, 'Ms. Aditi Rao', 'aditi.rao@nitj.ac.in', 'Ar$2025', 'faculty', 'Computer Science & Engg.', '2025-10-23 21:02:16', '987654323', '13A2', '2012-09-01'),
(1104, 'Dr. Harish Tandon', 'harish.t@nitj.ac.in', 'Ht%2025', 'faculty', 'Computer Science & Engg.', '2025-10-23 21:02:16', '987654324', '13A2', '2012-09-01'),
(1105, 'Dr. Aman Singh', 'aman.singh@nitj.ac.in', 'As#2025', 'faculty', 'Mechanical Engineering', '2025-10-23 21:02:16', '987654325', '13A2', '2012-09-01'),
(1106, 'Dr. Rajesh Kumar', 'rajesh.k@nitj.ac.in', 'Rk$2025', 'faculty', 'Electronics & Comm. Engg.', '2025-10-23 21:02:16', '987654326', '12', '2018-03-20'),
(1107, 'Dr. Sunita Devi', 'sunita.d@nitj.ac.in', 'Sd%2025', 'faculty', 'Physics', '2025-10-23 21:02:16', '987654327', '12', '2018-03-20'),
(1108, 'Dr. Vijay Bansal', 'vijay.b@nitj.ac.in', 'Vb^2025', 'faculty', 'Chemical Engineering', '2025-10-23 21:02:16', '987654328', '12', '2018-03-20'),
(1109, 'Prof. Meena Goel', 'meena.g@nitj.ac.in', 'Mg&2025', 'faculty', 'Civil Engineering', '2025-10-23 21:02:16', '987654329', '12', '2018-03-20'),
(1110, 'Prof. Alok Jain', 'hod.cse@nitj.ac.in', 'Hc$@2025', 'hod', 'Computer Science & Engg.', '2025-10-23 21:02:16', '9876543210', '14A', '2008-07-01'),
(1111, 'Dr. Neeraj Gupta', 'hod.me@nitj.ac.in', 'Hm#@2025', 'hod', 'Mechanical Engineering', '2025-10-23 21:02:16', '9876543211', '14A', '2008-07-01'),
(1112, 'Prof. Kavita Singh', 'hod.ece@nitj.ac.in', 'He%@2025', 'hod', 'Electronics & Comm. Engg.', '2025-10-23 21:02:16', '9876543212', '14A', '2008-07-01'),
(1113, 'Dr. Vineet Aggarwal', 'hod.phy@nitj.ac.in', 'Hp^@2025', 'hod', 'Physics', '2025-10-23 21:02:16', '9876543213', '14A', '2008-07-01'),
(1114, 'Ms. Ritu Verma', 'ar.accounts@nitj.ac.in', 'Ar#Acct', 'accounts_ar', 'Accounts Section', '2025-10-23 21:02:16', '9876543214', '9', '2022-05-01'),
(1115, 'Mr. Suresh Dutt', 'supdt.accounts@nitj.ac.in', 'Sa$Acct', 'accounts_supp.', 'Accounts Section', '2025-10-23 21:02:16', '9876543215', '10', '2022-05-01'),
(1116, 'Ms. Juhi Saini', 'da.accounts@nitj.ac.in', 'Da%Acct', 'accounts_da', 'Accounts Section', '2025-10-23 21:02:16', '9876543216', '9', '2022-05-01'),
(1117, 'Dr. Vikram Sharma', 'adfw@nitj.ac.in', 'Ad@Fw25', 'assoc_dean_fw', 'Faculty Welfare', '2025-10-23 21:02:16', '9876543217', '14A', '2022-05-01'),
(1118, 'Prof. Sameer Roy', 'dean.fw@nitj.ac.in', 'Df!W25', 'dean_fw', 'Faculty Welfare', '2025-10-23 21:02:16', '9876543218', '15', '2008-07-01'),
(1119, 'Ms. Geeta Kaur', 'da.fw@nitj.ac.in', 'da&fw25', 'dfw_da', 'Faculty Welfare', '2025-10-23 21:58:24', '9876543219', '9', '2022-05-01'),
(1120, 'Prof. Anil Kohli', 'director@nitj.ac.in', 'Dir#2025', 'director', 'Administration', '2025-10-23 21:02:16', '9876543220', '15', '2005-01-15');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `accounts_balance`
--
ALTER TABLE `accounts_balance`
  ADD PRIMARY KEY (`balance_id`),
  ADD KEY `idx_application` (`application_id`);

--
-- Indexes for table `application_attachments`
--
ALTER TABLE `application_attachments`
  ADD PRIMARY KEY (`attachment_id`),
  ADD KEY `idx_application` (`application_id`);

--
-- Indexes for table `application_timeline_messages`
--
ALTER TABLE `application_timeline_messages`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_ref_number` (`ref_number`),
  ADD KEY `idx_message_sequence` (`ref_number`,`message_sequence`),
  ADD KEY `idx_sender_identifier` (`sender_identifier`),
  ADD KEY `idx_recipient_identifier` (`recipient_identifier`);

--
-- Indexes for table `approval_workflow`
--
ALTER TABLE `approval_workflow`
  ADD PRIMARY KEY (`workflow_id`),
  ADD KEY `idx_application` (`application_id`),
  ADD KEY `idx_role` (`approver_role`);

--
-- Indexes for table `conference_expenditure`
--
ALTER TABLE `conference_expenditure`
  ADD PRIMARY KEY (`expenditure_id`),
  ADD KEY `idx_application_year` (`application_id`,`block_year`);

--
-- Indexes for table `consumable_items`
--
ALTER TABLE `consumable_items`
  ADD PRIMARY KEY (`item_id`),
  ADD KEY `idx_application` (`application_id`);

--
-- Indexes for table `contingent_expenditure`
--
ALTER TABLE `contingent_expenditure`
  ADD PRIMARY KEY (`expenditure_id`),
  ADD KEY `idx_application_type_year` (`application_id`,`expenditure_type`,`block_year`);

--
-- Indexes for table `cpda_applications`
--
ALTER TABLE `cpda_applications`
  ADD PRIMARY KEY (`application_id`),
  ADD UNIQUE KEY `ref_number` (`ref_number`),
  ADD KEY `idx_employee_code` (`employee_code`),
  ADD KEY `idx_status` (`status`),
  ADD KEY `idx_dated` (`dated`);

--
-- Indexes for table `cpda_balance_blocked`
--
ALTER TABLE `cpda_balance_blocked`
  ADD PRIMARY KEY (`block_id`);

--
-- Indexes for table `cpda_balance_master`
--
ALTER TABLE `cpda_balance_master`
  ADD PRIMARY KEY (`faculty_id`);

--
-- Indexes for table `cpda_balance_snapshot`
--
ALTER TABLE `cpda_balance_snapshot`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `cpda_event_applications`
--
ALTER TABLE `cpda_event_applications`
  ADD PRIMARY KEY (`application_id`),
  ADD UNIQUE KEY `application_number` (`ref_number`),
  ADD KEY `idx_employee_code` (`employee_code`),
  ADD KEY `idx_application_status` (`application_status`),
  ADD KEY `idx_submission_date` (`submission_date`),
  ADD KEY `idx_application_number` (`ref_number`);

--
-- Indexes for table `cpda_event_attachments`
--
ALTER TABLE `cpda_event_attachments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_application_id` (`application_id`);

--
-- Indexes for table `cpda_recommendation`
--
ALTER TABLE `cpda_recommendation`
  ADD PRIMARY KEY (`recommendation_id`),
  ADD KEY `application_ref_number` (`application_ref_number`);

--
-- Indexes for table `cpda_register_entries`
--
ALTER TABLE `cpda_register_entries`
  ADD PRIMARY KEY (`register_id`),
  ADD KEY `idx_application` (`application_id`);

--
-- Indexes for table `f4_professional_memberships`
--
ALTER TABLE `f4_professional_memberships`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_application_id` (`application_id`);

--
-- Indexes for table `f4_reimbursement_applications`
--
ALTER TABLE `f4_reimbursement_applications`
  ADD PRIMARY KEY (`application_id`),
  ADD UNIQUE KEY `ref_number` (`ref_number`),
  ADD KEY `idx_employee_code` (`employee_code`),
  ADD KEY `idx_application_status` (`application_status`),
  ADD KEY `idx_submission_date` (`submission_date`),
  ADD KEY `idx_ref_number` (`ref_number`);

--
-- Indexes for table `f4_reimbursement_attachments`
--
ALTER TABLE `f4_reimbursement_attachments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_application_id` (`application_id`);

--
-- Indexes for table `f5_attachments`
--
ALTER TABLE `f5_attachments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_reimbursement_id` (`reimbursement_id`),
  ADD KEY `idx_attachment_type` (`attachment_type`);

--
-- Indexes for table `f5_conference_reimbursements`
--
ALTER TABLE `f5_conference_reimbursements`
  ADD PRIMARY KEY (`application_id`),
  ADD UNIQUE KEY `ref_number` (`ref_number`),
  ADD KEY `idx_employee_code` (`employee_code`),
  ADD KEY `idx_status` (`status`),
  ADD KEY `idx_activity_dates` (`activity_start_date`,`activity_end_date`),
  ADD KEY `idx_created_at` (`created_at`);

--
-- Indexes for table `fdx_electronic_devices`
--
ALTER TABLE `fdx_electronic_devices`
  ADD PRIMARY KEY (`Device_ID`),
  ADD KEY `Application_ID` (`Application_ID`);

--
-- Indexes for table `fdx_expenditure_main`
--
ALTER TABLE `fdx_expenditure_main`
  ADD PRIMARY KEY (`Application_ID`);

--
-- Indexes for table `issued_devices`
--
ALTER TABLE `issued_devices`
  ADD PRIMARY KEY (`device_id`),
  ADD KEY `idx_application` (`application_id`),
  ADD KEY `idx_employee` (`employee_code`);

--
-- Indexes for table `membership_expenditure`
--
ALTER TABLE `membership_expenditure`
  ADD PRIMARY KEY (`expenditure_id`),
  ADD KEY `idx_application_year` (`application_id`,`block_year`);

--
-- Indexes for table `notifications`
--
ALTER TABLE `notifications`
  ADD PRIMARY KEY (`notification_id`),
  ADD KEY `idx_application` (`application_id`),
  ADD KEY `idx_recipient` (`recipient_email`,`is_read`);

--
-- Indexes for table `pda_expenditure_tracking`
--
ALTER TABLE `pda_expenditure_tracking`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_emp_block` (`employee_code`,`block_year`),
  ADD KEY `idx_application` (`application_id`);

--
-- Indexes for table `professional_memberships`
--
ALTER TABLE `professional_memberships`
  ADD PRIMARY KEY (`membership_id`),
  ADD KEY `idx_application` (`application_id`);

--
-- Indexes for table `status_history`
--
ALTER TABLE `status_history`
  ADD PRIMARY KEY (`history_id`),
  ADD KEY `idx_application_date` (`application_id`,`changed_at`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`employee_code`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `accounts_balance`
--
ALTER TABLE `accounts_balance`
  MODIFY `balance_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `application_attachments`
--
ALTER TABLE `application_attachments`
  MODIFY `attachment_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `application_timeline_messages`
--
ALTER TABLE `application_timeline_messages`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT for table `approval_workflow`
--
ALTER TABLE `approval_workflow`
  MODIFY `workflow_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `conference_expenditure`
--
ALTER TABLE `conference_expenditure`
  MODIFY `expenditure_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `consumable_items`
--
ALTER TABLE `consumable_items`
  MODIFY `item_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `contingent_expenditure`
--
ALTER TABLE `contingent_expenditure`
  MODIFY `expenditure_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `cpda_applications`
--
ALTER TABLE `cpda_applications`
  MODIFY `application_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- AUTO_INCREMENT for table `cpda_balance_blocked`
--
ALTER TABLE `cpda_balance_blocked`
  MODIFY `block_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `cpda_balance_snapshot`
--
ALTER TABLE `cpda_balance_snapshot`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `cpda_event_applications`
--
ALTER TABLE `cpda_event_applications`
  MODIFY `application_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `cpda_event_attachments`
--
ALTER TABLE `cpda_event_attachments`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `cpda_recommendation`
--
ALTER TABLE `cpda_recommendation`
  MODIFY `recommendation_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `cpda_register_entries`
--
ALTER TABLE `cpda_register_entries`
  MODIFY `register_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `f4_professional_memberships`
--
ALTER TABLE `f4_professional_memberships`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `f4_reimbursement_applications`
--
ALTER TABLE `f4_reimbursement_applications`
  MODIFY `application_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `f4_reimbursement_attachments`
--
ALTER TABLE `f4_reimbursement_attachments`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `f5_attachments`
--
ALTER TABLE `f5_attachments`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `f5_conference_reimbursements`
--
ALTER TABLE `f5_conference_reimbursements`
  MODIFY `application_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `fdx_electronic_devices`
--
ALTER TABLE `fdx_electronic_devices`
  MODIFY `Device_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `issued_devices`
--
ALTER TABLE `issued_devices`
  MODIFY `device_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `membership_expenditure`
--
ALTER TABLE `membership_expenditure`
  MODIFY `expenditure_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `notifications`
--
ALTER TABLE `notifications`
  MODIFY `notification_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `pda_expenditure_tracking`
--
ALTER TABLE `pda_expenditure_tracking`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `professional_memberships`
--
ALTER TABLE `professional_memberships`
  MODIFY `membership_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `status_history`
--
ALTER TABLE `status_history`
  MODIFY `history_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `accounts_balance`
--
ALTER TABLE `accounts_balance`
  ADD CONSTRAINT `accounts_balance_ibfk_1` FOREIGN KEY (`application_id`) REFERENCES `cpda_applications` (`application_id`) ON DELETE CASCADE;

--
-- Constraints for table `application_attachments`
--
ALTER TABLE `application_attachments`
  ADD CONSTRAINT `application_attachments_ibfk_1` FOREIGN KEY (`application_id`) REFERENCES `cpda_applications` (`application_id`) ON DELETE CASCADE;

--
-- Constraints for table `approval_workflow`
--
ALTER TABLE `approval_workflow`
  ADD CONSTRAINT `approval_workflow_ibfk_1` FOREIGN KEY (`application_id`) REFERENCES `cpda_applications` (`application_id`) ON DELETE CASCADE;

--
-- Constraints for table `conference_expenditure`
--
ALTER TABLE `conference_expenditure`
  ADD CONSTRAINT `conference_expenditure_ibfk_1` FOREIGN KEY (`application_id`) REFERENCES `cpda_applications` (`application_id`) ON DELETE CASCADE;

--
-- Constraints for table `consumable_items`
--
ALTER TABLE `consumable_items`
  ADD CONSTRAINT `consumable_items_ibfk_1` FOREIGN KEY (`application_id`) REFERENCES `cpda_applications` (`application_id`) ON DELETE CASCADE;

--
-- Constraints for table `contingent_expenditure`
--
ALTER TABLE `contingent_expenditure`
  ADD CONSTRAINT `contingent_expenditure_ibfk_1` FOREIGN KEY (`application_id`) REFERENCES `cpda_applications` (`application_id`) ON DELETE CASCADE;

--
-- Constraints for table `cpda_event_applications`
--
ALTER TABLE `cpda_event_applications`
  ADD CONSTRAINT `cpda_event_applications_ibfk_1` FOREIGN KEY (`employee_code`) REFERENCES `users` (`employee_code`) ON DELETE CASCADE;

--
-- Constraints for table `cpda_event_attachments`
--
ALTER TABLE `cpda_event_attachments`
  ADD CONSTRAINT `cpda_event_attachments_ibfk_1` FOREIGN KEY (`application_id`) REFERENCES `cpda_event_applications` (`application_id`) ON DELETE CASCADE;

--
-- Constraints for table `cpda_recommendation`
--
ALTER TABLE `cpda_recommendation`
  ADD CONSTRAINT `cpda_recommendation_ibfk_1` FOREIGN KEY (`application_ref_number`) REFERENCES `cpda_applications` (`ref_number`);

--
-- Constraints for table `cpda_register_entries`
--
ALTER TABLE `cpda_register_entries`
  ADD CONSTRAINT `cpda_register_entries_ibfk_1` FOREIGN KEY (`application_id`) REFERENCES `cpda_applications` (`application_id`) ON DELETE CASCADE;

--
-- Constraints for table `f4_professional_memberships`
--
ALTER TABLE `f4_professional_memberships`
  ADD CONSTRAINT `f4_professional_memberships_ibfk_1` FOREIGN KEY (`application_id`) REFERENCES `f4_reimbursement_applications` (`application_id`) ON DELETE CASCADE;

--
-- Constraints for table `f4_reimbursement_applications`
--
ALTER TABLE `f4_reimbursement_applications`
  ADD CONSTRAINT `f4_reimbursement_applications_ibfk_1` FOREIGN KEY (`employee_code`) REFERENCES `users` (`employee_code`) ON DELETE CASCADE;

--
-- Constraints for table `f4_reimbursement_attachments`
--
ALTER TABLE `f4_reimbursement_attachments`
  ADD CONSTRAINT `f4_reimbursement_attachments_ibfk_1` FOREIGN KEY (`application_id`) REFERENCES `f4_reimbursement_applications` (`application_id`) ON DELETE CASCADE;

--
-- Constraints for table `f5_attachments`
--
ALTER TABLE `f5_attachments`
  ADD CONSTRAINT `f5_attachments_ibfk_1` FOREIGN KEY (`reimbursement_id`) REFERENCES `f5_conference_reimbursements` (`application_id`) ON DELETE CASCADE;

--
-- Constraints for table `f5_conference_reimbursements`
--
ALTER TABLE `f5_conference_reimbursements`
  ADD CONSTRAINT `f5_conference_reimbursements_ibfk_1` FOREIGN KEY (`employee_code`) REFERENCES `users` (`employee_code`) ON DELETE CASCADE;

--
-- Constraints for table `fdx_electronic_devices`
--
ALTER TABLE `fdx_electronic_devices`
  ADD CONSTRAINT `fdx_electronic_devices_ibfk_1` FOREIGN KEY (`Application_ID`) REFERENCES `fdx_expenditure_main` (`Application_ID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `issued_devices`
--
ALTER TABLE `issued_devices`
  ADD CONSTRAINT `issued_devices_ibfk_1` FOREIGN KEY (`application_id`) REFERENCES `cpda_applications` (`application_id`) ON DELETE CASCADE;

--
-- Constraints for table `membership_expenditure`
--
ALTER TABLE `membership_expenditure`
  ADD CONSTRAINT `membership_expenditure_ibfk_1` FOREIGN KEY (`application_id`) REFERENCES `cpda_applications` (`application_id`) ON DELETE CASCADE;

--
-- Constraints for table `notifications`
--
ALTER TABLE `notifications`
  ADD CONSTRAINT `notifications_ibfk_1` FOREIGN KEY (`application_id`) REFERENCES `cpda_applications` (`application_id`) ON DELETE CASCADE;

--
-- Constraints for table `professional_memberships`
--
ALTER TABLE `professional_memberships`
  ADD CONSTRAINT `professional_memberships_ibfk_1` FOREIGN KEY (`application_id`) REFERENCES `cpda_applications` (`application_id`) ON DELETE CASCADE;

--
-- Constraints for table `status_history`
--
ALTER TABLE `status_history`
  ADD CONSTRAINT `status_history_ibfk_1` FOREIGN KEY (`application_id`) REFERENCES `cpda_applications` (`application_id`) ON DELETE CASCADE;
--
-- Database: `college`
--
CREATE DATABASE IF NOT EXISTS `college` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `college`;

-- --------------------------------------------------------

--
-- Table structure for table `accounts_balance`
--

CREATE TABLE `accounts_balance` (
  `balance_id` int(11) NOT NULL,
  `application_id` int(11) NOT NULL,
  `total_requested_amount` decimal(10,2) DEFAULT NULL,
  `available_balance` decimal(10,2) DEFAULT NULL,
  `budget_head` varchar(100) DEFAULT NULL,
  `balance_confirmed` tinyint(1) DEFAULT 0,
  `confirmed_by` varchar(200) DEFAULT NULL,
  `confirmation_date` datetime DEFAULT NULL,
  `remarks` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `application_attachments`
--

CREATE TABLE `application_attachments` (
  `attachment_id` int(11) NOT NULL,
  `application_id` int(11) NOT NULL,
  `file_name` varchar(255) DEFAULT NULL,
  `file_path` varchar(500) DEFAULT NULL,
  `file_type` varchar(50) DEFAULT NULL,
  `file_size` int(11) DEFAULT NULL,
  `uploaded_by` varchar(200) DEFAULT NULL,
  `uploaded_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `application_timeline_messages`
--

CREATE TABLE `application_timeline_messages` (
  `id` int(11) NOT NULL,
  `ref_number` varchar(100) NOT NULL,
  `message_sequence` int(11) NOT NULL,
  `message` text NOT NULL,
  `sender_identifier` varchar(255) NOT NULL,
  `recipient_identifier` varchar(255) DEFAULT NULL,
  `message_time` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `application_timeline_messages`
--

INSERT INTO `application_timeline_messages` (`id`, `ref_number`, `message_sequence`, `message`, `sender_identifier`, `recipient_identifier`, `message_time`) VALUES
(1, 'CPDA-693BD2441D4B4', 1, '[APPROVED] yo you o', '1110', '1119', '2025-12-12 14:06:24'),
(2, 'CPDA-EVT-25-000003', 1, '[APPROVED] iuyiyiu', '1110', '1119', '2025-12-12 14:06:59'),
(3, 'F4/2025/00007', 1, '[APPROVED] 65645654', '1110', '1114', '2025-12-12 14:07:11'),
(4, 'CPDA/F5/2025/693bd358c3bbb', 1, '[APPROVED] 98645-+-+', '1110', '1114', '2025-12-12 14:07:20'),
(5, 'CPDA-693BD2441D4B4', 2, '[DA-RECOMMENDED] iuomn', '1119', '1117', '2025-12-12 14:07:49'),
(6, 'CPDA-EVT-25-000003', 2, '[DA-SEND-BACK] 2145982323', '1119', '1110', '2025-12-12 14:08:07'),
(7, 'CPDA-EVT-25-000003', 3, '[APPROVED] 8745++-+', '1110', '1119', '2025-12-12 14:08:30'),
(8, 'CPDA-EVT-25-000003', 4, '[DA-RECOMMENDED] 45487', '1119', '1117', '2025-12-12 14:08:51'),
(9, 'CPDA-693BD2441D4B4', 3, '[ASSoc dean-RECOMMENDED] 8745', '1117', '1118', '2025-12-12 14:09:21'),
(10, 'CPDA-EVT-25-000003', 5, '[ASSoc dean-RECOMMENDED] tygfhg', '1117', '1118', '2025-12-12 14:09:31'),
(11, 'CPDA-693BD2441D4B4', 4, '[DFW-RECOMMENDED] krta yrr', '1118', '1120', '2025-12-12 14:10:14'),
(12, 'CPDA-EVT-25-000003', 6, '[DFW-RECOMMENDED] khush reh', '1118', '1120', '2025-12-12 14:10:27'),
(13, 'CPDA-693BD2441D4B4', 5, '[Director-SEND-BACK] ghat ke paise', '1120', '1118', '2025-12-12 14:25:04'),
(14, 'CPDA-EVT-25-000003', 7, '[Director-REJECTED] dfffa ho( ene paise)', '1120', '1101', '2025-12-12 14:25:24'),
(15, 'CPDA-693BD2441D4B4', 6, '[DFW-RECOMMENDED] krte ji', '1118', '1120', '2025-12-12 14:25:52'),
(16, 'CPDA-693BD2441D4B4', 7, '[Director-RECOMMENDED] aish kr', '1120', '1101', '2025-12-12 14:26:14'),
(17, 'CPDA-EVT-25-000002', 1, '[APPROVED] lkkl', '1110', '1119', '2025-12-12 14:31:15'),
(18, 'CPDA-EVT-25-000002', 2, '[DA-RECOMMENDED] dff', '1119', '1117', '2025-12-12 14:32:03'),
(19, 'CPDA-EVT-25-000002', 3, '[ASSoc dean-RECOMMENDED] df', '1117', '1118', '2025-12-12 14:33:05'),
(20, 'CPDA-EVT-25-000002', 4, '[DFW-RECOMMENDED] kj', '1118', '1120', '2025-12-12 14:41:05'),
(21, 'CPDA-EVT-25-000002', 5, '[Director-SEND-BACK] nm', '1120', '1118', '2025-12-12 14:58:16'),
(22, 'CPDA-EVT-25-000002', 6, '[DFW-RECOMMENDED] 564', '1118', '1120', '2025-12-12 15:00:12'),
(23, 'CPDA-EVT-25-000002', 7, '[Director-RECOMMENDED] kr mje', '1120', '1101', '2025-12-12 15:03:34');

-- --------------------------------------------------------

--
-- Table structure for table `approval_workflow`
--

CREATE TABLE `approval_workflow` (
  `workflow_id` int(11) NOT NULL,
  `application_id` int(11) NOT NULL,
  `approver_role` enum('HOD','ASSISTANT_REGISTRAR_ACCOUNTS','DEALING_ASSISTANT','SUPERINTENDENT_ACCOUNTS','ASSOCIATE_DEAN_FW','DEAN_FW','DIRECTOR') DEFAULT NULL,
  `approver_name` varchar(200) DEFAULT NULL,
  `action` enum('SUBMITTED','RECOMMENDED','NOT_RECOMMENDED','APPROVED','NOT_APPROVED','BALANCE_CONFIRMED','EXAMINED','PENDING') DEFAULT NULL,
  `comments` text DEFAULT NULL,
  `action_date` datetime DEFAULT NULL,
  `signature_captured` tinyint(1) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `approval_workflow`
--

INSERT INTO `approval_workflow` (`workflow_id`, `application_id`, `approver_role`, `approver_name`, `action`, `comments`, `action_date`, `signature_captured`, `created_at`) VALUES
(1, 4, 'HOD', 'Prof. Alok Jain', '', 'okk', '2025-10-29 14:07:32', 0, '2025-10-29 08:37:32'),
(2, 24, 'HOD', 'Prof. Alok Jain', '', 'hjkhj', '2025-10-29 15:05:34', 0, '2025-10-29 09:35:34'),
(3, 17, 'HOD', 'Prof. Alok Jain', '', 'jk', '2025-10-29 15:05:40', 0, '2025-10-29 09:35:40'),
(4, 23, 'HOD', 'Prof. Alok Jain', '', '', '2025-10-29 16:10:37', 0, '2025-10-29 10:40:37'),
(5, 24, 'DEALING_ASSISTANT', 'Ms. Juhi Saini', 'BALANCE_CONFIRMED', 'Expenditure data saved by DA and forwarded to Superintendent', '2025-10-30 00:18:42', 0, '2025-10-29 18:48:42'),
(6, 23, 'DEALING_ASSISTANT', 'Ms. Juhi Saini', 'BALANCE_CONFIRMED', 'Expenditure data saved by DA and forwarded to Superintendent', '2025-10-30 00:20:16', 0, '2025-10-29 18:50:16'),
(7, 4, 'DEALING_ASSISTANT', 'Ms. Juhi Saini', 'BALANCE_CONFIRMED', 'Expenditure data saved by DA and forwarded to Superintendent', '2025-10-30 00:21:15', 0, '2025-10-29 18:51:15'),
(8, 6, 'HOD', 'Prof. Alok Jain', '', '', '2025-10-30 10:13:48', 0, '2025-10-30 04:43:48'),
(9, 9, 'HOD', 'Prof. Alok Jain', '', '', '2025-10-31 11:47:08', 0, '2025-10-31 06:17:08'),
(10, 3, 'HOD', 'Prof. Alok Jain', '', 'sd', '2025-10-31 18:42:21', 0, '2025-10-31 13:12:21'),
(11, 2, 'HOD', 'Prof. Alok Jain', '', 'jk', '2025-10-31 19:42:31', 0, '2025-10-31 14:12:31'),
(12, 5, 'HOD', 'Prof. Alok Jain', '', 'sd', '2025-10-31 23:11:45', 0, '2025-10-31 17:41:45'),
(13, 5, 'HOD', 'Prof. Alok Jain', '', 'xsd', '2025-10-31 23:11:56', 0, '2025-10-31 17:41:56'),
(14, 5, 'HOD', 'Prof. Alok Jain', '', 'dsf', '2025-10-31 23:12:01', 0, '2025-10-31 17:42:01');

-- --------------------------------------------------------

--
-- Table structure for table `conference_expenditure`
--

CREATE TABLE `conference_expenditure` (
  `expenditure_id` int(11) NOT NULL,
  `application_id` int(11) NOT NULL,
  `block_year` int(11) NOT NULL,
  `financial_year` varchar(10) DEFAULT NULL,
  `events_attended_working_days` int(11) DEFAULT 0,
  `amount_spent` decimal(10,2) DEFAULT 0.00,
  `amount_committed` decimal(10,2) DEFAULT 0.00,
  `limit_applicable` decimal(10,2) DEFAULT 210000.00,
  `balance_amount` decimal(10,2) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `consumable_items`
--

CREATE TABLE `consumable_items` (
  `item_id` int(11) NOT NULL,
  `application_id` int(11) NOT NULL,
  `serial_number` int(11) DEFAULT NULL,
  `article_name` varchar(500) NOT NULL,
  `amount` decimal(10,2) NOT NULL,
  `item_category` enum('CHEMICALS','LABORATORY_GLASSWARE','SYNTHESIS_CHARGES','ANALYSIS_CHARGES','STATIONARY','BOOKS','COMPUTER_CONSUMABLES','EXTERNAL_STORAGE','CARTRIDGES','PATENT','OTHER') DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `consumable_items`
--

INSERT INTO `consumable_items` (`item_id`, `application_id`, `serial_number`, `article_name`, `amount`, `item_category`, `created_at`) VALUES
(1, 4, 0, 'sad', 324.00, 'CHEMICALS', '2025-10-28 14:04:29'),
(2, 4, 0, 'adsf234', 234.00, 'BOOKS', '2025-10-28 14:04:29'),
(3, 4, 0, 'tr', 56.00, 'EXTERNAL_STORAGE', '2025-10-28 14:04:29'),
(4, 4, 0, 'ert', 564.00, 'CARTRIDGES', '2025-10-28 14:04:29'),
(5, 6, 0, 'fds', 989.00, 'CARTRIDGES', '2025-10-29 08:26:16'),
(6, 7, 0, 'a', 33.00, 'CHEMICALS', '2025-10-29 08:29:06'),
(7, 17, 0, 'a', 23.00, 'CHEMICALS', '2025-10-29 09:00:40'),
(8, 17, 0, 'g', 232.00, 'PATENT', '2025-10-29 09:00:40'),
(9, 17, 0, 'as', 12.00, 'EXTERNAL_STORAGE', '2025-10-29 09:00:40'),
(10, 23, 1, 'd', 323.00, 'CHEMICALS', '2025-10-29 09:33:20'),
(11, 24, 1, 'jkkj', 15165.00, 'CHEMICALS', '2025-10-29 09:34:19'),
(12, 24, 2, 'hih', 78.00, 'CHEMICALS', '2025-10-29 09:34:19'),
(13, 26, 1, 'i', 78.00, 'CHEMICALS', '2025-12-12 06:12:18'),
(14, 27, 1, 'uoixv', 456.00, 'CHEMICALS', '2025-12-12 08:28:52');

-- --------------------------------------------------------

--
-- Table structure for table `contingent_expenditure`
--

CREATE TABLE `contingent_expenditure` (
  `expenditure_id` int(11) NOT NULL,
  `application_id` int(11) NOT NULL,
  `expenditure_type` enum('CONSUMABLES','SYNTHESIS_TESTING','STATIONARY','BOOKS','COMPUTER_CONSUMABLES') DEFAULT NULL,
  `block_year` int(11) NOT NULL,
  `financial_year` varchar(10) DEFAULT NULL,
  `amount_spent` decimal(10,2) DEFAULT 0.00,
  `amount_committed` decimal(10,2) DEFAULT 0.00,
  `limit_applicable` decimal(10,2) DEFAULT NULL,
  `balance_amount` decimal(10,2) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `cpda_applications`
--

CREATE TABLE `cpda_applications` (
  `application_id` int(11) NOT NULL,
  `ref_number` varchar(100) DEFAULT NULL,
  `dated` date DEFAULT NULL,
  `employee_code` varchar(50) NOT NULL,
  `faculty_name` varchar(200) NOT NULL,
  `email` varchar(100) DEFAULT NULL,
  `mobile_number` varchar(15) DEFAULT NULL,
  `designation` varchar(100) DEFAULT NULL,
  `department` varchar(100) DEFAULT NULL,
  `pay_level` varchar(50) DEFAULT NULL,
  `date_of_joining` date DEFAULT NULL,
  `purpose_of_purchase` text DEFAULT NULL,
  `technical_specification` text DEFAULT NULL,
  `source_of_information` text DEFAULT NULL,
  `remarks` text DEFAULT NULL,
  `applicant_signature_date` datetime DEFAULT NULL,
  `status` enum('DRAFT','SUBMITTED','HOD_APPROVED','HOD_REJECTED','ACCOUNTS_APPROVED','ACCOUNTS_REJECTED','DFW_APPROVED','DFW_REJECTED','DIRECTOR_APPROVED','DIRECTOR_REJECTED','COMPLETED') DEFAULT 'DRAFT',
  `pda_block_start_year` int(11) DEFAULT NULL,
  `pda_block_end_year` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `current_stage` enum('HOD_REVIEW','DA_REVIEW','ASS_REVIEW','DFW_REVIEW','DIRECTOR_REVIEW','COMPLETED') DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `cpda_applications`
--

INSERT INTO `cpda_applications` (`application_id`, `ref_number`, `dated`, `employee_code`, `faculty_name`, `email`, `mobile_number`, `designation`, `department`, `pay_level`, `date_of_joining`, `purpose_of_purchase`, `technical_specification`, `source_of_information`, `remarks`, `applicant_signature_date`, `status`, `pda_block_start_year`, `pda_block_end_year`, `created_at`, `updated_at`, `current_stage`) VALUES
(1, 'CPDA-6900C6ED21BE6', '2025-10-28', '1105', 'Dr. Aman Singh', 'aman.singh@nitj.ac.in', '7696124875', 'faculty', 'Mechanical Engineering', '13', '2025-10-22', 'trip', 'i9', NULL, '', NULL, 'SUBMITTED', NULL, NULL, '2025-10-28 13:36:45', '2025-12-12 07:35:29', 'HOD_REVIEW'),
(2, 'CPDA-6900CAB0C4730', '2025-10-28', '1101', 'Dr. Priya Sharma', 'priya.sharma@nitj.ac.in', '987654321', 'faculty', 'Computer Science & Engg.', '13A2', '2012-09-01', 'sdaljkf', 'sf', NULL, 'skldf', NULL, 'HOD_REJECTED', NULL, NULL, '2025-10-28 13:52:48', '2025-12-12 07:35:29', 'COMPLETED'),
(3, 'CPDA-6900CCF539F1A', '2025-10-28', '1101', 'Dr. Priya Sharma', 'priya.sharma@nitj.ac.in', '987654321', 'faculty', 'Computer Science & Engg.', '13A2', '2012-09-01', 'sdfsdf', 'fsd', NULL, '', NULL, 'SUBMITTED', NULL, NULL, '2025-10-28 14:02:29', '2025-12-12 07:35:29', 'HOD_REVIEW'),
(4, 'CPDA-6900CD6DE78B4', '2025-10-28', '1101', 'Dr. Priya Sharma', 'priya.sharma@nitj.ac.in', '987654321', 'faculty', 'Computer Science & Engg.', '13A2', '2012-09-01', 'asd', 'asd', NULL, 'we', NULL, 'SUBMITTED', NULL, NULL, '2025-10-28 14:04:29', '2025-12-12 07:35:29', 'HOD_REVIEW'),
(5, 'CPDA-6901CF0C2D694', '2025-10-29', '1101', 'Dr. Priya Sharma', 'priya.sharma@nitj.ac.in', '987654321', 'faculty', 'Computer Science & Engg.', '13A2', '2012-09-01', 'm', ' n', NULL, '', NULL, 'HOD_REJECTED', NULL, NULL, '2025-10-29 08:23:40', '2025-12-12 07:35:29', 'COMPLETED'),
(6, 'CPDA-6901CFA87EE48', '2025-10-29', '1101', 'Dr. Priya Sharma', 'priya.sharma@nitj.ac.in', '987654321', 'faculty', 'Computer Science & Engg.', '13A2', '2012-09-01', 'zasf', 'er', NULL, 'g', '0000-00-00 00:00:00', 'SUBMITTED', NULL, NULL, '2025-10-29 08:26:16', '2025-12-12 07:36:54', 'HOD_REVIEW'),
(7, 'CPDA-6901D0523648A', '2025-10-29', '1105', 'Dr. Aman Singh', 'aman.singh@nitj.ac.in', '987654325', 'faculty', 'Mechanical Engineering', '13A2', '2012-09-01', 'a', 'a', NULL, '', NULL, 'SUBMITTED', NULL, NULL, '2025-10-29 08:29:06', '2025-12-12 07:37:00', 'HOD_REVIEW'),
(8, 'CPDA-6901D3F80E738', '2025-10-29', '1105', 'Dr. Aman Singh', 'aman.singh@nitj.ac.in', '987654325', 'faculty', 'Mechanical Engineering', '13A2', '2012-09-01', 'as', 's', NULL, '', NULL, 'SUBMITTED', NULL, NULL, '2025-10-29 08:44:40', '2025-12-12 07:37:07', 'HOD_REVIEW'),
(9, 'CPDA-6901D4F6AE3FF', '2025-10-29', '1101', 'Dr. Priya Sharma', 'priya.sharma@nitj.ac.in', '987654321', 'faculty', 'Computer Science & Engg.', '13A2', '2012-09-01', 'a', 'q', NULL, '', NULL, 'SUBMITTED', NULL, NULL, '2025-10-29 08:48:54', '2025-12-12 07:37:13', 'HOD_REVIEW'),
(17, 'CPDA-6901D7B87F2F5', '2025-10-29', '1101', 'Dr. Priya Sharma', 'priya.sharma@nitj.ac.in', '987654321', 'faculty', 'Computer Science & Engg.', '13A2', '2012-09-01', 'sd', 's', NULL, '', NULL, 'HOD_REJECTED', NULL, NULL, '2025-10-29 09:00:40', '2025-12-12 07:37:21', 'COMPLETED'),
(23, 'CPDA-6901DF60AFD7C', '2025-10-29', '1101', 'Dr. Priya Sharma', 'priya.sharma@nitj.ac.in', '987654321', 'faculty', 'Computer Science & Engg.', '13A2', '2012-09-01', 'saa', 'a', NULL, '', NULL, 'DRAFT', NULL, NULL, '2025-10-29 09:33:20', '2025-12-12 09:27:35', NULL),
(24, 'CPDA-6901DF9B34794', '2025-10-29', '1101', 'Dr. Priya Sharma', 'priya.sharma@nitj.ac.in', '987654321', 'faculty', 'Computer Science & Engg.', '13A2', '2012-09-01', 'jhhj', 'bb\r\n', NULL, '', NULL, 'DRAFT', NULL, NULL, '2025-10-29 09:34:19', '2025-12-12 09:26:38', NULL),
(25, 'CPDA-6904F2D295F91', '2025-10-31', '1101', 'Dr. Priya Sharma', 'priya.sharma@nitj.ac.in', '987654321', 'faculty', 'Computer Science & Engg.', '13A2', '2012-09-01', 'a', '', NULL, '', NULL, 'SUBMITTED', NULL, NULL, '2025-10-31 17:33:06', '2025-12-12 07:37:38', 'HOD_REVIEW'),
(26, 'CPDA-693BB2420B501', '2025-12-12', '1101', 'Dr. Priya Sharma', 'priya.sharma@nitj.ac.in', '987654321', 'faculty', 'Computer Science & Engg.', '13A2', '2012-09-01', 'k', 'h', NULL, 'g', NULL, 'SUBMITTED', NULL, NULL, '2025-12-12 06:12:18', '2025-12-12 07:37:45', 'HOD_REVIEW'),
(27, 'CPDA-693BD2441D4B4', '2025-12-12', '1101', 'Dr. Priya Sharma', 'priya.sharma@nitj.ac.in', '987654321', 'faculty', 'Computer Science & Engg.', '13A2', '2012-09-01', 'fin', 'sin', NULL, 'weroiewroi', NULL, 'DIRECTOR_APPROVED', NULL, NULL, '2025-12-12 08:28:52', '2025-12-12 08:56:14', 'COMPLETED');

-- --------------------------------------------------------

--
-- Table structure for table `cpda_event_applications`
--

CREATE TABLE `cpda_event_applications` (
  `application_id` int(11) NOT NULL,
  `ref_number` varchar(50) NOT NULL,
  `employee_code` int(11) NOT NULL,
  `faculty_name` varchar(255) NOT NULL,
  `designation_hag` tinyint(1) DEFAULT 0,
  `designation_professor` tinyint(1) DEFAULT 0,
  `designation_associate_professor` tinyint(1) DEFAULT 0,
  `designation_assistant_professor` tinyint(1) DEFAULT 0,
  `pay_level` varchar(20) NOT NULL,
  `department` varchar(255) NOT NULL,
  `date_of_joining` date NOT NULL,
  `nature_of_event` varchar(255) NOT NULL,
  `title_of_event` text NOT NULL,
  `period_of_event` varchar(255) NOT NULL,
  `working_days_involved` int(11) NOT NULL,
  `venue_of_event` text NOT NULL,
  `paper_title` text DEFAULT NULL,
  `paper_authors` text DEFAULT NULL,
  `no_objection_details` text DEFAULT NULL,
  `abstract_attachment` varchar(255) DEFAULT NULL,
  `expense_registration_fee` decimal(10,2) DEFAULT 0.00,
  `expense_visa_fee` decimal(10,2) DEFAULT 0.00,
  `expense_insurance_fee` decimal(10,2) DEFAULT 0.00,
  `expense_air_fare` decimal(10,2) DEFAULT 0.00,
  `expense_local_travel` decimal(10,2) DEFAULT 0.00,
  `expense_da_per_diem` decimal(10,2) DEFAULT 0.00,
  `expense_boarding_lodging` decimal(10,2) DEFAULT 0.00,
  `expense_other_details` text DEFAULT NULL,
  `expense_other_amount` decimal(10,2) DEFAULT 0.00,
  `expense_total` decimal(10,2) DEFAULT 0.00,
  `event_during_holidays` enum('YES','NO') NOT NULL,
  `institute_arrangement_attachment` varchar(255) DEFAULT NULL,
  `attended_abroad_current_block` enum('YES','NO') NOT NULL,
  `previous_event_name` text DEFAULT NULL,
  `previous_event_dates` varchar(255) DEFAULT NULL,
  `previous_event_venues` text DEFAULT NULL,
  `application_status` enum('DRAFT','SUBMITTED','HOD_APPROVED','HOD_REJECTED','ACCOUNTS_APPROVED','ACCOUNTS_REJECTED','DFW_APPROVED','DFW_REJECTED','DIRECTOR_APPROVED','DIRECTOR_REJECTED','COMPLETED') DEFAULT 'DRAFT',
  `submission_date` datetime DEFAULT NULL,
  `last_updated` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `sanctioned_amount` decimal(10,2) DEFAULT NULL,
  `disbursement_status` enum('PENDING','PARTIAL','COMPLETED') DEFAULT 'PENDING',
  `disbursed_amount` decimal(10,2) DEFAULT 0.00,
  `disbursement_date` datetime DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `current_stage` enum('HOD_REVIEW','DA_REVIEW','ASS_REVIEW','DFW_REVIEW','DIRECTOR_REVIEW','COMPLETED') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `cpda_event_applications`
--

INSERT INTO `cpda_event_applications` (`application_id`, `ref_number`, `employee_code`, `faculty_name`, `designation_hag`, `designation_professor`, `designation_associate_professor`, `designation_assistant_professor`, `pay_level`, `department`, `date_of_joining`, `nature_of_event`, `title_of_event`, `period_of_event`, `working_days_involved`, `venue_of_event`, `paper_title`, `paper_authors`, `no_objection_details`, `abstract_attachment`, `expense_registration_fee`, `expense_visa_fee`, `expense_insurance_fee`, `expense_air_fare`, `expense_local_travel`, `expense_da_per_diem`, `expense_boarding_lodging`, `expense_other_details`, `expense_other_amount`, `expense_total`, `event_during_holidays`, `institute_arrangement_attachment`, `attended_abroad_current_block`, `previous_event_name`, `previous_event_dates`, `previous_event_venues`, `application_status`, `submission_date`, `last_updated`, `sanctioned_amount`, `disbursement_status`, `disbursed_amount`, `disbursement_date`, `created_at`, `updated_at`, `current_stage`) VALUES
(1, 'CPDA-EVT-25-000001', 1101, 'Dr. Priya Sharma', 0, 0, 0, 0, '13A2', 'Computer Science & Engg.', '2012-09-01', 'd', 'f', '34', 3, 'f', '', '', '', NULL, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, '', 0.00, 0.00, 'YES', NULL, 'NO', '', '', '', 'HOD_APPROVED', '2025-10-31 18:06:48', '2025-12-12 13:10:51', NULL, 'PENDING', 0.00, NULL, '2025-10-31 12:36:48', '2025-12-12 07:40:51', 'DA_REVIEW'),
(2, 'CPDA-EVT-25-000002', 1101, 'Dr. Priya Sharma', 0, 0, 0, 0, '13A2', 'Computer Science & Engg.', '2012-09-01', 'harry', 'sik', 'js', 98, 'jk', 'sss', 's', 'ss', 'CPDA-EVT-25-000002_abstract_1761914346.pdf', 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, '', 6767676.00, 6767676.00, 'NO', 'CPDA-EVT-25-000002_arrangement_1761914346.pdf', 'YES', 'z', '1u', 'bat', 'DIRECTOR_APPROVED', '2025-10-31 18:09:06', '2025-12-12 15:03:34', 897.00, 'PENDING', 0.00, NULL, '2025-10-31 12:39:06', '2025-12-12 09:33:34', 'COMPLETED'),
(3, 'CPDA-EVT-25-000003', 1101, 'Dr. Priya Sharma', 0, 0, 0, 1, '13A2', 'Computer Science & Engg.', '2012-09-01', 'kjhh', 'mn', '5-6 dec', 5, 'mnb', 'hj', 'yugu', 'tyc', 'CPDA-EVT-25-000003_abstract_1765528308.pdf', 564.00, 64.00, 513.00, 98.00, 132.00, 87.00, 32.00, '', 65.00, 1555.00, 'YES', NULL, 'NO', 'nb', 'nm', '', 'COMPLETED', '2025-12-12 14:01:48', '2025-12-12 14:54:37', 7878.00, 'PENDING', 0.00, NULL, '2025-12-12 08:31:48', '2025-12-12 09:24:37', 'COMPLETED');

-- --------------------------------------------------------

--
-- Table structure for table `cpda_event_attachments`
--

CREATE TABLE `cpda_event_attachments` (
  `id` int(11) NOT NULL,
  `application_id` int(11) NOT NULL,
  `attachment_type` enum('ABSTRACT','INSTITUTE_ARRANGEMENT','NO_OBJECTION_CERTIFICATE','ACCEPTANCE_LETTER','OTHER') NOT NULL,
  `file_name` varchar(255) NOT NULL,
  `file_path` varchar(500) NOT NULL,
  `file_size` int(11) DEFAULT NULL,
  `file_type` varchar(100) DEFAULT NULL,
  `uploaded_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `uploaded_by` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `cpda_event_attachments`
--

INSERT INTO `cpda_event_attachments` (`id`, `application_id`, `attachment_type`, `file_name`, `file_path`, `file_size`, `file_type`, `uploaded_at`, `uploaded_by`) VALUES
(1, 2, 'ABSTRACT', 'F-2.pdf', 'CPDA-EVT-25-000002_abstract_1761914346.pdf', 444303, 'application/pdf', '2025-10-31 12:39:06', '1101'),
(2, 2, 'INSTITUTE_ARRANGEMENT', 'F-4.pdf', 'CPDA-EVT-25-000002_arrangement_1761914346.pdf', 229514, 'application/pdf', '2025-10-31 12:39:06', '1101'),
(3, 3, 'ABSTRACT', 'F-5.pdf', 'CPDA-EVT-25-000003_abstract_1765528308.pdf', 298045, 'application/pdf', '2025-12-12 08:31:48', '1101');

-- --------------------------------------------------------

--
-- Table structure for table `cpda_recommendation`
--

CREATE TABLE `cpda_recommendation` (
  `recommendation_id` int(11) NOT NULL,
  `application_ref_number` varchar(100) NOT NULL,
  `amount_available` decimal(12,2) DEFAULT NULL,
  `amount_recommended` decimal(12,2) DEFAULT NULL,
  `recommendation_date` datetime DEFAULT current_timestamp(),
  `comments` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `cpda_recommendation`
--

INSERT INTO `cpda_recommendation` (`recommendation_id`, `application_ref_number`, `amount_available`, `amount_recommended`, `recommendation_date`, `comments`) VALUES
(1, 'CPDA-693BD2441D4B4', 879.00, 544.00, '2025-12-12 14:10:14', NULL),
(2, 'CPDA-693BD2441D4B4', 5654.00, 78.00, '2025-12-12 14:25:52', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `cpda_register_entries`
--

CREATE TABLE `cpda_register_entries` (
  `register_id` int(11) NOT NULL,
  `application_id` int(11) NOT NULL,
  `register_page_number` int(11) DEFAULT NULL,
  `register_serial_number` int(11) DEFAULT NULL,
  `entry_date` date DEFAULT NULL,
  `entered_by` varchar(200) DEFAULT NULL,
  `dealing_assistant_signature` tinyint(1) DEFAULT 0,
  `private_secretary_signature` tinyint(1) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `f4_professional_memberships`
--

CREATE TABLE `f4_professional_memberships` (
  `id` int(11) NOT NULL,
  `application_id` int(11) NOT NULL,
  `professional_body_name` varchar(255) NOT NULL,
  `membership_amount` decimal(10,2) NOT NULL,
  `membership_type` enum('NATIONAL','INTERNATIONAL') NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `f4_professional_memberships`
--

INSERT INTO `f4_professional_memberships` (`id`, `application_id`, `professional_body_name`, `membership_amount`, `membership_type`, `created_at`) VALUES
(1, 1, 'd', 34.00, 'NATIONAL', '2025-10-31 17:18:37'),
(2, 1, 'dsf', 324.00, 'INTERNATIONAL', '2025-10-31 17:18:37'),
(3, 2, 'dfsssss', 1111.00, 'NATIONAL', '2025-10-31 17:21:45'),
(4, 4, 'da', 33.00, 'INTERNATIONAL', '2025-10-31 17:22:49');

-- --------------------------------------------------------

--
-- Table structure for table `f4_reimbursement_applications`
--

CREATE TABLE `f4_reimbursement_applications` (
  `application_id` int(11) NOT NULL,
  `ref_number` varchar(50) NOT NULL,
  `employee_code` int(11) NOT NULL,
  `faculty_name` varchar(255) NOT NULL,
  `designation_hag` tinyint(1) DEFAULT 0,
  `designation_professor` tinyint(1) DEFAULT 0,
  `designation_associate_professor` tinyint(1) DEFAULT 0,
  `designation_assistant_professor` tinyint(1) DEFAULT 0,
  `pay_level` varchar(20) NOT NULL,
  `department` varchar(255) NOT NULL,
  `total_amount` decimal(10,2) DEFAULT 0.00,
  `expense_books` decimal(10,2) DEFAULT 0.00,
  `expense_stationary` decimal(10,2) DEFAULT 0.00,
  `expense_patent` decimal(10,2) DEFAULT 0.00,
  `expense_computer_consumables` decimal(10,2) DEFAULT 0.00,
  `expense_consumables` decimal(10,2) DEFAULT 0.00,
  `expense_synthesis_analysis` decimal(10,2) DEFAULT 0.00,
  `remarks` text DEFAULT NULL,
  `application_status` enum('DRAFT','SUBMITTED','UNDER_REVIEW','HOD_APPROVED','HOD_REJECTED','AR_APPROVED','AR_REJECTED') DEFAULT 'DRAFT',
  `submission_date` datetime DEFAULT NULL,
  `last_updated` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `hod_approval_status` enum('PENDING','APPROVED','REJECTED') DEFAULT 'PENDING',
  `hod_approval_date` datetime DEFAULT NULL,
  `hod_remarks` text DEFAULT NULL,
  `hod_approved_by` varchar(50) DEFAULT NULL,
  `ar_approval_status` enum('PENDING','APPROVED','REJECTED') DEFAULT 'PENDING',
  `ar_approval_date` datetime DEFAULT NULL,
  `ar_remarks` text DEFAULT NULL,
  `ar_approved_by` varchar(50) DEFAULT NULL,
  `sanctioned_amount` decimal(10,2) DEFAULT NULL,
  `disbursement_status` enum('PENDING','PARTIAL','COMPLETED') DEFAULT 'PENDING',
  `disbursed_amount` decimal(10,2) DEFAULT 0.00,
  `disbursement_date` datetime DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `f4_reimbursement_applications`
--

INSERT INTO `f4_reimbursement_applications` (`application_id`, `ref_number`, `employee_code`, `faculty_name`, `designation_hag`, `designation_professor`, `designation_associate_professor`, `designation_assistant_professor`, `pay_level`, `department`, `total_amount`, `expense_books`, `expense_stationary`, `expense_patent`, `expense_computer_consumables`, `expense_consumables`, `expense_synthesis_analysis`, `remarks`, `application_status`, `submission_date`, `last_updated`, `hod_approval_status`, `hod_approval_date`, `hod_remarks`, `hod_approved_by`, `ar_approval_status`, `ar_approval_date`, `ar_remarks`, `ar_approved_by`, `sanctioned_amount`, `disbursement_status`, `disbursed_amount`, `disbursement_date`, `created_at`, `updated_at`) VALUES
(1, 'F4/2025/00001', 1101, 'Dr. Priya Sharma', 0, 0, 0, 0, '13', 'Computer Science & Engg.', 43588.00, 340.00, 550.00, 33330.00, 230.00, 3240.00, 5540.00, '', 'SUBMITTED', '2025-10-31 22:48:37', '2025-10-31 22:48:37', 'PENDING', NULL, NULL, NULL, 'PENDING', NULL, NULL, NULL, NULL, 'PENDING', 0.00, NULL, '2025-10-31 17:18:37', '2025-10-31 17:18:37'),
(2, 'F4/2025/00002', 1101, 'Dr. Priya Sharma', 0, 0, 0, 0, '13', 'Computer Science & Engg.', 44341.00, 340.00, 550.00, 33330.00, 230.00, 3240.00, 5540.00, '', 'AR_APPROVED', '2025-10-31 22:51:45', '2025-11-04 20:50:39', 'APPROVED', '2025-11-04 20:48:51', 'd', '1110', 'APPROVED', '2025-11-04 20:50:39', 'hj', '1114', 44341.00, 'PENDING', 0.00, NULL, '2025-10-31 17:21:45', '2025-11-04 15:20:39'),
(3, 'F4/2025/00003', 1101, 'Dr. Priya Sharma', 0, 0, 0, 0, '13', 'Computer Science & Engg.', 43230.00, 340.00, 550.00, 33330.00, 230.00, 3240.00, 5540.00, '', 'AR_APPROVED', '2025-10-31 22:52:32', '2025-10-31 23:55:00', 'APPROVED', '2025-10-31 23:30:41', 'm', '1110', 'APPROVED', '2025-10-31 23:55:00', 'okk', '1114', 43230.00, 'PENDING', 0.00, NULL, '2025-10-31 17:22:32', '2025-10-31 18:25:00'),
(4, 'F4/2025/00004', 1101, 'Dr. Priya Sharma', 0, 0, 0, 0, '13', 'Computer Science & Engg.', 43263.00, 340.00, 550.00, 33330.00, 230.00, 3240.00, 5540.00, '', 'SUBMITTED', '2025-10-31 22:52:49', '2025-10-31 22:52:49', 'PENDING', NULL, NULL, NULL, 'PENDING', NULL, NULL, NULL, NULL, 'PENDING', 0.00, NULL, '2025-10-31 17:22:49', '2025-10-31 17:22:49'),
(5, 'F4/2025/00005', 1101, 'Dr. Priya Sharma', 0, 0, 0, 0, '13', 'Computer Science & Engg.', 43230.00, 340.00, 550.00, 33330.00, 230.00, 3240.00, 5540.00, '', 'AR_REJECTED', '2025-10-31 22:53:17', '2025-10-31 23:55:56', 'APPROVED', '2025-10-31 23:30:27', 'm', '1110', 'REJECTED', '2025-10-31 23:55:56', 'z', '1114', 0.00, 'PENDING', 0.00, NULL, '2025-10-31 17:23:17', '2025-10-31 18:25:56'),
(6, 'F4/2025/00006', 1101, 'Dr. Priya Sharma', 0, 0, 0, 0, '13', 'Computer Science & Engg.', 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, '', 'SUBMITTED', '2025-10-31 23:02:55', '2025-10-31 23:02:55', 'PENDING', NULL, NULL, NULL, 'PENDING', NULL, NULL, NULL, NULL, 'PENDING', 0.00, NULL, '2025-10-31 17:32:55', '2025-10-31 17:32:55'),
(7, 'F4/2025/00007', 1101, 'Dr. Priya Sharma', 0, 0, 0, 0, '13', 'Computer Science & Engg.', 247.00, 75.00, 98.00, 32.00, 0.00, 32.00, 10.00, 'mnb', 'HOD_APPROVED', '2025-12-12 14:02:27', '2025-12-12 14:07:11', 'APPROVED', '2025-12-12 14:07:11', '65645654', '1110', 'PENDING', NULL, NULL, NULL, NULL, 'PENDING', 0.00, NULL, '2025-12-12 08:32:27', '2025-12-12 08:37:11');

-- --------------------------------------------------------

--
-- Table structure for table `f4_reimbursement_attachments`
--

CREATE TABLE `f4_reimbursement_attachments` (
  `id` int(11) NOT NULL,
  `application_id` int(11) NOT NULL,
  `attachment_type` enum('BILL','RECEIPT','INVOICE','MEMBERSHIP_PROOF','BOOK_INVOICE','PATENT_DOCUMENT','OTHER') NOT NULL,
  `file_name` varchar(255) NOT NULL,
  `file_path` varchar(500) NOT NULL,
  `file_size` int(11) DEFAULT NULL,
  `file_type` varchar(100) DEFAULT NULL,
  `description` varchar(500) DEFAULT NULL,
  `uploaded_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `uploaded_by` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `f4_reimbursement_attachments`
--

INSERT INTO `f4_reimbursement_attachments` (`id`, `application_id`, `attachment_type`, `file_name`, `file_path`, `file_size`, `file_type`, `description`, `uploaded_at`, `uploaded_by`) VALUES
(1, 6, 'RECEIPT', 'F-5.pdf', '../uploads/f4/2025/F4_2025_00006_1761931975_0.pdf', 298045, 'application/pdf', '', '2025-10-31 17:32:55', '1101'),
(2, 7, 'RECEIPT', 'F-1.pdf', '../uploads/f4/2025/F4_2025_00007_1765528347_0.pdf', 512754, 'application/pdf', '564', '2025-12-12 08:32:27', '1101');

-- --------------------------------------------------------

--
-- Table structure for table `f5_attachments`
--

CREATE TABLE `f5_attachments` (
  `id` int(11) NOT NULL,
  `reimbursement_id` int(11) NOT NULL,
  `attachment_type` enum('REGISTRATION_RECEIPT','VISA_RECEIPT','INSURANCE_RECEIPT','FLIGHT_TICKET','TRAVEL_RECEIPT','HOTEL_BILL','BOARDING_LODGING','CONFERENCE_CERTIFICATE','OTHER') NOT NULL,
  `file_name` varchar(255) NOT NULL,
  `file_path` varchar(500) NOT NULL,
  `file_size` int(11) NOT NULL,
  `file_type` varchar(100) NOT NULL,
  `description` text DEFAULT NULL,
  `uploaded_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `f5_attachments`
--

INSERT INTO `f5_attachments` (`id`, `reimbursement_id`, `attachment_type`, `file_name`, `file_path`, `file_size`, `file_type`, `description`, `uploaded_at`) VALUES
(2, 2, 'REGISTRATION_RECEIPT', 'F-2.pdf', '../uploads/f5_attachments/2_1762268402_0.pdf', 444303, 'application/pdf', '', '2025-11-04 15:00:02'),
(3, 3, 'REGISTRATION_RECEIPT', 'F-5.pdf', '../uploads/f5_attachments/3_1765528408_0.pdf', 298045, 'application/pdf', '', '2025-12-12 08:33:28');

-- --------------------------------------------------------

--
-- Table structure for table `f5_conference_reimbursements`
--

CREATE TABLE `f5_conference_reimbursements` (
  `application_id` int(11) NOT NULL,
  `ref_number` varchar(100) DEFAULT NULL,
  `employee_code` int(11) NOT NULL,
  `faculty_name` varchar(200) NOT NULL,
  `designation` varchar(100) NOT NULL,
  `pay_level` varchar(10) NOT NULL,
  `department` varchar(200) NOT NULL,
  `activity_nature` enum('International Conference','National Conference','Workshop','Short Term Course','Seminar','Symposium') NOT NULL,
  `activity_name` varchar(500) NOT NULL,
  `activity_start_date` date NOT NULL,
  `activity_end_date` date NOT NULL,
  `activity_venue` varchar(300) NOT NULL,
  `location_type` enum('India','Abroad') NOT NULL,
  `expense_registration` decimal(10,2) DEFAULT 0.00,
  `expense_visa` decimal(10,2) DEFAULT 0.00,
  `expense_insurance` decimal(10,2) DEFAULT 0.00,
  `expense_air_fare` decimal(10,2) DEFAULT 0.00,
  `expense_local_travel` decimal(10,2) DEFAULT 0.00,
  `expense_da_per_diem` decimal(10,2) DEFAULT 0.00,
  `expense_boarding_lodging` decimal(10,2) DEFAULT 0.00,
  `expense_other` decimal(10,2) DEFAULT 0.00,
  `expense_other_description` text DEFAULT NULL,
  `total_amount` decimal(10,2) NOT NULL,
  `remarks` text DEFAULT NULL,
  `status` enum('PENDING','HOD_APPROVED','HOD_REJECTED','ACCOUNTS_APPROVED','ACCOUNTS_REJECTED','COMPLETED') DEFAULT 'PENDING',
  `hod_status` enum('PENDING','APPROVED','REJECTED') DEFAULT 'PENDING',
  `hod_approved_by` varchar(50) DEFAULT NULL,
  `hod_approved_at` datetime DEFAULT NULL,
  `hod_comments` text DEFAULT NULL,
  `accounts_status` enum('PENDING','APPROVED','REJECTED') DEFAULT 'PENDING',
  `accounts_approved_by` varchar(50) DEFAULT NULL,
  `accounts_approved_at` datetime DEFAULT NULL,
  `accounts_comments` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `f5_conference_reimbursements`
--

INSERT INTO `f5_conference_reimbursements` (`application_id`, `ref_number`, `employee_code`, `faculty_name`, `designation`, `pay_level`, `department`, `activity_nature`, `activity_name`, `activity_start_date`, `activity_end_date`, `activity_venue`, `location_type`, `expense_registration`, `expense_visa`, `expense_insurance`, `expense_air_fare`, `expense_local_travel`, `expense_da_per_diem`, `expense_boarding_lodging`, `expense_other`, `expense_other_description`, `total_amount`, `remarks`, `status`, `hod_status`, `hod_approved_by`, `hod_approved_at`, `hod_comments`, `accounts_status`, `accounts_approved_by`, `accounts_approved_at`, `accounts_comments`, `created_at`, `updated_at`) VALUES
(2, 'CPDA/F5/2025/690a14f2c1de0', 1101, 'Dr. Priya Sharma', 'faculty', '13A2', 'Computer Science & Engg.', 'Workshop', 'dsf', '2025-11-28', '2025-11-29', 'asd', 'India', 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, '', 0.00, '', 'ACCOUNTS_REJECTED', 'APPROVED', '1110', '2025-11-04 20:55:19', 'sd', 'REJECTED', '1114', '2025-11-04 20:58:29', 'd', '2025-11-04 15:00:02', '2025-11-04 15:28:29'),
(3, 'CPDA/F5/2025/693bd358c3bbb', 1101, 'Dr. Priya Sharma', 'faculty', '13A2', 'Computer Science & Engg.', 'National Conference', 'oiuu', '2025-12-04', '2025-12-10', 'n', 'India', 650.00, 8.00, 45.00, 89.00, 78.00, 21.00, 78.00, 98.00, '', 1067.00, '564', 'HOD_APPROVED', 'APPROVED', '1110', '2025-12-12 14:07:20', '98645-+-+', 'PENDING', NULL, NULL, NULL, '2025-12-12 08:33:28', '2025-12-12 08:37:20');

-- --------------------------------------------------------

--
-- Table structure for table `fdx_electronic_devices`
--

CREATE TABLE `fdx_electronic_devices` (
  `Device_ID` int(11) NOT NULL,
  `Application_ID` varchar(50) NOT NULL,
  `S_No` varchar(10) NOT NULL,
  `Item_Description` varchar(255) NOT NULL,
  `Date_of_Issue` date DEFAULT NULL,
  `Cost_at_Time_of_Issue` decimal(10,2) DEFAULT NULL,
  `Created_At` timestamp NOT NULL DEFAULT current_timestamp(),
  `Updated_At` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `fdx_electronic_devices`
--

INSERT INTO `fdx_electronic_devices` (`Device_ID`, `Application_ID`, `S_No`, `Item_Description`, `Date_of_Issue`, `Cost_at_Time_of_Issue`, `Created_At`, `Updated_At`) VALUES
(3, '4', '1', 'gfd', '2025-10-24', 3545.00, '2025-10-29 18:51:15', '2025-10-29 18:51:15'),
(4, '4', '2', 'fhgh', '2025-10-14', 5646.00, '2025-10-29 18:51:15', '2025-10-29 18:51:15');

-- --------------------------------------------------------

--
-- Table structure for table `fdx_expenditure_main`
--

CREATE TABLE `fdx_expenditure_main` (
  `Application_ID` varchar(50) NOT NULL,
  `P1_Conferences_Y1_2021_22_Num_Events` int(11) DEFAULT NULL,
  `P1_Conferences_Y1_2021_22_Amt_Spent` decimal(10,2) DEFAULT NULL,
  `P1_Conferences_Y1_2021_22_Amt_Committed` decimal(10,2) DEFAULT NULL,
  `P1_Conferences_Y1_2021_22_Balance` decimal(10,2) DEFAULT NULL,
  `P1_Conferences_Y2_2022_23_Num_Events` int(11) DEFAULT NULL,
  `P1_Conferences_Y2_2022_23_Amt_Spent` decimal(10,2) DEFAULT NULL,
  `P1_Conferences_Y2_2022_23_Amt_Committed` decimal(10,2) DEFAULT NULL,
  `P1_Conferences_Y2_2022_23_Balance` decimal(10,2) DEFAULT NULL,
  `P1_Conferences_Y3_2023_24_Num_Events` int(11) DEFAULT NULL,
  `P1_Conferences_Y3_2023_24_Amt_Spent` decimal(10,2) DEFAULT NULL,
  `P1_Conferences_Y3_2023_24_Amt_Committed` decimal(10,2) DEFAULT NULL,
  `P1_Conferences_Y3_2023_24_Balance` decimal(10,2) DEFAULT NULL,
  `P2_Membership_Y1_2021_22_Num_Availed` int(11) DEFAULT NULL,
  `P2_Membership_Y1_2021_22_Amt_Spent` decimal(10,2) DEFAULT NULL,
  `P2_Membership_Y1_2021_22_Amt_Committed` decimal(10,2) DEFAULT NULL,
  `P2_Membership_Y1_2021_22_Balance` decimal(10,2) DEFAULT NULL,
  `P2_Membership_Y2_2022_23_Num_Availed` int(11) DEFAULT NULL,
  `P2_Membership_Y2_2022_23_Amt_Spent` decimal(10,2) DEFAULT NULL,
  `P2_Membership_Y2_2022_23_Amt_Committed` decimal(10,2) DEFAULT NULL,
  `P2_Membership_Y2_2022_23_Balance` decimal(10,2) DEFAULT NULL,
  `P2_Membership_Y3_2023_24_Num_Availed` int(11) DEFAULT NULL,
  `P2_Membership_Y3_2023_24_Amt_Spent` decimal(10,2) DEFAULT NULL,
  `P2_Membership_Y3_2023_24_Amt_Committed` decimal(10,2) DEFAULT NULL,
  `P2_Membership_Y3_2023_24_Balance` decimal(10,2) DEFAULT NULL,
  `P3a_Consumables_Num_Availed` int(11) DEFAULT NULL,
  `P3a_Consumables_Amt_Spent` decimal(10,2) DEFAULT NULL,
  `P3a_Consumables_Amt_Committed` decimal(10,2) DEFAULT NULL,
  `P3a_Consumables_Balance` decimal(10,2) DEFAULT NULL,
  `P3b_Synthesis_Testing_Num_Availed` int(11) DEFAULT NULL,
  `P3b_Synthesis_Testing_Amt_Spent` decimal(10,2) DEFAULT NULL,
  `P3b_Synthesis_Testing_Amt_Committed` decimal(10,2) DEFAULT NULL,
  `P3b_Synthesis_Testing_Balance` decimal(10,2) DEFAULT NULL,
  `P3c_i_Stationary_Num_Availed` int(11) DEFAULT NULL,
  `P3c_i_Stationary_Amt_Spent` decimal(10,2) DEFAULT NULL,
  `P3c_i_Stationary_Amt_Committed` decimal(10,2) DEFAULT NULL,
  `P3c_i_Stationary_Balance` decimal(10,2) DEFAULT NULL,
  `P3c_ii_Books_Num_Availed` int(11) DEFAULT NULL,
  `P3c_ii_Books_Amt_Spent` decimal(10,2) DEFAULT NULL,
  `P3c_ii_Books_Amt_Committed` decimal(10,2) DEFAULT NULL,
  `P3c_ii_Books_Balance` decimal(10,2) DEFAULT NULL,
  `P3d_Computer_Consumables_Num_Availed` int(11) DEFAULT NULL,
  `P3d_Computer_Consumables_Amt_Spent` decimal(10,2) DEFAULT NULL,
  `P3d_Computer_Consumables_Amt_Committed` decimal(10,2) DEFAULT NULL,
  `P3d_Computer_Consumables_Balance` decimal(10,2) DEFAULT NULL,
  `Created_At` timestamp NOT NULL DEFAULT current_timestamp(),
  `Updated_At` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `fdx_expenditure_main`
--

INSERT INTO `fdx_expenditure_main` (`Application_ID`, `P1_Conferences_Y1_2021_22_Num_Events`, `P1_Conferences_Y1_2021_22_Amt_Spent`, `P1_Conferences_Y1_2021_22_Amt_Committed`, `P1_Conferences_Y1_2021_22_Balance`, `P1_Conferences_Y2_2022_23_Num_Events`, `P1_Conferences_Y2_2022_23_Amt_Spent`, `P1_Conferences_Y2_2022_23_Amt_Committed`, `P1_Conferences_Y2_2022_23_Balance`, `P1_Conferences_Y3_2023_24_Num_Events`, `P1_Conferences_Y3_2023_24_Amt_Spent`, `P1_Conferences_Y3_2023_24_Amt_Committed`, `P1_Conferences_Y3_2023_24_Balance`, `P2_Membership_Y1_2021_22_Num_Availed`, `P2_Membership_Y1_2021_22_Amt_Spent`, `P2_Membership_Y1_2021_22_Amt_Committed`, `P2_Membership_Y1_2021_22_Balance`, `P2_Membership_Y2_2022_23_Num_Availed`, `P2_Membership_Y2_2022_23_Amt_Spent`, `P2_Membership_Y2_2022_23_Amt_Committed`, `P2_Membership_Y2_2022_23_Balance`, `P2_Membership_Y3_2023_24_Num_Availed`, `P2_Membership_Y3_2023_24_Amt_Spent`, `P2_Membership_Y3_2023_24_Amt_Committed`, `P2_Membership_Y3_2023_24_Balance`, `P3a_Consumables_Num_Availed`, `P3a_Consumables_Amt_Spent`, `P3a_Consumables_Amt_Committed`, `P3a_Consumables_Balance`, `P3b_Synthesis_Testing_Num_Availed`, `P3b_Synthesis_Testing_Amt_Spent`, `P3b_Synthesis_Testing_Amt_Committed`, `P3b_Synthesis_Testing_Balance`, `P3c_i_Stationary_Num_Availed`, `P3c_i_Stationary_Amt_Spent`, `P3c_i_Stationary_Amt_Committed`, `P3c_i_Stationary_Balance`, `P3c_ii_Books_Num_Availed`, `P3c_ii_Books_Amt_Spent`, `P3c_ii_Books_Amt_Committed`, `P3c_ii_Books_Balance`, `P3d_Computer_Consumables_Num_Availed`, `P3d_Computer_Consumables_Amt_Spent`, `P3d_Computer_Consumables_Amt_Committed`, `P3d_Computer_Consumables_Balance`, `Created_At`, `Updated_At`) VALUES
('12', 12, 34.00, 23.00, 9.00, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-10-29 18:24:42', '2025-10-29 18:24:42'),
('23', 0, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, '2025-10-29 18:49:40', '2025-10-29 18:50:16'),
('24', 0, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, '2025-10-29 18:48:36', '2025-10-29 18:48:42'),
('4', 211, 0.00, 0.00, 0.00, 545, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, '2025-10-29 18:51:15', '2025-10-29 18:51:15');

-- --------------------------------------------------------

--
-- Table structure for table `issued_devices`
--

CREATE TABLE `issued_devices` (
  `device_id` int(11) NOT NULL,
  `application_id` int(11) NOT NULL,
  `employee_code` varchar(50) NOT NULL,
  `item_name` varchar(200) NOT NULL,
  `device_type` enum('LAPTOP','TABLET','NOTEBOOK','OTHER_ELECTRONIC') DEFAULT NULL,
  `date_of_issue` date DEFAULT NULL,
  `cost_at_issue` decimal(10,2) DEFAULT NULL,
  `serial_number` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `membership_expenditure`
--

CREATE TABLE `membership_expenditure` (
  `expenditure_id` int(11) NOT NULL,
  `application_id` int(11) NOT NULL,
  `block_year` int(11) NOT NULL,
  `financial_year` varchar(10) DEFAULT NULL,
  `number_availed` int(11) DEFAULT 0,
  `amount_spent` decimal(10,2) DEFAULT 0.00,
  `amount_committed` decimal(10,2) DEFAULT 0.00,
  `max_memberships_per_year` int(11) DEFAULT 3,
  `balance_amount` decimal(10,2) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `notifications`
--

CREATE TABLE `notifications` (
  `notification_id` int(11) NOT NULL,
  `application_id` int(11) NOT NULL,
  `recipient_role` varchar(100) DEFAULT NULL,
  `recipient_email` varchar(100) DEFAULT NULL,
  `notification_type` enum('SUBMISSION','APPROVAL_REQUIRED','APPROVED','REJECTED','REMINDER') DEFAULT NULL,
  `message` text DEFAULT NULL,
  `is_read` tinyint(1) DEFAULT 0,
  `sent_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `pda_expenditure_tracking`
--

CREATE TABLE `pda_expenditure_tracking` (
  `id` int(11) NOT NULL,
  `application_id` int(11) DEFAULT NULL,
  `employee_code` varchar(50) NOT NULL,
  `block_year` varchar(15) NOT NULL,
  `category` varchar(100) NOT NULL,
  `number_availed` int(11) DEFAULT 0,
  `no_of_events` int(11) DEFAULT 0,
  `amount_spent` decimal(12,2) DEFAULT 0.00,
  `amount_committed` decimal(12,2) DEFAULT 0.00,
  `balance_as_on_date` decimal(12,2) DEFAULT 0.00,
  `created_by` varchar(50) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `professional_memberships`
--

CREATE TABLE `professional_memberships` (
  `membership_id` int(11) NOT NULL,
  `application_id` int(11) NOT NULL,
  `professional_body_name` varchar(300) NOT NULL,
  `amount` decimal(10,2) NOT NULL,
  `membership_type` enum('NATIONAL','INTERNATIONAL','BOTH') DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `professional_memberships`
--

INSERT INTO `professional_memberships` (`membership_id`, `application_id`, `professional_body_name`, `amount`, `membership_type`, `created_at`) VALUES
(1, 4, 'sd', 2.00, 'NATIONAL', '2025-10-28 14:04:29'),
(2, 4, 'afds', 24.00, 'INTERNATIONAL', '2025-10-28 14:04:29'),
(3, 6, 'd', 33.00, 'NATIONAL', '2025-10-29 08:26:16'),
(4, 7, 'a', 44.00, 'BOTH', '2025-10-29 08:29:06'),
(5, 26, 'j', 665.00, 'NATIONAL', '2025-12-12 06:12:18'),
(6, 27, 'xcv', 45.00, 'NATIONAL', '2025-12-12 08:28:52'),
(7, 27, 'sfdljk', 98.00, 'INTERNATIONAL', '2025-12-12 08:28:52');

-- --------------------------------------------------------

--
-- Table structure for table `status_history`
--

CREATE TABLE `status_history` (
  `history_id` int(11) NOT NULL,
  `application_id` int(11) NOT NULL,
  `previous_status` varchar(50) DEFAULT NULL,
  `new_status` varchar(50) DEFAULT NULL,
  `changed_by` varchar(200) DEFAULT NULL,
  `change_reason` text DEFAULT NULL,
  `changed_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `employee_code` int(11) NOT NULL,
  `name` varchar(100) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `role` varchar(50) DEFAULT NULL,
  `department` varchar(100) DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `mobile_number` varchar(15) DEFAULT NULL,
  `pay_level` varchar(10) DEFAULT NULL,
  `date_of_joining` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`employee_code`, `name`, `email`, `password`, `role`, `department`, `created_at`, `mobile_number`, `pay_level`, `date_of_joining`) VALUES
(1101, 'Dr. Priya Sharma', 'priya.sharma@nitj.ac.in', 'Ps@2025', 'faculty', 'Computer Science & Engg.', '2025-10-23 21:02:16', '987654321', '13A2', '2012-09-01'),
(1102, 'Dr. Vivek Soni', 'vivek.soni@nitj.ac.in', 'Vs#2025', 'faculty', 'Computer Science & Engg.', '2025-10-23 21:02:16', '987654322', '13A2', '2012-09-01'),
(1103, 'Ms. Aditi Rao', 'aditi.rao@nitj.ac.in', 'Ar$2025', 'faculty', 'Computer Science & Engg.', '2025-10-23 21:02:16', '987654323', '13A2', '2012-09-01'),
(1104, 'Dr. Harish Tandon', 'harish.t@nitj.ac.in', 'Ht%2025', 'faculty', 'Computer Science & Engg.', '2025-10-23 21:02:16', '987654324', '13A2', '2012-09-01'),
(1105, 'Dr. Aman Singh', 'aman.singh@nitj.ac.in', 'As#2025', 'faculty', 'Mechanical Engineering', '2025-10-23 21:02:16', '987654325', '13A2', '2012-09-01'),
(1106, 'Dr. Rajesh Kumar', 'rajesh.k@nitj.ac.in', 'Rk$2025', 'faculty', 'Electronics & Comm. Engg.', '2025-10-23 21:02:16', '987654326', '12', '2018-03-20'),
(1107, 'Dr. Sunita Devi', 'sunita.d@nitj.ac.in', 'Sd%2025', 'faculty', 'Physics', '2025-10-23 21:02:16', '987654327', '12', '2018-03-20'),
(1108, 'Dr. Vijay Bansal', 'vijay.b@nitj.ac.in', 'Vb^2025', 'faculty', 'Chemical Engineering', '2025-10-23 21:02:16', '987654328', '12', '2018-03-20'),
(1109, 'Prof. Meena Goel', 'meena.g@nitj.ac.in', 'Mg&2025', 'faculty', 'Civil Engineering', '2025-10-23 21:02:16', '987654329', '12', '2018-03-20'),
(1110, 'Prof. Alok Jain', 'hod.cse@nitj.ac.in', 'Hc$@2025', 'hod', 'Computer Science & Engg.', '2025-10-23 21:02:16', '9876543210', '14A', '2008-07-01'),
(1111, 'Dr. Neeraj Gupta', 'hod.me@nitj.ac.in', 'Hm#@2025', 'hod', 'Mechanical Engineering', '2025-10-23 21:02:16', '9876543211', '14A', '2008-07-01'),
(1112, 'Prof. Kavita Singh', 'hod.ece@nitj.ac.in', 'He%@2025', 'hod', 'Electronics & Comm. Engg.', '2025-10-23 21:02:16', '9876543212', '14A', '2008-07-01'),
(1113, 'Dr. Vineet Aggarwal', 'hod.phy@nitj.ac.in', 'Hp^@2025', 'hod', 'Physics', '2025-10-23 21:02:16', '9876543213', '14A', '2008-07-01'),
(1114, 'Ms. Ritu Verma', 'ar.accounts@nitj.ac.in', 'Ar#Acct', 'accounts_ar', 'Accounts Section', '2025-10-23 21:02:16', '9876543214', '9', '2022-05-01'),
(1115, 'Mr. Suresh Dutt', 'supdt.accounts@nitj.ac.in', 'Sa$Acct', 'accounts_supp.', 'Accounts Section', '2025-10-23 21:02:16', '9876543215', '10', '2022-05-01'),
(1116, 'Ms. Juhi Saini', 'da.accounts@nitj.ac.in', 'Da%Acct', 'accounts_da', 'Accounts Section', '2025-10-23 21:02:16', '9876543216', '9', '2022-05-01'),
(1117, 'Dr. Vikram Sharma', 'adfw@nitj.ac.in', 'Ad@Fw25', 'assoc_dean_fw', 'Faculty Welfare', '2025-10-23 21:02:16', '9876543217', '14A', '2022-05-01'),
(1118, 'Prof. Sameer Roy', 'dean.fw@nitj.ac.in', 'Df!W25', 'dean_fw', 'Faculty Welfare', '2025-10-23 21:02:16', '9876543218', '15', '2008-07-01'),
(1119, 'Ms. Geeta Kaur', 'da.fw@nitj.ac.in', 'da&fw25', 'dfw_da', 'Faculty Welfare', '2025-10-23 21:58:24', '9876543219', '9', '2022-05-01'),
(1120, 'Prof. Anil Kohli', 'director@nitj.ac.in', 'Dir#2025', 'director', 'Administration', '2025-10-23 21:02:16', '9876543220', '15', '2005-01-15');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `accounts_balance`
--
ALTER TABLE `accounts_balance`
  ADD PRIMARY KEY (`balance_id`),
  ADD KEY `idx_application` (`application_id`);

--
-- Indexes for table `application_attachments`
--
ALTER TABLE `application_attachments`
  ADD PRIMARY KEY (`attachment_id`),
  ADD KEY `idx_application` (`application_id`);

--
-- Indexes for table `application_timeline_messages`
--
ALTER TABLE `application_timeline_messages`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_ref_number` (`ref_number`),
  ADD KEY `idx_message_sequence` (`ref_number`,`message_sequence`),
  ADD KEY `idx_sender_identifier` (`sender_identifier`),
  ADD KEY `idx_recipient_identifier` (`recipient_identifier`);

--
-- Indexes for table `approval_workflow`
--
ALTER TABLE `approval_workflow`
  ADD PRIMARY KEY (`workflow_id`),
  ADD KEY `idx_application` (`application_id`),
  ADD KEY `idx_role` (`approver_role`);

--
-- Indexes for table `conference_expenditure`
--
ALTER TABLE `conference_expenditure`
  ADD PRIMARY KEY (`expenditure_id`),
  ADD KEY `idx_application_year` (`application_id`,`block_year`);

--
-- Indexes for table `consumable_items`
--
ALTER TABLE `consumable_items`
  ADD PRIMARY KEY (`item_id`),
  ADD KEY `idx_application` (`application_id`);

--
-- Indexes for table `contingent_expenditure`
--
ALTER TABLE `contingent_expenditure`
  ADD PRIMARY KEY (`expenditure_id`),
  ADD KEY `idx_application_type_year` (`application_id`,`expenditure_type`,`block_year`);

--
-- Indexes for table `cpda_applications`
--
ALTER TABLE `cpda_applications`
  ADD PRIMARY KEY (`application_id`),
  ADD UNIQUE KEY `ref_number` (`ref_number`),
  ADD KEY `idx_employee_code` (`employee_code`),
  ADD KEY `idx_status` (`status`),
  ADD KEY `idx_dated` (`dated`);

--
-- Indexes for table `cpda_event_applications`
--
ALTER TABLE `cpda_event_applications`
  ADD PRIMARY KEY (`application_id`),
  ADD UNIQUE KEY `application_number` (`ref_number`),
  ADD KEY `idx_employee_code` (`employee_code`),
  ADD KEY `idx_application_status` (`application_status`),
  ADD KEY `idx_submission_date` (`submission_date`),
  ADD KEY `idx_application_number` (`ref_number`);

--
-- Indexes for table `cpda_event_attachments`
--
ALTER TABLE `cpda_event_attachments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_application_id` (`application_id`);

--
-- Indexes for table `cpda_recommendation`
--
ALTER TABLE `cpda_recommendation`
  ADD PRIMARY KEY (`recommendation_id`),
  ADD KEY `application_ref_number` (`application_ref_number`);

--
-- Indexes for table `cpda_register_entries`
--
ALTER TABLE `cpda_register_entries`
  ADD PRIMARY KEY (`register_id`),
  ADD KEY `idx_application` (`application_id`);

--
-- Indexes for table `f4_professional_memberships`
--
ALTER TABLE `f4_professional_memberships`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_application_id` (`application_id`);

--
-- Indexes for table `f4_reimbursement_applications`
--
ALTER TABLE `f4_reimbursement_applications`
  ADD PRIMARY KEY (`application_id`),
  ADD UNIQUE KEY `ref_number` (`ref_number`),
  ADD KEY `idx_employee_code` (`employee_code`),
  ADD KEY `idx_application_status` (`application_status`),
  ADD KEY `idx_submission_date` (`submission_date`),
  ADD KEY `idx_ref_number` (`ref_number`);

--
-- Indexes for table `f4_reimbursement_attachments`
--
ALTER TABLE `f4_reimbursement_attachments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_application_id` (`application_id`);

--
-- Indexes for table `f5_attachments`
--
ALTER TABLE `f5_attachments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_reimbursement_id` (`reimbursement_id`),
  ADD KEY `idx_attachment_type` (`attachment_type`);

--
-- Indexes for table `f5_conference_reimbursements`
--
ALTER TABLE `f5_conference_reimbursements`
  ADD PRIMARY KEY (`application_id`),
  ADD UNIQUE KEY `ref_number` (`ref_number`),
  ADD KEY `idx_employee_code` (`employee_code`),
  ADD KEY `idx_status` (`status`),
  ADD KEY `idx_activity_dates` (`activity_start_date`,`activity_end_date`),
  ADD KEY `idx_created_at` (`created_at`);

--
-- Indexes for table `fdx_electronic_devices`
--
ALTER TABLE `fdx_electronic_devices`
  ADD PRIMARY KEY (`Device_ID`),
  ADD KEY `Application_ID` (`Application_ID`);

--
-- Indexes for table `fdx_expenditure_main`
--
ALTER TABLE `fdx_expenditure_main`
  ADD PRIMARY KEY (`Application_ID`);

--
-- Indexes for table `issued_devices`
--
ALTER TABLE `issued_devices`
  ADD PRIMARY KEY (`device_id`),
  ADD KEY `idx_application` (`application_id`),
  ADD KEY `idx_employee` (`employee_code`);

--
-- Indexes for table `membership_expenditure`
--
ALTER TABLE `membership_expenditure`
  ADD PRIMARY KEY (`expenditure_id`),
  ADD KEY `idx_application_year` (`application_id`,`block_year`);

--
-- Indexes for table `notifications`
--
ALTER TABLE `notifications`
  ADD PRIMARY KEY (`notification_id`),
  ADD KEY `idx_application` (`application_id`),
  ADD KEY `idx_recipient` (`recipient_email`,`is_read`);

--
-- Indexes for table `pda_expenditure_tracking`
--
ALTER TABLE `pda_expenditure_tracking`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_emp_block` (`employee_code`,`block_year`),
  ADD KEY `idx_application` (`application_id`);

--
-- Indexes for table `professional_memberships`
--
ALTER TABLE `professional_memberships`
  ADD PRIMARY KEY (`membership_id`),
  ADD KEY `idx_application` (`application_id`);

--
-- Indexes for table `status_history`
--
ALTER TABLE `status_history`
  ADD PRIMARY KEY (`history_id`),
  ADD KEY `idx_application_date` (`application_id`,`changed_at`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`employee_code`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `accounts_balance`
--
ALTER TABLE `accounts_balance`
  MODIFY `balance_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `application_attachments`
--
ALTER TABLE `application_attachments`
  MODIFY `attachment_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `application_timeline_messages`
--
ALTER TABLE `application_timeline_messages`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT for table `approval_workflow`
--
ALTER TABLE `approval_workflow`
  MODIFY `workflow_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `conference_expenditure`
--
ALTER TABLE `conference_expenditure`
  MODIFY `expenditure_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `consumable_items`
--
ALTER TABLE `consumable_items`
  MODIFY `item_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `contingent_expenditure`
--
ALTER TABLE `contingent_expenditure`
  MODIFY `expenditure_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `cpda_applications`
--
ALTER TABLE `cpda_applications`
  MODIFY `application_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;

--
-- AUTO_INCREMENT for table `cpda_event_applications`
--
ALTER TABLE `cpda_event_applications`
  MODIFY `application_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `cpda_event_attachments`
--
ALTER TABLE `cpda_event_attachments`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `cpda_recommendation`
--
ALTER TABLE `cpda_recommendation`
  MODIFY `recommendation_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `cpda_register_entries`
--
ALTER TABLE `cpda_register_entries`
  MODIFY `register_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `f4_professional_memberships`
--
ALTER TABLE `f4_professional_memberships`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `f4_reimbursement_applications`
--
ALTER TABLE `f4_reimbursement_applications`
  MODIFY `application_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `f4_reimbursement_attachments`
--
ALTER TABLE `f4_reimbursement_attachments`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `f5_attachments`
--
ALTER TABLE `f5_attachments`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `f5_conference_reimbursements`
--
ALTER TABLE `f5_conference_reimbursements`
  MODIFY `application_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `fdx_electronic_devices`
--
ALTER TABLE `fdx_electronic_devices`
  MODIFY `Device_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `issued_devices`
--
ALTER TABLE `issued_devices`
  MODIFY `device_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `membership_expenditure`
--
ALTER TABLE `membership_expenditure`
  MODIFY `expenditure_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `notifications`
--
ALTER TABLE `notifications`
  MODIFY `notification_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `pda_expenditure_tracking`
--
ALTER TABLE `pda_expenditure_tracking`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `professional_memberships`
--
ALTER TABLE `professional_memberships`
  MODIFY `membership_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `status_history`
--
ALTER TABLE `status_history`
  MODIFY `history_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `accounts_balance`
--
ALTER TABLE `accounts_balance`
  ADD CONSTRAINT `accounts_balance_ibfk_1` FOREIGN KEY (`application_id`) REFERENCES `cpda_applications` (`application_id`) ON DELETE CASCADE;

--
-- Constraints for table `application_attachments`
--
ALTER TABLE `application_attachments`
  ADD CONSTRAINT `application_attachments_ibfk_1` FOREIGN KEY (`application_id`) REFERENCES `cpda_applications` (`application_id`) ON DELETE CASCADE;

--
-- Constraints for table `approval_workflow`
--
ALTER TABLE `approval_workflow`
  ADD CONSTRAINT `approval_workflow_ibfk_1` FOREIGN KEY (`application_id`) REFERENCES `cpda_applications` (`application_id`) ON DELETE CASCADE;

--
-- Constraints for table `conference_expenditure`
--
ALTER TABLE `conference_expenditure`
  ADD CONSTRAINT `conference_expenditure_ibfk_1` FOREIGN KEY (`application_id`) REFERENCES `cpda_applications` (`application_id`) ON DELETE CASCADE;

--
-- Constraints for table `consumable_items`
--
ALTER TABLE `consumable_items`
  ADD CONSTRAINT `consumable_items_ibfk_1` FOREIGN KEY (`application_id`) REFERENCES `cpda_applications` (`application_id`) ON DELETE CASCADE;

--
-- Constraints for table `contingent_expenditure`
--
ALTER TABLE `contingent_expenditure`
  ADD CONSTRAINT `contingent_expenditure_ibfk_1` FOREIGN KEY (`application_id`) REFERENCES `cpda_applications` (`application_id`) ON DELETE CASCADE;

--
-- Constraints for table `cpda_event_applications`
--
ALTER TABLE `cpda_event_applications`
  ADD CONSTRAINT `cpda_event_applications_ibfk_1` FOREIGN KEY (`employee_code`) REFERENCES `users` (`employee_code`) ON DELETE CASCADE;

--
-- Constraints for table `cpda_event_attachments`
--
ALTER TABLE `cpda_event_attachments`
  ADD CONSTRAINT `cpda_event_attachments_ibfk_1` FOREIGN KEY (`application_id`) REFERENCES `cpda_event_applications` (`application_id`) ON DELETE CASCADE;

--
-- Constraints for table `cpda_recommendation`
--
ALTER TABLE `cpda_recommendation`
  ADD CONSTRAINT `cpda_recommendation_ibfk_1` FOREIGN KEY (`application_ref_number`) REFERENCES `cpda_applications` (`ref_number`);

--
-- Constraints for table `cpda_register_entries`
--
ALTER TABLE `cpda_register_entries`
  ADD CONSTRAINT `cpda_register_entries_ibfk_1` FOREIGN KEY (`application_id`) REFERENCES `cpda_applications` (`application_id`) ON DELETE CASCADE;

--
-- Constraints for table `f4_professional_memberships`
--
ALTER TABLE `f4_professional_memberships`
  ADD CONSTRAINT `f4_professional_memberships_ibfk_1` FOREIGN KEY (`application_id`) REFERENCES `f4_reimbursement_applications` (`application_id`) ON DELETE CASCADE;

--
-- Constraints for table `f4_reimbursement_applications`
--
ALTER TABLE `f4_reimbursement_applications`
  ADD CONSTRAINT `f4_reimbursement_applications_ibfk_1` FOREIGN KEY (`employee_code`) REFERENCES `users` (`employee_code`) ON DELETE CASCADE;

--
-- Constraints for table `f4_reimbursement_attachments`
--
ALTER TABLE `f4_reimbursement_attachments`
  ADD CONSTRAINT `f4_reimbursement_attachments_ibfk_1` FOREIGN KEY (`application_id`) REFERENCES `f4_reimbursement_applications` (`application_id`) ON DELETE CASCADE;

--
-- Constraints for table `f5_attachments`
--
ALTER TABLE `f5_attachments`
  ADD CONSTRAINT `f5_attachments_ibfk_1` FOREIGN KEY (`reimbursement_id`) REFERENCES `f5_conference_reimbursements` (`application_id`) ON DELETE CASCADE;

--
-- Constraints for table `f5_conference_reimbursements`
--
ALTER TABLE `f5_conference_reimbursements`
  ADD CONSTRAINT `f5_conference_reimbursements_ibfk_1` FOREIGN KEY (`employee_code`) REFERENCES `users` (`employee_code`) ON DELETE CASCADE;

--
-- Constraints for table `fdx_electronic_devices`
--
ALTER TABLE `fdx_electronic_devices`
  ADD CONSTRAINT `fdx_electronic_devices_ibfk_1` FOREIGN KEY (`Application_ID`) REFERENCES `fdx_expenditure_main` (`Application_ID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `issued_devices`
--
ALTER TABLE `issued_devices`
  ADD CONSTRAINT `issued_devices_ibfk_1` FOREIGN KEY (`application_id`) REFERENCES `cpda_applications` (`application_id`) ON DELETE CASCADE;

--
-- Constraints for table `membership_expenditure`
--
ALTER TABLE `membership_expenditure`
  ADD CONSTRAINT `membership_expenditure_ibfk_1` FOREIGN KEY (`application_id`) REFERENCES `cpda_applications` (`application_id`) ON DELETE CASCADE;

--
-- Constraints for table `notifications`
--
ALTER TABLE `notifications`
  ADD CONSTRAINT `notifications_ibfk_1` FOREIGN KEY (`application_id`) REFERENCES `cpda_applications` (`application_id`) ON DELETE CASCADE;

--
-- Constraints for table `professional_memberships`
--
ALTER TABLE `professional_memberships`
  ADD CONSTRAINT `professional_memberships_ibfk_1` FOREIGN KEY (`application_id`) REFERENCES `cpda_applications` (`application_id`) ON DELETE CASCADE;

--
-- Constraints for table `status_history`
--
ALTER TABLE `status_history`
  ADD CONSTRAINT `status_history_ibfk_1` FOREIGN KEY (`application_id`) REFERENCES `cpda_applications` (`application_id`) ON DELETE CASCADE;
--
-- Database: `college_erp`
--
CREATE DATABASE IF NOT EXISTS `college_erp` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `college_erp`;

-- --------------------------------------------------------

--
-- Table structure for table `accounts_balance`
--

CREATE TABLE `accounts_balance` (
  `balance_id` int(11) NOT NULL,
  `application_id` int(11) NOT NULL,
  `total_requested_amount` decimal(10,2) DEFAULT NULL,
  `available_balance` decimal(10,2) DEFAULT NULL,
  `budget_head` varchar(100) DEFAULT NULL,
  `balance_confirmed` tinyint(1) DEFAULT 0,
  `confirmed_by` varchar(200) DEFAULT NULL,
  `confirmation_date` datetime DEFAULT NULL,
  `remarks` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `application_attachments`
--

CREATE TABLE `application_attachments` (
  `attachment_id` int(11) NOT NULL,
  `application_id` int(11) NOT NULL,
  `file_name` varchar(255) DEFAULT NULL,
  `file_path` varchar(500) DEFAULT NULL,
  `file_type` varchar(50) DEFAULT NULL,
  `file_size` int(11) DEFAULT NULL,
  `uploaded_by` varchar(200) DEFAULT NULL,
  `uploaded_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `approval_workflow`
--

CREATE TABLE `approval_workflow` (
  `workflow_id` int(11) NOT NULL,
  `application_id` int(11) NOT NULL,
  `approver_role` enum('HOD','ASSISTANT_REGISTRAR_ACCOUNTS','DEALING_ASSISTANT','SUPERINTENDENT_ACCOUNTS','ASSOCIATE_DEAN_FW','DEAN_FW','DIRECTOR') DEFAULT NULL,
  `approver_name` varchar(200) DEFAULT NULL,
  `action` enum('SUBMITTED','RECOMMENDED','NOT_RECOMMENDED','APPROVED','NOT_APPROVED','BALANCE_CONFIRMED','EXAMINED','PENDING') DEFAULT NULL,
  `comments` text DEFAULT NULL,
  `action_date` datetime DEFAULT NULL,
  `signature_captured` tinyint(1) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `approval_workflow`
--

INSERT INTO `approval_workflow` (`workflow_id`, `application_id`, `approver_role`, `approver_name`, `action`, `comments`, `action_date`, `signature_captured`, `created_at`) VALUES
(1, 4, 'HOD', 'Prof. Alok Jain', '', 'okk', '2025-10-29 14:07:32', 0, '2025-10-29 08:37:32'),
(2, 24, 'HOD', 'Prof. Alok Jain', '', 'hjkhj', '2025-10-29 15:05:34', 0, '2025-10-29 09:35:34'),
(3, 17, 'HOD', 'Prof. Alok Jain', '', 'jk', '2025-10-29 15:05:40', 0, '2025-10-29 09:35:40'),
(4, 23, 'HOD', 'Prof. Alok Jain', '', '', '2025-10-29 16:10:37', 0, '2025-10-29 10:40:37'),
(5, 24, 'DEALING_ASSISTANT', 'Ms. Juhi Saini', 'BALANCE_CONFIRMED', 'Expenditure data saved by DA and forwarded to Superintendent', '2025-10-30 00:18:42', 0, '2025-10-29 18:48:42'),
(6, 23, 'DEALING_ASSISTANT', 'Ms. Juhi Saini', 'BALANCE_CONFIRMED', 'Expenditure data saved by DA and forwarded to Superintendent', '2025-10-30 00:20:16', 0, '2025-10-29 18:50:16'),
(7, 4, 'DEALING_ASSISTANT', 'Ms. Juhi Saini', 'BALANCE_CONFIRMED', 'Expenditure data saved by DA and forwarded to Superintendent', '2025-10-30 00:21:15', 0, '2025-10-29 18:51:15'),
(8, 6, 'HOD', 'Prof. Alok Jain', '', '', '2025-10-30 10:13:48', 0, '2025-10-30 04:43:48'),
(9, 9, 'HOD', 'Prof. Alok Jain', '', '', '2025-10-31 11:47:08', 0, '2025-10-31 06:17:08');

-- --------------------------------------------------------

--
-- Table structure for table `conference_expenditure`
--

CREATE TABLE `conference_expenditure` (
  `expenditure_id` int(11) NOT NULL,
  `application_id` int(11) NOT NULL,
  `block_year` int(11) NOT NULL,
  `financial_year` varchar(10) DEFAULT NULL,
  `events_attended_working_days` int(11) DEFAULT 0,
  `amount_spent` decimal(10,2) DEFAULT 0.00,
  `amount_committed` decimal(10,2) DEFAULT 0.00,
  `limit_applicable` decimal(10,2) DEFAULT 210000.00,
  `balance_amount` decimal(10,2) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `consumable_items`
--

CREATE TABLE `consumable_items` (
  `item_id` int(11) NOT NULL,
  `application_id` int(11) NOT NULL,
  `serial_number` int(11) DEFAULT NULL,
  `article_name` varchar(500) NOT NULL,
  `amount` decimal(10,2) NOT NULL,
  `item_category` enum('CHEMICALS','LABORATORY_GLASSWARE','SYNTHESIS_CHARGES','ANALYSIS_CHARGES','STATIONARY','BOOKS','COMPUTER_CONSUMABLES','EXTERNAL_STORAGE','CARTRIDGES','PATENT','OTHER') DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `consumable_items`
--

INSERT INTO `consumable_items` (`item_id`, `application_id`, `serial_number`, `article_name`, `amount`, `item_category`, `created_at`) VALUES
(1, 4, 0, 'sad', 324.00, 'CHEMICALS', '2025-10-28 14:04:29'),
(2, 4, 0, 'adsf234', 234.00, 'BOOKS', '2025-10-28 14:04:29'),
(3, 4, 0, 'tr', 56.00, 'EXTERNAL_STORAGE', '2025-10-28 14:04:29'),
(4, 4, 0, 'ert', 564.00, 'CARTRIDGES', '2025-10-28 14:04:29'),
(5, 6, 0, 'fds', 989.00, 'CARTRIDGES', '2025-10-29 08:26:16'),
(6, 7, 0, 'a', 33.00, 'CHEMICALS', '2025-10-29 08:29:06'),
(7, 17, 0, 'a', 23.00, 'CHEMICALS', '2025-10-29 09:00:40'),
(8, 17, 0, 'g', 232.00, 'PATENT', '2025-10-29 09:00:40'),
(9, 17, 0, 'as', 12.00, 'EXTERNAL_STORAGE', '2025-10-29 09:00:40'),
(10, 23, 1, 'd', 323.00, 'CHEMICALS', '2025-10-29 09:33:20'),
(11, 24, 1, 'jkkj', 15165.00, 'CHEMICALS', '2025-10-29 09:34:19'),
(12, 24, 2, 'hih', 78.00, 'CHEMICALS', '2025-10-29 09:34:19');

-- --------------------------------------------------------

--
-- Table structure for table `contingent_expenditure`
--

CREATE TABLE `contingent_expenditure` (
  `expenditure_id` int(11) NOT NULL,
  `application_id` int(11) NOT NULL,
  `expenditure_type` enum('CONSUMABLES','SYNTHESIS_TESTING','STATIONARY','BOOKS','COMPUTER_CONSUMABLES') DEFAULT NULL,
  `block_year` int(11) NOT NULL,
  `financial_year` varchar(10) DEFAULT NULL,
  `amount_spent` decimal(10,2) DEFAULT 0.00,
  `amount_committed` decimal(10,2) DEFAULT 0.00,
  `limit_applicable` decimal(10,2) DEFAULT NULL,
  `balance_amount` decimal(10,2) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `cpda_applications`
--

CREATE TABLE `cpda_applications` (
  `application_id` int(11) NOT NULL,
  `ref_number` varchar(100) DEFAULT NULL,
  `dated` date DEFAULT NULL,
  `employee_code` varchar(50) NOT NULL,
  `faculty_name` varchar(200) NOT NULL,
  `email` varchar(100) DEFAULT NULL,
  `mobile_number` varchar(15) DEFAULT NULL,
  `designation` varchar(100) DEFAULT NULL,
  `department` varchar(100) DEFAULT NULL,
  `pay_level` varchar(50) DEFAULT NULL,
  `date_of_joining` date DEFAULT NULL,
  `purpose_of_purchase` text DEFAULT NULL,
  `technical_specification` text DEFAULT NULL,
  `source_of_information` text DEFAULT NULL,
  `remarks` text DEFAULT NULL,
  `applicant_signature_date` datetime DEFAULT NULL,
  `status` enum('DRAFT','SUBMITTED','HOD_REVIEW','HOD_APPROVED','HOD_REJECTED','ACCOUNTS_REVIEW','DFW_REVIEW','DFW_APPROVED','DFW_REJECTED','DIRECTOR_APPROVED','DIRECTOR_REJECTED','COMPLETED') DEFAULT 'DRAFT',
  `current_stage` varchar(100) DEFAULT NULL,
  `pda_block_start_year` int(11) DEFAULT NULL,
  `pda_block_end_year` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `cpda_applications`
--

INSERT INTO `cpda_applications` (`application_id`, `ref_number`, `dated`, `employee_code`, `faculty_name`, `email`, `mobile_number`, `designation`, `department`, `pay_level`, `date_of_joining`, `purpose_of_purchase`, `technical_specification`, `source_of_information`, `remarks`, `applicant_signature_date`, `status`, `current_stage`, `pda_block_start_year`, `pda_block_end_year`, `created_at`, `updated_at`) VALUES
(1, 'CPDA-6900C6ED21BE6', '2025-10-28', '1105', 'Dr. Aman Singh', 'aman.singh@nitj.ac.in', '7696124875', 'faculty', 'Mechanical Engineering', '13', '2025-10-22', 'trip', 'i9', NULL, '', NULL, 'SUBMITTED', 'HOD_REVIEW', NULL, NULL, '2025-10-28 13:36:45', '2025-10-28 13:36:45'),
(2, 'CPDA-6900CAB0C4730', '2025-10-28', '1101', 'Dr. Priya Sharma', 'priya.sharma@nitj.ac.in', '987654321', 'faculty', 'Computer Science & Engg.', '13A2', '2012-09-01', 'sdaljkf', 'sf', NULL, 'skldf', NULL, 'SUBMITTED', 'HOD_REVIEW', NULL, NULL, '2025-10-28 13:52:48', '2025-10-28 13:52:48'),
(3, 'CPDA-6900CCF539F1A', '2025-10-28', '1101', 'Dr. Priya Sharma', 'priya.sharma@nitj.ac.in', '987654321', 'faculty', 'Computer Science & Engg.', '13A2', '2012-09-01', 'sdfsdf', 'fsd', NULL, '', NULL, 'SUBMITTED', 'HOD_REVIEW', NULL, NULL, '2025-10-28 14:02:29', '2025-10-28 14:02:29'),
(4, 'CPDA-6900CD6DE78B4', '2025-10-28', '1101', 'Dr. Priya Sharma', 'priya.sharma@nitj.ac.in', '987654321', 'faculty', 'Computer Science & Engg.', '13A2', '2012-09-01', 'asd', 'asd', NULL, 'we', NULL, 'ACCOUNTS_REVIEW', 'ACCOUNTS_SUPDT_REVIEW', NULL, NULL, '2025-10-28 14:04:29', '2025-10-29 18:51:15'),
(5, 'CPDA-6901CF0C2D694', '2025-10-29', '1101', 'Dr. Priya Sharma', 'priya.sharma@nitj.ac.in', '987654321', 'faculty', 'Computer Science & Engg.', '13A2', '2012-09-01', 'm', ' n', NULL, '', NULL, 'SUBMITTED', 'HOD_REVIEW', NULL, NULL, '2025-10-29 08:23:40', '2025-10-29 08:23:40'),
(6, 'CPDA-6901CFA87EE48', '2025-10-29', '1101', 'Dr. Priya Sharma', 'priya.sharma@nitj.ac.in', '987654321', 'faculty', 'Computer Science & Engg.', '13A2', '2012-09-01', 'zasf', 'er', NULL, 'g', NULL, 'HOD_APPROVED', 'ACCOUNTS_REVIEW', NULL, NULL, '2025-10-29 08:26:16', '2025-10-30 04:43:48'),
(7, 'CPDA-6901D0523648A', '2025-10-29', '1105', 'Dr. Aman Singh', 'aman.singh@nitj.ac.in', '987654325', 'faculty', 'Mechanical Engineering', '13A2', '2012-09-01', 'a', 'a', NULL, '', NULL, 'SUBMITTED', 'HOD_REVIEW', NULL, NULL, '2025-10-29 08:29:06', '2025-10-29 08:29:06'),
(8, 'CPDA-6901D3F80E738', '2025-10-29', '1105', 'Dr. Aman Singh', 'aman.singh@nitj.ac.in', '987654325', 'faculty', 'Mechanical Engineering', '13A2', '2012-09-01', 'as', 's', NULL, '', NULL, 'SUBMITTED', 'HOD_REVIEW', NULL, NULL, '2025-10-29 08:44:40', '2025-10-29 08:44:40'),
(9, 'CPDA-6901D4F6AE3FF', '2025-10-29', '1101', 'Dr. Priya Sharma', 'priya.sharma@nitj.ac.in', '987654321', 'faculty', 'Computer Science & Engg.', '13A2', '2012-09-01', 'a', 'q', NULL, '', NULL, 'HOD_APPROVED', 'ACCOUNTS_REVIEW', NULL, NULL, '2025-10-29 08:48:54', '2025-10-31 06:17:08'),
(17, 'CPDA-6901D7B87F2F5', '2025-10-29', '1101', 'Dr. Priya Sharma', 'priya.sharma@nitj.ac.in', '987654321', 'faculty', 'Computer Science & Engg.', '13A2', '2012-09-01', 'sd', 's', NULL, '', NULL, 'HOD_REJECTED', 'COMPLETED', NULL, NULL, '2025-10-29 09:00:40', '2025-10-29 09:35:40'),
(23, 'CPDA-6901DF60AFD7C', '2025-10-29', '1101', 'Dr. Priya Sharma', 'priya.sharma@nitj.ac.in', '987654321', 'faculty', 'Computer Science & Engg.', '13A2', '2012-09-01', 'saa', 'a', NULL, '', NULL, 'ACCOUNTS_REVIEW', 'ACCOUNTS_SUPDT_REVIEW', NULL, NULL, '2025-10-29 09:33:20', '2025-10-29 19:15:28'),
(24, 'CPDA-6901DF9B34794', '2025-10-29', '1101', 'Dr. Priya Sharma', 'priya.sharma@nitj.ac.in', '987654321', 'faculty', 'Computer Science & Engg.', '13A2', '2012-09-01', 'jhhj', 'bb\r\n', NULL, '', NULL, 'ACCOUNTS_REVIEW', 'ACCOUNTS_SUPDT_REVIEW', NULL, NULL, '2025-10-29 09:34:19', '2025-10-29 18:48:42'),
(25, 'CPDA-6915A642C376C', '2025-11-13', '1101', 'Dr. Priya Sharma', 'priya.sharma@nitj.ac.in', '987654321', 'faculty', 'Computer Science & Engg.', '13A2', '2012-09-01', 'erth', 'erhy', NULL, 'eycj', NULL, 'SUBMITTED', 'HOD_REVIEW', NULL, NULL, '2025-11-13 09:34:58', '2025-11-13 09:34:58'),
(30, 'CPDA-6915C4435F0B1', '2025-11-13', '1101', 'Dr. Priya Sharma', 'priya.sharma@nitj.ac.in', '987654321', 'faculty', 'Computer Science & Engg.', '13A2', '2012-09-01', 'jbvuwvg', 'bwlblr', NULL, '', NULL, 'SUBMITTED', 'HOD_REVIEW', NULL, NULL, '2025-11-13 11:42:59', '2025-11-13 11:42:59');

-- --------------------------------------------------------

--
-- Table structure for table `cpda_register_entries`
--

CREATE TABLE `cpda_register_entries` (
  `register_id` int(11) NOT NULL,
  `application_id` int(11) NOT NULL,
  `register_page_number` int(11) DEFAULT NULL,
  `register_serial_number` int(11) DEFAULT NULL,
  `entry_date` date DEFAULT NULL,
  `entered_by` varchar(200) DEFAULT NULL,
  `dealing_assistant_signature` tinyint(1) DEFAULT 0,
  `private_secretary_signature` tinyint(1) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fdx_electronic_devices`
--

CREATE TABLE `fdx_electronic_devices` (
  `Device_ID` int(11) NOT NULL,
  `Application_ID` varchar(50) NOT NULL,
  `S_No` varchar(10) NOT NULL,
  `Item_Description` varchar(255) NOT NULL,
  `Date_of_Issue` date DEFAULT NULL,
  `Cost_at_Time_of_Issue` decimal(10,2) DEFAULT NULL,
  `Created_At` timestamp NOT NULL DEFAULT current_timestamp(),
  `Updated_At` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `fdx_electronic_devices`
--

INSERT INTO `fdx_electronic_devices` (`Device_ID`, `Application_ID`, `S_No`, `Item_Description`, `Date_of_Issue`, `Cost_at_Time_of_Issue`, `Created_At`, `Updated_At`) VALUES
(3, '4', '1', 'gfd', '2025-10-24', 3545.00, '2025-10-29 18:51:15', '2025-10-29 18:51:15'),
(4, '4', '2', 'fhgh', '2025-10-14', 5646.00, '2025-10-29 18:51:15', '2025-10-29 18:51:15');

-- --------------------------------------------------------

--
-- Table structure for table `fdx_expenditure_main`
--

CREATE TABLE `fdx_expenditure_main` (
  `Application_ID` varchar(50) NOT NULL,
  `P1_Conferences_Y1_2021_22_Num_Events` int(11) DEFAULT NULL,
  `P1_Conferences_Y1_2021_22_Amt_Spent` decimal(10,2) DEFAULT NULL,
  `P1_Conferences_Y1_2021_22_Amt_Committed` decimal(10,2) DEFAULT NULL,
  `P1_Conferences_Y1_2021_22_Balance` decimal(10,2) DEFAULT NULL,
  `P1_Conferences_Y2_2022_23_Num_Events` int(11) DEFAULT NULL,
  `P1_Conferences_Y2_2022_23_Amt_Spent` decimal(10,2) DEFAULT NULL,
  `P1_Conferences_Y2_2022_23_Amt_Committed` decimal(10,2) DEFAULT NULL,
  `P1_Conferences_Y2_2022_23_Balance` decimal(10,2) DEFAULT NULL,
  `P1_Conferences_Y3_2023_24_Num_Events` int(11) DEFAULT NULL,
  `P1_Conferences_Y3_2023_24_Amt_Spent` decimal(10,2) DEFAULT NULL,
  `P1_Conferences_Y3_2023_24_Amt_Committed` decimal(10,2) DEFAULT NULL,
  `P1_Conferences_Y3_2023_24_Balance` decimal(10,2) DEFAULT NULL,
  `P2_Membership_Y1_2021_22_Num_Availed` int(11) DEFAULT NULL,
  `P2_Membership_Y1_2021_22_Amt_Spent` decimal(10,2) DEFAULT NULL,
  `P2_Membership_Y1_2021_22_Amt_Committed` decimal(10,2) DEFAULT NULL,
  `P2_Membership_Y1_2021_22_Balance` decimal(10,2) DEFAULT NULL,
  `P2_Membership_Y2_2022_23_Num_Availed` int(11) DEFAULT NULL,
  `P2_Membership_Y2_2022_23_Amt_Spent` decimal(10,2) DEFAULT NULL,
  `P2_Membership_Y2_2022_23_Amt_Committed` decimal(10,2) DEFAULT NULL,
  `P2_Membership_Y2_2022_23_Balance` decimal(10,2) DEFAULT NULL,
  `P2_Membership_Y3_2023_24_Num_Availed` int(11) DEFAULT NULL,
  `P2_Membership_Y3_2023_24_Amt_Spent` decimal(10,2) DEFAULT NULL,
  `P2_Membership_Y3_2023_24_Amt_Committed` decimal(10,2) DEFAULT NULL,
  `P2_Membership_Y3_2023_24_Balance` decimal(10,2) DEFAULT NULL,
  `P3a_Consumables_Num_Availed` int(11) DEFAULT NULL,
  `P3a_Consumables_Amt_Spent` decimal(10,2) DEFAULT NULL,
  `P3a_Consumables_Amt_Committed` decimal(10,2) DEFAULT NULL,
  `P3a_Consumables_Balance` decimal(10,2) DEFAULT NULL,
  `P3b_Synthesis_Testing_Num_Availed` int(11) DEFAULT NULL,
  `P3b_Synthesis_Testing_Amt_Spent` decimal(10,2) DEFAULT NULL,
  `P3b_Synthesis_Testing_Amt_Committed` decimal(10,2) DEFAULT NULL,
  `P3b_Synthesis_Testing_Balance` decimal(10,2) DEFAULT NULL,
  `P3c_i_Stationary_Num_Availed` int(11) DEFAULT NULL,
  `P3c_i_Stationary_Amt_Spent` decimal(10,2) DEFAULT NULL,
  `P3c_i_Stationary_Amt_Committed` decimal(10,2) DEFAULT NULL,
  `P3c_i_Stationary_Balance` decimal(10,2) DEFAULT NULL,
  `P3c_ii_Books_Num_Availed` int(11) DEFAULT NULL,
  `P3c_ii_Books_Amt_Spent` decimal(10,2) DEFAULT NULL,
  `P3c_ii_Books_Amt_Committed` decimal(10,2) DEFAULT NULL,
  `P3c_ii_Books_Balance` decimal(10,2) DEFAULT NULL,
  `P3d_Computer_Consumables_Num_Availed` int(11) DEFAULT NULL,
  `P3d_Computer_Consumables_Amt_Spent` decimal(10,2) DEFAULT NULL,
  `P3d_Computer_Consumables_Amt_Committed` decimal(10,2) DEFAULT NULL,
  `P3d_Computer_Consumables_Balance` decimal(10,2) DEFAULT NULL,
  `Created_At` timestamp NOT NULL DEFAULT current_timestamp(),
  `Updated_At` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `fdx_expenditure_main`
--

INSERT INTO `fdx_expenditure_main` (`Application_ID`, `P1_Conferences_Y1_2021_22_Num_Events`, `P1_Conferences_Y1_2021_22_Amt_Spent`, `P1_Conferences_Y1_2021_22_Amt_Committed`, `P1_Conferences_Y1_2021_22_Balance`, `P1_Conferences_Y2_2022_23_Num_Events`, `P1_Conferences_Y2_2022_23_Amt_Spent`, `P1_Conferences_Y2_2022_23_Amt_Committed`, `P1_Conferences_Y2_2022_23_Balance`, `P1_Conferences_Y3_2023_24_Num_Events`, `P1_Conferences_Y3_2023_24_Amt_Spent`, `P1_Conferences_Y3_2023_24_Amt_Committed`, `P1_Conferences_Y3_2023_24_Balance`, `P2_Membership_Y1_2021_22_Num_Availed`, `P2_Membership_Y1_2021_22_Amt_Spent`, `P2_Membership_Y1_2021_22_Amt_Committed`, `P2_Membership_Y1_2021_22_Balance`, `P2_Membership_Y2_2022_23_Num_Availed`, `P2_Membership_Y2_2022_23_Amt_Spent`, `P2_Membership_Y2_2022_23_Amt_Committed`, `P2_Membership_Y2_2022_23_Balance`, `P2_Membership_Y3_2023_24_Num_Availed`, `P2_Membership_Y3_2023_24_Amt_Spent`, `P2_Membership_Y3_2023_24_Amt_Committed`, `P2_Membership_Y3_2023_24_Balance`, `P3a_Consumables_Num_Availed`, `P3a_Consumables_Amt_Spent`, `P3a_Consumables_Amt_Committed`, `P3a_Consumables_Balance`, `P3b_Synthesis_Testing_Num_Availed`, `P3b_Synthesis_Testing_Amt_Spent`, `P3b_Synthesis_Testing_Amt_Committed`, `P3b_Synthesis_Testing_Balance`, `P3c_i_Stationary_Num_Availed`, `P3c_i_Stationary_Amt_Spent`, `P3c_i_Stationary_Amt_Committed`, `P3c_i_Stationary_Balance`, `P3c_ii_Books_Num_Availed`, `P3c_ii_Books_Amt_Spent`, `P3c_ii_Books_Amt_Committed`, `P3c_ii_Books_Balance`, `P3d_Computer_Consumables_Num_Availed`, `P3d_Computer_Consumables_Amt_Spent`, `P3d_Computer_Consumables_Amt_Committed`, `P3d_Computer_Consumables_Balance`, `Created_At`, `Updated_At`) VALUES
('12', 12, 34.00, 23.00, 9.00, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-10-29 18:24:42', '2025-10-29 18:24:42'),
('23', 0, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, '2025-10-29 18:49:40', '2025-10-29 18:50:16'),
('24', 0, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, '2025-10-29 18:48:36', '2025-10-29 18:48:42'),
('4', 211, 0.00, 0.00, 0.00, 545, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, '2025-10-29 18:51:15', '2025-10-29 18:51:15');

-- --------------------------------------------------------

--
-- Table structure for table `form_history`
--

CREATE TABLE `form_history` (
  `id` int(11) NOT NULL,
  `form_id` int(11) NOT NULL,
  `form_type` varchar(10) NOT NULL,
  `user_id` int(11) NOT NULL,
  `submitted_on` datetime DEFAULT current_timestamp(),
  `status` enum('Pending','Processing','Processed') DEFAULT 'Pending',
  `remarks` text DEFAULT NULL,
  `updated_on` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `employee_code` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `form_history`
--

INSERT INTO `form_history` (`id`, `form_id`, `form_type`, `user_id`, `submitted_on`, `status`, `remarks`, `updated_on`, `employee_code`) VALUES
(1, 30, 'F1', 0, '2025-11-13 17:12:59', 'Pending', NULL, '2025-11-13 17:12:59', '1101');

-- --------------------------------------------------------

--
-- Table structure for table `issued_devices`
--

CREATE TABLE `issued_devices` (
  `device_id` int(11) NOT NULL,
  `application_id` int(11) NOT NULL,
  `employee_code` varchar(50) NOT NULL,
  `item_name` varchar(200) NOT NULL,
  `device_type` enum('LAPTOP','TABLET','NOTEBOOK','OTHER_ELECTRONIC') DEFAULT NULL,
  `date_of_issue` date DEFAULT NULL,
  `cost_at_issue` decimal(10,2) DEFAULT NULL,
  `serial_number` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `membership_expenditure`
--

CREATE TABLE `membership_expenditure` (
  `expenditure_id` int(11) NOT NULL,
  `application_id` int(11) NOT NULL,
  `block_year` int(11) NOT NULL,
  `financial_year` varchar(10) DEFAULT NULL,
  `number_availed` int(11) DEFAULT 0,
  `amount_spent` decimal(10,2) DEFAULT 0.00,
  `amount_committed` decimal(10,2) DEFAULT 0.00,
  `max_memberships_per_year` int(11) DEFAULT 3,
  `balance_amount` decimal(10,2) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `notifications`
--

CREATE TABLE `notifications` (
  `notification_id` int(11) NOT NULL,
  `application_id` int(11) NOT NULL,
  `recipient_role` varchar(100) DEFAULT NULL,
  `recipient_email` varchar(100) DEFAULT NULL,
  `notification_type` enum('SUBMISSION','APPROVAL_REQUIRED','APPROVED','REJECTED','REMINDER') DEFAULT NULL,
  `message` text DEFAULT NULL,
  `is_read` tinyint(1) DEFAULT 0,
  `sent_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `pda_expenditure_tracking`
--

CREATE TABLE `pda_expenditure_tracking` (
  `id` int(11) NOT NULL,
  `application_id` int(11) DEFAULT NULL,
  `employee_code` varchar(50) NOT NULL,
  `block_year` varchar(15) NOT NULL,
  `category` varchar(100) NOT NULL,
  `number_availed` int(11) DEFAULT 0,
  `no_of_events` int(11) DEFAULT 0,
  `amount_spent` decimal(12,2) DEFAULT 0.00,
  `amount_committed` decimal(12,2) DEFAULT 0.00,
  `balance_as_on_date` decimal(12,2) DEFAULT 0.00,
  `created_by` varchar(50) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `professional_memberships`
--

CREATE TABLE `professional_memberships` (
  `membership_id` int(11) NOT NULL,
  `application_id` int(11) NOT NULL,
  `professional_body_name` varchar(300) NOT NULL,
  `amount` decimal(10,2) NOT NULL,
  `membership_type` enum('NATIONAL','INTERNATIONAL','BOTH') DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `professional_memberships`
--

INSERT INTO `professional_memberships` (`membership_id`, `application_id`, `professional_body_name`, `amount`, `membership_type`, `created_at`) VALUES
(1, 4, 'sd', 2.00, 'NATIONAL', '2025-10-28 14:04:29'),
(2, 4, 'afds', 24.00, 'INTERNATIONAL', '2025-10-28 14:04:29'),
(3, 6, 'd', 33.00, 'NATIONAL', '2025-10-29 08:26:16'),
(4, 7, 'a', 44.00, 'BOTH', '2025-10-29 08:29:06'),
(5, 25, '34c6j274', 10000.00, 'NATIONAL', '2025-11-13 09:34:58'),
(6, 30, '34c6j274', 5000.00, 'NATIONAL', '2025-11-13 11:42:59');

-- --------------------------------------------------------

--
-- Table structure for table `status_history`
--

CREATE TABLE `status_history` (
  `history_id` int(11) NOT NULL,
  `application_id` int(11) NOT NULL,
  `previous_status` varchar(50) DEFAULT NULL,
  `new_status` varchar(50) DEFAULT NULL,
  `changed_by` varchar(200) DEFAULT NULL,
  `change_reason` text DEFAULT NULL,
  `changed_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `employee_code` int(11) NOT NULL,
  `name` varchar(100) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `role` varchar(50) DEFAULT NULL,
  `department` varchar(100) DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `mobile_number` varchar(15) DEFAULT NULL,
  `pay_level` varchar(10) DEFAULT NULL,
  `date_of_joining` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`employee_code`, `name`, `email`, `password`, `role`, `department`, `created_at`, `mobile_number`, `pay_level`, `date_of_joining`) VALUES
(1101, 'Dr. Priya Sharma', 'priya.sharma@nitj.ac.in', 'Ps@2025', 'faculty', 'Computer Science & Engg.', '2025-10-23 21:02:16', '987654321', '13A2', '2012-09-01'),
(1102, 'Dr. Vivek Soni', 'vivek.soni@nitj.ac.in', 'Vs#2025', 'faculty', 'Computer Science & Engg.', '2025-10-23 21:02:16', '987654322', '13A2', '2012-09-01'),
(1103, 'Ms. Aditi Rao', 'aditi.rao@nitj.ac.in', 'Ar$2025', 'faculty', 'Computer Science & Engg.', '2025-10-23 21:02:16', '987654323', '13A2', '2012-09-01'),
(1104, 'Dr. Harish Tandon', 'harish.t@nitj.ac.in', 'Ht%2025', 'faculty', 'Computer Science & Engg.', '2025-10-23 21:02:16', '987654324', '13A2', '2012-09-01'),
(1105, 'Dr. Aman Singh', 'aman.singh@nitj.ac.in', 'As#2025', 'faculty', 'Mechanical Engineering', '2025-10-23 21:02:16', '987654325', '13A2', '2012-09-01'),
(1106, 'Dr. Rajesh Kumar', 'rajesh.k@nitj.ac.in', 'Rk$2025', 'faculty', 'Electronics & Comm. Engg.', '2025-10-23 21:02:16', '987654326', '12', '2018-03-20'),
(1107, 'Dr. Sunita Devi', 'sunita.d@nitj.ac.in', 'Sd%2025', 'faculty', 'Physics', '2025-10-23 21:02:16', '987654327', '12', '2018-03-20'),
(1108, 'Dr. Vijay Bansal', 'vijay.b@nitj.ac.in', 'Vb^2025', 'faculty', 'Chemical Engineering', '2025-10-23 21:02:16', '987654328', '12', '2018-03-20'),
(1109, 'Prof. Meena Goel', 'meena.g@nitj.ac.in', 'Mg&2025', 'faculty', 'Civil Engineering', '2025-10-23 21:02:16', '987654329', '12', '2018-03-20'),
(1110, 'Prof. Alok Jain', 'hod.cse@nitj.ac.in', 'Hc$@2025', 'hod', 'Computer Science & Engg.', '2025-10-23 21:02:16', '9876543210', '14A', '2008-07-01'),
(1111, 'Dr. Neeraj Gupta', 'hod.me@nitj.ac.in', 'Hm#@2025', 'hod', 'Mechanical Engineering', '2025-10-23 21:02:16', '9876543211', '14A', '2008-07-01'),
(1112, 'Prof. Kavita Singh', 'hod.ece@nitj.ac.in', 'He%@2025', 'hod', 'Electronics & Comm. Engg.', '2025-10-23 21:02:16', '9876543212', '14A', '2008-07-01'),
(1113, 'Dr. Vineet Aggarwal', 'hod.phy@nitj.ac.in', 'Hp^@2025', 'hod', 'Physics', '2025-10-23 21:02:16', '9876543213', '14A', '2008-07-01'),
(1114, 'Ms. Ritu Verma', 'ar.accounts@nitj.ac.in', 'Ar#Acct', 'accounts_ar', 'Accounts Section', '2025-10-23 21:02:16', '9876543214', '9', '2022-05-01'),
(1115, 'Mr. Suresh Dutt', 'supdt.accounts@nitj.ac.in', 'Sa$Acct', 'accounts_supp.', 'Accounts Section', '2025-10-23 21:02:16', '9876543215', '10', '2022-05-01'),
(1116, 'Ms. Juhi Saini', 'da.accounts@nitj.ac.in', 'Da%Acct', 'accounts_da', 'Accounts Section', '2025-10-23 21:02:16', '9876543216', '9', '2022-05-01'),
(1117, 'Dr. Vikram Sharma', 'adfw@nitj.ac.in', 'Ad@Fw25', 'assoc_dean_fw', 'Faculty Welfare', '2025-10-23 21:02:16', '9876543217', '14A', '2022-05-01'),
(1118, 'Prof. Sameer Roy', 'dean.fw@nitj.ac.in', 'Df!W25', 'dean_fw', 'Faculty Welfare', '2025-10-23 21:02:16', '9876543218', '15', '2008-07-01'),
(1119, 'Ms. Geeta Kaur', 'da.fw@nitj.ac.in', 'da&fw25', 'dfw_da', 'Faculty Welfare', '2025-10-23 21:58:24', '9876543219', '9', '2022-05-01'),
(1120, 'Prof. Anil Kohli', 'director@nitj.ac.in', 'Dir#2025', 'director', 'Administration', '2025-10-23 21:02:16', '9876543220', '15', '2005-01-15');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `accounts_balance`
--
ALTER TABLE `accounts_balance`
  ADD PRIMARY KEY (`balance_id`),
  ADD KEY `idx_application` (`application_id`);

--
-- Indexes for table `application_attachments`
--
ALTER TABLE `application_attachments`
  ADD PRIMARY KEY (`attachment_id`),
  ADD KEY `idx_application` (`application_id`);

--
-- Indexes for table `approval_workflow`
--
ALTER TABLE `approval_workflow`
  ADD PRIMARY KEY (`workflow_id`),
  ADD KEY `idx_application` (`application_id`),
  ADD KEY `idx_role` (`approver_role`);

--
-- Indexes for table `conference_expenditure`
--
ALTER TABLE `conference_expenditure`
  ADD PRIMARY KEY (`expenditure_id`),
  ADD KEY `idx_application_year` (`application_id`,`block_year`);

--
-- Indexes for table `consumable_items`
--
ALTER TABLE `consumable_items`
  ADD PRIMARY KEY (`item_id`),
  ADD KEY `idx_application` (`application_id`);

--
-- Indexes for table `contingent_expenditure`
--
ALTER TABLE `contingent_expenditure`
  ADD PRIMARY KEY (`expenditure_id`),
  ADD KEY `idx_application_type_year` (`application_id`,`expenditure_type`,`block_year`);

--
-- Indexes for table `cpda_applications`
--
ALTER TABLE `cpda_applications`
  ADD PRIMARY KEY (`application_id`),
  ADD KEY `idx_employee_code` (`employee_code`),
  ADD KEY `idx_status` (`status`),
  ADD KEY `idx_dated` (`dated`);

--
-- Indexes for table `cpda_register_entries`
--
ALTER TABLE `cpda_register_entries`
  ADD PRIMARY KEY (`register_id`),
  ADD KEY `idx_application` (`application_id`);

--
-- Indexes for table `fdx_electronic_devices`
--
ALTER TABLE `fdx_electronic_devices`
  ADD PRIMARY KEY (`Device_ID`),
  ADD KEY `Application_ID` (`Application_ID`);

--
-- Indexes for table `fdx_expenditure_main`
--
ALTER TABLE `fdx_expenditure_main`
  ADD PRIMARY KEY (`Application_ID`);

--
-- Indexes for table `form_history`
--
ALTER TABLE `form_history`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `issued_devices`
--
ALTER TABLE `issued_devices`
  ADD PRIMARY KEY (`device_id`),
  ADD KEY `idx_application` (`application_id`),
  ADD KEY `idx_employee` (`employee_code`);

--
-- Indexes for table `membership_expenditure`
--
ALTER TABLE `membership_expenditure`
  ADD PRIMARY KEY (`expenditure_id`),
  ADD KEY `idx_application_year` (`application_id`,`block_year`);

--
-- Indexes for table `notifications`
--
ALTER TABLE `notifications`
  ADD PRIMARY KEY (`notification_id`),
  ADD KEY `idx_application` (`application_id`),
  ADD KEY `idx_recipient` (`recipient_email`,`is_read`);

--
-- Indexes for table `pda_expenditure_tracking`
--
ALTER TABLE `pda_expenditure_tracking`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_emp_block` (`employee_code`,`block_year`),
  ADD KEY `idx_application` (`application_id`);

--
-- Indexes for table `professional_memberships`
--
ALTER TABLE `professional_memberships`
  ADD PRIMARY KEY (`membership_id`),
  ADD KEY `idx_application` (`application_id`);

--
-- Indexes for table `status_history`
--
ALTER TABLE `status_history`
  ADD PRIMARY KEY (`history_id`),
  ADD KEY `idx_application_date` (`application_id`,`changed_at`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`employee_code`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `accounts_balance`
--
ALTER TABLE `accounts_balance`
  MODIFY `balance_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `application_attachments`
--
ALTER TABLE `application_attachments`
  MODIFY `attachment_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `approval_workflow`
--
ALTER TABLE `approval_workflow`
  MODIFY `workflow_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `conference_expenditure`
--
ALTER TABLE `conference_expenditure`
  MODIFY `expenditure_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `consumable_items`
--
ALTER TABLE `consumable_items`
  MODIFY `item_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `contingent_expenditure`
--
ALTER TABLE `contingent_expenditure`
  MODIFY `expenditure_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `cpda_applications`
--
ALTER TABLE `cpda_applications`
  MODIFY `application_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- AUTO_INCREMENT for table `cpda_register_entries`
--
ALTER TABLE `cpda_register_entries`
  MODIFY `register_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `fdx_electronic_devices`
--
ALTER TABLE `fdx_electronic_devices`
  MODIFY `Device_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `form_history`
--
ALTER TABLE `form_history`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `issued_devices`
--
ALTER TABLE `issued_devices`
  MODIFY `device_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `membership_expenditure`
--
ALTER TABLE `membership_expenditure`
  MODIFY `expenditure_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `notifications`
--
ALTER TABLE `notifications`
  MODIFY `notification_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `pda_expenditure_tracking`
--
ALTER TABLE `pda_expenditure_tracking`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `professional_memberships`
--
ALTER TABLE `professional_memberships`
  MODIFY `membership_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `status_history`
--
ALTER TABLE `status_history`
  MODIFY `history_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `accounts_balance`
--
ALTER TABLE `accounts_balance`
  ADD CONSTRAINT `accounts_balance_ibfk_1` FOREIGN KEY (`application_id`) REFERENCES `cpda_applications` (`application_id`) ON DELETE CASCADE;

--
-- Constraints for table `application_attachments`
--
ALTER TABLE `application_attachments`
  ADD CONSTRAINT `application_attachments_ibfk_1` FOREIGN KEY (`application_id`) REFERENCES `cpda_applications` (`application_id`) ON DELETE CASCADE;

--
-- Constraints for table `approval_workflow`
--
ALTER TABLE `approval_workflow`
  ADD CONSTRAINT `approval_workflow_ibfk_1` FOREIGN KEY (`application_id`) REFERENCES `cpda_applications` (`application_id`) ON DELETE CASCADE;

--
-- Constraints for table `conference_expenditure`
--
ALTER TABLE `conference_expenditure`
  ADD CONSTRAINT `conference_expenditure_ibfk_1` FOREIGN KEY (`application_id`) REFERENCES `cpda_applications` (`application_id`) ON DELETE CASCADE;

--
-- Constraints for table `consumable_items`
--
ALTER TABLE `consumable_items`
  ADD CONSTRAINT `consumable_items_ibfk_1` FOREIGN KEY (`application_id`) REFERENCES `cpda_applications` (`application_id`) ON DELETE CASCADE;

--
-- Constraints for table `contingent_expenditure`
--
ALTER TABLE `contingent_expenditure`
  ADD CONSTRAINT `contingent_expenditure_ibfk_1` FOREIGN KEY (`application_id`) REFERENCES `cpda_applications` (`application_id`) ON DELETE CASCADE;

--
-- Constraints for table `cpda_register_entries`
--
ALTER TABLE `cpda_register_entries`
  ADD CONSTRAINT `cpda_register_entries_ibfk_1` FOREIGN KEY (`application_id`) REFERENCES `cpda_applications` (`application_id`) ON DELETE CASCADE;

--
-- Constraints for table `fdx_electronic_devices`
--
ALTER TABLE `fdx_electronic_devices`
  ADD CONSTRAINT `fdx_electronic_devices_ibfk_1` FOREIGN KEY (`Application_ID`) REFERENCES `fdx_expenditure_main` (`Application_ID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `issued_devices`
--
ALTER TABLE `issued_devices`
  ADD CONSTRAINT `issued_devices_ibfk_1` FOREIGN KEY (`application_id`) REFERENCES `cpda_applications` (`application_id`) ON DELETE CASCADE;

--
-- Constraints for table `membership_expenditure`
--
ALTER TABLE `membership_expenditure`
  ADD CONSTRAINT `membership_expenditure_ibfk_1` FOREIGN KEY (`application_id`) REFERENCES `cpda_applications` (`application_id`) ON DELETE CASCADE;

--
-- Constraints for table `notifications`
--
ALTER TABLE `notifications`
  ADD CONSTRAINT `notifications_ibfk_1` FOREIGN KEY (`application_id`) REFERENCES `cpda_applications` (`application_id`) ON DELETE CASCADE;

--
-- Constraints for table `professional_memberships`
--
ALTER TABLE `professional_memberships`
  ADD CONSTRAINT `professional_memberships_ibfk_1` FOREIGN KEY (`application_id`) REFERENCES `cpda_applications` (`application_id`) ON DELETE CASCADE;

--
-- Constraints for table `status_history`
--
ALTER TABLE `status_history`
  ADD CONSTRAINT `status_history_ibfk_1` FOREIGN KEY (`application_id`) REFERENCES `cpda_applications` (`application_id`) ON DELETE CASCADE;
--
-- Database: `phpmyadmin`
--
CREATE DATABASE IF NOT EXISTS `phpmyadmin` DEFAULT CHARACTER SET utf8 COLLATE utf8_bin;
USE `phpmyadmin`;

-- --------------------------------------------------------

--
-- Table structure for table `pma__bookmark`
--

CREATE TABLE `pma__bookmark` (
  `id` int(10) UNSIGNED NOT NULL,
  `dbase` varchar(255) NOT NULL DEFAULT '',
  `user` varchar(255) NOT NULL DEFAULT '',
  `label` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `query` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Bookmarks';

-- --------------------------------------------------------

--
-- Table structure for table `pma__central_columns`
--

CREATE TABLE `pma__central_columns` (
  `db_name` varchar(64) NOT NULL,
  `col_name` varchar(64) NOT NULL,
  `col_type` varchar(64) NOT NULL,
  `col_length` text DEFAULT NULL,
  `col_collation` varchar(64) NOT NULL,
  `col_isNull` tinyint(1) NOT NULL,
  `col_extra` varchar(255) DEFAULT '',
  `col_default` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Central list of columns';

-- --------------------------------------------------------

--
-- Table structure for table `pma__column_info`
--

CREATE TABLE `pma__column_info` (
  `id` int(5) UNSIGNED NOT NULL,
  `db_name` varchar(64) NOT NULL DEFAULT '',
  `table_name` varchar(64) NOT NULL DEFAULT '',
  `column_name` varchar(64) NOT NULL DEFAULT '',
  `comment` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `mimetype` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `transformation` varchar(255) NOT NULL DEFAULT '',
  `transformation_options` varchar(255) NOT NULL DEFAULT '',
  `input_transformation` varchar(255) NOT NULL DEFAULT '',
  `input_transformation_options` varchar(255) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Column information for phpMyAdmin';

-- --------------------------------------------------------

--
-- Table structure for table `pma__designer_settings`
--

CREATE TABLE `pma__designer_settings` (
  `username` varchar(64) NOT NULL,
  `settings_data` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Settings related to Designer';

-- --------------------------------------------------------

--
-- Table structure for table `pma__export_templates`
--

CREATE TABLE `pma__export_templates` (
  `id` int(5) UNSIGNED NOT NULL,
  `username` varchar(64) NOT NULL,
  `export_type` varchar(10) NOT NULL,
  `template_name` varchar(64) NOT NULL,
  `template_data` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Saved export templates';

--
-- Dumping data for table `pma__export_templates`
--

INSERT INTO `pma__export_templates` (`id`, `username`, `export_type`, `template_name`, `template_data`) VALUES
(1, 'root', 'server', 'clg', '{\"quick_or_custom\":\"quick\",\"what\":\"sql\",\"db_select[]\":[\"clg\",\"college\",\"college_erp\",\"phpmyadmin\",\"test\"],\"aliases_new\":\"\",\"output_format\":\"sendit\",\"filename_template\":\"@SERVER@\",\"remember_template\":\"on\",\"charset\":\"utf-8\",\"compression\":\"none\",\"maxsize\":\"\",\"codegen_structure_or_data\":\"data\",\"codegen_format\":\"0\",\"csv_separator\":\",\",\"csv_enclosed\":\"\\\"\",\"csv_escaped\":\"\\\"\",\"csv_terminated\":\"AUTO\",\"csv_null\":\"NULL\",\"csv_columns\":\"something\",\"csv_structure_or_data\":\"data\",\"excel_null\":\"NULL\",\"excel_columns\":\"something\",\"excel_edition\":\"win\",\"excel_structure_or_data\":\"data\",\"json_structure_or_data\":\"data\",\"json_unicode\":\"something\",\"latex_caption\":\"something\",\"latex_structure_or_data\":\"structure_and_data\",\"latex_structure_caption\":\"Structure of table @TABLE@\",\"latex_structure_continued_caption\":\"Structure of table @TABLE@ (continued)\",\"latex_structure_label\":\"tab:@TABLE@-structure\",\"latex_relation\":\"something\",\"latex_comments\":\"something\",\"latex_mime\":\"something\",\"latex_columns\":\"something\",\"latex_data_caption\":\"Content of table @TABLE@\",\"latex_data_continued_caption\":\"Content of table @TABLE@ (continued)\",\"latex_data_label\":\"tab:@TABLE@-data\",\"latex_null\":\"\\\\textit{NULL}\",\"mediawiki_structure_or_data\":\"data\",\"mediawiki_caption\":\"something\",\"mediawiki_headers\":\"something\",\"htmlword_structure_or_data\":\"structure_and_data\",\"htmlword_null\":\"NULL\",\"ods_null\":\"NULL\",\"ods_structure_or_data\":\"data\",\"odt_structure_or_data\":\"structure_and_data\",\"odt_relation\":\"something\",\"odt_comments\":\"something\",\"odt_mime\":\"something\",\"odt_columns\":\"something\",\"odt_null\":\"NULL\",\"pdf_report_title\":\"\",\"pdf_structure_or_data\":\"data\",\"phparray_structure_or_data\":\"data\",\"sql_include_comments\":\"something\",\"sql_header_comment\":\"\",\"sql_use_transaction\":\"something\",\"sql_compatibility\":\"NONE\",\"sql_structure_or_data\":\"structure_and_data\",\"sql_create_table\":\"something\",\"sql_auto_increment\":\"something\",\"sql_create_view\":\"something\",\"sql_create_trigger\":\"something\",\"sql_backquotes\":\"something\",\"sql_type\":\"INSERT\",\"sql_insert_syntax\":\"both\",\"sql_max_query_size\":\"50000\",\"sql_hex_for_binary\":\"something\",\"sql_utc_time\":\"something\",\"texytext_structure_or_data\":\"structure_and_data\",\"texytext_null\":\"NULL\",\"yaml_structure_or_data\":\"data\",\"\":null,\"as_separate_files\":null,\"csv_removeCRLF\":null,\"excel_removeCRLF\":null,\"json_pretty_print\":null,\"htmlword_columns\":null,\"ods_columns\":null,\"sql_dates\":null,\"sql_relation\":null,\"sql_mime\":null,\"sql_disable_fk\":null,\"sql_views_as_tables\":null,\"sql_metadata\":null,\"sql_drop_database\":null,\"sql_drop_table\":null,\"sql_if_not_exists\":null,\"sql_simple_view_export\":null,\"sql_view_current_user\":null,\"sql_or_replace_view\":null,\"sql_procedure_function\":null,\"sql_truncate\":null,\"sql_delayed\":null,\"sql_ignore\":null,\"texytext_columns\":null}');

-- --------------------------------------------------------

--
-- Table structure for table `pma__favorite`
--

CREATE TABLE `pma__favorite` (
  `username` varchar(64) NOT NULL,
  `tables` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Favorite tables';

-- --------------------------------------------------------

--
-- Table structure for table `pma__history`
--

CREATE TABLE `pma__history` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `username` varchar(64) NOT NULL DEFAULT '',
  `db` varchar(64) NOT NULL DEFAULT '',
  `table` varchar(64) NOT NULL DEFAULT '',
  `timevalue` timestamp NOT NULL DEFAULT current_timestamp(),
  `sqlquery` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='SQL history for phpMyAdmin';

-- --------------------------------------------------------

--
-- Table structure for table `pma__navigationhiding`
--

CREATE TABLE `pma__navigationhiding` (
  `username` varchar(64) NOT NULL,
  `item_name` varchar(64) NOT NULL,
  `item_type` varchar(64) NOT NULL,
  `db_name` varchar(64) NOT NULL,
  `table_name` varchar(64) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Hidden items of navigation tree';

-- --------------------------------------------------------

--
-- Table structure for table `pma__pdf_pages`
--

CREATE TABLE `pma__pdf_pages` (
  `db_name` varchar(64) NOT NULL DEFAULT '',
  `page_nr` int(10) UNSIGNED NOT NULL,
  `page_descr` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='PDF relation pages for phpMyAdmin';

-- --------------------------------------------------------

--
-- Table structure for table `pma__recent`
--

CREATE TABLE `pma__recent` (
  `username` varchar(64) NOT NULL,
  `tables` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Recently accessed tables';

--
-- Dumping data for table `pma__recent`
--

INSERT INTO `pma__recent` (`username`, `tables`) VALUES
('root', '[{\"db\":\"clg\",\"table\":\"cpda_applications\"},{\"db\":\"clg\",\"table\":\"users\"},{\"db\":\"clg\",\"table\":\"cpda_balance_snapshot\"},{\"db\":\"clg\",\"table\":\"cpda_register_entries\"},{\"db\":\"college\",\"table\":\"users\"},{\"db\":\"college_erp\",\"table\":\"users\"},{\"db\":\"college_erp\",\"table\":\"form_history\"},{\"db\":\"college_erp\",\"table\":\"cpda_applications\"},{\"db\":\"college_erp\",\"table\":\"status_history\"}]');

-- --------------------------------------------------------

--
-- Table structure for table `pma__relation`
--

CREATE TABLE `pma__relation` (
  `master_db` varchar(64) NOT NULL DEFAULT '',
  `master_table` varchar(64) NOT NULL DEFAULT '',
  `master_field` varchar(64) NOT NULL DEFAULT '',
  `foreign_db` varchar(64) NOT NULL DEFAULT '',
  `foreign_table` varchar(64) NOT NULL DEFAULT '',
  `foreign_field` varchar(64) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Relation table';

-- --------------------------------------------------------

--
-- Table structure for table `pma__savedsearches`
--

CREATE TABLE `pma__savedsearches` (
  `id` int(5) UNSIGNED NOT NULL,
  `username` varchar(64) NOT NULL DEFAULT '',
  `db_name` varchar(64) NOT NULL DEFAULT '',
  `search_name` varchar(64) NOT NULL DEFAULT '',
  `search_data` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Saved searches';

-- --------------------------------------------------------

--
-- Table structure for table `pma__table_coords`
--

CREATE TABLE `pma__table_coords` (
  `db_name` varchar(64) NOT NULL DEFAULT '',
  `table_name` varchar(64) NOT NULL DEFAULT '',
  `pdf_page_number` int(11) NOT NULL DEFAULT 0,
  `x` float UNSIGNED NOT NULL DEFAULT 0,
  `y` float UNSIGNED NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Table coordinates for phpMyAdmin PDF output';

-- --------------------------------------------------------

--
-- Table structure for table `pma__table_info`
--

CREATE TABLE `pma__table_info` (
  `db_name` varchar(64) NOT NULL DEFAULT '',
  `table_name` varchar(64) NOT NULL DEFAULT '',
  `display_field` varchar(64) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Table information for phpMyAdmin';

-- --------------------------------------------------------

--
-- Table structure for table `pma__table_uiprefs`
--

CREATE TABLE `pma__table_uiprefs` (
  `username` varchar(64) NOT NULL,
  `db_name` varchar(64) NOT NULL,
  `table_name` varchar(64) NOT NULL,
  `prefs` text NOT NULL,
  `last_update` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Tables'' UI preferences';

-- --------------------------------------------------------

--
-- Table structure for table `pma__tracking`
--

CREATE TABLE `pma__tracking` (
  `db_name` varchar(64) NOT NULL,
  `table_name` varchar(64) NOT NULL,
  `version` int(10) UNSIGNED NOT NULL,
  `date_created` datetime NOT NULL,
  `date_updated` datetime NOT NULL,
  `schema_snapshot` text NOT NULL,
  `schema_sql` text DEFAULT NULL,
  `data_sql` longtext DEFAULT NULL,
  `tracking` set('UPDATE','REPLACE','INSERT','DELETE','TRUNCATE','CREATE DATABASE','ALTER DATABASE','DROP DATABASE','CREATE TABLE','ALTER TABLE','RENAME TABLE','DROP TABLE','CREATE INDEX','DROP INDEX','CREATE VIEW','ALTER VIEW','DROP VIEW') DEFAULT NULL,
  `tracking_active` int(1) UNSIGNED NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Database changes tracking for phpMyAdmin';

-- --------------------------------------------------------

--
-- Table structure for table `pma__userconfig`
--

CREATE TABLE `pma__userconfig` (
  `username` varchar(64) NOT NULL,
  `timevalue` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `config_data` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='User preferences storage for phpMyAdmin';

--
-- Dumping data for table `pma__userconfig`
--

INSERT INTO `pma__userconfig` (`username`, `timevalue`, `config_data`) VALUES
('root', '2026-01-06 16:25:36', '{\"Console\\/Mode\":\"collapse\",\"NavigationWidth\":0}');

-- --------------------------------------------------------

--
-- Table structure for table `pma__usergroups`
--

CREATE TABLE `pma__usergroups` (
  `usergroup` varchar(64) NOT NULL,
  `tab` varchar(64) NOT NULL,
  `allowed` enum('Y','N') NOT NULL DEFAULT 'N'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='User groups with configured menu items';

-- --------------------------------------------------------

--
-- Table structure for table `pma__users`
--

CREATE TABLE `pma__users` (
  `username` varchar(64) NOT NULL,
  `usergroup` varchar(64) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Users and their assignments to user groups';

--
-- Indexes for dumped tables
--

--
-- Indexes for table `pma__bookmark`
--
ALTER TABLE `pma__bookmark`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `pma__central_columns`
--
ALTER TABLE `pma__central_columns`
  ADD PRIMARY KEY (`db_name`,`col_name`);

--
-- Indexes for table `pma__column_info`
--
ALTER TABLE `pma__column_info`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `db_name` (`db_name`,`table_name`,`column_name`);

--
-- Indexes for table `pma__designer_settings`
--
ALTER TABLE `pma__designer_settings`
  ADD PRIMARY KEY (`username`);

--
-- Indexes for table `pma__export_templates`
--
ALTER TABLE `pma__export_templates`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `u_user_type_template` (`username`,`export_type`,`template_name`);

--
-- Indexes for table `pma__favorite`
--
ALTER TABLE `pma__favorite`
  ADD PRIMARY KEY (`username`);

--
-- Indexes for table `pma__history`
--
ALTER TABLE `pma__history`
  ADD PRIMARY KEY (`id`),
  ADD KEY `username` (`username`,`db`,`table`,`timevalue`);

--
-- Indexes for table `pma__navigationhiding`
--
ALTER TABLE `pma__navigationhiding`
  ADD PRIMARY KEY (`username`,`item_name`,`item_type`,`db_name`,`table_name`);

--
-- Indexes for table `pma__pdf_pages`
--
ALTER TABLE `pma__pdf_pages`
  ADD PRIMARY KEY (`page_nr`),
  ADD KEY `db_name` (`db_name`);

--
-- Indexes for table `pma__recent`
--
ALTER TABLE `pma__recent`
  ADD PRIMARY KEY (`username`);

--
-- Indexes for table `pma__relation`
--
ALTER TABLE `pma__relation`
  ADD PRIMARY KEY (`master_db`,`master_table`,`master_field`),
  ADD KEY `foreign_field` (`foreign_db`,`foreign_table`);

--
-- Indexes for table `pma__savedsearches`
--
ALTER TABLE `pma__savedsearches`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `u_savedsearches_username_dbname` (`username`,`db_name`,`search_name`);

--
-- Indexes for table `pma__table_coords`
--
ALTER TABLE `pma__table_coords`
  ADD PRIMARY KEY (`db_name`,`table_name`,`pdf_page_number`);

--
-- Indexes for table `pma__table_info`
--
ALTER TABLE `pma__table_info`
  ADD PRIMARY KEY (`db_name`,`table_name`);

--
-- Indexes for table `pma__table_uiprefs`
--
ALTER TABLE `pma__table_uiprefs`
  ADD PRIMARY KEY (`username`,`db_name`,`table_name`);

--
-- Indexes for table `pma__tracking`
--
ALTER TABLE `pma__tracking`
  ADD PRIMARY KEY (`db_name`,`table_name`,`version`);

--
-- Indexes for table `pma__userconfig`
--
ALTER TABLE `pma__userconfig`
  ADD PRIMARY KEY (`username`);

--
-- Indexes for table `pma__usergroups`
--
ALTER TABLE `pma__usergroups`
  ADD PRIMARY KEY (`usergroup`,`tab`,`allowed`);

--
-- Indexes for table `pma__users`
--
ALTER TABLE `pma__users`
  ADD PRIMARY KEY (`username`,`usergroup`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `pma__bookmark`
--
ALTER TABLE `pma__bookmark`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `pma__column_info`
--
ALTER TABLE `pma__column_info`
  MODIFY `id` int(5) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `pma__export_templates`
--
ALTER TABLE `pma__export_templates`
  MODIFY `id` int(5) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `pma__history`
--
ALTER TABLE `pma__history`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `pma__pdf_pages`
--
ALTER TABLE `pma__pdf_pages`
  MODIFY `page_nr` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `pma__savedsearches`
--
ALTER TABLE `pma__savedsearches`
  MODIFY `id` int(5) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- Database: `test`
--
CREATE DATABASE IF NOT EXISTS `test` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE `test`;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
