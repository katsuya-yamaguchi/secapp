FactoryGirl.define do
  factory :video_group do
    id "1"
    uq_group_name "OWASP ZAPを使用した自己診断"
    fk_category_id "1"
    created_at Time.new
    updated_at Time.new
    uq_group_perm "test-group"

    before(:create) do |video_group|
      create(:video_category)
    end
  end
end
