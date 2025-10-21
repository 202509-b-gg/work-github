require "test_helper"

class Public::GenreControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get public_genre_index_url
    assert_response :success
  end
end
