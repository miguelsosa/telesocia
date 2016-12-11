require 'global_phone'
GlobalPhone.db_path = Rails.root.join('db/global_phone.json')

# ORM to store information for one telesoci, validate sanity and
# helpers with presentation logic.
class Telesoci < ApplicationRecord
  
  validates :phone,  presence: true, uniqueness: true
  validates_format_of :email, :with => Devise::email_regexp, allow_blank: true
  validate :validate_url_is_http
  validate :validate_phone_looks_like_phone
  before_save :convert_phone_to_globalphone

  private
  
  def validate_url_is_http
    if url.presence
      errmsg = 'must be a valid http URL'
      begin
        return true if (URI.parse(url).kind_of? URI::HTTP)
      rescue Exception => error
        errmsg += " - error: #{error.message}"
      end
      errors.add(:url, errmsg)
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
