# frozen_string_literal: true

require "rails_helper"

RSpec.describe Role, :type => :model do
  subject { FactoryBot.build(:role) }
  
  describe "Validations" do 
    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name) }
  end

  describe 'Associations' do
    xit { should belong_to(:resource) }
    it { should have_and_belong_to_many(:users) }
  end
end
  