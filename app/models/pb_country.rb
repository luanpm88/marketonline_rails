class PbCountry < ActiveRecord::Base
 
  mount_uploader :image, AreaUploader
  mount_uploader :image_2, AreaUploader
  mount_uploader :image_3, AreaUploader
  mount_uploader :image_4, AreaUploader
  
  def self.datatable(params, user)    
    @records = self.order("areatype_id, name")
    
    # Keyword search
    q = params["search"]["value"].strip.downcase
    @records = @records.where("pb_countries.name LIKE ?", "%#{q}%") if !q.empty?
    
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
              item.name,
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
	if !image.present?
	  return "http://marketonline.vn/images/icon/announce.png"	
	else
	  return "http://marketonline.vn:3000/"+image.quare.url.to_s
	end
  end
  
  def image_2_thumb
	if !image_2.present?
	  return "http://marketonline.vn/images/icon/announce.png"
	else
	  return "http://marketonline.vn:3000/"+image_2.quare.url.to_s
	end
  end
  
  def image_3_thumb
	if !image_3.present?
	  return "http://marketonline.vn/images/icon/announce.png"
	else
	  return "http://marketonline.vn:3000/"+image_3.quare.url.to_s
	end
  end
  
  def image_4_thumb
	if !image_4.present?
	  return "http://marketonline.vn/images/icon/announce.png"
	else
	  return "http://marketonline.vn:3000/"+image_4.quare.url.to_s
	end
  end
  
end