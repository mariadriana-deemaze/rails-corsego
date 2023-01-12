# frozen_string_literal: true

require "rails_helper"

RSpec.describe User do
  it "is invalid with no attributes" do
    expect(User.new).not_to be_valid
  end
end
  