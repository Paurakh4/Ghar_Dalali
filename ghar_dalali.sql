-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: May 22, 2025 at 08:01 AM
-- Server version: 10.4.28-MariaDB
-- PHP Version: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `ghar_dalali`
--

-- --------------------------------------------------------

--
-- Table structure for table `contact_messages`
--

CREATE TABLE `contact_messages` (
  `message_id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `subject` varchar(255) NOT NULL,
  `message` text NOT NULL,
  `submitted_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `is_read` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `contact_messages`
--

INSERT INTO `contact_messages` (`message_id`, `user_id`, `name`, `email`, `phone`, `subject`, `message`, `submitted_at`, `is_read`) VALUES
(1, 34, 'Ram Dilbar', 'dilbar@gmail.com', '9800000000', 'yoooo!', 'helppppp!', '2025-05-21 14:52:44', 0),
(2, 34, 'asda', 'aasdas@sada.com', '9800000000', 'asd', 'asdas', '2025-05-21 14:56:57', 0),
(3, 34, 'asd', 'asd@ahsd.com', '9800000000', 'asdas', 'asds', '2025-05-21 15:04:10', 0),
(4, 34, 'asdasd', 'as@asd.com', '981782638712', 'asdas', 'dasd', '2025-05-21 15:04:39', 0);

-- --------------------------------------------------------

--
-- Table structure for table `properties`
--

CREATE TABLE `properties` (
  `property_id` int(11) NOT NULL,
  `property_name` varchar(100) NOT NULL,
  `property_type` enum('Apartment','House','Villa','Commercial','Land') NOT NULL,
  `description` text DEFAULT NULL,
  `location` varchar(255) NOT NULL,
  `price` decimal(12,2) NOT NULL,
  `bedrooms` int(11) DEFAULT NULL,
  `bathrooms` int(11) DEFAULT NULL,
  `size` decimal(10,2) DEFAULT NULL,
  `size_unit` varchar(10) DEFAULT 'sq.ft',
  `status` enum('FOR_SALE','FOR_RENT','SOLD','RENTED') NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `properties`
--

INSERT INTO `properties` (`property_id`, `property_name`, `property_type`, `description`, `location`, `price`, `bedrooms`, `bathrooms`, `size`, `size_unit`, `status`, `created_at`, `updated_at`) VALUES
(1, 'Luxury Villa', 'Apartment', 'awfsgdfgh', 'Kathmandu', 30000.00, 5, 5, 48.00, 'sq.ft', 'FOR_SALE', '2025-05-19 18:20:39', '2025-05-20 06:08:19'),
(2, 'Villa Serenity ', 'Villa', 'A tranquil sanctuary nestled in lush surroundings, Villa Serenity offers a peaceful retreat from the outside world. This distinguished residence combines timeless architecture with modern comforts, creating an atmosphere of refined relaxation. With its harmonious design and serene ambiance, Villa Serenity promises a lifestyle of elegant repose and understated luxury.', 'Butwal', 2000000.00, 5, 5, 255.00, 'sq.ft', 'FOR_SALE', '2025-05-20 06:10:42', '2025-05-20 20:51:37'),
(3, 'Modern Family Apartment', 'Apartment', 'Spacious, sunlit apartment with panoramic city views. Features an open-plan kitchen and living area, ideal for families.', 'Lalitpur', 120000.00, 3, 2, 1100.00, 'sq.ft', 'FOR_SALE', '2025-05-21 04:30:00', '2025-05-21 04:30:00'),
(4, 'Downtown Commercial Space', 'Commercial', 'Prime commercial property in the heart of the city. Suitable for offices, showrooms, or retail.', 'Kathmandu', 750000.00, NULL, 2, 2500.00, 'sq.ft', 'FOR_RENT', '2025-05-21 04:35:00', '2025-05-21 04:35:00'),
(5, 'Riverside Land Plot', 'Land', 'Large plot of land beside a river, perfect for development or investment.', 'Pokhara', 450000.00, NULL, NULL, 5000.00, 'sq.ft', 'FOR_SALE', '2025-05-21 04:40:00', '2025-05-21 04:40:00'),
(6, 'Hillside Retreat House', 'House', 'Charming house on a hillside with breathtaking mountain views. Quiet neighborhood.', 'Dhulikhel', 950000.00, 4, 3, 1800.00, 'sq.ft', 'FOR_SALE', '2025-05-21 04:45:00', '2025-05-21 04:45:00'),
(7, 'Urban Studio Apartment', 'Apartment', 'Compact studio apartment ideal for singles or students. Walking distance to major amenities.', 'Biratnagar', 45000.00, 1, 1, 500.00, 'sq.ft', 'FOR_RENT', '2025-05-21 04:50:00', '2025-05-21 04:50:00'),
(8, 'Luxury Penthouse Suite', 'Apartment', 'Exclusive penthouse with a private terrace and jacuzzi. High-end finishes throughout.', 'Kathmandu', 3000000.00, 4, 4, 2200.00, 'sq.ft', 'FOR_SALE', '2025-05-21 04:55:00', '2025-05-21 04:55:00'),
(9, 'Suburban Family House', 'House', 'Family-friendly house with a garden and children’s play area. Close to schools and parks.', 'Bhaktapur', 650000.00, 3, 2, 1600.00, 'sq.ft', 'FOR_SALE', '2025-05-21 05:00:00', '2025-05-21 05:00:00'),
(10, 'Commercial Office Tower', 'Commercial', 'Multi-story office tower with elevator access and parking.', 'Lalitpur', 5000000.00, NULL, 8, 10000.00, 'sq.ft', 'FOR_RENT', '2025-05-21 05:05:00', '2025-05-21 05:05:00'),
(11, 'Greenfield Land Parcel', 'Land', 'Undeveloped land ideal for agriculture or future construction.', 'Chitwan', 300000.00, NULL, NULL, 8000.00, 'sq.ft', 'FOR_SALE', '2025-05-21 05:10:00', '2025-05-21 05:10:00'),
(12, 'Studio Loft Apartment', 'Apartment', 'Trendy loft-style studio in a vibrant area with cafes and shops nearby.', 'Pokhara', 60000.00, 1, 1, 600.00, 'sq.ft', 'FOR_RENT', '2025-05-21 05:15:00', '2025-05-21 05:15:00'),
(13, 'City Center Flat', 'Apartment', 'Conveniently located flat with easy access to public transport and shopping areas.', 'Kathmandu', 150000.00, 2, 1, 900.00, 'sq.ft', 'FOR_RENT', '2025-05-21 05:25:00', '2025-05-21 05:25:00'),
(14, 'Lakeview Villa', 'Villa', 'Spectacular villa overlooking the lake, with landscaped gardens and a swimming pool.', 'Pokhara', 3500000.00, 6, 5, 3500.00, 'sq.ft', 'FOR_SALE', '2025-05-21 05:30:00', '2025-05-21 05:30:00'),
(15, 'Suburban Land Plot', 'Land', 'Ideal plot for residential development in a quiet suburb.', 'Birgunj', 250000.00, NULL, NULL, 4000.00, 'sq.ft', 'FOR_SALE', '2025-05-21 05:35:00', '2025-05-21 05:35:00'),
(16, 'Mountain View House', 'House', 'Beautiful house with panoramic mountain views and large balconies.', 'Dharan', 1200000.00, 5, 4, 2100.00, 'sq.ft', 'FOR_SALE', '2025-05-21 05:40:00', '2025-05-21 05:40:00'),
(17, 'Business Park Office Space', 'Commercial', 'Spacious office space in a modern business park. Ample parking and security.', 'Kathmandu', 1800000.00, NULL, 6, 6000.00, 'sq.ft', 'FOR_RENT', '2025-05-21 05:45:00', '2025-05-21 05:45:00'),
(18, 'Eco-Friendly House', 'House', 'Energy-efficient home with solar panels and rainwater harvesting.', 'Lalitpur', 800000.00, 3, 2, 1400.00, 'sq.ft', 'FOR_SALE', '2025-05-21 05:50:00', '2025-05-21 05:50:00'),
(19, 'Urban Retail Shop', 'Commercial', 'Street-level retail shop in a busy commercial area.', 'Pokhara', 300000.00, NULL, 1, 700.00, 'sq.ft', 'FOR_RENT', '2025-05-21 05:55:00', '2025-05-21 05:55:00'),
(20, 'Luxury Garden Villa', 'Villa', 'Exclusive villa surrounded by lush gardens with private parking.', 'Bhaktapur', 4000000.00, 7, 6, 3800.00, 'sq.ft', 'FOR_SALE', '2025-05-21 06:00:00', '2025-05-21 06:00:00'),
(21, 'Student Apartment Block', 'Apartment', 'Affordable apartments designed for students near university campuses.', 'Patan', 90000.00, 2, 1, 650.00, 'sq.ft', 'FOR_RENT', '2025-05-21 06:05:00', '2025-05-21 06:05:00'),
(22, 'Secluded Land Parcel', 'Land', 'Private land parcel surrounded by nature. Suitable for farmhouse or eco-resort.', 'Makwanpur', 220000.00, NULL, NULL, 7500.00, 'sq.ft', 'FOR_SALE', '2025-05-21 06:10:00', '2025-05-21 06:10:00');

-- --------------------------------------------------------

--
-- Table structure for table `property_applications`
--

CREATE TABLE `property_applications` (
  `application_id` int(11) NOT NULL,
  `property_id` int(11) NOT NULL,
  `userid` int(11) DEFAULT NULL,
  `full_name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `phone` varchar(20) NOT NULL,
  `message` text NOT NULL,
  `status` enum('PENDING','APPROVED','REJECTED') NOT NULL DEFAULT 'PENDING',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `property_applications`
--

INSERT INTO `property_applications` (`application_id`, `property_id`, `userid`, `full_name`, `email`, `phone`, `message`, `status`, `created_at`, `updated_at`) VALUES
(1, 1, 300, 'Paurakh Pyakurel', 'paurakh@admin.com', '9800000000', 'I am interested in this property and would like to schedule a viewing.', 'PENDING', '2025-05-20 07:30:53', '2025-05-21 08:30:56'),
(10, 13, 2, 'Bardan G', 'gogurung.bardan@gmail.com', '9827581286', 'I like this property and would like to have a talk about acquiring it', 'PENDING', '2025-05-20 18:38:11', '2025-05-20 18:41:53'),
(11, 13, 1, 'Messi', 'hola@gmail.com', '123454123', 'GOAT', 'PENDING', '2025-05-20 20:24:59', '2025-05-20 20:24:59'),
(12, 1, 34, 'asdas@aslkdja', 'asda@ANDKNS', '98000000', 'ASDASD', 'PENDING', '2025-05-21 10:58:16', '2025-05-21 10:58:16');

-- --------------------------------------------------------

--
-- Table structure for table `property_images`
--

CREATE TABLE `property_images` (
  `image_id` int(11) NOT NULL,
  `property_id` int(11) NOT NULL,
  `image_path` varchar(255) NOT NULL,
  `is_primary` tinyint(1) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `property_images`
--

INSERT INTO `property_images` (`image_id`, `property_id`, `image_path`, `is_primary`, `created_at`) VALUES
(1, 1, '/images/properties/property1.jpg', 1, '2025-05-21 11:59:40'),
(2, 1, '/images/properties/property2.jpg', 0, '2025-05-21 11:59:40'),
(3, 1, '/images/properties/property3.jpg', 0, '2025-05-21 11:59:40'),
(4, 2, '/images/properties/property4.jpg', 1, '2025-05-21 11:59:40'),
(5, 2, '/images/properties/property5.jpg', 0, '2025-05-21 11:59:40'),
(6, 2, '/images/properties/property6.jpg', 0, '2025-05-21 11:59:40'),
(7, 3, '/images/properties/property1.jpg', 1, '2025-05-21 11:59:40'),
(8, 3, '/images/properties/interior1.jpg', 0, '2025-05-21 11:59:40'),
(9, 4, '/images/properties/property2.jpg', 1, '2025-05-21 11:59:40'),
(10, 4, '/images/properties/interior2.jpg', 0, '2025-05-21 11:59:40'),
(11, 5, '/images/properties/property3.jpg', 1, '2025-05-21 11:59:40'),
(12, 5, '/images/properties/interior3.jpg', 0, '2025-05-21 11:59:40'),
(13, 6, '/images/properties/property4.jpg', 1, '2025-05-21 11:59:40'),
(14, 6, '/images/properties/interior4.jpg', 0, '2025-05-21 11:59:40'),
(15, 7, '/images/properties/property5.jpg', 1, '2025-05-21 11:59:40'),
(16, 7, '/images/properties/property6.jpg', 0, '2025-05-21 11:59:40'),
(17, 8, '/images/properties/property1.jpg', 1, '2025-05-21 11:59:40'),
(18, 8, '/images/properties/interior1.jpg', 0, '2025-05-21 11:59:40'),
(19, 9, '/images/properties/property2.jpg', 1, '2025-05-21 11:59:40'),
(20, 9, '/images/properties/interior2.jpg', 0, '2025-05-21 11:59:40'),
(21, 10, '/images/properties/property3.jpg', 1, '2025-05-21 11:59:40'),
(22, 10, '/images/properties/interior3.jpg', 0, '2025-05-21 11:59:40'),
(23, 11, '/images/properties/property4.jpg', 1, '2025-05-21 11:59:40'),
(24, 11, '/images/properties/interior4.jpg', 0, '2025-05-21 11:59:40'),
(25, 12, '/images/properties/property5.jpg', 1, '2025-05-21 11:59:40'),
(26, 12, '/images/properties/property6.jpg', 0, '2025-05-21 11:59:40'),
(27, 13, '/images/properties/property1.jpg', 1, '2025-05-21 11:59:40'),
(28, 13, '/images/properties/property2.jpg', 0, '2025-05-21 11:59:40'),
(29, 14, '/images/properties/property3.jpg', 1, '2025-05-21 11:59:40'),
(30, 14, '/images/properties/property4.jpg', 0, '2025-05-21 11:59:40'),
(31, 15, '/images/properties/property5.jpg', 1, '2025-05-21 11:59:40'),
(32, 15, '/images/properties/property6.jpg', 0, '2025-05-21 11:59:40'),
(33, 16, '/images/properties/property1.jpg', 1, '2025-05-21 11:59:40'),
(34, 16, '/images/properties/interior1.jpg', 0, '2025-05-21 11:59:40'),
(35, 17, '/images/properties/property2.jpg', 1, '2025-05-21 11:59:40'),
(36, 17, '/images/properties/interior2.jpg', 0, '2025-05-21 11:59:40'),
(37, 18, '/images/properties/property3.jpg', 1, '2025-05-21 11:59:40'),
(38, 18, '/images/properties/interior3.jpg', 0, '2025-05-21 11:59:40'),
(39, 19, '/images/properties/property4.jpg', 1, '2025-05-21 11:59:40'),
(40, 19, '/images/properties/interior4.jpg', 0, '2025-05-21 11:59:40'),
(41, 20, '/images/properties/property5.jpg', 1, '2025-05-21 11:59:40'),
(42, 20, '/images/properties/property6.jpg', 0, '2025-05-21 11:59:40'),
(43, 21, '/images/properties/property1.jpg', 1, '2025-05-21 11:59:40'),
(44, 21, '/images/properties/property2.jpg', 0, '2025-05-21 11:59:40'),
(45, 22, '/images/properties/property3.jpg', 1, '2025-05-21 11:59:40'),
(46, 22, '/images/properties/property4.jpg', 0, '2025-05-21 11:59:40'),
(47, 22, '/images/properties/property5.jpg', 0, '2025-05-21 11:59:40'),
(48, 22, '/images/properties/property6.jpg', 0, '2025-05-21 11:59:40');

-- --------------------------------------------------------

--
-- Table structure for table `reviews`
--

CREATE TABLE `reviews` (
  `review_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `property_id` int(11) NOT NULL,
  `rating` int(11) NOT NULL CHECK (`rating` between 1 and 5),
  `review_text` text DEFAULT NULL,
  `reviewed_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `status` varchar(20) DEFAULT 'PENDING'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `reviews`
--

INSERT INTO `reviews` (`review_id`, `user_id`, `property_id`, `rating`, `review_text`, `reviewed_at`, `updated_at`, `status`) VALUES
(13, 34, 2, 5, 'asda', '2025-05-21 20:32:08', '2025-05-21 20:32:08', 'PENDING');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `userid` int(11) NOT NULL,
  `username` varchar(100) NOT NULL,
  `contactNumber` varchar(15) DEFAULT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role` varchar(20) DEFAULT 'buyer',
  `address` varchar(255) DEFAULT NULL,
  `profilePicture` varchar(255) DEFAULT NULL,
  `bio` text DEFAULT NULL,
  `created_date` timestamp NOT NULL DEFAULT current_timestamp(),
  `status` varchar(20) DEFAULT 'Active'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`userid`, `username`, `contactNumber`, `email`, `password`, `role`, `address`, `profilePicture`, `bio`, `created_date`, `status`) VALUES
(33, 'durga', '9800000000', 'durga@superadmin.com', '40e865ba40ffa0cdf76db266bb51ca9d5c641219f9c495586a1460128109536c', 'admin', NULL, NULL, NULL, '2025-05-21 08:29:42', 'Active'),
(34, 'user', '9810000000', 'user@example.com', '561fe050a1a70d8debff4f5fde7a258270f07b09e7e967223c8329b91e56657a', 'buyer', 'Baneswor', NULL, 'I am a user', '2025-05-21 10:33:15', 'Active'),
(35, 'kalu', '9800000000', 'kalu@hehe.com', '8fb78fc33298985a321efe5ee8440726bcf0827967aed22ff512b1b4b9e41f1a', 'buyer', NULL, NULL, NULL, '2025-05-21 16:14:23', 'Active'),
(37, 'asdasd', '9840000000', 'asd@gmail.com', 'cb6f3ba16a6ddc7ae4f79f410abcd4187de72f269908baad3b3849e415271cd2', 'buyer', NULL, NULL, NULL, '2025-05-21 18:41:23', 'Active'),
(38, 'Ella', '9853636373', 'ella@email.com', '8080dbc35058d81f263929ea2765d1922d4f016087963def101ab8662f297aad', 'buyer', NULL, NULL, NULL, '2025-05-22 02:29:49', 'Active');

-- --------------------------------------------------------

--
-- Table structure for table `user_activities`
--

CREATE TABLE `user_activities` (
  `activity_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `activity_type` varchar(50) NOT NULL,
  `description` text NOT NULL,
  `entity_type` varchar(50) DEFAULT NULL,
  `entity_id` int(11) DEFAULT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `user_activities`
--

INSERT INTO `user_activities` (`activity_id`, `user_id`, `activity_type`, `description`, `entity_type`, `entity_id`, `ip_address`, `created_at`) VALUES
(1, 27, 'LOGIN', 'User logged in', 'USER', 27, '127.0.0.1', '2025-05-19 18:49:07'),
(2, 27, 'PROPERTY_ADD', 'Added new property: Luxury Villa', 'PROPERTY', 1, '127.0.0.1', '2025-05-19 18:49:07'),
(3, 27, 'PROPERTY_UPDATE', 'Updated property: Family House', 'PROPERTY', 2, '127.0.0.1', '2025-05-19 18:49:07'),
(4, 27, 'USER_UPDATE', 'Updated user profile', 'USER', 302, '127.0.0.1', '2025-05-19 18:49:07'),
(5, 300, 'LOGIN', 'User logged in', 'USER', 300, '127.0.0.1', '2025-05-19 18:49:07'),
(6, 300, 'PROPERTY_VIEW', 'Viewed property details', 'PROPERTY', 1, '127.0.0.1', '2025-05-19 18:49:07'),
(7, 27, 'PROPERTY_APPLICATION', 'Applied for property ID: 3', 'PROPERTY', 3, '0:0:0:0:0:0:0:1', '2025-05-20 08:08:24'),
(8, 27, 'PROPERTY_APPLICATION', 'Applied for property ID: 3', 'PROPERTY', 3, '0:0:0:0:0:0:0:1', '2025-05-20 08:15:47');

-- --------------------------------------------------------

--
-- Table structure for table `user_property`
--

CREATE TABLE `user_property` (
  `user_id` int(11) NOT NULL,
  `property_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `user_property_image`
--

CREATE TABLE `user_property_image` (
  `user_id` int(11) NOT NULL,
  `property_id` int(11) NOT NULL,
  `image_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `contact_messages`
--
ALTER TABLE `contact_messages`
  ADD PRIMARY KEY (`message_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `properties`
--
ALTER TABLE `properties`
  ADD PRIMARY KEY (`property_id`),
  ADD KEY `idx_property_type` (`property_type`),
  ADD KEY `idx_location` (`location`),
  ADD KEY `idx_status` (`status`),
  ADD KEY `idx_price` (`price`);

--
-- Indexes for table `property_applications`
--
ALTER TABLE `property_applications`
  ADD PRIMARY KEY (`application_id`),
  ADD KEY `idx_property_id` (`property_id`),
  ADD KEY `idx_user_id` (`userid`),
  ADD KEY `idx_status` (`status`),
  ADD KEY `idx_created_at` (`created_at`);

--
-- Indexes for table `property_images`
--
ALTER TABLE `property_images`
  ADD PRIMARY KEY (`image_id`),
  ADD KEY `idx_property_id` (`property_id`);

--
-- Indexes for table `reviews`
--
ALTER TABLE `reviews`
  ADD PRIMARY KEY (`review_id`),
  ADD UNIQUE KEY `unique_user_property_review` (`user_id`,`property_id`),
  ADD KEY `idx_user_id` (`user_id`),
  ADD KEY `idx_property_id` (`property_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`userid`),
  ADD UNIQUE KEY `username` (`username`);

--
-- Indexes for table `user_activities`
--
ALTER TABLE `user_activities`
  ADD PRIMARY KEY (`activity_id`),
  ADD KEY `idx_user_id` (`user_id`),
  ADD KEY `idx_activity_type` (`activity_type`),
  ADD KEY `idx_created_at` (`created_at`);

--
-- Indexes for table `user_property`
--
ALTER TABLE `user_property`
  ADD PRIMARY KEY (`user_id`,`property_id`);

--
-- Indexes for table `user_property_image`
--
ALTER TABLE `user_property_image`
  ADD PRIMARY KEY (`user_id`,`property_id`,`image_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `contact_messages`
--
ALTER TABLE `contact_messages`
  MODIFY `message_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `properties`
--
ALTER TABLE `properties`
  MODIFY `property_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=27;

--
-- AUTO_INCREMENT for table `property_applications`
--
ALTER TABLE `property_applications`
  MODIFY `application_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `property_images`
--
ALTER TABLE `property_images`
  MODIFY `image_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=53;

--
-- AUTO_INCREMENT for table `reviews`
--
ALTER TABLE `reviews`
  MODIFY `review_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `userid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=39;

--
-- AUTO_INCREMENT for table `user_activities`
--
ALTER TABLE `user_activities`
  MODIFY `activity_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `contact_messages`
--
ALTER TABLE `contact_messages`
  ADD CONSTRAINT `contact_messages_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`userid`) ON DELETE SET NULL;

--
-- Constraints for table `property_images`
--
ALTER TABLE `property_images`
  ADD CONSTRAINT `property_images_ibfk_1` FOREIGN KEY (`property_id`) REFERENCES `properties` (`property_id`) ON DELETE CASCADE;

--
-- Constraints for table `user_property_image`
--
ALTER TABLE `user_property_image`
  ADD CONSTRAINT `user_property_image_ibfk_1` FOREIGN KEY (`user_id`,`property_id`) REFERENCES `user_property` (`user_id`, `property_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
