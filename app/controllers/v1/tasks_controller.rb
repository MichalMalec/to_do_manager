class V1::TasksController < ApplicationController
  before_action :ensure_signed_in
  
  def index
    @tasks = current_user.tasks
    render json: @tasks, each_serializer: TaskSerializer, status: :ok
  end

  def show
    @task = current_user.tasks.where(id: params[:id]).first
      
    if @task
      render json: @task, each_serializer: TaskSerializer, status: :ok
    else
      render json: {
        error: "Task with id #{params[:id]} not found."
      }, status: :not_found
    end
  end

  def create
    @task = current_user.tasks.build(task_params)

    @task.save
    render json: @task, each_serializer: TaskSerializer, status: :created
  end

  def update
    @task = current_user.tasks.where(id: params[:id]).first

    if @task
      @task.update(task_params)
      render json: @task, each_serializer: TaskSerializer, status: :created
    else
      render json: {
        error: "Task with id #{params[:id]} not found."
      }, status: :not_found
    end
  end

  def destroy
    @task = current_user.tasks.where(id: params[:id]).first

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
end
