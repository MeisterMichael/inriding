
SwellMedia.configure do |config|

	config.registered_media_types = [ 'SwellMedia::Article', 'SwellMedia::Page' ]
	config.app_name = 'InRiding'
	config.app_host = ENV['APP_DOMAIN'] || 'localhost:3000'
	config.article_avatars = ['featured', 'pinterest']
	config.asset_host = ENV['ASSET_HOST']
	config.app_description = 'Discover the best rides and gear from our community of avid cyclists.'
	config.app_logo = 'https://media.licdn.com/media/p/1/000/27f/2a3/36f3707.jpg'
	config.twitter_handle = '@inriding'
	config.max_session_inactivity = 30.minutes
	config.encryption_secret = 'fdty45u654jtyredhgr4u654etrhdht54eu6e5hdrt5'
	config.registered_user_class = '::User'
	config.default_user_status = 'pending'
	config.google_analytics_code = ENV['GA_TRACKING_ID']
	config.google_analytics_site = ENV['APP_DOMAIN'] || 'localhost:3000'
	config.default_protocol = 'http'
	config.site_map_url = "#{ENV['ASSET_HOST'] || "http://#{ENV['FOG_DIRECTORY']}.s3.amazonaws.com"}/sitemaps/sitemap.xml.gz"
	# config.reserved_words = [ 'about', 'aboutus', 'account', 'admin', 'adm1n', 'administer', 'administor', 'administrater', 'administrator', 'anonymous', 'api', 'app', 'apps', 'auth', 'auther', 'author', 'blog', 'blogger', 'cache', 'changelog', 'ceo', 'config', 'contact', 'contact_us', 'contributer', 'contributor', 'cpanel', 'create', 'delete', 'directer', 'director', 'download', 'dowloads', 'edit', 'editer', 'editor', 'email', 'emailus', 'faq', 'favorites', 'feed', 'feeds', 'follow', 'followers', 'following', 'get', 'guest', 'help', 'home', 'hot', 'how_it_works', 'how-ti-works', 'howitworks', 'info', 'invitation', 'invitations', 'invite', 'jobs', 'list', 'lists', 'loggedin', 'loggedout', 'login', 'logout', 'member', 'members', 'moderater', 'moderator', 'mysql', 'new', 'news', 'nobody', 'oauth', 'openid', 'open_id', 'operater', 'operator', 'oracle', 'organizations', 'owner', 'popular', 'porn', 'postmaster', 'president', 'promo', 'promos', 'promotions', 'privacy', 'put', 'registar', 'register', 'registrar', 'remove', 'replies', 'retailer', 'retailers', 'root', 'rss', 'save', 'search', 'security', 'sessions', 'settings', 'signout', 'signup', 'sitemap', 'ssl', 'staff', 'status', 'stories', 'subscribe', 'support', 'terms', 'test', 'tester', 'tour', 'top', 'trending', 'unfollow', 'unsubscribe', 'update', 'url', 'user', 'users', 'vicepresident', 'viagra', 'webmaster', 'widget', 'widgets', 'wiki', 'wishlist', 'xfn', 'xmpp', 'xxx' ]
	# config.require_email_collector = false

	config.default_layouts = {
			'swell_media/categories#show' => 'categories'
	}
	config.froala_editor_key = nil

	# config.contact_email_to 	= false
	# config.contact_email_from = false

end

