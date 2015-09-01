wifi.setmode(wifi.SOFTAP);

cfg={}
cfg.ssid="qcorp_nodes"
cfg.pwd="password"

wifi.ap.config(cfg)
button_in = 3

counter = {0,0,0,0,0,0};
button_pressed = 1;

gpio.mode(button_in, gpio.INPUT)

srv=net.createServer(net.TCP)
print("Running");
print(wifi.ap.getip());

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
        
        buf = buf..counter[1].." "..counter[2].." "..counter[3].." "..counter[4].." "..counter[5].." "..counter[6]

        client:send(buf);
        client:close();

        if _GET.c1 then
          counter[1] = _GET.c1;
        end
        if _GET.c2 then
          counter[2] = _GET.c2;
        end
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
      
    end)
end)




function get_button()
     if(gpio.read(3)==1) then
         if (button_pressed == 0) then
               counter[1] = counter[1] + 1;
               button_pressed = 1;
         end
     end
     if (gpio.read(3) == 0) then
          button_pressed = 0;
     end
end

tmr.alarm(1,50,1,get_button)

