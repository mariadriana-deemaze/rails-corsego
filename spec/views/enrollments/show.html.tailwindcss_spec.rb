require 'rails_helper'

RSpec.describe "enrollments/show", type: :view do
  before(:each) do
    @enrollment = assign(:enrollment, Enrollment.create!(
      user: nil,
      course: nil,
      rating: 2,
      review: "MyText",
      price: 3
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/3/)
  end
end
