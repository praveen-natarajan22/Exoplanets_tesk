# 1. The number of orphan planets (no star). TypeFlag = 3
# 2. The name (planet identifier) of the planet orbiting the hottest star. 
# 3. A timeline of the number of planets discovered per year grouped by size. Use the following groups: â€œsmallâ€? is less than 1 Jupiter radii, â€œmediumâ€? is less than 2 Jupiter radii, and anything bigger is considered â€œlargeâ€?. For example, in 2004 we discovered 2 small planets, 5 medium planets, and 0 large planets.
require 'minitest/autorun'
require_relative "exoplanetsdetails"

#sample Json "json_test.txt" is required to execute this file
class ExoPlanetsTest < Minitest::Test
  def setup
    @uri = "json_test.txt"
    @exoplanet_results = ExoPlanets.new
  end
  def test_response_values
    response = @exoplanet_results.planets_details(@uri)
    assert response != nil
  end
  def test_response_values_is_array
    response = @exoplanet_results.planets_details(@uri)
    assert_kind_of Array, response
  end
  
  def test_predefined_answers_is_not_empty
    response = @exoplanet_results.planets_details(@uri)
    refute_empty response
  end
end
