button_in = 4

counter = {0,0,0,0,0,0};
button_pressed = 0;

gpio.mode(button_in, gpio.INPUT,gpio.PULLUP)

srv=net.createServer(net.TCP)
print("Running");
print("Station: ".. wifi.sta.getip())
print("AP: ".. wifi.ap.getip())
print("Status: ".. wifi.sta.status())

srv:listen(80,function(conn)

    conn:on("receive", function(client,request)
        local buf = "";
        local _, _, method, path, vars = string.find(request, "([A-Z]+) (.+)?(.+) HTTP");

        if(method == nil)then

            _, _, method, path = string.find(request, "([A-Z]+) (.+) HTTP");

        end

        local _GET = {}

        if (vars ~= nil)then

            for k, v in string.gmatch(vars, "(%w+)=(%w+)&*") do
                _GET[k] = v
            end
        end
        buf = "OK"
        client:send(buf)
        client:close();

        if _GET.c3 then
          counter[3] = _GET.c3;
        end
        if _GET.c4 then
          counter[4] = _GET.c4;
        end
        if _GET.c5 then
          counter[5] = _GET.c5;
        end
        if _GET.c6 then
          counter[6] = _GET.c6;
        end

        
        collectgarbage();
        postCounter();
        print(counter[3]);
    end)
end)





function get_button()
     if(gpio.read(button_in)==0) then
         if (button_pressed == 0) then
               counter[2] = counter[2] + 1;
               button_pressed = 1;
               postCounter();
               print("Pressed");
               tmr.alarm(2,100,0,resetButton);
         end
     end
end

function resetButton()
     if(gpio.read(button_in) == 1) then
          button_pressed = 0;
     else
          tmr.alarm(2,100,0,resetButton);
     end
     
end


tmr.alarm(1,20,1,get_button)


function postCounter()
    connout = nil;
    connout = net.createConnection(net.TCP, 0);
 
    connout:on("connection", function()  connout:send("GET /?c2=" .. counter[2].."&c3="..counter[3].."&c4="..counter[4].."&c5="..counter[5].."&c6="..counter[6].." HTTP/1.1\r\n")   end)
    connout:connect(80,'192.168.5.1');
     

  
    
end
