require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  include Devise::Test::ControllerHelpers

  def create_a_few_users
    # TODO: In the future we will wan to separate regular users from admin
    Faker::Config.locale = 'en-US'
    Faker::Base.numerify('###-###-####')
    (1..3).each do
      FactoryGirl.create(:user)
    end
  end

  def setup(type)
    @request.env["devise.mapping"] = Devise.mappings[:admin]
    create_a_few_users
    @user = FactoryGirl.create(type)
    sign_in @user
  end


  context "when not authenticated" do
    before(:all) do
      # No admin users
      create_a_few_users
    end

    after(:all) do
      # cleanup
      User.delete_all
    end

    it "GET (user) 'index' requires authenticated user" do
      get :index
      expect(response).not_to be_success
    end

    it "GET (user) 'show' requires authenticated user" do
      get :show, params: {id: User.first }
      expect(response).not_to be_success
    end

  end

  context "admin" do
    describe "Should be able to list users" do
      before(:each) do
        setup(:admin)
      end
        
      it "GET (user) 'index' succeeds and returns all users" do
        get :index
        expect(response).to be_success
      end

      it "Can GET 'show' a single user" do
        get :show, params: {id: User.first }
        expect(response).to be_success
      end
    end
  end

  context "regular user" do
    before(:each) do
      setup(:user)
    end
    
    # TODO: When roles and groups are added, a user can only see
    # those users that are visible due to their role and/or groups,
    # but until then we assume everything is visible
    it "Can GET 'show' a themselves" do
      get :show, params: {id: @user }
      expect(response).to be_success
    end

    it "Can't list other users" do
      get :index
      expect(response).not_to be_success
    end

  end
end
