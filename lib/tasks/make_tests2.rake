namespace :make_tests2 do
  desc "観光地をTestテーブルに保存"

  task :make_test_db do
    require 'capybara/poltergeist'
    require 'mechanize'
    require "open-uri"

    Capybara.register_driver :poltergeist do |app|
      Capybara::Poltergeist::Driver.new(app, {:js_errors => false, :timeout => 5000 })
    end

    session = Capybara::Session.new(:poltergeist)

    session.driver.headers = {
      'User-Agent' => "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_3) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/49.0.2564.97 Safari/537.36"
    }
    session.visit "http://4travel.jp/overseas/area/asia/india/kankospot/"
    while true do

      html = session.html

      doc = Nokogiri::HTML.parse(html)

      elements = doc.css(".ranking_crown h2 a")

      elements.each do |ele|
        session.visit "http://4travel.jp" + ele[:href]
        d_html = session.html
        d_doc = Nokogiri::HTML.parse(d_html)
        element = d_doc.css(".shisetsu_address .group dd").inner_text
        test = Test.create(:name => ele.inner_text, :address => element.gsub(/[\r\n]/,""))
        # p ele.inner_text
        # p element.gsub(/[\r\n]/,"")
      end
      next_page = session.find(".next a").click
      break unless next_page
    end
  end
end