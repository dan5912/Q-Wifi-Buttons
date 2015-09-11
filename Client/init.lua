abort = 0;
print('Waiting to begin...')


function run()

   
   tmr.stop(0);

   
   if (abort == 0) then
     print('Starting')
     dofile('program_c.lua')
     
   else
     print("Aborted");
   end
end


   tmr.alarm(0,2000,0,run)
