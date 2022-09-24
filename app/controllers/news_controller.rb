class NewsController < ApplicationController

  def show
  end

  BKK_URL = "https://www.bangkokpost.com/"
  NYT_URL = "https://www.nytimes.com"

  def getbkknews
    
    response = HTTParty.get(BKK_URL + '/world')

    @news = []
    if response.code == 200
      document = Nokogiri::HTML4(response.body)
      all_news_featured = document.css('div.hilight_sec--list')

      all_news_featured.each do |container|
        title = container.css('h2 a').text
        excerpt = container.css('p').text
        url = BKK_URL + container.css('h2 a').attr('href')
        img = container.css('.list-v > .item-photo a > img').attr('src')
        
        item = [title, excerpt,  url, img]
        @news << item

      end

      return @news

    else
      puts "Error in parsing the page"
      exit
    end
  
  end

  def getnytnews
    
    response = HTTParty.get(NYT_URL + '/section/world')

    @nynews = []
    if response.code == 200
      document = Nokogiri::HTML4(response.body)
      all_news_featured = document.css('li.eb97p613')

      count = 0

      all_news_featured.each do |container|

        # TEMPORARY GET ONLY THE 2 FEATURED FIRST 
        if count > 1
          break
        else
        end

        title = container.css('h2 a').text
        excerpt = container.css('p').text
        url = NYT_URL + container.css('h2 a').attr('href')
        img = container.css('article > figure > a > img >img').attr('src')
        
        item = [title, excerpt,  url, img]
        @nynews << item

        count = count + 1

      end

      return @nynews

    else
      puts "Error in parsing the page"
      exit
    end
  
  end

  def index
    @title = 'News aggregator'
    @news = getbkknews
    @nytnews = getnytnews
  end

  def divide_by_zero
    begin
      puts "You are about to divide by zero"
      @quotient = 8/0
    rescue => exception
      puts exception
      puts "Exception: Divide by Zero"
    end
  end

end
