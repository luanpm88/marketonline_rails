class PbSetting < ActiveRecord::Base
  self.primary_key = :id
  
  def self.datatable(params, user)    
    @records = self.all.order("name DESC, variable")
    
    # Keyword search
    q = params["search"]["value"].strip.downcase
    @records = @records.where("pb_settings.variable LIKE ? OR LOWER(pb_settings.variable) LIKE ?", "%#{q}%", "%#{q}%") if !q.empty?
    
    total = @records.count
    @records = @records.limit(params[:length]).offset(params["start"])
    data = []
    
    @records.each do |item|
      row = [
              item.variable,
              "<div class=\"text-nowrap\">"+item.name+"</div>",
              "<textarea class=\"form-control\" rel=\"#{item.id.to_s}\" name=\"setting_#{item.id.to_s}\" />#{item.valued}</textarea><a class=\"btn btn-primary btn-xs pull-right save_setting\" href=\"#save\">Save</a>",
              item.type_id,
              "<div class=\"text-right\"><ul class=\"icons-list\">"+
                  "<li class=\"dropup\">"+
                      "<a href=\"#\" class=\"dropdown-toggle\" data-toggle=\"dropdown\"><i class=\"icon-menu7\"></i></a>"+
                      "<ul class=\"dropdown-menu dropdown-menu-right\">"+
                          "<li></li>"+
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
end