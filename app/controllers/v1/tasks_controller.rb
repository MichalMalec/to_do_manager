class V1::TasksController < ApplicationController
  before_action :ensure_signed_in
  
  def index
    @tasks = project.tasks
    render json: @tasks
  end

  def show
    @task = project.tasks.where(id: params[:id]).first
      
    if @task
      render json: @task
    else
      render json: {
        error: "Task with id #{params[:id]} not found."
      }, status: :not_found
    end
  end

  def create
    @task = project.tasks.build(task_params)

    @task.save
    render json: @task, status: :created
  end

  def update
    @task = project.tasks.where(id: params[:id]).first

    if @task
      @task.update(task_params)
      render json: @task, status: :created
    else
      render json: {
        error: "Task with id #{params[:id]} not found."
      }, status: :not_found
    end
  end

  def destroy
    @task = project.tasks.where(id: params[:id]).first

    if @task
      @task.destroy
      render json: { status: 'Success', message: 'Task was removed' }
    else
      render json: {
        error: "Task with id #{params[:id]} not found."
      }, status: :not_found
    end
  end

  private

  def task_params
    params.require(:task).permit(:name, :priority, :is_done).merge(project_id: params[:project_id])
  end

  def ensure_signed_in
    if current_user.nil?
      head(:unauthorized)
    end
  end

  def project
    current_user.projects.find(params[:project_id])
  end
end
