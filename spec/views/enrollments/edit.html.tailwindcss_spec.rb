require 'rails_helper'

RSpec.describe "enrollments/edit", type: :view do
  before(:each) do
    @enrollment = assign(:enrollment, Enrollment.create!(
      user: nil,
      course: nil,
      rating: 1,
      review: "MyText",
      price: 1
    ))
  end

  it "renders the edit enrollment form" do
    render

    assert_select "form[action=?][method=?]", enrollment_path(@enrollment), "post" do

      assert_select "input[name=?]", "enrollment[user_id]"

      assert_select "input[name=?]", "enrollment[course_id]"

      assert_select "input[name=?]", "enrollment[rating]"

      assert_select "textarea[name=?]", "enrollment[review]"

      assert_select "input[name=?]", "enrollment[price]"
    end
  end
end
