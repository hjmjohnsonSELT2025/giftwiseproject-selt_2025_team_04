require "rails_helper"

RSpec.describe RecipientsController, type: :controller do
  it "shows test recipient when 'test' is entered in the search bar" do
    user=User.find_by(email: "a@b.c")
    result=user.recipients.select{ |search| search.name.downcase.include?("test")}
    expect(result.first.name).to eq("test recipient")
  end
end