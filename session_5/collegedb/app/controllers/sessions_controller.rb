class SessionsController < ApplicationController
  def new
  end

  def create
    student = Student.find_by_email(params[:email])
    if student
      session[:student_id] = student.id
      redirect_to courses_url, notice: "Logged in successfully." 
    else 
      render 'new'
      flash[:alert] = "Unable to login."
    end 
  end

  def destroy
  end
end
