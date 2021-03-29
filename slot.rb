require 'io/console'
# 端末上の入出力を制御する機能を IO に追加
# 基本的な入出力機能のクラス
def slot_start()
    puts ("メダルを入れてください")
    puts ("1(1メダル) 2(5メダル) 3(10メダル) 4(退出)")
    bet = gets.chomp.to_i
    
    if bet == 1
        bet_coin = 1
    elsif bet == 2
        bet_coin = 5
    elsif bet == 3
        bet_coin = 10
    elsif bet == 4
        puts ("終了します")
        exit
        #プログラムを終了
    end
    
    return bet, bet_coin
end

def slot_reel()
    number1 = Random.rand(1..9)
    number2 = Random.rand(1..9)
    number3 = Random.rand(1..9)
    return number1, number2, number3
end
#-----------------------------------
def per_slot(place, number, coin, bet_coin)
    puts ("当たり")
    puts ("#{place}に#{number}が揃いました")
    coin += bet_coin * 5
    puts ("#{bet_coin * 5}枚のメダルを獲得しました")
    per = true
    return coin, per
end
#-----------------------------------
coin = 100
per = false
game_again = 1
puts ("メダル残高#{coin}")

while game_again == 1
    bet_coin = 0
    
    bet, bet_coin = slot_start()
    #--------------再入力処理--------------
    while bet == 0 || bet >= 5 || coin < bet_coin
        if bet == 0 || bet >= 5
            puts ("1から４の数値を選択してください")
        else
            puts ("#{coin}枚のメダルを所持")
            puts ("メダルが不足しています")
        end
        bet, bet_coin = slot_start()
    end
    #----------------------------------
    
    #-------------メダル減算-----------
    coin -= bet_coin
    puts ("-------------")
    puts ("Enterを３回押してください")
    #----------------------------------
    
    #----------スロット本体------------
    slot_top =[0, 0, 0]
    slot_center =[0, 0, 0]
    slot_bottom =[0, 0, 0]
    #----------------------------------
    
    #--------スロットを押す処理--------
    for i in 1..3 do
        key = STDIN.getch
        while key != "\r"
            puts ("Enterを押してください")
            key = STDIN.getch
    end
    if (key == "\r")
        slot_top[i-1], slot_center[i-1], slot_bottom[i-1] = slot_reel()
    #----------------------------------
    
     #---スロットにランダムで値を入力---
    if i == 1
         puts ("|#{slot_top[0]}| | |")
         puts ("|#{slot_center[0]}| | |")
         puts ("|#{slot_bottom[0]}| | |")
    elsif i == 2 
         puts ("|#{slot_top[0]}|#{slot_top[1]} | |")
         puts ("|#{slot_center[0]}|#{slot_center[1]} | |")
         puts ("|#{slot_bottom[0]}|#{slot_bottom[1]} | |")
    elsif i == 3
         puts ("|#{slot_top[0]}|#{slot_top[1]}|#{slot_top[2]}|")
         puts ("|#{slot_center[0]}|#{slot_center[1]}|#{slot_center[2]}|")
         puts ("|#{slot_bottom[0]}|#{slot_bottom[1]}|#{slot_bottom[2]}|")
    end
    puts ("-------------")
  end
end

#揃った時の処理
if [slot_top[0], slot_top[1], slot_top[2]].uniq.count == 1
    coin, point, per = per_slot("上段", slot_top[0], coin, bet_coin)
end
if [slot_center[0], slot_center[1], slot_center[2]].uniq.count == 1
    coin, per = per_slot("中段", slot_center[0], coin, bet_coin)
end
if [slot_bottom[0], slot_bottom[1], slot_bottom[2]].uniq.count == 1
    coin, per = per_slot("下段", slot_bottom[0], coin, bet_coin)
end


#外れた時の処理
if per == false
    puts ("ハズレ")
    if coin < 1
        puts ("現在#{coin}枚のメダルを所持しています")
        puts ("メダルが無くなりました")
        puts ("終了します")
        exit
        end
    end
    
    puts ("メダル残高#{coin}")
    puts ("-------------")
    puts ("もう一度実行しますか")
    puts ("1(はい) 2(いいえ)")
    game_again = gets.chomp.to_i
    if game_again != 1
        puts ("またどうぞ")
    end
end