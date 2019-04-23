function switchEngine ( playerSource )
    local theVehicle = getPedOccupiedVehicle ( playerSource )
    if theVehicle and getVehicleController ( theVehicle ) == playerSource then
        local state = getVehicleEngineState ( theVehicle )
        setVehicleEngineState ( theVehicle, not state )
		
    end
end
addCommandHandler ( "motor", switchEngine )