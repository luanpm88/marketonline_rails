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
    end
    
    breadcrumb += '</ul>'
    
    return {breadcrumb: breadcrumb.html_safe, title: title}
  end
end
