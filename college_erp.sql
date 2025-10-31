-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Oct 31, 2025 at 07:48 AM
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
-- Database: `college_erp`
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
(24, 'CPDA-6901DF9B34794', '2025-10-29', '1101', 'Dr. Priya Sharma', 'priya.sharma@nitj.ac.in', '987654321', 'faculty', 'Computer Science & Engg.', '13A2', '2012-09-01', 'jhhj', 'bb\r\n', NULL, '', NULL, 'ACCOUNTS_REVIEW', 'ACCOUNTS_SUPDT_REVIEW', NULL, NULL, '2025-10-29 09:34:19', '2025-10-29 18:48:42');

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
(4, 7, 'a', 44.00, 'BOTH', '2025-10-29 08:29:06');

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
  MODIFY `application_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

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
  MODIFY `membership_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

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
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
