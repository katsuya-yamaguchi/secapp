require 'rails_helper'

RSpec.describe Video, type: :model do
  describe "screenshot" do
    let(:user){ create(:user) }
    let(:video){ create(:video) }
    context "when file is uploaded" do
      it "file upload succeeds." do
        user
        video
        expect(File.exist?("public/uploads/tmp/test.jpg")).to be true
      end
      it "tmpfile is deleted." do
      end
      it "upload tmpfile is left." do
      end
    end
  end
end
