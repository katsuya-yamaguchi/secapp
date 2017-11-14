require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  def setup
    # 時間表示形式:1999-01-08 04:05:06
    t = Time.now
    current_time = t.strftime("%Y-%m-%d %H:%M:%S")

    @user = User.new(create_time: current_time, name: "TEST", password: "141913", login_time: current_time, logout_time: current_time, mail_address: "test@sample.com")
  end

  test "should be valid" do
    assert @user.valid?
  end

end
