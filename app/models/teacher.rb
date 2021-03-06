class Teacher < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  mount_uploader :avatar, AvatarUploader

  has_many :lessons, dependent: :destroy

  has_many :reservations, through: :lessons

  has_many :languages, dependent: :destroy
  has_many :reports, through: :lessons

  scope :without_admin, -> { where(admin: false) }

end
