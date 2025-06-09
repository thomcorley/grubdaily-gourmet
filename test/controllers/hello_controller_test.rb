require "test_helper"

class HelloControllerTest < ActionDispatch::IntegrationTest
  test "should get home" do
    get root_url
    assert_response :success
  end

  test "should render home view" do
    get root_url
    assert_response :success
    assert_select "h1", "Hello World!"
  end
end 