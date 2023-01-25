# frozen_string_literal: true

require "rails_helper"

RSpec.describe Course, :type => :model do
  subject(:course) { build(:course) }

  describe "Validations" do 
    it { expect(course).to be_valid }
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:description) }
    it { should have_rich_text(:description) }
    it { should validate_presence_of(:short_description) }
    it { should validate_presence_of(:level) }
    it { should validate_presence_of(:language) }    
  end

  describe 'Associations' do
    it { should have_many(:lessons) }
    it { should belong_to(:user) }
  end
end
  