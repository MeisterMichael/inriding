
namespace :import do


	task tzsak: :environment do

		user = User.friendly.find('tzsak')
		category = SwellMedia::Category.friendly.find('rides')

		urls = [
			"http://tzsak.com/index.php/mount-shasta-summit-super-century-2005",
			"http://tzsak.com/index.php/breathless-agony",
			"http://tzsak.com/index.php/up-and-up-2007",
			"http://tzsak.com/index.php/ebbetts-pass-century-2009",
			"http://tzsak.com/index.php/cycling-camp-san-diego-2010",
			"http://tzsak.com/index.php/horseshoe-meadow-road-2010",
			"http://tzsak.com/index.php/2011-nine-mile-canyon-road",
			"http://tzsak.com/index.php/mighty-onion-valley-2011",
			"http://tzsak.com/index.php/2011-whitney-portal-road",
			"http://tzsak.com/index.php/2011-l-etape-du-california",
			"http://tzsak.com/index.php/2011-white-mountain",
			"http://tzsak.com/index.php/2011-horseshoe-meadow-road",
			"http://tzsak.com/index.php/2011-methuselah",
			"http://tzsak.com/index.php/2011-sonora-pass-east-and-west",
			"http://tzsak.com/index.php/2011-ride-the-wild-sierra",
			"http://tzsak.com/index.php/2013-white-mountain",
			"http://tzsak.com/index.php/2013-donut-ride",
			"http://tzsak.com/index.php/2013-muir-s-ride",
			"http://tzsak.com/index.php/lone-pine-2014",
			"http://tzsak.com/index.php/2014-white-mountain",
			"http://tzsak.com/index.php/near-death-experience/2005",
			"http://tzsak.com/index.php/near-death-experience/2006",
			"http://tzsak.com/index.php/near-death-experience/2007",
			"http://tzsak.com/index.php/near-death-experience/2012",
			"http://tzsak.com/index.php/markleeville-death-ride",
			"http://tzsak.com/index.php/markleeville-death-ride/2004",
			"http://tzsak.com/index.php/markleeville-death-ride/2005",
			"http://tzsak.com/index.php/markleeville-death-ride/2006",
			"http://tzsak.com/index.php/markleeville-death-ride/2007",
			"http://tzsak.com/index.php/markleeville-death-ride/2008",
			"http://tzsak.com/index.php/markleeville-death-ride/2009",
			"http://tzsak.com/index.php/markleeville-death-ride/2010",
		]

		a = Mechanize.new { |agent|
			agent.user_agent_alias = 'Mac Safari'
		}
		puts "\n"

		urls.each do |url|
			puts url

			a.get(url) do |page|
				article = page.at_css('article')
				title = article.at_css('h2').text.strip

				puts title

				error() if SwellMedia::Article.where( title: title, user: user ).count > 1
				media = SwellMedia::Article.where( title: title, user: user ).first

				article.css('h2').remove
				article.css('.pager').remove

				article.css('img').each do |img|

					complete_url = img['src']
					if img['src'][0] == '/'

						complete_url = "http://tzsak.com/#{img['src']}"

					else


					end

					asset = media.assets.where( origin_url: complete_url ).first
					asset ||= media.assets.create( type: 'SwellMedia::ImageAsset', origin_url: complete_url, remote_uploader_url: complete_url, status: :active )

					puts "#{complete_url} => #{asset.url}"

					img['src'] = asset.url

				end

				html = article.to_s

				media.update( content: html )

			end

			puts "\n"

		end




	end



end