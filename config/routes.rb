Rails.application.routes.draw do
  resources :system_messages do
    collection do
      get 'datatable'
      get 'delete'
    end
  end
  resources :deals do
    collection do
      get 'datatable'
      get 'delete'
      get 'show_product_details'
      get 'agent_list'
      get 'customer_list'
      get 'item_list'
    end
  end
  resources :ad_clicks do
    collection do
      get 'datatable'
    end
  end
  resources :ads do
    collection do
      get 'datatable'
      get 'image'
      get 'image_2'
      get 'image_3'
      get 'image_4'
      get 'delete'
      get 'click'
      get 'chart'
      get 'get_nganluong_checkout_return'
      get 'enable'
      get 'disable'
    end
  end
  resources :ad_positions do
    collection do
      get 'datatable'
      get 'delete'
      get 'iframe_home_top_banner'
      get 'iframe_home_feature_4_images_box'
      get 'iframe_home_feature_3_images_box'
      get 'iframe_6_items_list'
      get 'iframe_1_wide_banners'
      get 'iframe_3_wide_banners'
      get 'iframe_4_wide_banners'
      get 'iframe_5_wide_banners'
      get 'iframe_6_wide_banners'
      get 'iframe_7_wide_banners'
      get 'iframe_area_top_3_banner'
      get 'preview_box'
      get 'get_values'
      get 'get_remaining_time'
    end
  end
  resources :pb_products do
    collection do
      
    end
  end
  resources :pb_areas do
    collection do
      
    end
  end
  
  resources :pb_areatypeinfos do
    collection do
      get 'datatable'
      get 'delete'
    end
  end
  
  resources :pb_areainfos do
    collection do
      get 'datatable'
      get 'delete'
    end
  end
  
  resources :pb_settings do
    collection do
      get 'datatable'
      get 'save'
    end
  end
  
  resources :pb_saleorders do
    collection do
      get 'datatable'
      get 'buy_orders'
      get 'finish'
      get 'cancel'
      get 'admin_list'
    end
  end
  
  resources :pb_saleorderitems do
    collection do
      get 'datatable'      
    end
  end
  
  resources :pb_members do
    collection do
      get 'deal_customers'
      get 'deal_agents'
    end
  end
  
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'ads#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
