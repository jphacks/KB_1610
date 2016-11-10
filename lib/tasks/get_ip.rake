namespace :get_ip do
  desc "It is sample task!!"

  task :say_ip do
    require "geocoder"
    require "socket"
    p IPSocket::getaddress(Socket::gethostname)
    #g = Geocoder.address("39.70150773,141.13672256")
    #g = Geocoder.address(IPSocket::getaddress(Socket::gethostname))
    #puts g
  end
end