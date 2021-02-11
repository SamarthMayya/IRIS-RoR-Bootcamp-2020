class AssignmentsController < ApplicationController
  def update
    @assignment = Assignment.find(params[:id])
    if @assignment.update(assignment_params)
      redirect_to @assignment.course, notice: "Assignment submitted successfully."
    else 
      redirect_to @assignment.course, notice: "Assignment couldn't be submitted."
    end 
  end

  def destroy
    @assignment = Assignment.find(params[:id])
    @assignment.destroy 
    redirect_to @assignment.course, notice: "Assignment deleted successfully."
  end

  private 

    def assignment_params
      params.require(:assignment).permit(:name, :submission_deadline, :course_id)
    end 
end
