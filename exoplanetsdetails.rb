# 1. The number of orphan planets (no star). TypeFlag = 3
# 2. The name (planet identifier) of the planet orbiting the hottest star. 
# 3. A timeline of the number of planets discovered per year grouped by size. Use the following groups: â€œsmallâ€? is less than 1 Jupiter radii, â€œmediumâ€? is less than 2 Jupiter radii, and anything bigger is considered â€œlargeâ€?. For example, in 2004 we discovered 2 small planets, 5 medium planets, and 0 large planets.
require "rubygems"
require "json"
require "net/http"
require "uri"
require 'open-uri'

class ExoPlanets
  def initialize
    @uri = "https://gist.githubusercontent.com/joelbirchler/66cf8045fcbb6515557347c05d789b4a/raw/9a196385b44d4288431eef74896c0512bad3defe/exoplanets"
  end
  def planets_details(uri=@uri)
    response = JSON.load(open(uri))
    
    ans1 = response.select { |a| a['TypeFlag'] == 3 }
    
    puts "\n1. The number of orphan planets (no star): #{ans1.size}"
    

    ans2MaxTemp = response.max_by{|a2| a2[:HostStarTempK] }
    a2 = []
    ans2 = response.select { |a| a['HostStarTempK'] ==  ans2MaxTemp['HostStarTempK'] }
    ans2.each do |a2v|
      a2 << a2v['PlanetIdentifier']
    end
    puts "\n2. The name (planet identifier) of the planet orbiting the hottest star: #{a2.sort.join(', ')}"

    discoveryYearUniq = []
      response.each do |res|
        if res["DiscoveryYear"].to_i != 0
        discoveryYearUniq << res["DiscoveryYear"]
        end
      end
    puts "\n3. A timeline of the number of planets discovered per year grouped by size as given below,\n"  
    discoveryYearUniq = discoveryYearUniq.uniq.sort
    discoveryYearUniq.each do |dy|
    getYearData = response.select { |a| a['DiscoveryYear'].to_i == dy }
    ans3small = getYearData.select { |a3s| a3s['RadiusJpt'].to_f < 1 }
    ans3medium = getYearData.select { |a3m| (a3m['RadiusJpt'].to_f > 1 && a3m['RadiusJpt'].to_f < 2) }
    ans3large = getYearData.select { |a3l| a3l['RadiusJpt'].to_f > 2 }
    puts "\nIn #{dy} we discovered #{ans3small.size} small planets, #{ans3medium.size} medium planets, and #{ans3large.size} large planets"
    end
  end
end

#Print statements will show the results expected for the 3 statements above
result_values = ExoPlanets.new
result_values.planets_details
