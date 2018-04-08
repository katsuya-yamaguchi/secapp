FactoryGirl.define do
  factory :video do
    id "1"
    video_name "テスト"
    video_file_name Rack::Test::UploadedFile.new(File.join(Rails.root, "spec/fixtures/test.mp4"))
    created_at Time.new
    updated_at Time.new
    description "テスト用ビデオデータ"
    fk_users_id 1

    #before(:create) do |user|
    #  create(:user)
    #end
  end
end
