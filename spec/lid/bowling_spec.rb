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
    context "ストライクを取った場合" do
      it "ストライクボーナスが加算されること" do
        #第一フレーム
        @game.add_score(10)
        #第二フレーム
        @game.add_score(5)
        @game.add_score(4)
        #以降すべてガーター
        add_many_score(17, 0)
        
        @game.calc_score
        
        expect(@game.total_score).to eq 28
      end
    end  
    context "ダブルを取った場合" do
      it "それぞれのストライクボーナスが加算されること" do
        #第一フレーム
        @game.add_score(10)
        #第二フレーム
        @game.add_score(10)
        #第三フレーム
        @game.add_score(5)
        @game.add_score(4)
        #以降すべてガーター
        add_many_score(14, 0)
        
        @game.calc_score
        
        expect(@game.total_score).to eq 53
      end  
    end
    context "ターキーを取った場合" do
      it "それぞれのストライクボーナスが加算されること" do
        #第一フレーム
        @game.add_score(10)
        #第二フレーム
        @game.add_score(10)
        #第三フレーム
        @game.add_score(10)
        #第四フレーム
        @game.add_score(5)
        @game.add_score(4)
        #以降すべてガーター
        add_many_score(12, 0)
        
        @game.calc_score
        
        expect(@game.total_score).to eq 83
      end  
    end
  end
  describe "フレームごとの合計" do
    context "全ての投球で１ピンずつ倒した場合" do
      it "１フレーム目の合計が２になること" do
        add_many_score(20, 1)
        @game.calc_score
        expect(@game.flame_score(1)).to eq 2
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
        
        expect(@game.flame_score(1)).to eq 14
      end  
    end
    context "ストライクを取った場合" do
      it "ストライクボーナスが加算されること" do
        #第一フレーム
        @game.add_score(10)
        #第二フレーム
        @game.add_score(5)
        @game.add_score(4)
        #以降すべてガーター
        add_many_score(17, 0)
        
        @game.calc_score
        
        expect(@game.flame_score(1)).to eq 19
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