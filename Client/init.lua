print('Waiting to begin...')

function run()
   print('starting')
   tmr.stop(0);
   dofile('program.lua')
   end


   tmr.alarm(0,5000,0,run)
