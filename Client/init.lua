button_number = 6







abort = 0;

print('Waiting to begin...')


wifi.sta.config("Net02","password")
wifi.sta.setip({ip="192.168.4."..button_number,netmask="255.255.255.0",gateway="192.168.4.1"})

wifi.sta.autoconnect(1);
wifi.setmode(wifi.STATION);

function run()

   
   tmr.stop(0);

   
   if (abort == 0) then
     print('starting')
      tmr.stop(0);
     dofile('program_c.lua')
   else
     print("Aborted");
   end
end


   tmr.alarm(0,2000,0,run)
