ALTER TABLE  `profiles` CHANGE  `image_large`  `image_medium` VARCHAR( 255 ) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL;

ALTER TABLE  `profiles` CHANGE  `image_square`  `image_square` VARCHAR( 255 ) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT  '/images/man_silhouette_square.png',
CHANGE  `image_small`  `image_small` VARCHAR( 255 ) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT  '/images/man_silhouette_small.png',
CHANGE  `image_medium`  `image_medium` VARCHAR( 255 ) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT  '/images/man_silhouette_medium.png',
CHANGE  `image_original`  `image_original` VARCHAR( 255 ) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT  '/images/man_silhouette_orig.png';

ALTER TABLE `profiles` CHANGE `image_square` `image_square` VARCHAR(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT '''/images/man_silhouette_square.png''', CHANGE `image_small` `image_small` VARCHAR(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT '''/images/man_silhouette_small.png''', CHANGE `image_medium` `image_medium` VARCHAR(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT '''/images/man_silhouette_medium.png''', CHANGE `image_original` `image_original` VARCHAR(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT '''/images/man_silhouette_orig.png'''