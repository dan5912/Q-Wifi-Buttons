
button_in = 4;

while (wifi.sta.status() ~=5 ) do  
wifi.sleeptype(wifi.MODEM_SLEEP)      
      node.restart();
end

print(wifi.sta.getip());







counter = 0;
button_pressed = 0;
gpio.mode(button_in, gpio.INPUT,gpio.PULLUP);
function postCounter()
    connout = nil;
    connout = net.createConnection(net.TCP, 0);
 

    
    connout:on("connection", function()  connout:send("GET /?c"..button_number.."="..counter.." HTTP/1.1\r\n")  end)
    connout:connect(80,'192.168.4.1');


  
    
end
 



local function get_button()

     if(gpio.read(button_in)==0) then
         if (button_pressed == 0) then
               counter = counter + 1;
               button_pressed = 1;
               wifi.sleeptype(wifi.NONE_SLEEP)
               postCounter();
               wifi.sleeptype(wifi.MODEM_SLEEP)
               tmr.alarm(2,200,0,resetButton);
               
         end
     end

end

function resetButton()

     if (gpio.read(button_in) == 1) then
     
          button_pressed = 0;
          print("reset button")
     else
          tmr.alarm(2,100,0,resetButton);
     end

end
tmr.alarm(1,5,1,get_button)


