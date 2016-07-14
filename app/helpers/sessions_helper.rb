module SessionsHelper
	# logs in a given user
	def log_in(user)
		session[:user_id] = user.id
		
	end

	# remember a user in a permanent session
	def remember 
		user.remember
		cookies.permanent.signed[:user_id] = user.id
		cookies.permanent[:remember_token] = user.remember_token
	end

	# forget a user in a session
	def forget
		user.forget
		cookies.delete(:user_id)
		cookies.delete(:remember_token)
	end

	def current_user?
		user == current_user
	end
	# return the current user
	def current_user
	    if (user_id = session[:user_id])
	      @current_user ||= User.find_by(id: user_id)
	    elsif (user_id = cookies.signed[:user_id])
	      user = User.find_by(id: user_id)
	      if user && user.authenticated?(:remember, cookies[:remember_token])
	        log_in user
	        @current_user = user
	      end
	    end
	end
	#
	def logged_in?
		!current_user.nil?
	end
	#
	def log_out
		forget(current_user)
		session.delete(user_id)
		@current_user = nil
	end

	#redirected the default url 
	def redirect_back_or(default)
		reidirect_to(session[:forwarding_url] || default)
		session.delete[:forwarding_url]
	end

	#store the url trying to be  accessed
	def store_location
			session[:forwarding_url] = request.original_url if request.get?
		end	
end
