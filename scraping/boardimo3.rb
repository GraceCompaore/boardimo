require "pry"
require "nokogiri"
require "open-uri"
require "sqlite3"

url = " https://simply-home-group.herokuapp.com/Accueil.php "
html = URI.open(url)
app = Nokogiri::HTML(html)
db = SQLITE3::Database.new(" ")