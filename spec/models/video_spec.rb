require 'rails_helper'

RSpec.describe Video, type: :model do
  describe "validates" do
    let(:video){ create(:video) }
    context "validate is" do
      it "true" do
        expect(video.validate).to be true
      end
    end
  end
end
