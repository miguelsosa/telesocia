require 'global_phone'
GlobalPhone.db_path = Rails.root.join('db/global_phone.json')

class Telesoci < ApplicationRecord
  validates :phone,  presence: true, uniqueness: true
  validates_format_of :email, :with => Devise::email_regexp, allow_blank: true
  #validates_format_of :url, :with => URI::regexp
  validate :validate_url_is_http
  validate :validate_phone_looks_like_phone
  before_save :convert_phone_to_globalphone

  # helper to ensure that nickname has *something* on it. TODO:
  # consider if we should make nickname a required field
  def get_nickname
    nickname.presence || 'unknown'
  end

  def get_name
    if last_name.presence && first_name.presence
      "#{last_name.capitalize}, #{first_name.capitalize}"
    elsif last_name.presence
      last_name.capitalize
    elsif first_name.presence
      first_name.capitalize
    else
      nil
    end
  end

  private
  
  def validate_url_is_http
    if url.presence && !(URI.parse(url).kind_of? URI::HTTP)
      errors.add(:url, 'must be a valid http URL')
    end
  end

  def validate_phone_looks_like_phone
    unless GlobalPhone.validate(phone)
      errors.add(:phone, 'must have a valid phone number format')
    end
  end

  def convert_phone_to_globalphone
    number = GlobalPhone.parse(phone)
    phone = number
    Rails.logger.debug("hone number parsed is: phone")
  end
end
