ALTER TABLE  `subscriptions` ADD  `paypal_payer_email` VARCHAR( 255 ) NULL ,
ADD  `paypal_subscr_id` VARCHAR( 255 ) NULL ,
ADD  `paypal_payer_id` VARCHAR( 255 ) NULL;

ALTER TABLE subscriptions ADD UNIQUE KEY (system_id, user_id);