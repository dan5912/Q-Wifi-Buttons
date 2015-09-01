print('Waiting to begin...')

function run()
   print('starting')
   tmr.stop(0);
   dofile('program_c.lua')
   end


   tmr.alarm(0,5000,0,run)
