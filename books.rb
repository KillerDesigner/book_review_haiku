require 'sinatra'
require 'sinatra/reloader'
require 'sqlite3'

# create the booklist database
db = SQLite3::Database.new( 'booklist.sqlite3' )

# return a list of all books in the database
get '/' do
  @result = db.execute( "SELECT * FROM books;" )
  puts "*********************"
  puts @result
  puts "@@@@@@@@@@@@@@@@@@@"
  erb :home
end

# add a book to the books table
post '/add' do
  sql = "insert into books values ('#{params[:title]}', '#{params[:author]}', '#{params[:review]}')"
  db.execute( sql)
  redirect '/'
end