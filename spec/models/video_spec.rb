require 'rails_helper'

RSpec.describe Video, type: :model do

  describe "get_token_with_conoha" do
    context "when called," do
      let(:user){ create(:user) }
      let(:video){ create(:video) }
      let(:video_id){"1"}
      it "successfully get tokens." do
        user
        video
        instance = Video.new
        result = instance.get_token_with_conoha
        expect(result.empty?).to be false
      end
    end
  end

  describe "convert_video_file_name_to_image_file_name" do
    context "when called," do
      let(:user){ create(:user) }
      let(:video){ create(:video) }
      let(:video_id){"1"}
      it "successfully change video_file_name to img_file_name." do
        user
        video
        instance = Video.new
        result = instance.convert_video_file_name_to_image_file_name_with("1")
        expect(result.size).to eq 2
        expect(result).to include(video: "test.mp4", image: "test.mp4.jpg")
      end
    end
  end

  describe "delete_file_with" do
  let(:user){ create(:user) }
  let(:video){ create(:video) }
    context "when called," do
      let(:video_id){"1"}
      it "api call succeeds." do
        user
        video
        instance = Video.new
        result = instance.delete_file_with(video_id)
        expect(result).to eq 0
      end
    end
  end
end
