# Class for Device user (authentication gem)
class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def visible_users
    if self.admin?
      User.all
    else
      nil
    end
  end

  def show_user(id)
    if self.admin? || id == self.id
      User.find(id)
    else
      nil
    end
  end
end
