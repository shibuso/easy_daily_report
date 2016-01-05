class ReportsController < ApplicationController
  before_action :set_report, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  def index
    page = params[:page].presence || 1
    @reports = Report.published.order_update_newest.page(page).per(Settings.report.per)
  end

  def show
    if @report.status == Settings.report.status_types.draft
      redirect_to reports_url, alert: '該当のページは存在しません。'
      return
    end
  end

  def new
    @report = Report.new
    @report.target_date = Date.today
    @projects = current_user.projects.active
    @draft_count = current_user.reports.draft.count
  end

  def edit
    redirect_to reports_url, alert: '編集権限がありません。' and return if @report.user != current_user

    @projects = current_user.projects.active
  end

  def confirm
    # render text: params and return
    @projects = current_user.projects.active

    if request.post?
      @report = Report.new(report_params)
      @report.user_id = current_user.id
    else
      @report = Report.find(params[:id])
      @report.attributes = report_params
    end

    redirect_to reports_url, alert: '編集権限がありません。' and return if @report.user != current_user

    @draft_count = current_user.reports.draft.count
    if params['report']['works_attributes'].blank?
      flash.now[:alert] = 'プロジェクトを追加してください。'
      render :action => request.post? ? :new : :edit and return
    end

    params['report']['works_attributes'].each do |key, work|
      if (work['project_id'].blank?)
        flash.now[:alert] = 'プロジェクトを指定してください。'
        render :action => request.post? ? :new : :edit and return
      end
    end

    unless @report.valid?
      render :action => request.post? ? :new : :edit and return
    end

    if @report.status == Settings.report.status_types.draft && @report.save
      redirect_to reports_url, notice: '下書きが保存されました。' and return
    end
  end

  def create
    # render text: params and return
    @report = Report.new(report_params)
    @report.user_id = current_user.id
    @report.status = Settings.report.status_types.published
    if @report.save
      redirect_to reports_url, notice: '日報を投稿しました。'
    else
      @projects = current_user.projects.active
      render :new
    end
  end

  def update
    redirect_to reports_url, alert: '編集権限がありません。' and return if @report.user != current_user

    if @report.update(report_params)
      redirect_to @report, notice: '日報を更新しました。'
    else
      render :edit
    end
  end

  def destroy
    unless current_user == @report.user || current_user.user_type == Settings.user_types.admin
      redirect_to reports_url, alert: '削除権限がありません。' and return
    end
    @report.destroy
    redirect_to reports_url, notice: '日報を削除しました。'
  end

  def drafts
    page = params[:page].presence || 1
    @reports = current_user.reports.draft.order_update_newest.page(page).per(Settings.report.per)
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_report
    @report = Report.find(params[:id])
  rescue => e
    redirect_to reports_url, alert: '該当のページは存在しません。'
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def report_params
    params.require(:report).permit(:id, :target_date, :question, :impression, :status, works_attributes: [:id, :project_id, :report_id, :time, :detail, :_destroy])
  end
end
