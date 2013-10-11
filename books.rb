require 'sinatra'
require 'sinatra/reloader'
require 'sqlite3'
#require 'google/api-client'
require 'googlebooks'

# create the booklist database
db = SQLite3::Database.new( 'booklist.sqlite3' )

# the google books API object
@book_description

# return a list of all books in the database
get '/' do
  @result = db.execute( "SELECT * FROM books ORDER BY RANDOM() LIMIT 3;" )
  puts "*********************"
  puts @result
  puts "@@@@@@@@@@@@@@@@@@@"
  erb :home
end

#get '/book_info/:title' do
get '/:title' do
   @book_title = params[:title]
   @book_title.chomp.gsub!(' ', '+')
   puts "@@@@@@@@@@@@@"
   puts @book_title
   puts "%%%%%%%%%%%"
   #erb :home
   
   #@book_data = GoogleBooks.search("#{@book_title}", {:order_by => 'newest'})
   @book_data = GoogleBooks.search("#{@book_title}").first
   puts "@@@@@@@@"
   puts @book_data.description
   #p @book_data
   puts "!!!!!!!!!"
end

# add a book to the books table
post '/add' do
  haiku = params[:review].gsub!("'", "''")
  sql = "insert into books values ('#{params[:title]}', '#{params[:author]}', '#{haiku}')"
  db.execute( sql)
  redirect '/'
end