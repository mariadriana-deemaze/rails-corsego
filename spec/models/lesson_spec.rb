# frozen_string_literal: true

require "rails_helper"

RSpec.describe Lesson, :type => :model do
  subject(:lesson) { build(:lesson) }
  
  describe "Validations" do 
    it { expect(lesson).to be_valid }
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:content) }
    it { should have_rich_text(:content) }
  end

  describe 'Associations' do
    it { should belong_to(:course) }
  end
end
  