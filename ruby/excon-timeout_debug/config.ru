app = proc do |env|
  sleep 3
  [ 200, {'Content-Type' => 'text/plain'}, ["a"] ]
end

run app
