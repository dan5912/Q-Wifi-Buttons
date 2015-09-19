abort = 0;
print('Waiting to begin...')
cfg={}
cfg.ssid="Net02"
cfg.pwd="password"
wifi.ap.config(cfg)

wifi.sta.config("Net01","password")
wifi.sta.setip({ip="192.168.4.3",netmask="255.255.255.0",gateway="192.168.4.1"})

wifi.sta.autoconnect(1);
wifi.setmode(wifi.STATIONAP);
function run()

   
   tmr.stop(0);

   
   if (abort == 0) then
     print('Starting')
     dofile('program_c_test.lua')
     
   else
     print("Aborted");
   end
end


   tmr.alarm(0,2000,0,run)
