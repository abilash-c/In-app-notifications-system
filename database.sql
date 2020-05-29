-- phpMyAdmin SQL Dump
-- version 4.8.5
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 29, 2020 at 09:09 PM
-- Server version: 10.1.38-MariaDB
-- PHP Version: 7.1.27

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `nodejs_login`
--

-- --------------------------------------------------------

--
-- Table structure for table `course`
--

CREATE TABLE `course` (
  `id` int(20) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `start_time` datetime NOT NULL,
  `end_time` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `course`
--

INSERT INTO `course` (`id`, `name`, `start_time`, `end_time`) VALUES
(1, 'MBA', '2020-05-01 05:00:00', '2020-05-19 17:30:00'),
(2, 'Java', '2020-05-21 06:50:00', '2020-05-31 21:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tenth_mark` float NOT NULL,
  `twelth_mark` float NOT NULL,
  `ug_cgpa` float NOT NULL,
  `college` varchar(300) COLLATE utf8mb4_unicode_ci NOT NULL,
  `backlogs` mediumint(10) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `password`, `tenth_mark`, `twelth_mark`, `ug_cgpa`, `college`, `backlogs`) VALUES
(1, 'Abilash', 'abilash@gmail.com', '$2b$12$y.XAzlVDlkgOd0pxdUy9euThqhPZ0kJUvhozZVhIpwxrCBKCDmHVa', 97.8, 94.3, 8.38, 'Sri Ramakrishna Engineering College ', 0),
(2, 'Harinee Mira', 'pa.harineemira@gmail.com', '$2b$12$cFjCDAUh687BLZScvNOcCeT6VpifProaZxnbtXmUfYmhvnBOHhbl2', 0, 0, 0, '', 0),
(3, 'Aathika', 'aathika@gmail.com', '$2b$12$.RJeEh05.2gvwtjvC4M02.3JnYki01HSKqKf1tIWwC8nG5RrOfMJS', 0, 0, 0, '', 0),
(4, 'Ashwini', 'ashwini@gmail.com', '$2b$12$wAcgC5snT8w11zhCmn3ei.YKyhjZ3Dd0no89oSctDBOXs7MOkuPo.', 0, 0, 0, '', 0),
(6, 'Krish', 'krish@gmail.com', '$2b$12$okHH6yYwG2dnrTPrTUyLKO5YsL1pZzY44Jgt4gy5T7DDV3XVvNDwG', 90.9, 88.7, 7.89, 'Sri Krishna College of Technology', 0),
(7, 'Harry Potter', 'harry@gmail.com', '$2b$12$BZsu1V/Ei/I3g6Th.mCvV.DJjN7mI6qdcmkmJG1jYobtJlERgKwuq', 99.2, 98, 9.8, 'PSG College of Technology', 0),
(8, 'Kapil Dev', 'kapil@gmail.com', '$2b$12$ngsZbr0qF5xubTUKFH6hJ.UaNThUYfueXJcXRrPck49oQHmH6DS2K', 0, 0, 0, '', 0),
(9, 'Dhoni', 'dhoni@gmail.com', '$2b$12$wcP78TWLjXd5nVlK9xA7VOgMJy6qHMkDL/lGXfmzPqL6YNoMRy/Ny', 0, 0, 0, '', 0),
(10, 'John Brown', 'john@gmail.com', '$2b$12$RQUZzkSznxaBqQzyykMgJekTD9hJD4eUb2ThG.8oMi6GhC8sJJxXS', 79.8, 75.9, 7.23, 'SNS College of Technology', 0);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `course`
--
ALTER TABLE `course`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `course`
--
ALTER TABLE `course`
  MODIFY `id` int(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
