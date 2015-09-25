class ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  def index
    @projects = Project.all.order(id: :desc)
  end

  def show
  end

  def new
    @project = Project.new
  end

  def edit
  end

  def create
    @project = Project.new(project_params)
    @project.status = 'active'
    if @project.save
      redirect_to projects_url, notice: '正常にプロジェクト情報が登録されました。'
    else
      render :new
    end
  end

  def update
    if @project.update(project_params)
      redirect_to @project, notice: '正常にプロジェクト情報が更新されました。'
    else
      render :edit
    end
  end

  def destroy
    #TODO 削除する前に紐付いてる情報が無いかの確認
    if true
      redirect_to projects_url, alert: '紐付いた日報があるため削除できません。' and return
    end

    @project.destroy
    redirect_to projects_url, notice: '正常にプロジェクト情報が削除されました。'
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_project
    @project = Project.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def project_params
    params.require(:project).permit(:customer_id, :name, user_ids: [])
  end
end
