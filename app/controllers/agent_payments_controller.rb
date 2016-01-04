class AgentPaymentsController < ApplicationController
  before_action :set_agent_payment, only: [:show, :edit, :update, :destroy]

  # GET /agent_payments
  # GET /agent_payments.json
  def index
    @agent_payments = AgentPayment.all
  end

  # GET /agent_payments/1
  # GET /agent_payments/1.json
  def show
  end

  # GET /agent_payments/new
  def new
    @agent_payment = AgentPayment.new
    @agent_payment.pb_member = PbMember.find(params[:member_id])
  end

  # GET /agent_payments/1/edit
  def edit
  end

  # POST /agent_payments
  # POST /agent_payments.json
  def create
    @agent_payment = AgentPayment.new(agent_payment_params)
    @agent_payment.user = @current_user

    respond_to do |format|
      if @agent_payment.save
        format.html { redirect_to admin_agent_list_deals_path, notice: 'Agent payment was successfully created.' }
        format.json { render :show, status: :created, location: @agent_payment }
      else
        format.html { render :new }
        format.json { render json: @agent_payment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /agent_payments/1
  # PATCH/PUT /agent_payments/1.json
  def update
    respond_to do |format|
      if @agent_payment.update(agent_payment_params)
        format.html { redirect_to admin_agent_list_deals_path, notice: 'Agent payment was successfully updated.' }
        format.json { render :show, status: :ok, location: @agent_payment }
      else
        format.html { render :edit }
        format.json { render json: @agent_payment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /agent_payments/1
  # DELETE /agent_payments/1.json
  def destroy
    @agent_payment.destroy
    respond_to do |format|
      format.html { redirect_to agent_payments_url, notice: 'Agent payment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  
  def user_payments
    respond_to do |format|
      format.html
      format.json {
        result = AgentPayment.user_payments(params, @current_user)    
        render json: result[:result]
      }
    end    
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_agent_payment
      @agent_payment = AgentPayment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def agent_payment_params
      params.require(:agent_payment).permit(:deal_id, :payment_type, :pb_member_id, :amount, :user_id, :note)
    end
end
