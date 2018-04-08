require 'rails_helper'

RSpec.describe StaticPagesController, type: :controller do
  describe "POST #file_upload" do
    let(:user){ create(:user) }
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
      it "tmpfile is deleted." do
      end
      it "upload tmpfile is left." do
      end
    end
  end

end
