class V1::TasksController < ApplicationController
  before_action :authenticate_user!, :ensure_existing_project
  before_action :ensure_existing_task, only: [:show, :update, :destroy]
  
  def index
    tasks = project.tasks
    authorize tasks

    render json: tasks
  end

  def show
    task = project.tasks.where(id: params[:id]).first
    authorize task
      
    render json: task
  end

  def create
    task = project.tasks.build(task_params)
    authorize task

    task.save
    render json: task, status: :created
  end

  def update
    task = project.tasks.where(id: params[:id]).first
    authorize task

    task.update(task_params)
    render json: task, status: :created
  end

  def destroy
    task = project.tasks.where(id: params[:id]).first
    authorize task

    task.destroy
    render json: { status: 'Success', message: 'Task was removed' }
  end

  private

  def task_params
    params.require(:task).permit(:name, :priority, :is_done).merge(project_id: params[:project_id])
  end

  def ensure_existing_project
    if current_user.projects.where(id: params[:project_id]).first.nil?
      render json: {
        error: "Project with id #{params[:project_id]} not found."
      }, status: :not_found
    end
  end

  def project
    current_user.projects.find(params[:project_id])
  end

  def ensure_existing_task
    if project.tasks.where(id: params[:id]).first.nil?
      render json: {
        error: "Task with id #{params[:id]} not found."
      }, status: :not_found
    end
  end
end
