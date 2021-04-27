class HouseSanitizer
    def initialize(data)
        @data = data
    end

    def to_h
        @data

        begin
            valid
            @data
        rescue => _
            {}
        end
    end

    def clean_data
        title
        price 
        size
        foundation_years 
        energy
        
    end

    def sanitize_size
        @data[:size].slice!("m2") if @data[:size].include?("m2")
        
    end

    def sanitize_price
        if @data[:price].to_s.include?("€")
            @data[:price] = @data[:price].split("€").first.tr(' ', '').to_i
    end

    def sanitize_energy
        
    end

    def sanitize_foundation_year
        @data[:year] = @data[:year].delete("^0-9").to_i
    end

end

