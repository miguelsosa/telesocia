require 'rails_helper'

RSpec.describe TelesocisController, type: :controller do
  include Devise::Test::ControllerHelpers

  def setup
    @request.env["devise.mapping"] = Devise.mappings[:admin]
    Faker::Config.locale = 'en-US'
    Faker::Base.numerify('###-###-####')
    @user = FactoryGirl.create(:user)
    sign_in @user
  end

  # I'm testing authentication here and all the routes but really all
  # this does is test that devise and rails are doing what they says
  # they should be doing, and that we are using it correctly.  I'll
  # leave these tests here as boilerplate for future projects or for
  # future functionality

  describe "authentication" do
    describe "when authenticated" do
      before(:each) do
        setup
        @telesoci = create(:telesoci)
      end

      it "GET 'show' succeeds" do
        get :show, params: {id: @telesoci }
        expect(response).to be_success
      end

      it "GET 'index' succeeds" do
        get :index
        expect(response).to be_success
      end

      it "GET 'new' succeeds" do
        # This just returns the 'new' page
        get :new
        expect(response).to be_success
      end

      it "GET 'edit' succeeds" do
        get :edit, params: {id: @telesoci }
        expect(response).to be_success
      end

      it "POST 'create' succeeds" do
        test_phone = "352-555-1234"
        test_url = "http://www.google.com"
        post :create, params: { telesoci: { phone: test_phone, url: test_url} }
        expect(response).to redirect_to(assigns(:telesoci))

        new_tsoci = Telesoci.where({phone: test_phone})
        expect(new_tsoci.one?).to be(true)
        expect(new_tsoci.first.url).to eq(test_url)
      end

      it "PATCH 'update' succeeds" do
        new_phone = "787-555-1235"
        modified_telesoci = Telesoci.first
        patch :update, params: { id: modified_telesoci.id, telesoci: { phone: new_phone } }
        expect(response).to redirect_to(assigns(:telesoci))
        # Get telesoci after update:
        modified_telesoci = Telesoci.first
        expect(modified_telesoci.phone).to eq(new_phone)
      end

      it "PUT 'update' succeeds" do
        new_phone = "787-555-1236"
        modified_telesoci = Telesoci.first
        put :update, params: { :id => modified_telesoci.id, :telesoci => {:telesoci => modified_telesoci}.merge({phone: new_phone})}
        
        expect(response).to redirect_to(assigns(:telesoci))
        
        # Get telesoci after update:
        expect(Telesoci.find(modified_telesoci.id).phone).to eq(new_phone)
      end

      it "DELETE 'destroy' succeeds" do
        # The precondition
        expect(Telesoci.find(@telesoci.id)).to eq(@telesoci)
        delete :destroy, params: {id: @telesoci }
        expect(response).to redirect_to(assigns(:telesoci))

        # Shouldn't find it
        expect {
          Telesoci.find(@telesoci.id)
        }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end

    it "GET 'show' fails if not authenticated user" do
      get :show, params: { id: 1 }
      expect(response).not_to be_success
    end

    it "GET 'show' succceds authenticated user" do
      get :show, params: { id: 1 }
      expect(response).not_to be_success
    end

    it "GET 'index' requires authenticated user" do
      get :index
      expect(response).not_to be_success
    end
  end
 
  describe "GET 'show'" do
    before(:each) do
      setup
    end

    describe "as html" do
      before(:each) do
        @telesoci = create(:telesoci)
        get :show, params: { id: @telesoci }
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

        get :show, params: { format: :json, id: @telesoci }
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
