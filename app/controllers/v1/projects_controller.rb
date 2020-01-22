class V1::ProjectsController < ApplicationController
  before_action :ensure_signed_in
  
  def index
    @projects = current_user.projects
    render json: @projects, each_serializer: ProjectSerializer, status: :ok
  end

  def show
    @project = current_user.projects.where(id: params[:id]).first
    
    if @project
      render json: @project, each_serializer: ProjectSerializer, status: :ok
    else
      render json: {
        error: "Project with id #{params[:id]} not found."
      }, status: :not_found
    end
  end

  def create
    @project = current_user.projects.build(project_params)

    @project.save
    render json: @project, each_serializer: ProjectSerializer, status: :created
  end

  def update
    @project = current_user.projects.where(id: params[:id]).first
    
    if @project
      @project.update(project_params)
      render json: @project, each_serializer: ProjectSerializer, status: :created
    else
      render json: {
        error: "Project with id #{params[:id]} not found."
      }, status: :not_found
    end
  end

  def destroy
    @project = current_user.projects.where(id: params[:id]).first
    
    if @project
      @project.destroy
      render json: { status: 'Success', message: 'Project was removed'}
    else
      render json: {
        error: "Project with id #{params[:id]} not found."
      }, status: :not_found
    end
  end

  private

  def project_params
    params.require(:project).permit(:name)
  end

  def ensure_signed_in
    if current_user.nil?
      head(:unauthorized)
    end
  end
end
