module ApplicationHelper
  def page_info(params)
    title = ""
    breadcrumb =  '<ul class="breadcrumb">'+
              '<li><a href="'+root_path+'"><i class="icon-home2 position-left"></i> Trang chính</a></li>'

    if ["ads"].include?(params[:controller])
      breadcrumb += '<li><a href="'+ads_path+'"><i class="icon-stack2 position-left"></i> Quản lý quảng cáo</a></li>'
      title = "Quản lý quảng cáo"
      
      if ["new"].include?(params[:action])
        breadcrumb += '<li class="active">Thêm quảng cáo</li>'
        title = 'Thêm quảng cáo'
        
      end
      if ["edit"].include?(params[:action])
        ad = Ad.find(params[:id])
        breadcrumb += '<li class="active">'+ad.name+'</li>'
        title = 'Sửa quảng cáo: '+ad.name
        
      end
      if ["show"].include?(params[:action])
        ad = Ad.find(params[:id])
        breadcrumb += '<li class="active">'+ad.name+'</li>'
        title = 'Thống kê quảng cáo: '+ad.name
        
      end
    elsif ["ad_positions"].include?(params[:controller])
      breadcrumb += '<li><a href="'+ad_positions_path+'"><i class="icon-stack2 position-left"></i> Vị trí đặt quảng cáo</a></li>'
      title = "Vị trí đặt quảng cáo"
      
      if ["new"].include?(params[:action])
        breadcrumb += '<li class="active">Thêm vị trí</li>'
        title = 'Thêm vị trí'
        
      end
      if ["edit"].include?(params[:action])
        ad = AdPosition.find(params[:id])
        breadcrumb += '<li class="active">'+ad.title+'</li>'
        title = 'Sửa vị trí: '+ad.title
        
      end
      
    elsif ["home"].include?(params[:controller])
      if ["index"].include?(params[:action])
        #breadcrumb += '<li><a href="#">Thêm quảng cáo</a></li>'
        title = 'Tranh chính'
        
      end
    elsif ["pb_areatypeinfos"].include?(params[:controller])
      if ["index"].include?(params[:action])
        #breadcrumb += '<li><a href="#">Thêm quảng cáo</a></li>'
        title = 'Quản lý thông tin vị trí địa lý'
        
      end
    elsif ["deals"].include?(params[:controller])
      if ["index"].include?(params[:action])
        breadcrumb += '<li class="active">Danh sách DEAL</li>'
        title = 'Quản lý sản phẩm DEAL'        
      end
      if ["show"].include?(params[:action])
        deal = Deal.find(params[:id])
        breadcrumb += '<li><a href="'+deals_path+'">Danh sách DEAL</a></li>'
        breadcrumb += '<li class="active">'+deal.pb_product.name+'</li>'
        title = 'Chi tiết DEAL: '+deal.pb_product.name
        
      end
      if ["new"].include?(params[:action])
        breadcrumb += '<li><a href="'+deals_path+'">Danh sách DEAL</a></li>'
        breadcrumb += '<li class="active">Tạo mới DEAL</li>'
        title = 'Tạo mới DEAL'
        
      end
      if ["edit"].include?(params[:action])
        deal = Deal.find(params[:id])
        breadcrumb += '<li><a href="'+deals_path+'">Danh sách DEAL</a></li>'
        breadcrumb += '<li class="active">'+deal.pb_product.name+'</li>'
        title = 'Chỉnh sửa DEAL: '+deal.pb_product.name
        
      end
      if ["item_list"].include?(params[:action])
        breadcrumb += '<li><a href="'+deals_path+'">Danh sách DEAL</a></li>'
        breadcrumb += '<li class="active">Lịch sử bán hàng</li>'
        title = 'Lịch sử bán hàng'
        
      end
      if ["agent_list"].include?(params[:action])
        breadcrumb += '<li><a href="'+deals_path+'">Danh sách DEAL</a></li>'
        breadcrumb += '<li class="active">Cộng tác viên</li>'
        title = 'Cộng tác viên DEAL'
        
      end
      if ["customer_list"].include?(params[:action])
        breadcrumb += '<li><a href="'+deals_path+'">Danh sách DEAL</a></li>'
        breadcrumb += '<li class="active">Khách hàng</li>'
        title = 'Danh sách khách hàng mua DEAL'
        
      end
    elsif ["pb_saleorders"].include?(params[:controller])
      if ["index"].include?(params[:action])
        breadcrumb += '<li class="active">Đơn đặt hàng từ khách</li>'
        title = 'Đơn đặt hàng từ khách'
        
      end
      if ["buy_orders"].include?(params[:action])
        breadcrumb += '<li class="active">Lịch sử mua hàng</li>'
        title = 'Lịch sử mua hàng'
        
      end
      if ["show"].include?(params[:action])
        item = PbSaleorder.find(params[:id])
        if item.seller == @current_user
          breadcrumb += '<li><a href="'+pb_saleorders_path+'">Đơn đặt hàng từ khách</a></</li>'
        else
          breadcrumb += '<li><a href="'+buy_orders_pb_saleorders_path+'">Lịch sử mua hàng</a></</li>'
        end         
        breadcrumb += '<li class="active">Chi tiết đơn hàng</li>'
        title = 'Chi tiết đơn hàng'
        
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
