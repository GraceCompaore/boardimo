class Board
  
    attr_reader :houses, :current_house, :average
  
    def initialize
      @houses = []
      @averages = 0
    end
  
    def comparaison_price (price, size)
    end

    def comparaison_year(foundation_years)
    end

    def comparaison_energy(energy)
    end


  
    def clear
      @products = []
      Product::all.each { |product| @counter[product.name] = 0 }
    end
  
    def <<(product)
      @counter[product.name] += 1
      @products << product
    end
  
    private
  
    def discount
      (discount_cherries + discount_bananas +
       discount_apples_en + discount_apples_it)
    end
  
    def discount_cherries
      @counter["Cerises"] / 2 * CHERRY_DISCOUNT
    end
  
    def discount_bananas
      @counter["Bananes"] / 2 * Product::find_by_name("Bananes").price
    end
  
    def discount_apples_en
      @counter["Apples"] / 3 *  Product::find_by_name("Apples").price
    end
  
    def discount_apples_it
      @counter["Mele"] / 2 * MELE_DISCOUNT
    end
  
    def total_without_discount
      @products.map(&:price).sum
    end
  end
  