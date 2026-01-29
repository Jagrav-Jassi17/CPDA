-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jan 29, 2026 at 05:42 PM
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
(23, 'CPDA-EVT-25-000002', 7, '[Director-RECOMMENDED] kr mje', '1120', '1101', '2025-12-12 15:03:34'),
(24, 'CPDA-693D7814E167C', 1, '[APPROVED]  ', '1110', '1119', '2026-01-29 16:47:24'),
(25, 'CPDA-EVT-25-000002', 8, '[Director-RECOMMENDED] ok', '1121', '1101', '2026-01-29 21:26:22');

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
(28, 'CPDA-693D7814E167C', '2025-12-13', '1101', 'Dr. Priya Sharma', 'priya.sharma@nitj.ac.in', '987654321', 'faculty', 'Computer Science & Engg.', '13A2', '2012-09-01', 'important', '', NULL, '', NULL, 'HOD_APPROVED', NULL, NULL, '2025-12-13 14:28:36', '2026-01-29 11:17:24', 'DA_REVIEW'),
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
  `location` enum('national','international') NOT NULL DEFAULT 'national',
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
  `application_status` enum('DRAFT','SUBMITTED','HOD_APPROVED','HOD_REJECTED','ACCOUNTS_APPROVED','ACCOUNTS_REJECTED','DFW_APPROVED','DFW_REJECTED','DIRECTOR_APPROVED','DIRECTOR_REJECTED','COMPLETED','CHAIRMAN_APPROVED','CHAIRMAN_REJECTED') DEFAULT 'DRAFT',
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

INSERT INTO `cpda_event_applications` (`application_id`, `ref_number`, `employee_code`, `faculty_name`, `designation_hag`, `designation_professor`, `designation_associate_professor`, `designation_assistant_professor`, `pay_level`, `department`, `location`, `date_of_joining`, `nature_of_event`, `title_of_event`, `period_of_event`, `working_days_involved`, `venue_of_event`, `paper_title`, `paper_authors`, `no_objection_details`, `abstract_attachment`, `expense_registration_fee`, `expense_visa_fee`, `expense_insurance_fee`, `expense_air_fare`, `expense_local_travel`, `expense_da_per_diem`, `expense_boarding_lodging`, `expense_other_details`, `expense_other_amount`, `expense_total`, `event_during_holidays`, `institute_arrangement_attachment`, `attended_abroad_current_block`, `previous_event_name`, `previous_event_dates`, `previous_event_venues`, `application_status`, `submission_date`, `last_updated`, `sanctioned_amount`, `disbursement_status`, `disbursed_amount`, `disbursement_date`, `created_at`, `updated_at`, `current_stage`) VALUES
(1, 'CPDA-EVT-25-000001', 1101, 'Dr. Priya Sharma', 0, 0, 0, 0, '13A2', 'Computer Science & Engg.', 'international', '2012-09-01', 'd', 'f', '34', 3, 'f', '', '', '', NULL, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, '', 0.00, 0.00, 'YES', NULL, 'NO', '', '', '', 'HOD_APPROVED', '2025-10-31 18:06:48', '2026-01-29 21:07:54', NULL, 'PENDING', 0.00, NULL, '2025-10-31 12:36:48', '2026-01-29 15:37:54', 'DA_REVIEW'),
(2, 'CPDA-EVT-25-000002', 1101, 'Dr. Priya Sharma', 0, 0, 0, 0, '13A2', 'Computer Science & Engg.', 'international', '2012-09-01', 'harry', 'sik', 'js', 98, 'jk', 'sss', 's', 'ss', 'CPDA-EVT-25-000002_abstract_1761914346.pdf', 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, '', 6767676.00, 6767676.00, 'NO', 'CPDA-EVT-25-000002_arrangement_1761914346.pdf', 'YES', 'z', '1u', 'bat', 'CHAIRMAN_APPROVED', '2025-10-31 18:09:06', '2026-01-29 21:30:47', 897.00, 'PENDING', 0.00, NULL, '2025-10-31 12:39:06', '2026-01-29 16:00:47', 'COMPLETED'),
(3, 'CPDA-EVT-25-000003', 1101, 'Dr. Priya Sharma', 0, 0, 0, 1, '13A2', 'Computer Science & Engg.', 'national', '2012-09-01', 'kjhh', 'mn', '5-6 dec', 5, 'mnb', 'hj', 'yugu', 'tyc', 'CPDA-EVT-25-000003_abstract_1765528308.pdf', 564.00, 64.00, 513.00, 98.00, 132.00, 87.00, 32.00, '', 65.00, 1555.00, 'YES', NULL, 'NO', 'nb', 'nm', '', 'COMPLETED', '2025-12-12 14:01:48', '2025-12-12 14:54:37', 7878.00, 'PENDING', 0.00, NULL, '2025-12-12 08:31:48', '2025-12-12 09:24:37', 'COMPLETED'),
(4, 'CPDA-EVT-26-000001', 1101, 'Dr. Priya Sharma', 0, 0, 0, 1, '13A2', 'Computer Science & Engg.', 'international', '2012-09-01', 'hh', 'jj', '16-17 feb', 2, 'lp', '', '', '', NULL, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, '', 0.00, 0.00, 'YES', NULL, 'NO', '', '', '', 'SUBMITTED', '2026-01-29 21:37:50', '2026-01-29 21:37:50', NULL, 'PENDING', 0.00, NULL, '2026-01-29 16:07:50', '2026-01-29 16:07:50', 'HOD_REVIEW');

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
  `employee_code` int(11) NOT NULL,
  `Item_Description` varchar(255) NOT NULL,
  `Date_of_Issue` date DEFAULT NULL,
  `Cost_at_Time_of_Issue` decimal(10,2) DEFAULT NULL,
  `Created_At` timestamp NOT NULL DEFAULT current_timestamp(),
  `Updated_At` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `fdx_electronic_devices`
