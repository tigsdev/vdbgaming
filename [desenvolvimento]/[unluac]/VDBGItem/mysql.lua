local host = "167.114.158.222"
local username = "vdbg_servidor"
local password = "ti3832ds@"
local db = "vdbg_servidor"
local results = {}

addEventHandler("onResourceStart", resourceRoot, function()
	dbHandler = dbConnect("mysql","dbname=".. db ..";host="..host, username, password, "autoreconnect=1")
	if not dbHandler then
		outputChatBox("#1 mysql kapcsolódás meghiúsult")
		cancelEvent(true)
	end
end)

function query_free(q,poll)
	local this = #results + 1
	results[this] = dbQuery(dbHandler, q)
	if poll then
		local result, num_affected_rows, last_insert_id = dbPoll(results[this], -1)
		if result == nil then
			dbFree(results[this])
			return this, nil
		elseif result == false then
			dbFree(results[this])
			return this, nil
		else
			dbFree(results[this])
			return this, tonumber(last_insert_id)
		end
	end
	dbFree(results[this])
	return this
end

function getConnection()
	return dbHandler
end

function singleQuery(str,...)
    if (dbHandler) then
        local query = dbQuery(dbHandler,str,...)
        local result = dbPoll(query,-1)
        if (type(result == "table")) then
			return result[1]
        else
			return result
        end
    else
        return false
    end
end

function execute(str)
    if (dbHandler) then
		local query, id = query_free(str, true)
		return query
    else
        return false
    end
end

function getFreeResultPoolID()
	return #results + 1
end

function escape_string(str)
	if (str) then
		return str
	end
	return false
end

function query_rows_assoc(str,...)
    if (dbHandler) then
		local this = #results + 1
		results[this] = dbQuery(dbHandler, str, ...)
		return dbPoll(results[this],-1)
    else
        return false
    end
end

function query(str,...)
    if (dbHandler) then
		return query_rows_assoc(str,...)
    else
        return false
    end
end

function query_fetch_assoc(str,...)
	if(not str)then
		return false
	end
	return singleQuery(str,...)
end

function query_insert_free(str)
    if (dbHandler) then
		local query, id = query_free(str, true)
		return id
    else
        return false
    end
end

function num_rows(result)
	if(not result)then
		return 0
	end
	if (type(result == "table")) then
		return (#result or 0)
	else
		return 1
	end
end