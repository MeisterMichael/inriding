
namespace :import do


	task tzsak: :environment do

		user = User.friendly.find('inriding')

		urls = ['http://tzsak.com/index.php/mount-shasta-summit-super-century-2005']

		a = Mechanize.new { |agent|
			agent.user_agent_alias = 'Mac Safari'
		}
		puts "\n"

		urls.each do |url|
			puts url

			a.get(url) do |page|
				article = page.at_css('article')
				title = article.at_css('h2').text.strip

				media = SwellMedia::Article.create( title: title, user: user, status: 'draft' )


				article.css('img').each do |img|

					complete_url = img['src']
					if img['src'][0] == '/'

						complete_url = "http://tzsak.com/#{img['src']}"

					else


					end

					asset = media.assets.create( type: 'SwellMedia::ImageAsset', origin_url: complete_url, remote_uploader_url: complete_url, status: :active )

					img['src'] = asset.url

				end

				html = article.css('p').collect(&:to_s).join('')

				media.update( content: html )

			end

			puts "\n"

		end




	end



end