class V1::ProjectsController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_existing_project, only: [:show, :update, :destroy]
  
  def index
    projects = current_user.projects
    authorize projects

    render json: projects
  end

  def show
    project = current_user.projects.where(id: params[:id]).first
    authorize project
    
    render json: project
  end

  def create
    project = current_user.projects.build(project_params)
    authorize project

    project.save
    render json: project, status: :created
  end

  def update
    project = current_user.projects.where(id: params[:id]).first
    authorize project

    project.update(project_params)
    render json: project, status: :created
  end

  def destroy
    project = current_user.projects.where(id: params[:id]).first
    authorize project

    project.destroy
    render json: { status: 'Success', message: 'Project was removed' }
  end

  private

  def project_params
    params.require(:project).permit(:name)
  end

  def ensure_existing_project
    if current_user.projects.where(id: params[:id]).first.nil?
      render json: {
        error: "Project with id #{params[:id]} not found."
      }, status: :not_found
    end
  end
end
