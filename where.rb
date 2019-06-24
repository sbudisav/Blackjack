class Array
  def where(hash_input)
    output_array = []
    i = 0
    puts "ah shit we got two inputs now"
    puts hash_input
    self.each do |hash|
      hash_input.each_key do |input_key|
        hash.each do |key, value|
          if hash_input[key] === value
            output_array << self[i]
          end
        end
      end
      i+=1
    end
    pp output_array
    output_array
  end
end

