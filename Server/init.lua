abort=0
print('Waiting to begin...')

cfg={}
cfg.ssid="Net01"
cfg.pwd="password"
cfg.ip="192.168.5.1"
cfg.netmask="255.255.255.0"
cfg.gateway="192.168.5.1"

wifi.ap.config(cfg)
wifi.ap.setip(cfg)

wifi.setmode(wifi.SOFTAP);

function run()

     if abort == 0 then
          print('starting')
          tmr.stop(0);
          dofile('program.lua')
     else
          print("Aborted")
     end
end


   tmr.alarm(0,2000,0,run)
