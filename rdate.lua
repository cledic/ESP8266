-- tested on NodeMCU 0.9.5 
-- Semplice programma per leggere la data dal server NTP 

print('rdate4.lua started')

conn = nil
conn=net.createConnection(net.TCP, 0) 

-- show the retrieved date and time

conn:on("receive", function(conn, payload) 
                       success = true
                       print(payload) 
                       end) 

-- when disconnected, let it be known
conn:on("disconnection", function(conn, payload) print('\nDisconnected') end)
                                             
conn:connect(13,'193.204.114.233') 
