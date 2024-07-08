require 'rails_helper'

RSpec.describe "PageViews" do
  it "shows the number of pages views" do
    visit '/'
    expect(page.text).to match(/Learn the Docker fundamentals at:!/)
  end
end