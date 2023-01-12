# frozen_string_literal: true

require "rails_helper"

RSpec.describe User, :type => :model do
  subject { FactoryBot.build(:user) }
  
  describe "Validations" do 
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email).case_insensitive }
    it { should validate_presence_of(:password) }
  end

  describe 'Associations' do
    it { should have_many(:courses) }
  end
end
  