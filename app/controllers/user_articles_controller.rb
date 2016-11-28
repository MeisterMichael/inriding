class UserArticlesController < ApplicationController

	before_filter :authenticate_user!
	before_filter :get_article, except: [ :create ]



	def create
		@article = SwellMedia::Article.new( article_params )
		@article.user = current_user
		@article.status = 'draft'
		@article.category ||= SwellMedia::Category.friendly.find('rides')

		if params[:article][:category_name].present?
			@article.category = SwellMedia::Category.where( name: params[:article][:category_name] ).first_or_create( status: 'active' )
		end

		if @article.save
			set_flash 'Article Created'
			redirect_to edit_user_article_path( @article )
		else
			set_flash 'Article could not be created', :error, @article
			redirect_to :back
		end
	end


	def destroy
		raise ActionController::RoutingError.new('Not Found') if @article.user != current_user

		@article.trash!
		set_flash 'Article Deleted'
		redirect_to :back
	end


	def edit
		raise ActionController::RoutingError.new('Not Found') if @article.user != current_user

		# create new working version if none exists or if not a draft
		# unless @article.working_media_version.try(:draft?)
		#
		# 	@article.update working_media_version: @article.media_versions.create
		#
		# end
		#
		# @current_draft = @article.working_media_version
	end


	def index
		raise ActionController::RoutingError.new('Not Found')
	end



	def preview
		@media = @article

		@media_comments = SwellSocial::UserPost.active.where( parent_obj_id: @media.id, parent_obj_type: @media.class.name ).order( created_at: :desc ) if defined?( SwellSocial )

		layout = @media.class.name.underscore.pluralize
		layout = @media.layout if @media.layout.present?

		render "swell_media/articles/show", layout: layout
	end


	def update
		raise ActionController::RoutingError.new('Not Found') if @article.user != current_user

		@article.attributes = article_params
		@article.avatar_urls = params[:article][:avatar_urls] if params[:article].present? && params[:article][:avatar_urls].present?
		@article.status = 'active' if params[:commit] == 'Publish'

		if @article.active? && @article.status_was == 'draft'
			@article.publish_at = Time.now
			@article.slug = nil
		end

		if @article.save
			set_flash 'Article Updated'
			redirect_to edit_user_article_path( @article.id )
		else
			set_flash 'Article could not be Updated', :error, @article
			render :edit
		end

	end


	private
	def article_params
		params.require( :article ).permit( :title, :subtitle, :description, :content, :category_id, :status, :publish_at, :show_title, :is_commentable, :user_id, :tags, :tags_csv, :avatar, :avatar_asset_file, :avatar_asset_url, :cover_path, :avatar_urls )
	end

	def get_article
		@article = SwellMedia::Article.friendly.find( params[:id] )
	end


end