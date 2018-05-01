require "streamio-ffmpeg"
require "net/http"
require "uri"
require "json"

class Video < ApplicationRecord
  has_many :group_maps, class_name: "GroupMap"
  has_many :likes, class_name: "Like", dependent: :destroy
  has_many :video_groups, class_name: "VideoGroup", through: :group_maps
  mount_uploader :video_file_name, VideoUploader
  
  VALID_VIDEO_REGEX = /.*\.mp4/
  validates :video_file_name, presence: true, format: {with: VALID_VIDEO_REGEX}
  validates :video_name, presence: true

  def self.pagination(offset_times, sql, search_word)
    addition_video_id = []
    addition_video_title = []
    addition_video_data = Video.find_by_sql([sql, {num: offset_times, word: search_word}])
    for i in 0..addition_video_data.size-1 do
      if addition_video_data[i].nil? then
        break
      end
      addition_video_id.push(addition_video_data[i]["id"])
      addition_video_title.push(addition_video_data[i]["video_name"])
    end
    return addition_video_id, addition_video_title
  end

  def save_tags(tags, video_id)
    current_tags = VideoGroup.pluck(:uq_group_name)
    new_tags = tags - current_tags

    group = VideoGroup.select("id").where(uq_group_name: tags)
    unless group[0].nil?
      self.group_maps.create(video_group_id: group[0]["id"], video_id: video_id, created_at: Time.new, updated_at: Time.new)
    end

    unless new_tags.empty?
      new_tags.each do |new_name|
        video_group = self.video_groups.new(uq_group_name: new_name, created_at: Time.new, updated_at: Time.new)
        if video_group.save
          self.group_maps.create(video_group_id: video_group.id, video_id: video_id, created_at: Time.new, updated_at: Time.new)
        else
          @error_msg = video_group.errors.full_messages
        end
      end
    end
  end

  def like_by(user_id)
    likes.find_by(user_id: user_id)
  end

  def get_likes_number(video_id)
    likes.where(video_id: video_id).size
  end

  def delete_file_with(video_id)
    file_names = convert_video_file_name_to_image_file_name_with(video_id)
    access_token = get_token_with_conoha
    video_file_name = file_names[:video]
    image_file_name = file_names[:image]

    uri_video_file = URI.parse("https://object-storage.tyo1.conoha.io/v1/nc_ae525541a58a443c98717ded126b6ac3/shirobuhi_obs/uploads/#{video_file_name}")
    uri_image_file = URI.parse("https://object-storage.tyo1.conoha.io/v1/nc_ae525541a58a443c98717ded126b6ac3/shirobuhi_obs/uploads/#{image_file_name}")

    http_video_file = Net::HTTP.new(uri_video_file.host, uri_video_file.port)
    http_image_file = Net::HTTP.new(uri_image_file.host, uri_image_file.port)

    http_video_file.use_ssl = true
    http_image_file.use_ssl = true

    http_video_file.verify_mode = OpenSSL::SSL::VERIFY_NONE
    http_image_file.verify_mode = OpenSSL::SSL::VERIFY_NONE

    request_video_file = Net::HTTP::Delete.new(uri_video_file.path)
    request_image_file = Net::HTTP::Delete.new(uri_image_file.path)

    request_video_file["X-Auth-Token"] = access_token
    request_image_file["X-Auth-Token"] = access_token

    response_video_file = http_video_file.request(request_video_file)
    response_image_file = http_image_file.request(request_image_file)
    code_video = response_video_file.code.to_i
    code_image = response_image_file.code.to_i

    if code_video == 204 && code_image == 204
      flag = 0 
      return flag
    else
      raise "API DELETE fialed.(conoha) Responce code[video file: #{code_video}, image file: #{code_image}]"
    end
  end

  def get_token_with_conoha
    uri = URI.parse("https://identity.tyo1.conoha.io/v2.0/tokens")
    row = {auth: {passwordCredentials: {username: "gncu68180377", password: "AUNjIKV@ofK8"}, tenantId: "ae525541a58a443c98717ded126b6ac3"}}
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    request = Net::HTTP::Post.new(uri.request_uri)
    request.content_type = "application/json"
    request.body = row.to_json
    response = http.request(request)
    response_to_json = JSON.parse(response.body)
    return response_to_json["access"]["token"]["id"]
  end

  def convert_video_file_name_to_image_file_name_with(video_id)
    video_and_image_file_name = {video: "", image: ""}
    record = Video.select("video_file_name").where(id: video_id)[0]
    video_file_name = record["video_file_name"]
    image_file_name = Marshal.load(Marshal.dump(video_file_name)) << ".jpg"
    video_and_image_file_name[:video] = video_file_name
    video_and_image_file_name[:image] = image_file_name
    return video_and_image_file_name
  end

end
