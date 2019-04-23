local modShops = {
	{name="Temple TransFender", x=1041.3841552734, y=-1017.5839233398, z=31},
	{name="Redsands TransFender", x=1990.6890, y=2056.8046, z=10},
	{name="Loco Low Co.", x=2499.6159, y=-1779.8135, z=13},
	{name="Wheel Arch Angles", x=-2723.7060, y=217.2689, z=4},
	{name="Wheel Arch Angles", x=-2723.7060, y=217.2689, z=4},
	{name="Condomio dos boy", x=3295.58, y=1869.92, z=18.77},
}
local modShopGarages = {
	{x=1994.276, y=2041.688, z=12.063, rX=0, rY=0, rZ=90, model=11326},
	{x=2514.873, y=-1775.783, z=14.797, rX=0, rY=0, rZ=180, model=11326},
}
local vehicleUpgrades = {}
local modShopMarkers = {}
local carPickups = createElement("carPickups", "carPickups")

addEventHandler("onResourceStart",resourceRoot,
function ()
	for index, loc in pairs(modShops) do
		modShopMarkers[loc.name] = createMarker(loc.x, loc.y, loc.z-1, "cylinder", 2.5, 255, 0, 0, 125)
		setElementData(modShopMarkers[loc.name],"modShopName",loc.name)
		addEventHandler("onMarkerHit",modShopMarkers[loc.name],onModShopMarkerHit)
		createBlipAttachedTo( modShopMarkers[loc.name], 27, 2, 0,0,0,255, 0, 180 )
	end
	for index, garage in pairs(modShopGarages) do
		createObject(garage.model, garage.x, garage.y, garage.z, garage.rX, garage.rY, garage.rZ)
	end
end)

addEvent("modShop:getModShops",true)
addEventHandler("modShop:getModShops",root,
function ()
	triggerClientEvent(source,"modShop:createPickups",source,modShops)
end)

function onModShopMarkerHit(hitPlayer, dim)
	if (not dim) then return end
	if getElementType(hitPlayer) == "vehicle" then
	if (getElementData(source,"modShopUsed")) then return end
		local driver = getVehicleOccupant(hitPlayer, 0)
		exports["(SAUR)Info"]:sendMessage(driver, "Mod Shop: Welcome to ".. tostring(getElementData(source,"modShopName")) ..".",0,255,0)
		setModShopUsed(getElementData(source,"modShopName"), true)
		setElementData(driver,"modShop",tostring(getElementData(source,"modShopName")))
		triggerClientEvent(driver,"modShop:show",driver,vehicleUpgrades,source)
	end
end

function loadItems( )
    local file_root = xmlLoadFile( "moditems.xml" )
    local sub_node = xmlFindChild( file_root, "item", 0 )
    local i = 1
    while sub_node do
		vehicleUpgrades[xmlNodeGetAttribute( sub_node, "itemid" )] = {name=xmlNodeGetAttribute( sub_node, "name" ), price=xmlNodeGetAttribute( sub_node, "price" )}
        sub_node = xmlFindChild( file_root, "item", i )
        i = i + 1
    end
end
loadItems()

addEvent("modShop:exit",true)
addEventHandler("modShop:exit",root,
function (bool, upgrades, colors, paintjob, cost)
if bool then
	local vehicle = getPedOccupiedVehicle(source)
	if isElement( vehicle ) and getElementType( vehicle ) == 'vehicle' and type( upgrades ) == 'table' then
        local vehUpg = { getVehicleUpgrades( vehicle ) }
        local upgs = { }
        for k,v in pairs( upgrades ) do
            for i,j in pairs( vehUpg ) do
                if v ~= j then
                addVehicleUpgrade( vehicle, v )
                table.insert( upgs, v )
            end
        end
    end
    if paintjob == 255 or paintjob == getVehiclePaintjob( vehicle ) then 
            paintjob = false
        else
        setVehiclePaintjob( vehicle, paintjob )
    end
	setVehicleColor( vehicle, unpack( colors ) )
	end
	if tonumber(cost) > 0 then
		takePlayerMoney(source, tonumber(cost))
		exports["(SAUR)Info"]:sendMessage(source,"Mod Shop: You've paid a total of ".. exports["(SAUR)Tools"]:convertMoneyToString(tonumber(cost)) .." for the upgrade(s).",0,255,0)
		end
	end
	setModShopUsed(getElementData(source,"modShop"), false)
end)

addEventHandler("onPlayerQuit",root,
function ()
	if getElementData(source,"modShop") then
		setModShopUsed(getElementData(source,"modShop"), false)
	end
end)

addEventHandler("onPlayerLogout",root,
function ()
	if getElementData(source,"modShop") then
		setModShopUsed(getElementData(source,"modShop"), false)
	end
end)

function setModShopUsed(name, state)
	if modShopMarkers[name] and isElement(modShopMarkers[name]) then
		setElementData(modShopMarkers[name], "modShopUsed", false)
	end
end