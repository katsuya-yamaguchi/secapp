require 'rails_helper'

RSpec.describe VideoCategory, type: :model do
  describe "validates" do
    let(:video_category){ create(:video_category) }
    context "validate is" do
      it "true" do
        expect(video_category.validate).to be true
      end
    end
  end
end
