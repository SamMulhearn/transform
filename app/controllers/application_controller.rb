class ApplicationController < ActionController::Base
  protect_from_forgery
  include SessionsHelper

	rescue_from CanCan::AccessDenied do |exception|
    if signed_in?
    	redirect_to root_url, :alert => exception.message
    else
    	store_location
    	redirect_to signin_path, :alert => "Try signing in first. #{exception.message}"
    end
  end

end
