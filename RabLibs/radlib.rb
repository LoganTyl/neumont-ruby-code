require 'sinatra'

get '/' do
    @storyList = Dir.entries('uploads')
    @storyList.shift(2)
    item = ''
    @storyList.each do |i|
        i.slice! '.txt'
        item.concat("<p><a href=#{i}>#{i}</a></p>")
    end
    erb item
end

get '/upload' do
    erb :upload
end

post '/upload' do
    file = params["myFile"][:filename]
    File.open("uploads/#{file}", "wb") do |f|
        f.write(params["myFile"][:tempfile].read)
    end
    erb "<p>Page Has Been Uploaded</p>"
end

get '/:storyName' do
    input = ''
    @storyName = params['storyName']
    @linkName = @storyName.concat(".txt")
    file = File.open("uploads/" + @linkName, "r")
    @fileText = file.read
    file.close
    @nounAmount = @fileText.scan("[noun]").length
    @verbAmount = @fileText.scan("[verb]").length
    @adjAmount = @fileText.scan("[adjective]").length
    input.concat("<form action='/#{@storyName}' method='post'>")
    @counter = 0
    @nounAmount.times do
        @nounCount = "noun" + @counter.to_s
        input.concat("<p>Noun: <input type='text' name='post[#{@nounCount}]' size=20 /></p>")
        @counter += 1
    end
    @counter = 0
    @verbAmount.times do
        @verbCount = "verb" + @counter.to_s
        input.concat("<p>Verb: <input type='text' name='post[#{@verbCount}]' size=20 /></p>")
        @counter += 1
    end
    @counter = 0
    @adjAmount.times do
        @adjCount = "adj" + @counter.to_s
        input.concat("<p>Adjective: <input type='text' name='post[#{@adjCount}]' size=20 /></p>")
        @counter += 1
    end
    @counter = 0
    input.concat("<input type='submit' value='Submit' />")
    input.concat("</form>")
    erb input
end

post '/:storyName' do
    @storyName = params['storyName']
    file = File.open("uploads/" + @storyName, "r")
    @fileText = file.read
    file.close
    @nounAmount = @fileText.scan("[noun]").length
    @verbAmount = @fileText.scan("[verb]").length
    @adjAmount = @fileText.scan("[adjective]").length
    @counter = 0
    @nounAmount.times do
        @nounCount = "noun" + @counter.to_s
        @fileText.sub!("[noun]", params[:post][:"#{@nounCount}"])
        @counter += 1
    end
    @counter = 0
    @verbAmount.times do
        @verbCount = "verb" + @counter.to_s
        @fileText.sub!("[verb]", params[:post][:"#{@verbCount}"])
        @counter += 1
    end
    @counter = 0
    @adjAmount.times do
        @adjCount = "adj" + @counter.to_s
        @fileText.sub!("[adjective]", params[:post][:"#{@adjCount}"])
        @counter += 1
    end
    @counter = 0
    erb @fileText
end
