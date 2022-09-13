#!/usr/bin/env ruby
require 'locomotive/coal'
require 'uri'
require 'net/http'
require "open-uri"


# this script will be called with the site name as parameter
site_name = ARGV[0]

# create a client
client = Locomotive::Coal::Client.new('https://cms.patternpoints.com', { 
    email: ENV['LOCOMOTIVE_USERNAME'], 
    api_key:  ENV['LOCOMOTIVE_APIKEY']
})

# get the site
site_client = client.scope_by(site_name)

# fetch the first account from site
main_account = site_client.contents.accounts.all.first

# now read upcontent api urls stored in each category
site_client.contents.categories.all.each do |c|
    puts "#{c.title}, fetching #{c.upcontenturl}\n\n"
    next if c.upcontenturl.nil? or c.upcontenturl.empty?

    # fetch the upcontent poll
    uri = URI(c.upcontenturl)
    response = Net::HTTP.get(uri)
    posts = JSON.parse(response)
    puts "Found #{posts.length} posts\n\n"


    # check, if the post already exists
    posts.each do |post|
        existing = site_client.contents.posts.all(title:  post['title'] )
        
        if existing.length > 0
            puts "#{post['title']} already exists\n\n"
            next
        end

        # uris from upcontent have been rescaled. We need to get the original image.
        # the original image url is the second part of the url, separated by a slash
        # https://m.img.upcontent.com/300x225/https://i.insider.com/6308000b58ebf60018c7caf5?width=1200&format=jpeg

        # get the second part of the url
        image_url = "https://#{post['image_url'].split('/https://')[1]}"
        
        # not all urls are built like that, so if image_url is blank, we use the original url
        image_url =  post['image_url'] if image_url == "https://"
        
        # some urls dont have a proper file extension, so we need to check and create them
        filename = URI.parse(image_url)
        filename = "tmp/#{File.basename(filename.path)}"
        if File.extname(filename).blank?
            filename = filename + ".jpg"
        end
        
        # some filename are too long, so we need to shorten them
        filename = filename[0..128] + File.extname(filename) if filename.length > 128


        URI.open(post['image_url']) do |image|
            File.open(filename, "wb") do |file|
                file.write(image.read)
            end
        end

        # # uploading the image as asset
        # image = site_client.content_assets.create(source: Locomotive::Coal::UploadIO.new(filename))
        # puts "Image uploaded: #{image._id}"
        
        puts "Adding #{post['title']}\n\n"
        site_client.contents.posts.create({
            title: post['title'],
            tags: "", #could tags be added in the response?
            post_type: "Image", # do you also support video posts?
            teaser: post['text'], # is there an abstract?
            account: main_account._id,
            category: c._id, # can the collection name be part of the json response?
            posted_at: DateTime.now, # in our case this is a date when we publish it on our blog 
            source_origin_url: post['short_url'],
            source_author: post['creator'], # is there a way to get the author name?
            source_published_at: post['posted'],
            source_publishing_label: post['creator'],
            likes: 0,
            prime: false,
            featured_image: Locomotive::Coal::UploadIO.new(filename),
            featured_image_caption: "Image credits to " + post['creator'], 
            body: post['text']
        })

        File.delete(filename) if File.exists? filename


    end
end

  