--

INSERT INTO `fdx_electronic_devices` (`Device_ID`, `employee_code`, `Item_Description`, `Date_of_Issue`, `Cost_at_Time_of_Issue`, `Created_At`, `Updated_At`) VALUES
(46, 1101, 'l', '2004-04-07', 998.00, '2026-01-19 21:03:31', '2026-01-19 21:09:51'),
(48, 1101, 'yujh', '2026-01-02', 45.00, '2026-01-19 21:07:07', '2026-01-19 21:10:18'),
(49, 1101, '7', '2026-01-01', 78.00, '2026-01-19 21:10:47', '2026-01-19 21:10:47');

-- --------------------------------------------------------

--
-- Table structure for table `fdx_expenditure_main`
--

CREATE TABLE `fdx_expenditure_main` (
  `Sr. no` int(11) NOT NULL,
  `employee_code` int(11) DEFAULT NULL,
  `P1_Conferences_Y1_Num_Events` int(11) DEFAULT NULL,
  `P1_Conferences_Y1_Amt_Spent` decimal(10,2) DEFAULT NULL,
  `P1_Conferences_Y1_Amt_Committed` decimal(10,2) DEFAULT NULL,
  `P1_Conferences_Y1_Balance` decimal(10,2) DEFAULT NULL,
  `P1_Conferences_Y2_Num_Events` int(11) DEFAULT NULL,
  `P1_Conferences_Y2_Amt_Spent` decimal(10,2) DEFAULT NULL,
  `P1_Conferences_Y2_Amt_Committed` decimal(10,2) DEFAULT NULL,
  `P1_Conferences_Y2_Balance` decimal(10,2) DEFAULT NULL,
  `P1_Conferences_Y3_Num_Events` int(11) DEFAULT NULL,
  `P1_Conferences_Y3_Amt_Spent` decimal(10,2) DEFAULT NULL,
  `P1_Conferences_Y3_Amt_Committed` decimal(10,2) DEFAULT NULL,
  `P1_Conferences_Y3_Balance` decimal(10,2) DEFAULT NULL,
  `P2_Membership_Y1_Num_Availed` int(11) DEFAULT NULL,
  `P2_Membership_Y1_Amt_Spent` decimal(10,2) DEFAULT NULL,
  `P2_Membership_Y1_Amt_Committed` decimal(10,2) DEFAULT NULL,
  `P2_Membership_Y1_Balance` decimal(10,2) DEFAULT NULL,
  `P2_Membership_Y2_Num_Availed` int(11) DEFAULT NULL,
  `P2_Membership_Y2_Amt_Spent` decimal(10,2) DEFAULT NULL,
  `P2_Membership_Y2_Amt_Committed` decimal(10,2) DEFAULT NULL,
  `P2_Membership_Y2_Balance` decimal(10,2) DEFAULT NULL,
  `P2_Membership_Y3_Num_Availed` int(11) DEFAULT NULL,
  `P2_Membership_Y3_Amt_Spent` decimal(10,2) DEFAULT NULL,
  `P2_Membership_Y3_Amt_Committed` decimal(10,2) DEFAULT NULL,
  `P2_Membership_Y3_Balance` decimal(10,2) DEFAULT NULL,
  `P3a_Consumables_Y1_Amt_Committed` decimal(10,2) DEFAULT NULL,
  `P3a_Consumables_Y2_Amt_Committed` decimal(10,2) DEFAULT NULL,
  `P3a_Consumables_Y3_Amt_Committed` decimal(10,2) DEFAULT NULL,
  `P3a_Consumables_Balance` decimal(10,2) DEFAULT NULL,
  `P3b_Synthesis_Testing_Y1_Amt_Committed` decimal(10,2) DEFAULT NULL,
  `P3b_Synthesis_Testing_Y2_Amt_Committed` decimal(10,2) DEFAULT NULL,
  `P3b_Synthesis_Testing_Y3_Amt_Committed` decimal(10,2) DEFAULT NULL,
  `P3b_Synthesis_Testing_Balance` decimal(10,2) DEFAULT NULL,
  `P3c_i_Stationary_Y1_Amt_Committed` decimal(10,2) DEFAULT NULL,
  `P3c_i_Stationary_Y2_Amt_Committed` decimal(10,2) DEFAULT NULL,
  `P3c_i_Stationary_Y3_Amt_Committed` decimal(10,2) DEFAULT NULL,
  `P3c_i_Stationary_Balance` decimal(10,2) DEFAULT NULL,
  `P3c_ii_Books_Y1_Amt_Committed` decimal(10,2) DEFAULT NULL,
  `P3c_ii_Books_Y2_Amt_Committed` decimal(10,2) DEFAULT NULL,
  `P3c_ii_Books_Y3_Amt_Committed` decimal(10,2) DEFAULT NULL,
  `P3c_ii_Books_Balance` decimal(10,2) DEFAULT NULL,
  `P3d_Computer_Consumables_Y1_Amt_Committed` double(10,2) DEFAULT NULL,
  `P3d_Computer_Consumables_Y2_Amt_Committed` decimal(10,2) DEFAULT NULL,
  `P3d_Computer_Consumables_Y3_Amt_Committed` decimal(10,2) DEFAULT NULL,
  `P3d_Computer_Consumables_Balance` decimal(10,2) DEFAULT NULL,
  `Created_At` timestamp NOT NULL DEFAULT current_timestamp(),
  `Updated_At` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `fdx_expenditure_main`
--

INSERT INTO `fdx_expenditure_main` (`Sr. no`, `employee_code`, `P1_Conferences_Y1_Num_Events`, `P1_Conferences_Y1_Amt_Spent`, `P1_Conferences_Y1_Amt_Committed`, `P1_Conferences_Y1_Balance`, `P1_Conferences_Y2_Num_Events`, `P1_Conferences_Y2_Amt_Spent`, `P1_Conferences_Y2_Amt_Committed`, `P1_Conferences_Y2_Balance`, `P1_Conferences_Y3_Num_Events`, `P1_Conferences_Y3_Amt_Spent`, `P1_Conferences_Y3_Amt_Committed`, `P1_Conferences_Y3_Balance`, `P2_Membership_Y1_Num_Availed`, `P2_Membership_Y1_Amt_Spent`, `P2_Membership_Y1_Amt_Committed`, `P2_Membership_Y1_Balance`, `P2_Membership_Y2_Num_Availed`, `P2_Membership_Y2_Amt_Spent`, `P2_Membership_Y2_Amt_Committed`, `P2_Membership_Y2_Balance`, `P2_Membership_Y3_Num_Availed`, `P2_Membership_Y3_Amt_Spent`, `P2_Membership_Y3_Amt_Committed`, `P2_Membership_Y3_Balance`, `P3a_Consumables_Y1_Amt_Committed`, `P3a_Consumables_Y2_Amt_Committed`, `P3a_Consumables_Y3_Amt_Committed`, `P3a_Consumables_Balance`, `P3b_Synthesis_Testing_Y1_Amt_Committed`, `P3b_Synthesis_Testing_Y2_Amt_Committed`, `P3b_Synthesis_Testing_Y3_Amt_Committed`, `P3b_Synthesis_Testing_Balance`, `P3c_i_Stationary_Y1_Amt_Committed`, `P3c_i_Stationary_Y2_Amt_Committed`, `P3c_i_Stationary_Y3_Amt_Committed`, `P3c_i_Stationary_Balance`, `P3c_ii_Books_Y1_Amt_Committed`, `P3c_ii_Books_Y2_Amt_Committed`, `P3c_ii_Books_Y3_Amt_Committed`, `P3c_ii_Books_Balance`, `P3d_Computer_Consumables_Y1_Amt_Committed`, `P3d_Computer_Consumables_Y2_Amt_Committed`, `P3d_Computer_Consumables_Y3_Amt_Committed`, `P3d_Computer_Consumables_Balance`, `Created_At`, `Updated_At`) VALUES
(1, 1101, 122, 1500.00, 15222.00, 35.00, 42, 45.00, 1.00, 56.00, 12, 536.00, 53.00, 22.00, 45, 54.00, 21.00, 89.00, 4, 5.00, 2.00, 65.00, 798, 54.00, 3.00, 565.00, 21.00, 56.00, 56.00, 4.00, 211.00, 5.00, 24.00, 24.00, 554.00, 24.00, 5.00, 5.00, 45.00, 65.00, 89.00, 5.00, 89.00, 5553.00, 56.00, 536.00, '2026-01-14 08:46:55', '2026-01-19 18:54:11'),
(2, 1102, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-01-17 17:52:56', '2026-01-17 17:52:56'),
(3, 1103, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-01-17 18:06:01', '2026-01-17 18:06:01');

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
(1120, 'Prof. Anil Kohli', 'director@nitj.ac.in', 'Dir#2025', 'director', 'Administration', '2025-10-23 21:02:16', '9876543220', '15', '2005-01-15'),
(1121, 'Prof. Rajesh Mehta', 'chairman@nitj.ac.in', 'chair@2026', 'chairman', 'Administration', '2026-01-29 17:12:52', '9876543210', '15', '2020-01-15');

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
  ADD PRIMARY KEY (`Device_ID`);

--
-- Indexes for table `fdx_expenditure_main`
--
ALTER TABLE `fdx_expenditure_main`
  ADD PRIMARY KEY (`Sr. no`),
  ADD UNIQUE KEY `employee_code` (`employee_code`);

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

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
  MODIFY `application_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

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
  MODIFY `Device_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=50;

--
-- AUTO_INCREMENT for table `fdx_expenditure_main`
--
ALTER TABLE `fdx_expenditure_main`
  MODIFY `Sr. no` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

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
-- Constraints for table `fdx_expenditure_main`
--
ALTER TABLE `fdx_expenditure_main`
  ADD CONSTRAINT `fk_fdx_expenditure_main_employee_code` FOREIGN KEY (`employee_code`) REFERENCES `users` (`employee_code`);

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
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
