require "bowling"

describe "ボウリングのスコア計算" do
  before do
    @game = Bowling.new
  end  
  describe "全体の合計" do
    context "全部ガターだった時" do
      it "0になること" do
        add_many_score(20, 0)
        @game.calc_score
        expect(@game.total_score).to eq 0
      end  
    end  
    context "全ての投球で1ピンずつ倒した場合" do
      it "20になること" do
        add_many_score(20, 1)
        @game.calc_score
        expect(@game.total_score).to eq 20
      end  
    end  
    context "スペアをとった場合" do
      it "スペアボーナスが加算されること" do
        #第一フレーム
        @game.add_score(3)
        @game.add_score(7)
        #第二フレーム
        @game.add_score(4)
        #以降すべてガーター
        add_many_score(17, 0)
        
        @game.calc_score
        
        expect(@game.total_score).to eq 18
      end  
    end 
    context "フレーム違いでスペアになるようなスコアの時" do
      it "スペアボーナスが加算されないこと" do
        #第一フレーム
        @game.add_score(3)
        @game.add_score(5)
        #第二フレーム
        @game.add_score(5)
        @game.add_score(4)
        #以降すべてガーター
        add_many_score(16, 0)
        
        @game.calc_score
        
        expect(@game.total_score).to eq 17
      end  
    end
    context "最終フレームでスペアをとった場合" do
      it "スペアボーナスが加算されないこと" do
        #第一フレーム
        @game.add_score(3)
        @game.add_score(7)
        #第二フレーム
        @game.add_score(4)
        #以降15投ガーター
        add_many_score(15, 0)
        #最終フレーム
        @game.add_score(3)
        @game.add_score(7)
        
        @game.calc_score
        
        expect(@game.total_score).to eq 28
      end  
    end  
  end  
end
private
def add_many_score(count, pins)
  count.times do
    @game.add_score(pins)
  end  
end  