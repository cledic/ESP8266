-- Legge da un sito fortune frasi di autori inglesi 
-- http://wertarbyte.de/gigaset-rss/?limit=140&cookies=1&lang=en&format=txt&jar=people

-- Source: http://lua-users.org/wiki/MakingLuaLikePhp
-- Credit: http://richard.warburton.it/
function explode(div,str)
    if (div=='') then return false end
    local pos,arr = 0,{}
    for st,sp in function() return string.find(str,div,pos,true) end do
        table.insert(arr,string.sub(str,pos,st-1))
        pos = sp + 1
    end
    table.insert(arr,string.sub(str,pos))
    return arr
end

print('fortune.lua started')

conn = nil
conn=net.createConnection(net.TCP, 0) 

-- show the retrieved web page

conn:on("receive", function(conn, payload) 
             success = true
             --print(payload) 
					   local t={}
					   t=explode('\n', payload)
					   print(t[9])
             end) 

-- when connected, request page (send parameters to a script)
conn:on("connection", function(conn, payload) 
                       print('\nConnected') 
                       conn:send("GET /gigaset-rss/?limit=140&cookies=1&lang=en&format=txt&jar=people"
                        .." HTTP/1.1\r\n" 
                        .."Host: wertarbyte.de\r\n" 
               		      .."Connection: close\r\n"
                        .."Accept: */*\r\n" 
                        .."User-Agent: Mozilla/4.0 (compatible; esp8266 Lua; Windows NT 5.1)\r\n" 
                        .."\r\n")
                       end) 
-- when disconnected, let it be known
conn:on("disconnection", function(conn, payload) print('\nDisconnected') end)
                                             
conn:connect(80,'wertarbyte.de') 
