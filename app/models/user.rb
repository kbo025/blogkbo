class User < ActiveRecord::Base
  # Include default devise modules.
  before_save -> { skip_confirmation! }
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :trackable, :validatable,
          :confirmable, :omniauthable
  has_many :articles
  has_many :coments
  include DeviseTokenAuth::Concerns::User
end
