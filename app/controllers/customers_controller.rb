class CustomersController < ApplicationController
  before_action :set_customer, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  before_action :without_partner

  def index
    @customers = Customer.all.order(id: :desc)
  end

  def show
  end

  def new
    @customer = Customer.new
  end

  def edit
  end

  def create
    @customer = Customer.new(customer_params)

    if @customer.save
      redirect_to customers_url, notice: '正常に顧客情報が登録されました。'
    else
      render :new
    end
  end

  def update
    if @customer.update(customer_params)
      redirect_to @customer, notice: '正常に顧客情報が更新されました。'
    else
      render :edit
    end
  end

  def destroy
    if @customer.projects.present?
      redirect_to customers_url, alert: 'プロジェクトが登録されているため削除できません。' and return
    end
    @customer.destroy
    redirect_to customers_url, notice: '正常に顧客情報が削除されました。'
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_customer
    @customer = Customer.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def customer_params
    params.require(:customer).permit(:name)
  end
end
