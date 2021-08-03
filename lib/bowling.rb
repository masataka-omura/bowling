class Bowling
  def initialize
    @total_score = 0
    @scores = [] #全体のスコア
    @temp = [] #一時保存
  end  
  
  def total_score
    @total_score
  end  
  
  def add_score(pins)
    @temp << pins
    if @temp.size == 2 || strike?(@temp)
      @scores << @temp
      @temp = []
    end  
  end  
  
  def calc_score
    @scores.each.with_index(1) do |score, index|
      if strike?(score) && not_last_flame?(index)
        if strike?(@scores[index]) && not_last_flame?(index + 1)
          @total_score += 20 + @scores[index + 1].first
        else
          @total_score += 10 + @scores[index].inject(:+)
        end  
      elsif spare?(score) && not_last_flame?(index) 
        @total_score += calc_spare_bonus(index)
      else
        @total_score += score.inject(:+)
      end  
    end  
  end  
  
  private
  def strike?(score)
    score.first == 10
  end  
  
  def spare?(score)
    score.inject(:+) == 10
  end  
  
  def not_last_flame?(index)
    index < 10
  end  
  
  def calc_spare_bonus(index)
    10 + @scores[index].first
  end  
end 
