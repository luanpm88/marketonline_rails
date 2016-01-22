class PbAreainfo < ActiveRecord::Base
  self.primary_key = :id
  
  belongs_to :pb_area, foreign_key: "area_id"
  belongs_to :pb_member, foreign_key: "member_id"
  
  mount_uploader :image, AreainfoUploader
  
  def self.active_items(params)
    items = self.all.order("created DESC").where(status: 1)
    items = items.where("end_at >= ?", Time.now.beginning_of_day)
    items = items.where("start_at <= ?", Time.now.end_of_day)
    if params[:area_id].present?
	  items = items.where("pb_areainfos.related_area_ids LIKE ?", "%[#{params[:area_id]}]%")
    end
    return items
  end
  
  def self.datatable(params, user)    
    @records = self.includes(:pb_area).order("created DESC")
    
    # Keyword search
    q = params["search"]["value"].strip.downcase
    @records = @records.where("pb_areas.name LIKE ?", "%#{q}%") if !q.empty?
    
    if params[:type_name].present?
      @records = @records.where("pb_areainfos.type_name = ?", params[:type_name])
    end    
    
    total = @records.count
    @records = @records.limit(params[:length]).offset(params["start"])
    data = []
    
    @records.each do |item|
      row = [
              "<a target=\"_blank\"href=\"http://marketonline.vn:/thi-truong/#{item.pb_area.areatype.name.downcase.unaccent.strip.gsub(" ","-")}/#{item.pb_area.id.to_s}/#{item.pb_area.name.downcase.unaccent.strip.gsub(" ","-")}\">"+item.pb_area.full_name_inverse+"</a>",
              item.content,
              (item.pb_member.present? ? item.pb_member.display_name : ""),
              item.created.strftime("%d/%m/%Y, %H:%I"),
              item.display_status,
              "<div class=\"text-right\"><ul class=\"icons-list\">"+
                  "<li class=\"dropup\">"+
                      "<a href=\"#\" class=\"dropdown-toggle\" data-toggle=\"dropdown\"><i class=\"icon-menu7\"></i></a>"+
                      "<ul class=\"dropdown-menu dropdown-menu-right\">"+
                          "<li>#{item.destroy_link(user)}</li>"+
                      "</ul>"+
                  "</li>"+
              "</ul></div>"
            ]
      data << row      
    end
    
    result = {
              "drawn" => params[:drawn],
              "recordsTotal" => total,
              "recordsFiltered" => total
    }
    result["data"] = data
    
    return {result: result}
  end
  
  def display_image_url
	if !image.present?
	  "http://marketonline.vn:3000/img/announce.png"
    else
	  image_url
    end
    
  end
  
  def self.member_datatable(params, user)    
    @records = self.includes(:pb_area).order("created DESC")
    
    if user.role != "admin"
      @records = @records.where(member_id: user.id)
    end
    
    # Keyword search
    q = params["search"]["value"].strip.downcase
    @records = @records.where("pb_areas.name LIKE ?", "%#{q}%") if !q.empty?
    
    if params[:type_name].present?
      @records = @records.where("pb_areainfos.type_name = ?", params[:type_name])
    end
    
    total = @records.count
    @records = @records.limit(params[:length]).offset(params["start"])
    data = []
    
    
    @records.each do |item|
      row = []
      if user.role == "admin"
        row << item.pb_member.display_name+"<br />"+item.pb_member.username
	  end
      row += [
			  '<img width="90" src="'+item.image_thumb+'" />',
              item.title,
              (item.pb_areatypes.empty? ? "" : item.pb_areatypes.map(&:name).join(", ")+", ")+item.pb_areas.map(&:name).join(", "),              
              item.start_at.strftime("%d/%m/%Y"),
              item.end_at.strftime("%d/%m/%Y"),
              item.display_status,
              "<div class=\"text-right\"><div>"+item.unapprove_link(user)+"<div><div>"+item.approve_link(user)+"<div><div>"+item.view_link(user)+"</div><div>"+item.edit_link(user)+"</div><div>"+item.destroy_link(user)+"<div></div>",              
            ]
      data << row      
    end
    
    result = {
              "drawn" => params[:drawn],
              "recordsTotal" => total,
              "recordsFiltered" => total
    }
    result["data"] = data
    
    return {result: result}
  end
  
  def image_thumb
	if !image.present?
	  return "http://marketonline.vn/images/icon/announce.png"
	else
	  return "http://marketonline.vn:3000/"+image.quare.url.to_s
	end
  end
  
  def display_status
    if status == 1
      "<span class=\"ad_status label bg-green\" title=\"Đã chọn\">Đã chọn</span>"
    else
      "<span class=\"ad_status label bg-draft\" title=\"Đang đợi duyệt\">Đợi duyệt</span>"
    end
  end
  
  def destroy_link(user)
    return "" if !user.can?(:delete, self)
  
    ActionView::Base.send(:include, Rails.application.routes.url_helpers)
    link_helper = ActionController::Base.helpers
    
    link_helper.link_to("<i class=\"icon-bin\"></i> Xóa".html_safe, {controller: "pb_areainfos", action: "delete", id: self.id}, method: :delete, data: { confirm: 'Bạn có chắc muốn xóa quảng cáo này?' }, class: "ajax_link")
  end
  
  def approve_link(user)
    return "" if !user.can?(:approve, self) || status == 1
  
    ActionView::Base.send(:include, Rails.application.routes.url_helpers)
    link_helper = ActionController::Base.helpers
    
    link_helper.link_to("<i class=\"icon-checkmark\"></i> Duyệt".html_safe, {controller: "pb_areainfos", action: "approve", id: self.id}, data: { confirm: 'Bạn có chắc muốn duyệt thông tin này?' }, class: "ajax_link")
  end
  
  def unapprove_link(user)
    return "" if !user.can?(:unapprove, self) || status == 0
  
    ActionView::Base.send(:include, Rails.application.routes.url_helpers)
    link_helper = ActionController::Base.helpers
    
    link_helper.link_to("<i class=\"icon-close2\"></i> Bỏ duyệt".html_safe, {controller: "pb_areainfos", action: "unapprove", id: self.id}, data: { confirm: 'Bạn có chắc muốn bỏ duyệt thông tin này?' }, class: "ajax_link")
  end
  
  def view_link(user)
    return "" if !user.can?(:read, self)
  
    ActionView::Base.send(:include, Rails.application.routes.url_helpers)
    link_helper = ActionController::Base.helpers
    
    link_helper.link_to("<i class=\"icon-zoomin3\"></i> Xem".html_safe, {controller: "pb_areainfos", action: "show", id: self.id, type_name: self.type_name})
  end
  
  def edit_link(user)
    return "" if !user.can?(:update, self)
  
    ActionView::Base.send(:include, Rails.application.routes.url_helpers)
    link_helper = ActionController::Base.helpers
    
    link_helper.link_to("<i class=\"icon-pencil\"></i> Sửa".html_safe, {controller: "pb_areainfos", action: "edit", id: self.id, type_name: self.type_name})
  end
  
  def json_encode_area_ids_names
    json = pb_areas.map {|t| {id: t.id.to_s, text: t.full_name_inverse}}
    json.to_json
  end
  
  
  def area_name
    if area_id == -1
      result = "Mặc định"
    elsif area_id == -2
      result = "Miền Nam"
    elsif area_id == -3
      result = "Miền Trung"
    elsif area_id == -4
      result = "Miền Bắc"
    else
      # check if area nil? return ""
      result = pb_area.nil? ? "" : pb_area.full_name_inverse
    end
    
    return result
  end
  
  def pb_area_ids
    return [] if area_ids.nil?
    area_ids.split(",")
  end
  
  def pb_areas    
    PbArea.where(id: pb_area_ids)
  end
  
  def pb_areatypes
	maps = [{"id": "-2", "to_id": 1},{"id": "-3", "to_id": 2},{"id": "-4", "to_id": 3}]
	at_ids = []
	maps.each do |m|
	  at_ids << m[:to_id] if pb_area_ids.include?(m[:id])
	end
    PbAreatype.where(id: at_ids)
  end
  
  def area_link(params)
    str = ["http://marketonline.vn"]
    str << ["thi-truong"]
    
    if params[:areatype_id].present? && !params[:area_id].present?
		areatype = PbAreatype.find(params[:areatype_id])
        str << areatype.name.unaccent.downcase.gsub(/\s+/,"xaaaaax").gsub(/[^a-zA-Z0-9]/, '').gsub("xaaaaax","-")
    end
    
    if params[:area_id].present?
		area = PbArea.find(params[:area_id])
        str << area.pb_areatype.name.unaccent.downcase.gsub(/\s+/,"xaaaaax").gsub(/[^a-zA-Z0-9]/, '').gsub("xaaaaax","-")
        str << area.id
        str << area.name.unaccent.downcase.gsub(/\s+/,"xaaaaax").gsub(/[^a-zA-Z0-9]/, '').gsub("xaaaaax","-")
    end
    
    if params[:info_page].present?
      str << params[:info_page]
    end
    
    str << self.id
    str << self.title.unaccent.downcase.gsub(/\s+/,"xaaaaax").gsub(/[^a-zA-Z0-9]/, '').gsub("xaaaaax","-")
    
    return str.join("/")
  end
  
  def self.area_link(params)
    str = ["http://marketonline.vn"]
    str << ["thi-truong"]
    
    if params[:areatype_id].present? && !params[:area_id].present?
		areatype = PbAreatype.find(params[:areatype_id])
        str << areatype.name.unaccent.downcase.gsub(/\s+/,"xaaaaax").gsub(/[^a-zA-Z0-9]/, '').gsub("xaaaaax","-")
    end
    
    if params[:area_id].present?
		area = PbArea.find(params[:area_id])
        str << area.pb_areatype.name.unaccent.downcase.gsub(/\s+/,"xaaaaax").gsub(/[^a-zA-Z0-9]/, '').gsub("xaaaaax","-")
        str << area.id
        str << area.name.unaccent.downcase.gsub(/\s+/,"xaaaaax").gsub(/[^a-zA-Z0-9]/, '').gsub("xaaaaax","-")
    end
    
    if params[:info_page].present?
      str << params[:info_page]
    end
    
    
    
    return str.join("/")
  end
  
  def related_area_ids
	arr = []
	pb_areas.each do |c|
	  arr += c.related_ids
	end
	
	pb_areatypes.each do |at|
	  at.pb_areas.each do |c|
		arr += c.related_ids
	  end
	end
	
	return arr
  end
  
  def update_related_area_ids
	values = "["+related_area_ids.join("][")+"]"
	self.update_attribute(:related_area_ids, values)
  end
  
end