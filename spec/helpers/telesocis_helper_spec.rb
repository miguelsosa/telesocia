require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the TelesocisHelper. For example:
#
# describe TelesocisHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe TelesocisHelper, type: :helper do
  let (:valid_phone) { '352-555-1234' }

  describe 'get_nickname' do
    it 'returns unknown if nickname is not set' do
      t = Telesoci.new({phone: valid_phone})
      expect(get_nickname(t)).to eq('unknown')
    end

    it 'returns nickname if nickname is set' do
      nick = 'my nickname'
      t = Telesoci.new({phone: valid_phone, nickname: nick})
      expect(get_nickname(t)).to eq(nick)
    end
  end

  # I've moved these functions to helpers so these test no longer run
  describe 'display_name' do
    let (:first) { 'first' }
    let (:last)  { 'last' }
    
    it 'returns capitalized "last, first" if both first_name and last_name are set' do
      t = Telesoci.new({phone: valid_phone, first_name: first, last_name: last})
      expect(display_name(t)).to eq("#{last.capitalize}, #{first.capitalize}")
    end

    it 'returns capitalized last if only last_name is set' do
      t = Telesoci.new({phone: valid_phone, last_name: last})
      expect(display_name(t)).to eq("#{last.capitalize}")
    end

    it 'returns capitalized first if only first_name is set' do
      t = Telesoci.new({phone: valid_phone, first_name: first})
      expect(display_name(t)).to eq("#{first.capitalize}")
    end

    it 'returns nil if neither first nor last is set' do
      t = Telesoci.new({phone: valid_phone})
      expect(display_name(t)).to be_nil
    end
  end
end
