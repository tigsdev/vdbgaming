
 ---------------------------------------------- portao 1 ---------------------------------------------------------
 
 function createTheGate ()
 
         base_free5_pt1 = createObject ( 980, 1055.9000244141, 2087.6999511719, 12.60000038147, 0, 0, 90.25 )

 
      end
 
      addEventHandler ( "onResourceStart", getResourceRootElement ( getThisResource () ), createTheGate )
 
 
 
 
 
 function openMyGate ( )
 moveObject ( base_free5_pt1, 2500, 1055.9000244141, 2087.6999511719, 6.9000000953674)
 end
 addCommandHandler("lola",openMyGate)
 
 
 function movingMyGateBack ()
 moveObject ( base_free5_pt1, 2500, 1055.9000244141, 2087.6999511719,  12.60000038147 )
 end
 addCommandHandler("lolal",movingMyGateBack)

 

