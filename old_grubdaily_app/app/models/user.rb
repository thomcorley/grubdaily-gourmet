class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :recoverable, :rememberable,
         :validatable, :omniauthable, :confirmable, :lockable, :timeoutable, :trackable
end
