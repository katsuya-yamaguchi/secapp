FactoryGirl.define do
  factory :video do
    id "1"
    video_time Time.new 
    uq_video_name "OWASP ZAPのセットアップ"
    fk_groups_id "1"
    created_at Time.new
    updated_at Time.new
    video "0001_owasp_setup.m3u8"
    description "0001_owasp_setup_desc.html"
    procedure "0001_owasp_setup_proc.html"

    before(:create) do |video|
      create(:video_group)
    end
  end
end
