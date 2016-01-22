class PbAreainfosController < ApplicationController
  #load_and_authorize_resource
  
  # load_and_authorize_resource
  before_action :set_pb_areainfo, only: [:delete, :show, :edit, :update, :destroy]
  
  
  def listing
    if params[:info_page] == 'thong-bao'
      @type_title = "Thông báo"
      @new_list = PbAreainfo.where(type_name: "tb").order("created DESC")
    elsif params[:info_page] == 'gioi-thieu'
      @type_title = "Giới thiệu"
      @new_list = PbAreainfo.where(type_name: "gt").order("created DESC")
    end
    
    
    render layout: nil
  end
  
  def index
  
  end
  
  def datatable
    authorize! :read, PbAreainfo
    
    result = PbAreainfo.datatable(params, @current_user)
    
    render json: result[:result]
  end
  
  def member_datatable
    authorize! :read, PbAreainfo
    
    result = PbAreainfo.member_datatable(params, @current_user)
    
    render json: result[:result]
  end
  
  def intros
    #code
  end
  
  # DELETE /ads/1
  # DELETE /ads/1.json
  def delete    
    @ad = PbAreainfo.find(params[:id])    
    authorize! :delete, @ad
    
    @message = "Thông tin vị trí đã được xóa."
    @ad.destroy
    respond_to do |format|      
      format.html { render "/home/ajax_success", layout: nil }
      format.json { head :no_content }
    end
  end
  
  def approve
    @ad = PbAreainfo.find(params[:id])    
    authorize! :approve, @ad
    
    @message = "Thông tin vị trí đã được duyệt."
    @ad.update_attribute(:status, 1)
    respond_to do |format|      
      format.html { render "/home/ajax_success", layout: nil }
      format.json { head :no_content }
    end
  end
  
  def unapprove
    @ad = PbAreainfo.find(params[:id])    
    authorize! :unapprove, @ad
    
    @message = "Thông tin vị trí đã được bỏ duyệt."
    @ad.update_attribute(:status, 0)
    respond_to do |format|      
      format.html { render "/home/ajax_success", layout: nil }
      format.json { head :no_content }
    end
  end
  
  def member_intros
    authorize! :read, PbAreainfo
    
  end
  
  def member_announces
    authorize! :read, PbAreainfo
    
  end
  
  # GET /deals/1
  # GET /deals/1.json
  def show
    authorize! :read, @pb_areainfo
  end

  # GET /deals/new
  def new
    authorize! :create, PbAreainfo
    
    @pb_areainfo = PbAreainfo.new(type_name: params[:type_name])
    @pb_areainfo.start_at = Date.today
    @pb_areainfo.end_at = Date.today + 1.month
  end

  # GET /deals/1/edit
  def edit
    authorize! :update, @pb_areainfo
  end

  # POST /deals
  # POST /deals.json
  def create
    authorize! :create, PbAreainfo
  
    @pb_areainfo = PbAreainfo.new(pb_areainfo_params)
    @pb_areainfo.area_id = 0
    @pb_areainfo.area_moderator = 0
    @pb_areainfo.created = Time.now
    @pb_areainfo.member_id = @current_user.id
    respond_to do |format|
      if @pb_areainfo.save
        format.html { redirect_to pb_areainfos_path(type_name: @pb_areainfo.type_name), notice: 'Thông tin đã được tạo thành công!' }
        format.json { render :show, status: :created, location: @deal }
      else
        format.html { render :new }
        format.json { render json: @deal.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /deals/1
  # PATCH/PUT /deals/1.json
  def update
    authorize! :update, @pb_areainfo

    respond_to do |format|
      if @pb_areainfo.update(pb_areainfo_params)
        format.html { redirect_to pb_areainfos_path(type_name: @pb_areainfo.type_name), notice: 'Thông tin đã được lưu thành công!' }
        format.json { render :show, status: :created, location: @deal }
      else
        format.html { render :new }
        format.json { render json: @deal.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def upload_image_video
    `mkdir public/uploads/editor`    
    uploaded_io = params[:upload_file]
    file_name = Time.now.getutc.to_i.to_s+"."+uploaded_io.original_filename.split(".").last
    path = Rails.root.join('public', 'uploads', 'editor', file_name)
    public_path = 'http://marketonline.vn:3000/uploads/editor/'+file_name
    
    # check image
    images = ['image/png', 'image/jpeg', 'image/jpg', 'image/gif']
    if images.include?(uploaded_io.content_type)
      File.open(path, 'wb') do |file|
        file.write(uploaded_io.read)
      end
      
      render text: "<script>parent.editor_uploaded('<img src=\""+public_path.to_s+"\" />')</script>"
    end
    
    # check video
    videos = ['video/x-flv', 'video/mp4', 'application/x-mpegURL', 'video/MP2T', 'video/3gpp', 'video/quicktime', 'video/x-msvideo', 'video/x-ms-wmv']
    if videos.include?(uploaded_io.content_type)
      File.open(path, 'wb') do |file|
        file.write(uploaded_io.read)
      end
      
      #video_tag = '<video width="100%" height="100%" controls>'
      #video_tag += '<source src="'+public_path+'" type="video/mp4">'
      #video_tag += 'Your browser does not support the video tag.'
      #video_tag += '</video>'
      video_tag += "<img width=\"100%\" height=\"100%\" rel=\"#{public_path.to_s}\" src=\"'http://marketonline.vn:3000/img/videobg.png\" />"
      render text: "<script>parent.editor_uploaded('"+video_tag+"')</script>"
    end
  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pb_areainfo
      @pb_areainfo = PbAreainfo.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def pb_areainfo_params
      params.require(:pb_areainfo).permit(:image, :type_name, :area_ids, :start_at, :end_at, :title, :area_id, :member_id, :content, :status, :created, :type_name, :area_moderator)
    end
  
end