class Ability
  include CanCan::Ability

  def initialize(user)
    can :click, Ad
    can :image, Ad
    can :image_2, Ad
    can :image_3, Ad
    can :image_4, Ad
    
    can :iframe_home_top_banner, AdPosition
    can :iframe_home_feature_4_images_box, AdPosition
    can :iframe_home_feature_3_images_box, AdPosition
    can :iframe_6_items_list, AdPosition
    can :iframe_1_wide_banners, AdPosition
    can :iframe_3_wide_banners, AdPosition
    can :iframe_4_wide_banners, AdPosition
    can :iframe_5_wide_banners, AdPosition
    can :iframe_6_wide_banners, AdPosition
    can :iframe_7_wide_banners, AdPosition
    can :iframe_area_top_3_banner, AdPosition
    can :get_remaining_time, AdPosition
    can :home, Deal
    can :ajax_deal_info, Deal
    
    can :ajax_content, SystemMessage
    
    if user.present?
      if user.present?
        can :manage, :home
        
        can :create, Ad
        can :datatable, Ad
        can :read, Ad do |c|
          c.pb_member_id = user.id
        end
        can :update, Ad do |c|
          c.pb_member_id = user.id && c.active != 1
        end
        can :destroy, Ad do |c|
          c.pb_member_id = user.id && c.active != 1
        end
        can :get_nganluong_checkout_return, Ad do |c|
          c.pb_member_id = user.id
        end
        can :chart, Ad do |c|
          c.pb_member_id = user.id
        end
        
        can :read, PbSaleorder
        can :datatable, PbSaleorder
        can :buy_orders, PbSaleorder
        can :cancel, PbSaleorder do |i|
          i.seller_id == user.id
        end
        can :finish, PbSaleorder do |i|
          i.seller_id == user.id
        end
        
        can :read, Deal do |d|
          d.pb_member_id == user.id
        end
        can :create, Deal
        can :update, Deal do |d|
          d.pb_member_id == user.id
        end
        can :destroy, Deal do |d|
          d.pb_member_id == user.id
        end
        can :corp_deals, Deal
        can :corp_members, Deal
        can :corp_customers, Deal
        can :corp_non_member_customers, Deal
        can :agent_list, Deal
        can :customer_list, Deal
        can :show_product_details, Deal
        can :agent_page, Deal
        can :on, Deal do |d|
          d.pb_member_id == user.id
        end
        can :off, Deal do |d|
          d.pb_member_id == user.id
        end
        
        can :read, PbSaleorderitem
        can :datatable, PbSaleorderitem
        
        can :deal_customers, PbMember
        can :deal_agents, PbMember
        can :select2_options, PbMember
        can :pending_order_count, PbMember
      end
      
      if user.role == "admin"
        can :manage, Ad
        can :manage, AdPosition
        can :manage, PbArea
        can :manage, PbAreainfo
        can :manage, PbAreatypeinfo
        can :manage, PbSetting
        can :manage, Deal
        can :manage, PbSaleorderitem
        can :manage, PbMember
        can :manage, SystemMessage
        can :manage, PbSaleorder
      end
    end
    
    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user 
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on. 
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/ryanb/cancan/wiki/Defining-Abilities
  end
end
