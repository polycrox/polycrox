require 'rubygems'
require 'active_record'
require 'sinatra/base'
require 'pry'

ActiveRecord::Base.establish_connection(
  adapter: 'sqlite3',
  database: 'db/local.sqlite3.db',
  timeout: 5000

)

class Fidji < ActiveRecord::Base
  validates :name, :family, presence: true
end

class App < Sinatra::Base
  set :static, true
  set :public_folder, "static"

  set :server, "thin"
  set :logging, true

  get '/' do
    @fidjis = Fidji.all.sort
    erb 'fidjis/index'.to_sym    
  end

  get '/fidjis' do
    @fidjis = Fidji.all.sort
    erb 'fidjis/index'.to_sym    
  end

  get '/fidjis/new' do
    erb 'fidjis/new'.to_sym
  end
  post '/fidjis' do
    
    fidji = Fidji.new(params["fidji"])
    if fidji.save
      redirect to('/')
    else
      @error = fidji.errors
      erb 'fidjis/index'.to_sym    
    end
  end

  after do
    ActiveRecord::Base.clear_active_connections!
  end 
end

App.run!