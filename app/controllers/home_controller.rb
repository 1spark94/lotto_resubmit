require 'open-uri'
require 'json'

class HomeController < ApplicationController
    def index

    @page = open ('http://www.nlotto.co.kr/common.do?method=getLottoNumber&drwNo=801')
    @page = @page.read
    
    @page_info = JSON.parse(@page)
    @draw_numbers = []
    
    @page_info.each do |k, v|
        @draw_numbers << v if k.include?('drwtNo') 
        end
 
    
    @draw_numbers.sort!
    
    @bonus_number = @page_info["bnusNo"]
    
    @lotto = [*1..45].sample(6).sort
    
    @match_numbers = @lotto & @draw_numbers
    
    @match_count = @match_numbers.count
    
    if @match_count == 6
        @result = '일등했닭 ! 오늘은 미쳐버린 파닭 !'
      elsif (@match_count == 5) && (@lotto.include?(@bonus_number))
        @result = '아쉽다,, 축배를 들기 위해 송엘림 !'
      elsif @match_count == 5
        @result = '야 ! 3등도 잘한거야 !'
      elsif @match_count == 4
        @result = '사구 각,,'
      elsif @match_count == 3
        @result = '방에서 혼술 각'
      else
        @result = '술도 아까움'
    end
    
    end
end
