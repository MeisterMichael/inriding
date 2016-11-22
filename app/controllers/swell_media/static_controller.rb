module SwellMedia
	class StaticController < ApplicationController

		def about

			@page = SwellMedia::Page.friendly.find('about') rescue nil

			render layout: 'swell_media/pages'
		end

		def home
			# the homepage

			@page = SwellMedia::Page.friendly.find('home') rescue nil

			@results = SwellMedia::Article.published.where('featured > 0').order(featured: :desc, score: :desc, publish_at: :desc, id: :desc)
			@results = @results.page(params[:page]).per(6)

			render layout: 'swell_media/homepage'
		end

	end
end