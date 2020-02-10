require "application_system_test_case"

class GamesTest < ApplicationSystemTestCase
  test "Going to /new gives us a new random grid to play with" do
    visit new_url
    assert test: "New game"
    assert_selector "li", count: 10
  end

  test "a random word gives us a fail " do
    visit new_url
    fill_in "answer", with: "sfsdgsvvs"
    click_on "Submit!"
    assert_text "not an english word"
  end

end
