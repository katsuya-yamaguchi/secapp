require 'rails_helper'

RSpec.describe VideoGroup, type: :model do
  describe "validates" do
    let(:video_group){ create(:video_group) }
    context "validates is" do
      it "true" do
        expect(video_group.validate).to be true
      end
    end
  end
end
