if [ -f /var/www/wordpress/wp-config.php ]
then
	echo "wordpress already installed"
else
	echo "This in the first launch of this website, let's begin the set up ! It will take a while."
	wget https://fr.wordpress.org/latest-fr_FR.tar.gz
	tar -xzvf latest-fr_FR.tar.gz
	rm latest-fr_FR.tar.gz
	if [ -f /usr/bin/wp ]
	then
		echo "wp-cli already installed"
	else
		wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
		chmod +x wp-cli.phar
		mv wp-cli.phar /usr/bin/wp
	fi
	echo "<?php
			define('DB_NAME', '${MYSQL_DATABASE}');
			define('DB_USER', '${MYSQL_USER}');
			define('DB_PASSWORD', '${MYSQL_PASSWORD}');
			define('DB_HOST', '${MYSQL_HOSTNAME}');
			define('DB_CHARSET','utf8');
			define('DB_COLLATE','');
			define( 'AUTH_KEY',         'eifwifbweifbwifbwi' );
			define( 'SECURE_AUTH_KEY',  'ger98jawwgwqhw' );
			define( 'LOGGED_IN_KEY',    'qyw4jeq8j1w9e8t4' );
			define( 'NONCE_KEY',        'eachw1jw5j4aw98' );
			define( 'AUTH_SALT',        'pascmpohrjsw61u4rn' );
			define( 'SECURE_AUTH_SALT', 'apmapbktahykoaee481ba4ery1b3' );
			define( 'LOGGED_IN_SALT',   'qounsun14s6s1423' );
			define( 'NONCE_SALT',       'POUMVGHAnomcgwe879v4w1' );" > /var/www/wordpress/wp-config.php
	echo -n	'$table_prefix' >> /var/www/wordpress/wp-config.php
	echo	" = 'wp_';
			define( 'WP_DEBUG', true );
			if ( ! defined('ABSPATH')) {
				define('ABSPATH', __DIR__ . '/');
			}
		require_once ABSPATH . 'wp-settings.php';
			?>" >> /var/www/wordpress/wp-config.php
	echo "Waiting for mariadb init"
	sleep 5
	echo "Users creation."
	wp core install --path='/var/www/wordpress' --url='njaros.42lyon.fr' --title='incepfion' --admin_user='pouetpouet' --admin_password='pouet' --admin_email='pouetpouet@osef.com' --allow-root;
	wp user create --path='var/www/wordpress' --allow-root 'michel' 'michel@lebg.fr' --user_pass='pouet' --role=author;
fi

/usr/sbin/php-fpm7.3 -F
