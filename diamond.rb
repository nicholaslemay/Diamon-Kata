require 'rspec'

class Diamond 

  def initialize(limit)
    @limit = limit
    @letter_range = ('A'..@limit).to_enum	
    @number_of_letters = @letter_range.count
  end

  def rendered()
    return 'A' if @limit == 'A'
            
    diamond_rows = top_rows_of_diamond + mirror_of(top_rows_of_diamond)
    diamond_rows.join("\n") 
  end
  
  private 
  
  def top_rows_of_diamond
    @letter_range.with_index.collect{|letter, rank| row_to_display(letter, rank)}
  end

  def row_to_display(letter, rank)
   return centered("A") if(rank == 0)
   centered(letter + middle_padding_at(rank) + letter)
  end

  def centered(line)
   line.center(diamond_width, "-")
  end

  def middle_padding_at(rank)
    "-" * middle_padding_width_at(rank)
  end 

  def middle_padding_width_at(rank)
    rank * 2 -1
  end

  def diamond_width
    @number_of_letters * 2 - 1
  end

  def mirror_of(rows)
    rows[0...-1].reverse
  end

end

describe Diamond do
 
 it 'can be generated for one letter' do
   expect(Diamond.new('A').rendered).to eq('A')
 end

 it 'can be generated for two letters' do
   diamond_for_b  = "-A-\n"
   diamond_for_b << "B-B\n"
   diamond_for_b << "-A-" 

   expect(Diamond.new('B').rendered).to eq(diamond_for_b)
 end

 it 'can be generated for four letters' do 
   diamond_for_d =  "---A---\n"
   diamond_for_d << "--B-B--\n"
   diamond_for_d << "-C---C-\n"
   diamond_for_d << "D-----D\n"
   diamond_for_d << "-C---C-\n"
   diamond_for_d << "--B-B--\n"
   diamond_for_d << "---A---"

   expect(Diamond.new('D').rendered).to eq(diamond_for_d)
 end

end
