require 'rspec'

class Diamond 

  FILLER_CHARACTER = '-'

  def initialize(last_letter)
    @letter_range = ('A'..last_letter).to_enum
  end

  def rendered
    return 'A' if @letter_range.count == 1
            
    (top_rows_of_diamond + mirror_of(top_rows_of_diamond)).join("\n")
  end
  
  private 
  
  def top_rows_of_diamond
    @letter_range.collect.with_index{|letter, rank| row_to_display(letter, rank)}
  end

  def row_to_display(letter, rank)
   return centered('A') if(rank == 0)
   centered(letter + middle_padding_at(rank) + letter)
  end

  def centered(line)
   line.center(diamond_width, FILLER_CHARACTER)
  end

  def diamond_width
    @letter_range.count * 2 - 1
  end

  def middle_padding_at(rank)
    FILLER_CHARACTER * middle_padding_width_at(rank)
  end 

  def middle_padding_width_at(rank)
    rank * 2 - 1
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
