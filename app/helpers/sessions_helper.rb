module SessionsHelper

	def signed_in?
    !current_user.nil?
  end

  def sign_in(user)
    #cookies.permanent[:remember_token] = user.remember_token #Remember User Via Cookie
    session[:remember_token] = user.remember_token #Remember user only in this session
    current_user = user
    reset_cancan
  end

  def sign_out
    current_user = nil
    session[:remember_token] = nil
    cookies.delete(:remember_token)
    reset_cancan
  end

  #Getter
  def current_user
    @current_user ||= user_from_remember_token
  end

  def current_user=(user)
    @current_user = user
  end

  def current_user?(user)
    user == current_user
  end

  def signed_in_user
    unless signed_in?
      store_location
      redirect_to signin_path, notice: "Please sign in."
    end
  end
  
  #Setter


  def redirect_back_or(default)
    #redirect_to root_path
    
    redirect_to(session[:return_to] || default)
    clear_return_to
  end

  def store_location
    session[:return_to] = request.fullpath
  end


  private
    
    def reset_cancan
      @current_ability = nil
      @current_user = nil
    end
    
    def clear_return_to
      session.delete(:return_to)
    end
    
    def user_from_remember_token
      # remember_token = cookies[:remember_token] #Remember User Via Cookie
      remember_token = session[:remember_token] #Remember user only in this sesssion
      User.find_by_remember_token(remember_token) unless remember_token.nil?
    end
end