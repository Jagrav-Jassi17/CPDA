-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Oct 24, 2025 at 02:46 PM
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
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `employee_code` int(11) NOT NULL,
  `name` varchar(100) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `role` enum('faculty','hod','accounts_da','accounts_ar','accounts_supp.','dfw_da','assoc_dean_fw','dean_fw','director','admin') DEFAULT NULL,
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
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`employee_code`),
  ADD UNIQUE KEY `email` (`email`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
