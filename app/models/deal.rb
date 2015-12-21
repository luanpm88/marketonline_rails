class Deal < ActiveRecord::Base
  belongs_to :pb_company
  belongs_to :pb_product
  
  def price=(new)
    self[:price] = new.to_s.gsub(/\,/, '')
  end  
  def agent_price=(new)
    self[:agent_price] = new.to_s.gsub(/\,/, '')
  end
  def share_price=(new)
    self[:share_price] = new.to_s.gsub(/\,/, '')
  end
  
  def self.datatable(params, user)    
    @records = self.all
    
    total = @records.count
    @records = @records.limit(params[:length]).offset(params["start"])
    data = []
    
    @records.each do |item|
      row = [
              "<div class=\"\"><img src=\"#{item.pb_product.default_image}\" width=\"100\" /></div>",
              "<div class=\"\">#{item.pb_product.name}</div>",
              "<div class=\"\">#{ApplicationController.helpers.format_price(item.price)} VNĐ</div>",
              "<div class=\"\">#{ApplicationController.helpers.format_price(item.quantity)} #{item.pb_product.price_unit}</div>",
              "<div class=\"\">0</div>",
              "<div class=\"\">Từ: #{item.start_at.strftime("%d-%m-%Y")}<br />Đến: #{item.end_at.strftime("%d-%m-%Y")}</div>",
              "<div class=\"\"></div>",
              "<div class=\"text-right\"><ul class=\"icons-list\">"+
                  "<li class=\"dropup\">"+
                      "<a href=\"#\" class=\"dropdown-toggle\" data-toggle=\"dropdown\"><i class=\"icon-menu7\"></i></a>"+
                      "<ul class=\"dropdown-menu dropdown-menu-right\">"+
                          "<li>#{item.edit_link}</li>"+
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
  
  def destroy_link
    ActionView::Base.send(:include, Rails.application.routes.url_helpers)
    link_helper = ActionController::Base.helpers
    
    link_helper.link_to("<i class=\"icon-bin\"></i> Xóa".html_safe, {controller: "deals", action: "delete", id: self.id}, method: :delete, data: { confirm: 'Bạn có chắc muốn xóa DEAL này?' }, class: "ajax_link")
  end
  def edit_link
    ActionView::Base.send(:include, Rails.application.routes.url_helpers)
    link_helper = ActionController::Base.helpers
    
    link_helper.link_to("<i class=\"icon-pencil\"></i> Sửa".html_safe, {controller: "deals", action: "edit", id: self.id})
  end
end
