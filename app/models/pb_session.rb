class PbSession < ActiveRecord::Base  
  def self.get_current_auth_cookie(cookies)
    auth_string = cookies[:B19_auth]
    result = `php b2b_func.php #{auth_string}`
    return result == "false" ? nil : JSON.parse(result)
  end
  
  def self.get_current_user(cookies)
    auth = self.get_current_auth_cookie(cookies)
    return auth.nil? ? nil : PbMember.find(auth[0])
  end
end