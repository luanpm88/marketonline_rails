class SystemMessage < ActiveRecord::Base
  self.table_name = "pb_system_messages"
  
  
  def self.datatable(params, user)
    # FILTERS
    filters = {}
    params["filters"].split('&').each do |row|
      filters[row.split("=")[0]] = row.split("=")[1]
    end
    
    @records = SystemMessage.all
    
    ## Keyword search
    #q = params["search"]["value"].strip.downcase
    #@records = @records.where("pb_saleorders.name LIKE ?", "%#{q}%") if !q.empty?
    
    total = @records.count
    @records = @records.limit(params[:length]).offset(params["start"])
    data = []
    
    @records.each do |item|
      row = [
              item.code,
              item.name,
              ActionController::Base.helpers.strip_tags(item.content)[0..50]+"...",
              "<div class=\"text-left text-nowrap\">#{item.edit_link}<br />#{item.destroy_link}</div>"
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
  
  def destroy_link
    ActionView::Base.send(:include, Rails.application.routes.url_helpers)
    link_helper = ActionController::Base.helpers
    
    link_helper.link_to("<i class=\"icon-bin\"></i> Xóa".html_safe, {controller: "system_messages", action: "delete", id: self.id}, method: :delete, class: "ajax_link", style: "display:none")
  end
  def edit_link
    ActionView::Base.send(:include, Rails.application.routes.url_helpers)
    link_helper = ActionController::Base.helpers
    
    link_helper.link_to("<i class=\"icon-pencil\"></i> Sửa".html_safe, {controller: "system_messages", action: "edit", id: self.id})
  end
  
  def self.get(code)
    sms = self.where(code: code).first
    return (sms.nil? ? "" : ActionController::Base.helpers.strip_tags(sms.content))
  end
  
end
