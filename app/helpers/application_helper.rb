module ApplicationHelper
  def page_info(params)
    title = ""
    breadcrumb =  '<ul class="breadcrumb">'+
              '<li><a href="'+root_path+'"><i class="icon-home2 position-left"></i> Trang chính</a></li>'

    if ["ads"].include?(params[:controller])
      breadcrumb += '<li><a href="'+ads_path+'"><i class="icon-stack2 position-left"></i> Quản lý quảng cáo</a></li>'
      title = "Quản lý quảng cáo"
      
      if ["new"].include?(params[:action])
        breadcrumb += '<li><a href="#">Thêm quảng cáo</a></li>'
        title = 'Thêm quảng cáo'
        
      end
      if ["edit"].include?(params[:action])
        ad = Ad.find(params[:id])
        breadcrumb += '<li><a href="#">'+ad.name+'</a></li>'
        title = 'Sửa quảng cáo: '+ad.name
        
      end
      if ["show"].include?(params[:action])
        ad = Ad.find(params[:id])
        breadcrumb += '<li><a href="#">'+ad.name+'</a></li>'
        title = 'Thống kê quảng cáo: '+ad.name
        
      end
    elsif ["ad_positions"].include?(params[:controller])
      breadcrumb += '<li><a href="'+ad_positions_path+'"><i class="icon-stack2 position-left"></i> Vị trí đặt quảng cáo</a></li>'
      title = "Vị trí đặt quảng cáo"
      
      if ["new"].include?(params[:action])
        breadcrumb += '<li><a href="#">Thêm vị trí</a></li>'
        title = 'Thêm vị trí'
        
      end
      if ["edit"].include?(params[:action])
        ad = AdPosition.find(params[:id])
        breadcrumb += '<li><a href="#">'+ad.title+'</a></li>'
        title = 'Sửa vị trí: '+ad.title
        
      end
      
    elsif ["home"].include?(params[:controller])
      if ["index"].include?(params[:action])
        #breadcrumb += '<li><a href="#">Thêm quảng cáo</a></li>'
        title = 'Tranh chính'
        
      end
    end
    
    breadcrumb += '</ul>'
    
    return {breadcrumb: breadcrumb.html_safe, title: title}
  end
  
  def format_price(number, vn = false, round = false, precision = nil)
    prec = (number.to_f.round == number.to_f) ? 0 : 2
    prec = 0 if round
    
    if !precision.nil?
      prec = precision
    end
    
    
    if vn
      number_to_currency(number, precision: prec, separator: ",", unit: '', delimiter: ".")
    else
      number_to_currency(number, precision: prec, separator: ".", unit: '', delimiter: ",")
    end
  end
end
