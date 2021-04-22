class Board
  
    attr_reader :current_house
  
    # def initialize
      
    # end

    def find_house_by_title(title)
      @current_house = House::find_by_title(title)
      puts current_house
    end
  
    def comparaison_price (price, size)
    end

    def comparaison_year(foundation_years)
    end

    def comparaison_energy(energy)
    end
  
  end
  