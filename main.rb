require 'sqlite3'
require 'sinatra'
require 'json'
connect = SQLite3::Database.open("main.db")

get '/' do
  @result = connect.execute("SELECT * FROM users")
  erb :index
end

post '/create' do
  if params['uname'] && params['pass']
    connect.execute("INSERT INTO users(id, uname, pass)VALUES(NULL, '#{params['uname']}', '#{params['pass']}')");
    redirect '/'
  end
end

get '/delete/{id}' do
  if params[:id]
    connect.execute("DELETE FROM users WHERE id = '#{params[:id]}'")
    redirect '/'
  end
end

get '/create' do
  erb :insert
end

get '/update/{id}' do
  @result = connect.execute("SELECT * FROM users WHERE id = '#{params[:id]}'")
  erb :update
end

post '/update/{id}' do
  if params['uname'] && params['pass'] && params['uname'] != '' && params['pass'] != ''
      uname = params['uname']
      pass = params['pass']
      @result = connect.execute("UPDATE users SET uname = '#{uname}', pass = '#{pass}' WHERE id = '#{params[:id]}'")
      redirect('/')
  end
end