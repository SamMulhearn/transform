class CommentsController < ApplicationController
	def new
		if signed_in?
			@rfc = Rfc.find(params[:rfc_id])
			@comment = @rfc.comments.build(:user => current_user)
		else
			store_location
      redirect_to signin_path, notice: "Sorry, you need to be logged in to add a comment"
		end
	end
	def index
		@comments = Rfc.find(params[:rfc_id]).comments
		logger.debug "RFC:#{Rfc.find(params[:rfc_id]).id}"
	end

	def create
		@comment = Comment.new(params[:comment])
		@comment.user = current_user
		@comment.rfc = Rfc.find(params[:rfc_id])
		if @comment.save!
      		redirect_to rfc_path(@comment.rfc), notice: "Your comment has been added."
    	else
      		render new
    	end
	end
end
