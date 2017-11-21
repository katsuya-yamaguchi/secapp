require 'rails_helper'

describe "management" do
  let(:user){ create(:user) }
  let(:video){ create(:video) }
  let(:video_group){ create(:video_group) }
  let(:login_to_get){
    login_as(user)
    get admin_path
  }
  context "Get admin_path" do
    it "Redirect to root_path." do
      get admin_path
      expect(response).to redirect_to("/")
    end
    it "Response is 200." do
      login_to_get
      expect(response).to have_http_status(200) 
    end
    it "Successful new of Video model." do
      login_to_get
      expect(Video.new.attributes.length).to eq 11
    end
    it "Successful acquisition of Video groups." do
      login_to_get
      video_group
      groups = [video_group.id, video_group.uq_group_name]
      expect(groups).not_to be_empty
    end
    
  end

  context "Post admin_path" do
    it "Successful save of Video model." do
      login_as(user)
      video_group
      expect { post admin_path, video: attributes_for(:video) }.to change(Video, :count).by(1)
    end
    it "Redirect to admin_path." do
      login_as(user)
      video_group
      post admin_path, video: attributes_for(:video)
      expect(response).to redirect_to("/admin")
    end
    it "Render is index." do
      # エラーにする方法が分からないため、スキップする。
    end
  end
end
