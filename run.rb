require 'net/http'
(1..30).each{|n|
  Net::HTTP.get_print("192.168.33.100", "/fizzbuzz?n=#{n}")
}

