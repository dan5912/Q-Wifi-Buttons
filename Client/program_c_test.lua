button_number = "3";




button_in = 4;
wifi.setmode(wifi.STATION);
wifi.sta.config("Net01","password")
wifi.sta.autoconnect(1);
exit = 0;
tmr.delay(1000000);
wifi.sta.connect()
tmr.delay(1000000);
if( not wifi.sta.getip()) then
     node.restart();
end
print(wifi.sta.getip());







counter = 0;
button_pressed = 0;
gpio.mode(button_in, gpio.INPUT,gpio.PULLUP);
function postCounter()
    connout = nil;
    connout = net.createConnection(net.TCP, 0);
 

    
    connout:on("connection", function() print("posted") connout:send("GET /?c"..button_number.."="..counter.." HTTP/1.1\r\n")  end)
    connout:connect(80,'192.168.4.1');


  
    
end
 



local function get_button()

     if(gpio.read(button_in)==0) then
         if (button_pressed == 0) then
               counter = counter + 1;
               button_pressed = 1;
               print(wifi.sleeptype(wifi.NONE_SLEEP))
               postCounter();
               print(wifi.sleeptype(wifi.MODEM_SLEEP))
               tmr.alarm(2,300,0,resetButton);
               
         end
     end

end

function resetButton()

     if (gpio.read(button_in) == 1) then
     
          button_pressed = 0;
          print("reset button")
     else
          tmr.alarm(2,300,0,resetButton);
     end

end
tmr.alarm(1,10,1,get_button)


