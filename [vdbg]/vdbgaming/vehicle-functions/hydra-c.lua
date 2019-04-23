addEventHandler("onClientResourceStart", resourceRoot,
    function ()
    setAircraftMaxVelocity(20.41)
    end
)
 
addEventHandler("onClientResourceStop", resourceRoot,
    function ()
    setAircraftMaxVelocity(1.5)
    end
)