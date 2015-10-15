class PbSession < ActiveRecord::Base  
  def self.get_current_auth_cookie(cookies)
    auth_string = cookies[:B19_auth]
    return JSON.parse(`php b2b_func.php #{auth_string}`)
  end  
end