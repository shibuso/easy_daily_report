class ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  before_action :without_partner

  def index
    page = params[:page].presence || 1
    @projects = Project.order(id: :desc).page(page).per(Settings.project.per)
  end

  def show
    @year = params[:year].to_i == 0 ? Time.now.year : params[:year].to_i
    @works = {}
    (1..12).each do |month|
     @works[month] = Work.select('reports.user_id AS user_id, users.name AS name, SUM(works.time) AS time').
         joins(:report).
         joins('INNER JOIN users ON reports.user_id = users.id').
         where('works.project_id = ? AND reports.target_date BETWEEN ? AND ?', @project.id, Date.new(@year, month), Date.new(@year, month).end_of_month).
         group('reports.user_id')
    end
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
    params.require(:project).permit(:customer_id, :name, :status, user_ids: [])
  end
end
