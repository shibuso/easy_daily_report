class ReportsController < ApplicationController
  before_action :set_report, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  def index
    @reports = Report.all
  end

  def show
  end

  def new
    @report = Report.new
    @projects = current_user.projects
  end

  def edit
    @projects = current_user.projects
  end

  def confirm
    # render text: params and return
    if request.post?
      @report = Report.new(report_params)
    else
      @report = Report.find(params[:id])
      @report.attributes = report_params
    end

    unless @report.valid?
      @projects = current_user.projects
      render :action => request.post? ? :new : :edit
      return
    end
  end

  def create
    # render text: params and return
    @report = Report.new(report_params)
    @report.user_id = current_user.id
    if @report.save
      redirect_to reports_url, notice: '正常に日報が投稿されました。'
    else
      @projects = current_user.projects
      render :new
    end
  end

  def update
    if @report.update(report_params)
      redirect_to @report, notice: '正常に日報が更新されました。'
    else
      render :edit
    end
  end

  def destroy
    @report.destroy
    redirect_to reports_url, notice: '正常に日報が削除されました。'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_report
      @report = Report.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def report_params
      params.require(:report).permit(:id, :target_date, :question, :impression, works_attributes: [:id, :project_id, :report_id, :time, :detail, :_destroy])
    end
end
