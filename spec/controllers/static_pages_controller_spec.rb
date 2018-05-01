require 'rails_helper'

RSpec.describe StaticPagesController, type: :controller do
  let(:user){ create(:user) }
  describe "POST #file_upload" do
    let(:video){ create(:video) }
    let(:tag){ }
    let(:messages){ {video_name: "zapの使い方", video_file_name: "test.mp4", description: "テスト用の動画ファイル。", category_tag: "test"} }
    context "when file is uploaded" do
      it "file upload succeeds." do
        user
        video
        login_as user
        post :file_upload, video: messages
        expect(File.exist?("public/uploads/tmp/test.jpg")).to be true
      end
    end
  end

  describe "POST #video_destroy" do
    let(:video){ create(:video) }
    let(:user){ create(:user) }
    context "when file exist," do
      it "delete_file_with call succeeds." do
        user
        video
        login_as user
        post :video_destroy, id: "1"
        expect(response).to redirect_to(mypage_path)
      end
    end
  end

end
