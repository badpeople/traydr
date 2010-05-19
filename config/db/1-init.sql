-- phpMyAdmin SQL Dump
-- version 2.10.0.2
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Apr 27, 2010 at 06:30 PM
-- Server version: 5.0.27
-- PHP Version: 4.3.11RC1-dev

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";

--
-- Database: `traydr_development`
--

-- --------------------------------------------------------

--
-- Table structure for table `emailalerts`
--

CREATE TABLE `emailalerts` (
  `id` int(11) NOT NULL auto_increment,
  `system_id` int(11) NOT NULL,
  `title` text NOT NULL,
  `body` text NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `send_at` datetime NOT NULL,
  `status` varchar(255) NOT NULL,
  PRIMARY KEY  (`id`),
  KEY `system_id` (`system_id`,`send_at`),
  KEY `send_at` (`send_at`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=9 ;

-- --------------------------------------------------------

--
-- Table structure for table `profiles`
--

CREATE TABLE `profiles` (
  `id` int(11) NOT NULL auto_increment,
  `user_id` int(11) NOT NULL,
  `first_name` varchar(255) default NULL,
  `last_name` varchar(255) default NULL,
  `blog` varchar(255) default NULL,
  `covestor` varchar(255) default NULL,
  `stocktwits` varchar(255) default NULL,
  `kaching` varchar(255) default NULL,
  `personal_blurb` text,
  `style_blurb` text,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`,`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=9 ;

-- --------------------------------------------------------

--
-- Table structure for table `smsalerts`
--

CREATE TABLE `smsalerts` (
  `id` bigint(20) NOT NULL auto_increment,
  `system_id` int(11) NOT NULL,
  `message` text NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `send_at` datetime NOT NULL,
  `status` varchar(255) NOT NULL,
  PRIMARY KEY  (`id`),
  KEY `created_at` (`created_at`),
  KEY `send_at` (`send_at`),
  KEY `status` (`status`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=2 ;

-- --------------------------------------------------------

--
-- Table structure for table `subscriptions`
--

CREATE TABLE `subscriptions` (
  `id` int(11) NOT NULL auto_increment,
  `system_id` int(11) NOT NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  `status` varchar(64) NOT NULL,
  `to_email` varchar(255) NOT NULL,
  `to_sms` varchar(255) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY  (`id`),
  KEY `user_id` (`user_id`),
  KEY `system_id` (`system_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=6 ;

-- --------------------------------------------------------

--
-- Table structure for table `systems`
--

CREATE TABLE `systems` (
  `id` int(11) NOT NULL auto_increment,
  `user_id` int(11) NOT NULL,
  `name` varchar(255) default NULL,
  `description` text,
  `price_email` decimal(10,0) default NULL,
  `price_sms` decimal(10,0) default NULL,
  `frequency_expected` int(11) default NULL,
  `frequency_actual` int(11) default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=10 ;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL auto_increment,
  `username` varchar(255) default NULL,
  `email` varchar(255) default NULL,
  `password_hash` varchar(255) default NULL,
  `password_salt` varchar(255) default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  `admin` tinyint(1) NOT NULL default '0',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=14 ;
