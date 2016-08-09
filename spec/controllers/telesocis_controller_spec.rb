require 'rails_helper'

# telesocis GET    /telesocis(.:format)           telesocis#index
# POST   /telesocis(.:format)           telesocis#create
# new_telesoci GET    /telesocis/new(.:format)       telesocis#new
# edit_telesoci GET    /telesocis/:id/edit(.:format)  telesocis#edit
# telesoci GET    /telesocis/:id(.:format)       telesocis#show
# PATCH  /telesocis/:id(.:format)       telesocis#update
# PUT    /telesocis/:id(.:format)       telesocis#update
# DELETE /telesocis/:id(.:format)       telesocis#destroy


RSpec.describe TelesocisController, type: :controller do
  include Devise::Test::ControllerHelpers

  def setup
    @request.env["devise.mapping"] = Devise.mappings[:admin]
    Faker::Config.locale = 'en-US'
    Faker::Base.numerify('###-###-####')
    @user = FactoryGirl.create(:user)
    sign_in @user
  end
 
  describe "GET 'show'" do
    before(:each) do
      setup
    end

    describe "as html" do
      before(:each) do
        @telesoci = create(:telesoci)
        get :show, params: { id: @telesoci.id }
      end

      it "should be successful" do
        expect(response).to be_success
      end

      it "should show the 'show' view" do
        expect(response).to render_template(:show)
      end
      
      it "should return the correct telesoci when correct id is passed" do
        expect(assigns(:telesoci).id).to eq(@telesoci.id)
      end
    end

    describe "as json" do
      before(:each) do
        @telesoci = create(:telesoci)

        get :show, params: { format: :json, id: @telesoci.id }
      end

      it "should be successful" do
        expect(response).to be_success
      end
      
      it "should return the correct telesoci" do
        body = JSON.parse(response.body)
        expect(body["id"]).to eq(@telesoci.id)
      end

      it "should have the right phone" do
        body = JSON.parse(response.body)
        expect(body["phone"]).to eq(@telesoci.phone)
      end
    end
  end
end
