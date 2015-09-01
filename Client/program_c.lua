wifi.setmode(wifi.STATION);
wifi.sta.config("Net01","password");
print(wifi.sta.getip());
button_in = 3
counter = 0;
button_pressed = 0;
gpio.mode(button_in, gpio.INPUT);
print(wifi.NONE_SLEEP);
print(wifi.MODEM_SLEEP);
function postCounter()
    connout = nil;
    connout = net.createConnection(net.TCP, 0);
 

    
    connout:on("connection", function() print("posted") connout:send("GET /?c2="..counter.." HTTP/1.1\r\n") end)
    connout:connect(80,'192.168.4.1');


  
    
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


