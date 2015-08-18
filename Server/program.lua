wifi.setmode(wifi.STATION)
wifi.sta.config("11FX02061911","f37792acaf")
print(wifi.sta.getip())
button_in = 3
counter = {0,0,0,0,0,0};
button_pressed = {0,0,0,0,0,0};
gpio.mode(button_in, gpio.INPUT)
srv=net.createServer(net.TCP)

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
        buf = buf.."<h1>Counters 1-6: "..counter[1].." "..counter[2].." "..counter[3].." "..counter[4].." "..counter[5].." "..counter[6].." ".."</h1>"
        buf = buf.."<script type='text/javascript'>setTimeout(function () { location.reload(true); }, 5000);</script>"

     
        
        client:send(buf);
        client:close();
        collectgarbage();
    end)
end)

function get_button()
     if(gpio.read(3)==1) then
         if (button_pressed[1] == 0) then
               counter[1] = counter[1] + 1;
               button_pressed[1] = 1;
         end
     end
     if (gpio.read(3) == 0) then
          button_pressed[1] = 0;
     end
end

tmr.alarm(1,50,1,get_button)
