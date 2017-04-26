require 'wombat'

module Crawler
  def self.test_crawler
    Wombat.crawl do
      base_url "https://www.github.com"
      path "/"

      headline xpath: "//h1"
      subheading css: "p.alt-lead"

      what_is({css: ".one-fourth h4"}, :list)

      links do
        explore xpath: '/html/body/header/div/div/nav[1]/a[4]' do |e|
          e.gsub(/Explore/, "Love")
        end

        features css: '.nav-item-opensource'
        business css: '.nav-item-business'
      end
    end

  end
end




