begin
  class LoginPage
    def initialize
      @txt_username = { id: 'usernameTextField' }
      @txt_password = { id: 'passwordTextField' }
      @btn_login = { id: 'loginButton' }
      @btn_logout = { id: 'logoutButton' }
    end

    def set_identifier(user_name)
      PageHelper.is_element_enabled(@txt_username)
      PageHelper.find(@txt_username).send_keys(user_name)
    end

    def set_password(user_password)
      PageHelper.find(@txt_password).send_keys(user_password)
    end

    def click_login
      PageHelper.click_element(@btn_login)
    end

    def verify_login
      PageHelper.is_element_enabled(@btn_logout).should == true
    end

    def click_logout
      PageHelper.click_element(@btn_logout)
    end

    def verify_logout
      PageHelper.is_element_enabled(@btn_login).should == true
    end
  end
rescue Exception => ex
  p ex
end