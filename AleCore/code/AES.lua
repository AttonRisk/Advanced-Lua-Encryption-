AES = {}

function AES.encryptString(password, data, keyLength, mode)
	assert(type(password) == "string" and type(data) == "string", "Bad argument @ encryptString")

	return aeslua.encrypt(password, data, aeslua[keyLength], aeslua[mode])
end

function AES.decryptString(password, data, keyLength, mode)
	assert(type(password) == "string" and type(data) == "string", "Bad argument @ decryptString")

	return aeslua.decrypt(password, data, aeslua[keyLength], aeslua[mode])
end

function AES.encryptFile(password, sourceFile, destinationFile, keyLength, mode)
	assert(type(password) == "string" and type(sourceFile) == "string" and type(destinationFile) == "string", "Bad argument @ encryptFile")

	if not fileExists(sourceFile) then
		outputDebugString"Source file does not exist"
	end
	local srcFile = fileOpen(sourceFile, true)
	local destFile = fileCreate(destinationFile)
	
	if not srcFile or not destFile then
		outputDebugString"Error opening files"
		return
	end
	
	if not AES.checkForValidPath(sourceFile) or not AES.checkForValidPath(destinationFile)  then
		outputDebugString"Please use the complete path notation ':resource/cryptic.lua'"
		return
	end
	
	local data = aeslua.encrypt(password, fileRead(srcFile, fileGetSize(srcFile)), aeslua[keyLength], aeslua[mode])
	fileWrite(destFile, data)
	
	fileClose(srcFile)
	fileClose(destFile)
	
	return data ~= nil
end

function AES.decryptFile(password, sourceFile, destinationFile, keyLength, mode)
	assert(type(password) == "string" and type(sourceFile) == "string" and type(destinationFile) == "string", "Bad argument @ decryptFile")

	if not fileExists(sourceFile) then
		outputDebugString"Source file does not exist"
	end
	local srcFile = fileOpen(sourceFile, true)
	local destFile = fileCreate(destinationFile)
	
	if not srcFile or not destFile then
		outputDebugString"Error opening files"
		return
	end
	
	if not AES.checkForValidPath(sourceFile) or not AES.checkForValidPath(destinationFile)  then
		outputDebugString"Please use the complete path notation ':resource/cryptic.lua'"
		return
	end
	
	local data = aeslua.decrypt(password, fileRead(srcFile, fileGetSize(srcFile)), aeslua[keyLength], aeslua[mode])
	fileWrite(destFile, data)
	
	fileClose(srcFile)
	fileClose(destFile)
	
	return data and true or false
end

function AES.checkForValidPath(path)
	return path:find(":(.+)/(.+)")
end

-- Copy to _G (to allow exports)
for k, v in pairs(AES) do
	_G[k] = v
end
