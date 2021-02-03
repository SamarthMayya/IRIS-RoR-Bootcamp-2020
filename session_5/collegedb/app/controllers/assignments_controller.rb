class AssignmentsController < ApplicationController
  def update
    @assignment = Assignment.find(params[:id])
    if @assignment.update(assignment_params)
      redirect_to course_path, notice: "Assignment submitted successfully."
    else 
      redirect_to course_path, notice: "Assignment couldn't be submitted."
    end 
  end

  def destroy
  end

  private 

    def assignment_params
      params.require(:assignment).permit(:name, :submission_deadline, :course_id, :submission)
    end 
end
