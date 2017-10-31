require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe "POST #create" do
    context "with invalid params" do
      it "validates the presence of user's email and password" do
        post :create, params: { user: { username: "trung", password: "" } }

        expect(response).to render_template("new")
        expect(flash[:errors]).to be_present
      end

      it "validates that the password is at least 6 characters long" do
        post :create, params: { user: { username: "trung", password: "abc" } }

        expect(response).to render_template("new")
        expect(flash[:errors]).to be_present
      end
    end

    context "with valid params" do
      it "redirects user to the goals page if success" do
        post :create, params: { user: { username: "trung", password: "password" } }

        expect(response).to redirect_to(goals_url)
      end
    end

  end
end
