require 'rails_helper'

describe "management" do
  let(:user){ create(:user) }
  context "Get admin_path" do
    it "Response is 200." do
      login_as(user)
      get admin_path
      expect(response).to have_http_status(200) 
    end
  end

  context "Post admin_path" do
  end
end
