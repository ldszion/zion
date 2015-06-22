class User < ActiveRecord::Base
  has_secure_password

  validates :email,
    presence: {presence: true, message: "Email obrigatório"},
    uniqueness: {uniqueness: true, message: "Email já existe"}

  def register_to event
    "registrando em #{event.name}"
  end
end
