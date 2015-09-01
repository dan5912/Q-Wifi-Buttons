wifi.setmode(wifi.STATION);
wifi.sta.config("11FX02061911","f37792acaf")
exit = 0
while( not wifi.sta.getip() or exit > 10) do
   exit = exit + 1;
   tmr.delay(1000000);
   print("Connecting to wifi...");
   wifi.connect();
end
print(wifi.sta.getip());
if (wifi.sta.getip() == nil) then

     wifi.sta.config("qcorp_node_alpha","password");
     print("Connecting to alpha");
     wifi.connect();
end
button_in = 3
counter = 0;
button_pressed = 0;
gpio.mode(button_in, gpio.INPUT);
function postCounter()
    connout = nil;
    connout = net.createConnection(net.TCP, 0);
 

    
    connout:on("connection", function() print("posted") connout:send("GET /?c2="..counter.." HTTP/1.1\r\n")  end)
    connout:connect(81,'192.168.4.1');


  
    
end
 



local function get_button()

     if(gpio.read(3)==1) then
         if (button_pressed == 0) then
               counter = counter + 1;
               button_pressed = 1;
               print(wifi.sleeptype(wifi.NONE_SLEEP))
               postCounter();
               print(wifi.sleeptype(wifi.MODEM_SLEEP))
               
         end
     end
     if (gpio.read(3) == 0) then
          button_pressed = 0;
     end

end


tmr.alarm(1,50,1,get_button)


