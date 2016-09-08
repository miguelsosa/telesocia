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

  def setup
    @request.env["devise.mapping"] = Devise.mappings[:admin]
    create_a_few_users
    @user = User.last
    sign_in @user
  end

  describe "Should be able to list users" do
    describe "when authenticated" do
      before(:each) do
        setup
      end
    
      # TODO: When roles and groups are added, a user can only see
      # those users that are visible due to their role and/or groups,
      # but until then we assuem everything is visible
      
      it "GET (user) 'index' succeeds and returns all users" do
        get :index
        expect(response).to be_success
      end

      it "Can GET 'show' a single user" do
        get :show, params: {id: User.first }
        expect(response).to be_success
      end
    end

    
    describe "when not authenticated" do
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
  end
end
