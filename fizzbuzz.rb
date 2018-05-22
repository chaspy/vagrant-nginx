r = Nginx::Request.new
n = r.var.arg_n.to_i

if n % 15 == 0
    ans = "FizzBuzz"
elsif n % 3 == 0
    ans = "Fizz"
elsif n % 5 == 0
    ans = "Buzz"
else
    ans = n
end

Nginx.rputs(ans)
