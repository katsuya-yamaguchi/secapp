FactoryGirl.define do
  factory :video do
    id "1"
    video_time Time.new 
    uq_video_name "OWASP ZAPのセットアップ"
    fk_groups_id "1"
    created_at Time.new
    updated_at Time.new
    video Rack::Test::UploadedFile.new(File.join(Rails.root, "public/uploads/video/log-entry-75144.html"))
    description Rack::Test::UploadedFile.new(File.join(Rails.root, "public/uploads/desc/log-entry-75144.html")) 
    procedure Rack::Test::UploadedFile.new(File.join(Rails.root, "public/uploads/procedure/sample.html"))
    uq_video_perm "test-video"

    before(:create) do |video|
      create(:video_group)
    end
  end
end
