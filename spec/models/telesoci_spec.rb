require 'rails_helper'

RSpec.describe Telesoci, type: :model do
  let (:valid_phones) { ['352-555-1234', '3525551234', '(352) 555-1234', '1-352-555-1234', '352-abc-defg'] }
  let (:invalid_phones) { ['52-555-1234', '1+23-555-1234', '352'] }

  describe 'validates phone inputs' do

    it 'requires a valid phone number' do
      valid_phones.each do |p|
        t = Telesoci.new({phone: p})
        expect(t.save).to be_truthy
        expect(t.errors.count).to be(0)
      end
      expect(Telesoci.count).to eq(valid_phones.count)
    end

    it 'will not save with invalid phone number' do
      invalid_phones.each do |p|
        t = Telesoci.new({phone: p})
        expect(t.save).to be_falsey
        expect(t.errors.count).not_to be(0)
      end
      expect(Telesoci.count).to eq(0)
    end

    it 'will add to errors if phone number is invalid' do
      t = Telesoci.new({phone: invalid_phones.first})
      t.save
      expect(t.errors.count).not_to be(0)
    end

    it 'will not allow two telesocis wht the same phone number' do
      t1 = Telesoci.new({phone: valid_phones.first, first_name: 'First'})
      t2 = Telesoci.new({phone: valid_phones.first, first_name: 'Second'})
      expect(t1.save).to be_truthy
      expect(t2.save).to be_falsey
    end
  end

  describe 'validates email input' do

    it 'will allow a valid email' do
      t = Telesoci.new({phone: valid_phones.first, email: 'valid-looking-email@telesocia.com'})
      expect(t.save).to be_truthy
    end

    it 'will allow an empyt email' do
      t = Telesoci.new({phone: valid_phones.first, email: ''})
      expect(t.save).to be_truthy
    end

    it 'will not allow invalid email' do
      t = Telesoci.new({phone: valid_phones.first, email: 'not-an-email'})
      expect(t.save).to be_falsey      
    end
  end

  describe 'validates url input' do

    it 'allows a valid looking http url' do
      t = Telesoci.new({phone: valid_phones.first, url: 'http://www.google.com'})
      expect(t.save).to be_truthy
    end

    it 'allows a valid looking https url' do
      t = Telesoci.new({phone: valid_phones.first, url: 'https://www.google.com'})
      expect(t.save).to be_truthy
    end

    it 'does not allow an invalid looking https url' do
      t = Telesoci.new({phone: valid_phones.first, url: 'https://&*#$#'})
      expect(t.save).to be_falsey
    end
  end

  describe 'get_nickname' do
    it 'returns unknown if nickname is not set' do
      t = Telesoci.new({phone: valid_phones.first})
      expect(t.get_nickname).to eq('unknown')
    end

    it 'returns nickname if nickname is set' do
      nick = 'my nickname'
      t = Telesoci.new({phone: valid_phones.first, nickname: nick})
      expect(t.get_nickname).to eq(nick)
    end
  end

  describe 'get_name' do
    let (:first) { 'first' }
    let (:last)  { 'last' }
    
    it 'returns capitalized "last, first" if both first_name and last_name are set' do
      t = Telesoci.new({phone: valid_phones.first, first_name: first, last_name: last})
      expect(t.get_name).to eq("#{last.capitalize}, #{first.capitalize}")
    end

    it 'returns capitalized last if only last_name is set' do
      t = Telesoci.new({phone: valid_phones.first, last_name: last})
      expect(t.get_name).to eq("#{last.capitalize}")
    end

    it 'returns capitalized first if only first_name is set' do
      t = Telesoci.new({phone: valid_phones.first, first_name: first})
      expect(t.get_name).to eq("#{first.capitalize}")
    end

    it 'returns nil if neither first nor last is set' do
      t = Telesoci.new({phone: valid_phones.first})
      expect(t.get_name).to be_nil
    end
  end
end
