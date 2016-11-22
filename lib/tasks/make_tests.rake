namespace :make_tests do
  desc "観光地をTestテーブルに保存"

  task :make_test_db do
    require "mechanize"
      agent = Mechanize.new
      links = []
      next_url = ""

      while true do
        current_page = agent.get("http://4travel.jp/overseas/area/asia/india/kankospot/")
        elements = current_page.search(".ranking_crown h2 a")
        elements.each do |ele|
          p ele.inner_text
          # links << ele.get_attribute('href')
        end

        next_page = current_page.link_with(:text => '次のページへ').click

        break unless next_page
      end
      # links.each do |link|
      #   get_product('http://review-movie.herokuapp.com' + link)
      # end


    # def get_product(link)
    #   agent=Mechanize.new
    #   page=agent.get(link)
    #   title=page.at(".entry-title").inner_text if page.at('.entry-title')
    #   image_url=page.at(".entry-content img").get_attribute("src") if page.at(".entry-content img")
    #   director=page.at(".director span").inner_text if page.at('.director span')
    #   detail=page.at(".entry-content p").inner_text if page.at('.entry-content p')
    #   open_date=page.at(".date span").inner_text if page.at('.date span')

    #   product=Product.where(title: title).first_or_initialize
    #   product.image_url=image_url
    #   product.director=director
    #   product.detail=detail
    #   product.open_date=open_date
    #   product.save
    # end
  end
end