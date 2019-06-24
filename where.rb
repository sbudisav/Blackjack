class Array
  def where(hash_input)
    output_array = []
    i = 0
    self.each do |hash|
      if hash_input.all? {|key, value| value === hash[key]}
        output_array << self[i]
      end
      i+=1
    end
    puts "**** FINAL OUTPUT ****"
    pp output_array
    output_array
  end
end