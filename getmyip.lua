-- Legge l'IP con cui naviga in Internet tramite dyndns

print('getmyip.lua started')

conn = nil
conn=net.createConnection(net.TCP, 0) 

-- show the retrieved web page

conn:on("receive", function(conn, payload) 
                       success = true
                       -- print(payload) 
					             print(string.sub(payload,string.find(payload, "<body>")+string.len("<body>"),string.len(payload)-16));
                       end) 

-- when connected, request page (send parameters to a script)
conn:on("connection", function(conn, payload) 
                       print('\nConnected') 
                       conn:send("GET /"
                        .." HTTP/1.1\r\n" 
                        .."Host: checkip.dyndns.org\r\n" 
               		      .."Connection: close\r\n"
                        .."Accept: */*\r\n" 
                        .."User-Agent: Mozilla/4.0 (compatible; esp8266 Lua; Windows NT 5.1)\r\n" 
                        .."\r\n")
                       end) 
-- when disconnected, let it be known
conn:on("disconnection", function(conn, payload) print('\nDisconnected') end)
                                             
conn:connect(80,'checkip.dyndns.org') 
