#The purpose of this script is to speed up the process of Juniper firewall change request writeups. 
#Juniper does not allow ranges to be specified in the cli, so creating large groups that can't be CIDR addressed can be time consuming. 
#Eg. “Please create a policy for dst-ips 192.168.0.1-192.168.0.33"

require "ipaddr"

puts "Type 1 for Screen OS. Type 2 for Junos OS."
osquery = gets.chomp

puts "Type 1 for defining an IP. Type 2 for defining an address group."
groupquery = gets.chomp

puts "What is the starting IP Address?"
firstip = gets.chomp

puts "What is the ending IP Address?"
lastip = gets.chomp

ip = IPAddr.new firstip
ip2 = IPAddr.new lastip

if osquery == "1" && groupquery == "1"

puts "What zone?"
zone = gets.chomp

puts "set address #{zone} #{firstip} #{firstip}/32"
for x in ip...ip2
puts "set address #{zone} #{x.succ()} #{x.succ()}/32"
end

elsif osquery == "2" && groupquery == "1"
	
#In this case we are using an SRX global address group, not zone-based.
puts "set security address-book global address #{firstip} #{firstip}/32"
for x in ip...ip2
puts "set security address-book global address #{x.succ()} #{x.succ()}/32"
end

elsif osquery == "1" && groupquery == "2"
	
puts "What is the group address name?"
groupname = gets.chomp
puts "What zone?"
zone = gets.chomp

puts "set group address #{zone} #{groupname} add #{firstip}"
for x in ip...ip2
puts "set group address #{zone} #{groupname} add #{x.succ()}"
end

elsif osquery == "2" && groupquery == "2"

puts "What is the group address name?"
groupname = gets.chomp

puts "set security address-book global address-set #{groupname} address #{firstip}"
for x in ip...ip2
puts "set security address-book global address-set #{groupname} address #{x.succ()}"
end

else
print "Mistakes were made..."
end
