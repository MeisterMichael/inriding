class UserHomeController < ApplicationController

	before_filter :authenticate_user!



	def articles

		@articles = SwellMedia::Article.where( user: current_user, status: [ 'draft', 'active' ] )


		@articles = @articles.page(params[:page]).per(8)

	end

	def profile

	end

	def profile_update

		current_user.update( params.require(:user).permit(:full_name, :avatar) )

	end

end

