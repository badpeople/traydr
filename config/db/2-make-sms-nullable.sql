ALTER TABLE  `subscriptions` CHANGE  `to_sms`  `to_sms` VARCHAR( 255 ) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL ;

ALTER TABLE  `profiles` ADD  `image_square` VARCHAR( 255 ) NULL AFTER  `id` ,
ADD  `image_small` VARCHAR( 255 ) NULL AFTER  `image_square` ,
ADD  `image_large` VARCHAR( 255 ) NULL AFTER  `image_small` ,
ADD  `image_original` VARCHAR( 255 ) NULL AFTER  `image_large`;
