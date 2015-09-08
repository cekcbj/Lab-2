
require 'csv'

require 'erb'

shipments = []

CSV.foreach("./planet_express_logs.csv", headers: true) do |row|

  shipments << row.to_hash
end

money = shipments.map { |data| data["Money"].to_i }.reduce(:+)

fry_counter=0
fry_money=0
bender_counter=0
bender_money=0
amy_counter=0
amy_money=0
leela_counter=0
leela_money=0

shipments.each do |x|



  if x["Destination"] == "Earth"
  fry_counter += 1
   fry_money += x["Money"].to_i*0.10
  elsif x["Destination"]== "Uranus"
  bender_counter +=1
 bender_money += x["Money"].to_i*0.10
 elsif x["Destination"] == "Mars"
   amy_counter += 1
    amy_money += x["Money"].to_i*0.10
  else

  leela_counter += 1
 leela_money += x["Money"].to_i*0.10

end
end

pilots = [
  { "name" => "Leela", "trips" =>leela_counter ,  "money" => leela_money },
  { "name" =>"Fry", "trips" => fry_counter ,  "money" => fry_money,},
  { "name" =>"Amy", "trips" => amy_counter ,  "money" => amy_money,},
  { "name" =>"Bender", "trips" => bender_counter ,  "money" => bender_money},
  ]

b = binding

html = File.read("./report.erb")

the_html = ERB.new(html).result(b)

puts "------OUTPUT-FILE--------"
puts the_html

File.open("./report.html", "wb") {|f| f << the_html}
