require "pry"
require "nokogiri"
require "open-uri"
require "sqlite3"

url = " https://simply-home-cda.herokuapp.com/pages/accueil.php "
html = URI.open(url)
app = Nokogiri::HTML(html)
db = SQLITE3::Database.new(" ")