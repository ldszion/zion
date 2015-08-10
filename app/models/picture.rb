class Picture < ActiveRecord::Base
  belongs_to :imageable, polymorphic: true
  has_attached_file :image, styles: {medium: "300x300>", thumb: "80x80"},
    default_url: "avatar.jpg"
  validates_attachment :image, presence: true,
    content_type: { content_type: /\Aimage\/.*\Z/ },
    size: { in: 0..2.megabytes }
end
