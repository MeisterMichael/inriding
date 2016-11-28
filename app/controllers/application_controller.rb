class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

	helper SwellMedia::Engine.helpers

	before_filter :init_page_meta
	before_filter :featured_results

	def after_sign_in_failure_path
		'/login?oauth_sign_in=1'
	end

	def after_sign_in_path_for(resource)

		main_app.articles_user_home_path()

	end

	protected
	def featured_results

		@featured_results = SwellMedia::Article.published.where('featured > 0').order(featured: :desc, score: :desc, publish_at: :desc, id: :desc).limit(6)
		@featured_results.where( id: ENV['FEATURED_RESULTS'].split(',').collect{|str| str.strip.to_i } ) if ENV['FEATURED_RESULTS'].present?

	end


end
