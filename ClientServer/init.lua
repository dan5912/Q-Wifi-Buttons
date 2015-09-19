button_number = 2







abort = 0;

print('Waiting to begin...')
cfg={}
cfg.ssid="Net02"
cfg.pwd="password"
wifi.ap.config(cfg)

wifi.sta.config("Net01","password")
wifi.sta.setip({ip="192.168.5.12",netmask="255.255.255.0",gateway="192.168.5.1"})

wifi.sta.autoconnect(1);
wifi.setmode(wifi.STATIONAP);

function run()

   
   tmr.stop(0);

   
   if (abort == 0) then
     print('starting')
      tmr.stop(0);
     dofile('client_server.lua')
   else
     print("Aborted");
   end
end


   tmr.alarm(0,2000,0,run)
