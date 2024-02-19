require "rails_helper"

RSpec.describe "Admin::Tags" do
  it "is inaccessible to normal user" do
    sign_in create(:user, admin: false)
    get "/admin/acts_as_taggable_on_tags"
    expect(response).to have_http_status(:unauthorized)
  end

  context "with admin permission" do
    before do
      sign_in create(:user, admin: true)
    end

    it "is accessible" do
      get "/admin/acts_as_taggable_on_tags"
      expect(response).to have_http_status(:success)
    end

    it "is inaccessible in demo mode" do
      allow(SiteSettings).to receive(:demo_mode?).and_return(true)
      expect { get("/admin/acts_as_taggable_on_tags") }.to raise_error(Pundit::NotAuthorizedError)
    end
  end
end
