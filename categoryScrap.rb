require 'mechanize'
require 'json'
require "sqlite3"



agent = Mechanize.new						# making a new instance of Mechanize
page = agent.get("https://www.daraz.pk/")
cat_ul = page.search('span.nav-subTxt')   #jitni b search aaye ga wo is mn save huta rhy ga



db = SQLite3::Database.open "locker3.db"
db.execute "CREATE TABLE IF NOT EXISTS Website(webId INTEGER PRIMARY KEY,Name TEXT)"
db.execute "CREATE TABLE IF NOT EXISTS Category(catId INTEGER PRIMARY KEY,Name TEXT, trackwebsite INTEGER, FOREIGN KEY(trackwebsite) REFERENCES Website(webId))"


db.execute "INSERT INTO Website(Name) VALUES('pakwheels.com')"
# db.execute "INSERT INTO  Category(Name,trackwebsite) VALUES('Sudan',1)"
# db.execute "SELECT trackwebsite FROM Category WHERE Name = 'Sudan'"
# result=db.execute"SELECT * FROM Website WHERE webId = (SELECT trackwebsite FROM Category WHERE Name = 'Sudan')"
# result=result.to_json

insert = db.prepare('INSERT INTO Category (Name, trackwebsite) VALUES (?, ?)')

cat_ul.each do |x|
	x=x.text
 # db.execute "INSERT INTO  Category(Name,trackwebsite) VALUES('#{x}',1)"
	# # puts x.text
insert.execute(x,1)

end