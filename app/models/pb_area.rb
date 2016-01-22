class PbArea < ActiveRecord::Base
  belongs_to :parent, class_name: "PbArea", foreign_key: "parent_id"
  belongs_to :pb_areatype, class_name: "PbAreatype", foreign_key: "areatype_id"
  has_many :children, class_name: "PbArea", foreign_key: "parent_id"
  
  mount_uploader :image, AreaUploader
  mount_uploader :image_2, AreaUploader
  mount_uploader :image_3, AreaUploader
  mount_uploader :image_4, AreaUploader
  
  def self.datatable(params, user)    
    @records = self.order("areatype_id, name")
    
    # Keyword search
    q = params["search"]["value"].strip.downcase
    @records = @records.where("pb_areas.name LIKE ?", "%#{q}%") if !q.empty?
    
    #if params[:type_name].present?
    #  @records = @records.where("pb_areainfos.type_name = ?", params[:type_name])
    #end
    
    total = @records.count
    @records = @records.limit(params[:length]).offset(params["start"])
    data = []
    
    @records.each do |item|
      row = [
              '<img width="140" height="" src="'+item.image_thumb+'" /><br/>'+item.delete_image_link(user, ""),
              '<img width="140" height="" src="'+item.image_2_thumb+'" /><br/>'+item.delete_image_link(user, "_2"),
              '<img width="140" height="" src="'+item.image_3_thumb+'" /><br/>'+item.delete_image_link(user, "_3"),
              '<img width="140" height="" src="'+item.image_4_thumb+'" /><br/>'+item.delete_image_link(user, "_4"),
              item.full_name_inverse,
              item.edit_link(user),
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
  
  def delete_image_link(user,pos)
    return "" if !user.can?(:delete, self) || !self["image"+pos].present?
  
    ActionView::Base.send(:include, Rails.application.routes.url_helpers)
    link_helper = ActionController::Base.helpers
    
    link_helper.link_to("<i class=\"icon-bin\"></i> Xóa hình".html_safe, {controller: "pb_areas", action: "delete_image", id: self.id, pos: pos}, method: :delete, data: { confirm: 'Bạn có chắc muốn xóa quảng cáo này?' }, class: "ajax_link")
  end
  
  def edit_link(user)
    ActionView::Base.send(:include, Rails.application.routes.url_helpers)
    link_helper = ActionController::Base.helpers
    
    link_helper.link_to("<i class=\"icon-pencil\"></i> Sửa".html_safe, {controller: "pb_areas", action: "edit", id: self.id})
  end
  
  def areatype_name
    (pb_areatype.nil? ? "" : pb_areatype.name)
  end
  
  def image_thumb
	country = PbCountry.find(4)
	if !image.present?
	  if parent.present? && parent.image.present?
		return "http://marketonline.vn:3000/"+parent.image.quare.url.to_s
	#  elsif parent.present? && parent.parent.present? && parent.parent.image.present?
	#	return "http://marketonline.vn:3000/"+parent.parent.image.quare.url.to_s
	  elsif pb_areatype.present? && pb_areatype.image.present?
		return "http://marketonline.vn:3000/"+pb_areatype.image.quare.url.to_s
	  elsif parent.present? && parent.pb_areatype.present? && parent.pb_areatype.image.present?
		return "http://marketonline.vn:3000/"+parent.pb_areatype.image.quare.url.to_s
	  elsif country.present? && country.image.present?
		return "http://marketonline.vn:3000/"+country.image.quare.url.to_s
	  else		
		return "http://marketonline.vn/images/icon/announce.png"
	  end		
	else
	  return "http://marketonline.vn:3000/"+image.quare.url.to_s
	end
  end
  
  def image_2_thumb
	if !image_2.present?
	  if parent.present? && parent.image_2.present?
		return "http://marketonline.vn:3000/"+parent.image_2.quare.url.to_s
	#  elsif parent.present? && parent.parent.present? && parent.parent.image_2.present?
	#	return "http://marketonline.vn:3000/"+parent.parent.image_2.quare.url.to_s
	  elsif pb_areatype.present? && pb_areatype.image_2.present?
		return "http://marketonline.vn:3000/"+pb_areatype.image_2.quare.url.to_s
	  elsif parent.present? && parent.pb_areatype.present? && parent.pb_areatype.image_2.present?
		return "http://marketonline.vn:3000/"+parent.pb_areatype.image_2.quare.url.to_s
	  elsif PbCountry.find(4).present? && PbCountry.find(4).image_2.present?
		return "http://marketonline.vn:3000/"+PbCountry.find(4).image_2.quare.url.to_s
	  else
		return "http://marketonline.vn/images/icon/announce.png"
	  end
	else
	  return "http://marketonline.vn:3000/"+image_2.quare.url.to_s
	end
  end
  
  def image_3_thumb
	if !image_3.present?
	  if parent.present? && parent.image_3.present?
		return "http://marketonline.vn:3000/"+parent.image_3.quare.url.to_s
	#  elsif parent.present? && parent.parent.present? && parent.parent.image_3.present?
	#	return "http://marketonline.vn:3000/"+parent.parent.image_3.quare.url.to_s
	  elsif pb_areatype.present? && pb_areatype.image_3.present?
		return "http://marketonline.vn:3000/"+pb_areatype.image_3.quare.url.to_s
	  elsif parent.present? && parent.pb_areatype.present? && parent.pb_areatype.image_3.present?
		return "http://marketonline.vn:3000/"+parent.pb_areatype.image_3.quare.url.to_s
	  elsif PbCountry.find(4).present? && PbCountry.find(4).image_3.present?
		return "http://marketonline.vn:3000/"+PbCountry.find(4).image_3.quare.url.to_s
	  else
		return "http://marketonline.vn/images/icon/announce.png"
	  end
	else
	  return "http://marketonline.vn:3000/"+image_3.quare.url.to_s
	end
  end
  
  def image_4_thumb
	if !image_4.present?
	  if parent.present? && parent.image_4.present?
		return "http://marketonline.vn:3000/"+parent.image_4.quare.url.to_s
	#  elsif parent.present? && parent.parent.present? && parent.parent.image_4.present?
	#	return "http://marketonline.vn:3000/"+parent.parent.image_4.quare.url.to_s
	  elsif pb_areatype.present? && pb_areatype.image_4.present?
		return "http://marketonline.vn:3000/"+pb_areatype.image_4.quare.url.to_s
	  elsif parent.present? && parent.pb_areatype.present? && parent.pb_areatype.image_4.present?
		return "http://marketonline.vn:3000/"+parent.pb_areatype.image_4.quare.url.to_s
	  elsif PbCountry.find(4).present? && PbCountry.find(4).image_4.present?
		return "http://marketonline.vn:3000/"+PbCountry.find(4).image_4.quare.url.to_s
	  else
		return "http://marketonline.vn/images/icon/announce.png"
	  end
	else
	  return "http://marketonline.vn:3000/"+image_4.quare.url.to_s
	end
  end
  
  def self.general_search(params, user)
    result = self.where.not(id: 1)
    result = result.where("LOWER(pb_areas.name) LIKE ?", "%#{params[:q].strip.downcase}%")
   
    result = result.limit(200).map {|model| {:id => model.id, :text => model.full_name_inverse} }
    result.unshift({"text": "Miền Nam", "id": -2})
    result.unshift({"text": "Miền Trung", "id": -3})
    result.unshift({"text": "Miền Bắc", "id": -4})
    
    if user.role == "admin"
        result.unshift({"text": "Mặc định", "id": -1})
    end
    
    return result
  end
  
  def areatype
    if self.level == 3
      self.parent.pb_areatype
    else
      self.pb_areatype
    end    
  end
  
  def full_name
    names = []
    current = self
    while !current.nil?
      names << current.name
      current = current.parent
    end
    return names.join(", ")
  end
  
  def full_name_inverse
    names = []
    current = self
    while !current.nil?
      names.unshift(current.name)
      current = current.parent
    end
    return names.join(" - ")
  end
  
  def area_link(params)
    str = ["http://marketonline.vn"]
    str << ["thi-truong"]
    #if params[:areatype_id].present?
    #  str << PbAreatype.find(params[:areatype_id]).name.unaccent.downcase.gsub(/\s+/,"xaaaaax").gsub(/[^a-zA-Z0-9]/, '').gsub("xaaaaax","-")
    #end
    #if params[:area_id].present?
    #  str << PbArea.find(params[:area_id]).id
    #  str << PbArea.find(params[:area_id]).name.unaccent.downcase.gsub(/\s+/,"xaaaaax").gsub(/[^a-zA-Z0-9]/, '').gsub("xaaaaax","-")
    #end
    
    if self.id
        str << pb_areatype.name.unaccent.downcase.gsub(/\s+/,"xaaaaax").gsub(/[^a-zA-Z0-9]/, '').gsub("xaaaaax","-")
        str << self.id    
        str << self.name.unaccent.downcase.gsub(/\s+/,"xaaaaax").gsub(/[^a-zA-Z0-9]/, '').gsub("xaaaaax","-")
    end
    
    if params[:type].present? && !params[:info_page].present?
      str << params[:type]
    end
    
    if params[:catgroup_id].present? && !params[:info_page].present?
      str << "vung-mien"
      str << params[:catgroup_id]
      str << Catgroup.find(params[:catgroup_id]).name.unaccent.downcase.gsub(/\s+/,"xaaaaax").gsub(/[^a-zA-Z0-9]/, '').gsub("xaaaaax","-")
    end
    
    if params[:info_page].present?
      str << params[:info_page]
    end
    
    return str.join("/")
  end
  
  def self.select_toptions
    
    result = self.where.not(id: 1)
    #result = result.where("LOWER(pb_areas.name) LIKE ?", "%#{params[:q].strip.downcase}%")
   
    result = result.map {|model| [model.full_name_inverse, model.id] }
    #result.unshift(["Miền Nam", -2])
    #result.unshift(["Miền Trung", -3])
    #result.unshift(["Miền Bắc", -4])
    
    return result
  end
  
  def related_ids
    arr = [self.id]
    children.each do |c|
      arr << c.id
      c.children.each do |cc|
        arr << cc.id
        cc.children.each do |ccc|
          arr << ccc.id          
        end
      end
    end
    return arr
  end
  
end