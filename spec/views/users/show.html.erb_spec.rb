require 'rails_helper'

RSpec.describe "users/show", type: :view do
  before(:each) do
    assign(:user, User.create!(
      name: "Name",
      email: "Email",
      password: "Password",
      password_confirmation: "Password Confirmation"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Email/)
    expect(rendered).to match(/Password/)
    expect(rendered).to match(/Password Confirmation/)
  end
end
