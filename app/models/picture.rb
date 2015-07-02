class Picture < ActiveRecord::Base
  belongs_to :imageable, polymorphic: true
  has_attached_file :image, styles: {medium: "300x300>", thumb: "80x80"}, default_url: "/images/:style/default.jpg"
  validates_attachment_content_type :image, :content_type => { :content_type => ['image/jpeg', 'image/jpg', 'image/png', 'image/gif'] }
end
