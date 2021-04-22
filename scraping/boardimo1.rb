require "pry"
require "nokogiri"
require "open-uri"
require "sqlite3"


url = "https://simply-home.herokuapp.com/house.php"
html = URI.open(url)
app = Nokogiri::HTML(html)
db = SQLite3::Database.new("boardimo1DB.db")

# Drop Create table if not exists
db.execute <<-SQL
  DROP TABLE if exists house;
SQL

db.execute <<-SQL
  create table if not exists house (
    image_maison TEXT(30),
    title TEXT,
    price INT, 
    size INT, 
    foundation_years INT, 
    energy CHAR(2)
  );
SQL

db.execute <<-SQL
  create table if not exists city (
    designation TEXT,
    code INT
  );
SQL

db.execute <<-SQL
  create table if not exists agence (
    naming TEXT,
    adress INT,
    cities Text
  );
SQL
house_node_list = app.css(".articleHouse a")

house_node_list.each do |house_node|
  current_house_url = house_node.attr('href')
  puts "#{current_house_url}"
  current_url = "https://simply-home.herokuapp.com/#{current_house_url}"
  current_html = URI.open(current_url)
  current_app = Nokogiri::HTML(current_html)

  image_maison = current_app.css("#singleArticleImage img").attr('src')

  title = current_app.css("#titleSingleArticle h2").children.text

  price = current_app.css("#singleArticleIcon .price").children.text
  price = price.split("€").first.tr(' ', '').to_i

  size = current_app.css("#singleArticleIcon .size").children.text
  size = size.split("m²").first.tr(' ', '').to_i

  foundation_years = current_app.css("#singleArticleIcon .foundation-years").children.text

  energy = current_app.css("#singleArticleIcon .energy").children.text

  # data = {
  #     "image_maison" => image_maison,
  #     "title" => title,
  #     "price" => price,
  #     "size" => size,
  #     "foundation_years" => foundation_years,
  #     "energy" => energy
  # }

    db.execute "INSERT INTO house (title, price, size, foundation_years, energy) VALUES (?, ?, ?, ?, ?)", [title , price, size, foundation_years, energy]
end

request = db.prepare "SELECT * FROM house"
result = request.execute
    
for row in result do
  puts row.join "\s"
end

binding.pry