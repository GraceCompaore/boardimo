require "pry"
require "nokogiri"
require "open-uri"
require "sqlite3"

url = "https://simply-home.herokuapp.com/house1.php"
html = URI.open(url)
app = Nokogiri::HTML(html)
db = SQLite3::Database.new("boardimo1DB.db")

# Create table if not exists
rows = db.execute <<-SQL
  create table if not exists house (
    image_maison TEXT(30),
    title TEXT,
    price INT, 
    size INT, 
    foundation_years INT, 
    energy CHAR(2)
  );
SQL

image_maison = app.css("#singleArticleImage img").attr('src')

title = app.css("#titleSingleArticle h2").children.text

price = app.css("#singleArticleIcon .price").children.text
price = price.split("€").first.tr(' ', '').to_i

size = app.css("#singleArticleIcon .size").children.text
size = size.split("m²").first.tr(' ', '').to_i

foundation_years = app.css("#singleArticleIcon .foundation-years").children.text

energy = app.css("#singleArticleIcon .energy").children.text

data = {
    "image_maison" => image_maison,
    "title" => title,
    "price" => price,
    "size" => size,
    "foundation_years" => foundation_years,
    "energy" => energy
}

db.execute "INSERT INTO house (title, price, size, foundation_years, energy) VALUES (?, ?, ?, ?, ?)", [title , price, size, foundation_years, energy]

stm = db.prepare "SELECT * FROM house"
result = stm.execute
    
for row in result do
  puts row.join "\s"
end

binding.pry