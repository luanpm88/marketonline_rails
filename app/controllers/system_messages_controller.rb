class SystemMessagesController < ApplicationController
  #load_and_authorize_resource
  before_action :set_system_message, only: [:delete, :show, :edit, :update, :destroy]
  before_action :check_role

  # GET /system_messages
  # GET /system_messages.json
  def index
    @system_messages = SystemMessage.all
  end

  # GET /system_messages/1
  # GET /system_messages/1.json
  def show
  end

  # GET /system_messages/new
  def new
    @system_message = SystemMessage.new
  end

  # GET /system_messages/1/edit
  def edit
  end

  # POST /system_messages
  # POST /system_messages.json
  def create
    @system_message = SystemMessage.new(system_message_params)

    respond_to do |format|
      if @system_message.save
        format.html { redirect_to system_messages_path, notice: 'System message was successfully created.' }
        format.json { render :show, status: :created, location: @system_message }
      else
        format.html { render :new }
        format.json { render json: @system_message.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /system_messages/1
  # PATCH/PUT /system_messages/1.json
  def update
    respond_to do |format|
      if @system_message.update(system_message_params)
        format.html { redirect_to system_messages_path, notice: 'System message was successfully updated.' }
        format.json { render :show, status: :ok, location: @system_message }
      else
        format.html { render :edit }
        format.json { render json: @system_message.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /system_messages/1
  # DELETE /system_messages/1.json
  def destroy
    @system_message.destroy
    respond_to do |format|
      format.html { redirect_to system_messages_url, notice: 'System message was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  
  def datatable
    result = SystemMessage.datatable(params, @current_user)
    
    render json: result[:result]
  end
  
  def delete
    @message = "Nhãn <strong>#{@system_message.code}</strong> đã được xóa."
    @system_message.destroy
    respond_to do |format|      
      format.html { render "/home/ajax_success", layout: nil }
      format.json { head :no_content }
    end
  end
  
  

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_system_message
      @system_message = SystemMessage.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def system_message_params
      params.require(:system_message).permit(:code, :name, :content)
    end
    
    def check_role
      can? :manage, SystemMessage
    end
end
