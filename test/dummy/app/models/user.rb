class User < ApplicationRecord
  include SimpleTeams::MemberObject

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def full_name
    [first_name, last_name].join(" ")
  end
end
