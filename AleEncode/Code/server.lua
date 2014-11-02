--[[
--Advanced Lua Encryption 2.0 [Ale]
--By Atton Risk 2014/2013
--thenuke321@yahoo.com
--Feel free to edit this script but please do not claim it as yours or profit from it.
]]--
local cryptType = "AES256"
local mode = "ECBMODE"

local debugMode = true
-- Global Shit
local clientName = "client"
local serverName = "server"
-- This key can be anything

local kf = xmlLoadFile("key.xml")
local data = xmlFindChild(kf,"key",0)
local thekey = xmlNodeGetValue(data)
local keyc = tostring(thekey)

local sKey = "1234"
local eKey = teaDecode(tostring(keyc),tostring(sKey))
local rawKey = tostring(eKey)

local key = rawKey


function encode ()
-- Opens Files
serverFile = fileOpen("@:AleEncode/luafiles/"..serverName..".lua",true)
clientFile = fileOpen("@:AleEncode/luafiles/"..clientName..".lua",true)
-- Files Reads
local serverRead = fileRead(serverFile, fileGetSize(serverFile))
local clientRead = fileRead(clientFile, fileGetSize(clientFile))
-- Files Made Here
	if fileCreate("@:AleEncode/luafiles/"..clientName..".ale") and fileCreate("@:AleEncode/luafiles/"..serverName..".ale") then
			local wServer = fileOpen ("@:AleEncode/luafiles/"..serverName..".ale")
			local wClient = fileOpen ("@:AleEncode/luafiles/"..clientName..".ale")

			local eServer = exports.AleCore:encryptString(key,tostring(serverRead),cryptType,mode)
			local eClient = exports.AleCore:encryptString(key,tostring(clientRead),cryptType,mode)
			fileWrite(wServer,eServer)
			fileWrite(wClient,eClient)
			fileFlush(wServer)
			fileFlush(wClient)
		if serverFile and clientFile and wServer and wClient then
			-- For some fucking reason this does not seem to actually work so yeah!
--			fileDebug(serverFile,clientFile,wServer,wClient)
			fileClose(serverFile) 
			fileClose(clientFile)
			fileClose(wServer)
			fileClose(wClient)
			--outputChatBox("Process Ended",root)
		else
			outputChatBox("Error",root)
		end
	end
end
addCommandHandler("encodeluafiles",encode)


function makeKey (plr,hold,val1,val2)
	if val1 and val2 then
		local key = teaEncode(tostring(val1),tostring(val2))
		outputChatBox("The key is: "..tostring(key).." ".."The secret key is:"..tostring(val2),plr)
	end
end
addCommandHandler("makeKey",makeKey)



