class ApplicationController < ActionController::Base
    helper_method :current_user
    rescue_from CanCan::AccessDenied do |exception|
      redirect_to root_url, notice: "You have #{current_user.private_articles_remaining} private articles remaining"
    end 
    # rescue_from CanCan::AccessDenied do |exception|
      # control = exception.subject.to_s 
      # act = exception.action.to_s 
      #if !current_user 
      #  redirect_to root_url, notice: "You must be logged in"
      #elsif control.include? 'Article'
      #  if ['edit','destroy'].any? { |str| str == act }
      #    redirect_to root_url, notice: "You cannot edit or delete other peoples' articles"
      #  elsif current_user.private_articles_remaining == 0
      #    redirect_to root_url, notice: "You have exhausted your quota of private articles"
      #  end 
      #else
      #  redirect_to root_url, notice: "Not authorised to #{exception.action} #{exception.subject}"
      #end 
    #end 

    def current_user
      if session[:user_id]
        @current_user ||= User.find(session[:user_id])
      else
        @current_user = nil 
      end 
    end 
end
