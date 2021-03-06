class PbAreatypeinfo < ActiveRecord::Base
  self.primary_key = :id
  
  belongs_to :pb_areatype, foreign_key: "areatype_id"
  belongs_to :pb_member, foreign_key: "member_id"
  
  def self.datatable(params, user)    
    @records = self.joins(:pb_areatype).order("created DESC")
    
    # Keyword search
    q = params["search"]["value"].strip.downcase
    @records = @records.where("pb_areatypes.name LIKE ?", "%#{q}%") if !q.empty?
    
    if params[:type_name].present?
      @records = @records.where("pb_areatypeinfos.type_name = ?", params[:type_name])
    end
    
    total = @records.count
    @records = @records.limit(params[:length]).offset(params["start"])
    data = []
    
    @records.each do |item|
      row = [
              "<a target=\"_blank\"href=\"http://marketonline.vn:/thi-truong/#{item.pb_areatype.name.downcase.unaccent.strip.gsub(" ","-")}\">"+item.pb_areatype.name+"</a>",
              item.content,
              (item.pb_member.present? ? item.pb_member.display_name : ""),
              item.created.strftime("%d/%m/%Y, %H:%I"),
              item.display_status,
              "<div class=\"text-right\"><ul class=\"icons-list\">"+
                  "<li class=\"dropup\">"+
                      "<a href=\"#\" class=\"dropdown-toggle\" data-toggle=\"dropdown\"><i class=\"icon-menu7\"></i></a>"+
                      "<ul class=\"dropdown-menu dropdown-menu-right\">"+
                          "<li>#{item.destroy_link}</li>"+
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
  
  def display_status
    if status == 1
      "<span class=\"ad_status label bg-green\" title=\"Đã chọn\">Đã chọn</span>"
    else
      "<span class=\"ad_status label bg-draft\" title=\"Đang đợi duyệt\">Đợi duyệt</span>"
    end
  end
  
  def destroy_link
    ActionView::Base.send(:include, Rails.application.routes.url_helpers)
    link_helper = ActionController::Base.helpers
    
    link_helper.link_to("<i class=\"icon-bin\"></i> Xóa".html_safe, {controller: "pb_areatypeinfos", action: "delete", id: self.id}, method: :delete, data: { confirm: 'Bạn có chắc muốn xóa quảng cáo này?' }, class: "ajax_link")
  end
  
end