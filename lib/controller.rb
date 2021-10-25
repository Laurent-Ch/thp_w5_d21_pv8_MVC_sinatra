require 'gossip'

class ApplicationController < Sinatra::Base
  
  get '/' do
    erb :index, locals: {gossips: Gossip.all}
  end

  get '/gossips/new/' do
    erb :new_gossip
  end

  post '/gossips/new/' do
    #Gossip.new("super auteur", "super gossip").save
    Gossip.new(params["gossip_author"], params["gossip_content"]).save
    redirect '/'
  end

  get '/gossips/:id/' do
    erb :show
    #result = Gossip.find(params['id'])
    #"#{result[0]}, #{result[1]}"
  end
  
  get '/gossips/id/edit/' do
    erb :edit
  end

  post '/gossips/id/edit/' do
    Gossip.update(params["edit_row"], params["edit_author"], params["edit_content"])
    redirect '/'
  end

 # run! if app_file == $0
end
 

