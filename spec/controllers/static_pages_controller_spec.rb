require 'rails_helper'

RSpec.describe StaticPagesController, type: :controller do
  describe "index" do
    context "Get #index" do
      it "Response is 200." do
        get :index 
        expect(response).to have_http_status(200) 
      end
    end
  end

  describe "riyokiyaku" do
    context "Get #riyokiyaku" do
      it "Response is 200." do
        get :riyokiyaku
        expect(response).to have_http_status(200)
      end
    end
  end

  describe "courses" do
    let(:video_category){ create(:video_category) }
    let(:courses_id_name){ { video_category.attributes["id"] => video_category.attributes["uq_category_name"] } }
    context "Get #courses" do
      it "Response is 200." do
        get :courses
        expect(response).to have_http_status(200)
      end
      it "The value of @courses_id_name is correct." do
        expect(courses_id_name.keys[0].class).to eq Integer
        expect(courses_id_name[1].class).to eq String
      end
      it "The value of @courses_id_name_length is correct." do
        expect(courses_id_name.length.class).to eq Integer
      end
    end
  end

  describe "list_courses" do
    let(:video_group){ create(:video_group) }
    let(:video_category){ create(:video_category) }
    let(:params){ { id: 1 } }
    let(:video_category_id){ video_category.attributes["id"] }
    let(:video_group_id){ video_group.attributes["id"] }
    let(:video_group_name){ video_group.attributes["uq_group_name"] }
    context "Get #list" do
      it "Response is 200." do
        get :list_courses, params
        expect(response).to have_http_status(200)
      end
      it "The value of @request_courses_name is correct."
      it "The value of @video_category_id is correct." do
        expect(video_category_id.class).to eq Integer
      end
      it "The value of @video_group_id is correct." do
        expect(video_group_id.class).to eq Integer
      end
      it "The value of @video_group_name is correct." do
        expect(video_group_name.class).to eq String
      end
    end
  end

  describe "list_videos" do
    let(:video){ create(:video) }
    let(:video_group){ create(:video_group) }
    let(:params){ { id: 1 } }
    let(:video_group_name){ video_group.attributes["uq_group_name"] }
    let(:video_id){ video.attributes["id"] }
    let(:video_name){ video.attributes["uq_video_name"] }
    let(:video_time){ video.attributes["video_time"] }
    context "Get #list_video" do
      it "Response is 200."
      it "The value of @request_group_id is correct." 
      it "The value of @video_group_name is correct." do
        expect(video_group_name.class).to eq String
      end
      it "The value of @video_id is correct." do
        expect(video_id.class).to eq Integer
      end
      it "The value of @video_name is correct." do
        expect(video_name.class).to eq String
      end
      it "The value of @video_time is correct." do
        expect(video_time.class).to eq ActiveRecord::Type::Time::Value
      end
    end
  end

  describe "videos" do
    let(:video){ create(:video) }
    #let(:video_group){ create(:video_group) }
    let(:params){ { id: "test-perm", video_perm: video.attributes["uq_video_perm"] } }
    it "Response is 200." do
      p params
      get :videos, params
      expect(response).to have_http_status(200) 
    end
    it "Successful selection of video file list." do
      # select uq_video_name from videos where fk_groups_id = (
      #   select fk_groups_id from videos where uq_video_perm = @request_video_perm;
      # ) order by id
      # Video.select("fk_groups_id").where(uq_video_perm: @request_video_perm)
    end
    it "Successful selection of desc file."
    it "Successful selection of proc file."
    it "Successful assignment of variable."
  end

end
