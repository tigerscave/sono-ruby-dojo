require 'sinatra'
require 'sinatra/reloader'
require 'pry'
require 'active_record'
require 'rack/csrf'

use Rack::Session::Cookie, secret: "thisissomethingsecret"
use Rack::Csrf, raise: true

helpers do
  def csrf_tag
    Rack::Csrf.csrf_tag(env)
  end
  def csrf_token
    Rack::Csrf.csrf_token(env)
  end
  def h(str)
    Rack::Utils.escape_html(str)
  end
end

ActiveRecord::Base.establish_connection(
  adapter: 'sqlite3',
  database: './bbs.db'
)

class Comment < ActiveRecord::Base
  validates :body, presence: true
end


get '/' do
  @title = "My BBS"
  @comments = Comment.all
  erb :index
end

post '/create' do
  Comment.create(body: params[:body], name: params[:name])
  redirect to('/')
end

post '/destroy' do
  Comment.find(params[:id]).destroy
end

get '/about' do
  @title = "About this site"
  erb :about
end


#get '/hello/*/*' do |f, l|
#  "hello #{f} #{l}"
#end

#get '/hello/*/*' do
#  "hello #{params[:splat][0]} #{params[:splat][1]}"
#end

#get %r{/users/([0-9]*)} do
#  "user id = #{params[:captures][0]}"
#end
