class Picture < ActiveRecord::Base
  belongs_to :imageable, polymorphic: true
  has_attached_file :file, styles: {medium: "300x300>", thumb: "80x80"}, default_url: "/images/:style/default.jpg"
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/
end
