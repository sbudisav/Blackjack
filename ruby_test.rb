require 'minitest/autorun'
require './where'
require 'pp'

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



class WhereTest < Minitest::Test
  def setup
    @boris   = {:name => 'Boris The Blade', :quote => "Heavy is good. Heavy is reliable. If it doesn't work you can always hit them.", :title => 'Snatch', :rank => 4}
    @charles = {:name => 'Charles De Mar', :quote => 'Go that way, really fast. If something gets in your way, turn.', :title => 'Better Off Dead', :rank => 3}
    @wolf    = {:name => 'The Wolf', :quote => 'I think fast, I talk fast and I need you guys to act fast if you wanna get out of this', :title => 'Pulp Fiction', :rank => 4}
    @glen    = {:name => 'Glengarry Glen Ross', :quote => "Put. That coffee. Down. Coffee is for closers only.",  :title => "Blake", :rank => 3}
    @mikey   = {:name => 'Mickey Mean Fists', :quote => "Hey don't make me punch ya with these here mean fists",  :title => "Real Life", :rank => 3}

    @fixtures = [@boris, @charles, @wolf, @glen, @mikey]
  end

  def test_where_with_exact_match
    assert_equal [@wolf], @fixtures.where(:name => 'The Wolf')
  end

  def test_where_with_partial_match_and_multi_criteria
    assert_equal [@charles, @glen], @fixtures.where(:title => /^B.*/, :rank => 3)
  end

  def test_where_with_mutliple_exact_results
    assert_equal [@boris, @wolf], @fixtures.where(:rank => 4)
  end

  def test_with_with_multiple_criteria
    assert_equal [@wolf], @fixtures.where(:rank => 4, :quote => /get/)
  end

  def test_with_chain_calls
    assert_equal [@charles], @fixtures.where(:quote => /if/i).where(:rank => 3)
  end
end