require 'gossip'
require 'comment'

class ApplicationController < Sinatra::Base
  
  # Homepage
  get '/' do
    erb :index, locals: {gossips: Gossip.all}
  end

  # New gossip.
  get '/gossips/new/' do
    erb :new_gossip
  end

  post '/gossips/new/' do
    #Gossip.new("super auteur", "super gossip").save
    Gossip.new(params["gossip_author"], params["gossip_content"]).save
    redirect '/'
  end

  # ID specific page
  get '/gossips/:id/' do
    erb :show #, locals: {comments: Comment.all(params["id"])}
    # Doesn't work, no idea why, using the other method.
    #result = Gossip.find(params['id'])
    #"#{result[0]}, #{result[1]}"
  end
  
  post '/gossips/:id/' do
    #Gossip.new("super auteur", "super gossip").save
    Comment.new(params["id"], params["comment_author"], params["comment_content"]).save
    redirect '/'
  end

  # Editing existing gossips
  get '/gossips/id/edit/' do
    erb :edit
  end

  post '/gossips/id/edit/' do
    Gossip.update(params["edit_row"], params["edit_author"], params["edit_content"])
    redirect '/'
  end

 # run! if app_file == $0
end
 

