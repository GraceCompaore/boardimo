require "sqlite3"

class House
  attr_reader :title, :price, :size, :foundation_years, :energy
  
  def initialize(title:, price:, size:, foundation_years:, energy:)
    @title = title
    @price = price
    @size = price
    @foundation_years = foundation_years
    @energy = energy
  end

  def self.dbCnx
    @dbCnx ||= SQLite3::Database.new("./boardimo1DB.db")
    @dbCnx.results_as_hash = true
    @dbCnx
  end

  def self.all
    dbCnx.execute("SELECT title, price, size, foundation_years, energy FROM house").map do |row|
      self.new(title: row["title"], price: row["price"], size: row["size"], foundation_years: row["foundation_years"], energy: row["energy"])
    end
  end

  def self.find_by_title(title)
    row = dbCnx.execute("SELECT * FROM house WHERE title='#{title}' LIMIT 1").first

    self.new(title: row["title"], price: row["price"], size: row["size"], foundation_years: row["foundation_years"], energy: row["energy"])
  end

  def self.get_average(size)
      dbCnx.execute("SELECT AVG (price) AS average FROM house WHERE size = #{size}").first
  end
end