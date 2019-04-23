local x, y = guiGetScreenSize()

Top1Use = false
Top2Use = false
Top3Use = false
Top4Use = false
Top5Use = false

Top1Stuff = {nil,nil,nil,nil,nil}

    function FirstTopAnnounce()
        dxDrawText(Top1Stuff[1]..": "..Top1Stuff[2],x/2.2,y/4+80,x,y/4,tocolor(Top1Stuff[3],Top1Stuff[4],Top1Stuff[5],255),1.3,"pricedown","centre","top",false,false,false)
    end
    
	    function SecondTopAnnounce()
	   		dxDrawText(Top2Stuff[1]..": "..Top2Stuff[2],x/2.2,y/4+60,x,y/4,tocolor(Top2Stuff[3],Top2Stuff[4],Top2Stuff[5],254),1.3,"pricedown","centre","top",false,false,false)
	    end
    
		    function ThirdTopAnnounce()
		   		dxDrawText(Top3Stuff[1]..": "..Top3Stuff[2],x/2.2,y/4+40,x,y/4,tocolor(Top3Stuff[3],Top3Stuff[4],Top3Stuff[5],253),1.3,"pricedown","centre","top",false,false,false)
		    end
    
			    function FourthTopAnnounce()
			   		dxDrawText(Top4Stuff[1]..": "..Top4Stuff[2],x/2.2,y/4+20,x,y/4,tocolor(Top4Stuff[3],Top4Stuff[4],Top4Stuff[5],252),1.3,"pricedown","centre","top",false,false,false)
			    end
    
				    function FifthTopAnnounce()
				   		dxDrawText(Top5Stuff[1]..": "..Top5Stuff[2],x/2.2,y/4,x,y/4,tocolor(Top5Stuff[3],Top5Stuff[4],Top5Stuff[5],251),1.3,"pricedown","centre","top",false,false,false)
				    end
    
		function FirstTopAnnounceDown ()
		Top1Use = false
		removeEventHandler("onClientRender",getRootElement(), FirstTopAnnounce )
		end
		
		function SecondTopAnnounceDown ()
		Top2Use = false
		removeEventHandler("onClientRender",getRootElement(), SecondTopAnnounce )
		end
		
		function ThirdTopAnnounceDown ()
		Top3Use = false
		removeEventHandler("onClientRender",getRootElement(), ThirdTopAnnounce )
		end
		
		function FourthTopAnnounceDown ()
		Top4Use = false
		removeEventHandler("onClientRender",getRootElement(), FourthTopAnnounce )
		end
		
		function FifthTopAnnounceDown ()
		Top5Use = false
		removeEventHandler("onClientRender",getRootElement(), FifthTopAnnounce )
		end

function TakeAnnouncement (name,text,color)

	r,g,b = getCol(color)

	text = table.concat (text, " ")

	newest = {name,text,r,g,b}
	--test probably i will forgot to removeCommandHandler
     killTimer(timer1)
     killTimer(timer11)
     killTimer(timer111)
     killTimer(timer1111)
     killTimer(timer11111)
     killTimer(timer111111)
     killTimer(timer2)
     killTimer(timer22)
     killTimer(timer222)
     killTimer(timer2222)
     killTimer(timer22222)
     killTimer(timer3)
     killTimer(timer33)
     killTimer(timer333)
     killTimer(timer3333)
     killTimer(timer4) 
     killTimer(timer44)
     killTimer(timer444)
     killTimer(timer5)
     killTimer(timer55)
	--test end
	if not Top1Use then
		Top1Use = true
		Top1Stuff = newest
		addEventHandler("onClientRender",getRootElement(), FirstTopAnnounce )
		timer1 = setTimer(FirstTopAnnounceDown,6000,1)
	elseif Top1Use and not Top2Use then
		Top2Use = true
		Top2Stuff = Top1Stuff
		Top1Stuff = newest
		addEventHandler("onClientRender",getRootElement(), SecondTopAnnounce )
		timer2 = setTimer(SecondTopAnnounceDown,5000,1)
		timer11 = setTimer(FirstTopAnnounceDown,6000,1)
	elseif Top1Use and Top2Use and not Top3Use then
		Top3Use = true
		Top3Stuff = Top2Stuff
		Top2Stuff = Top1Stuff
		Top1Stuff = newest
		addEventHandler("onClientRender",getRootElement(), ThirdTopAnnounce )
		timer3 = setTimer(ThirdTopAnnounceDown,4000,1)
		timer111 = setTimer(FirstTopAnnounceDown,6000,1)
		timer22 = setTimer(SecondTopAnnounceDown,5000,1)
	elseif Top1Use and Top2Use and Top3Use and not Top4Use then
		Top4Use = true
		Top4Stuff = Top3Stuff
		Top3Stuff = Top2Stuff
		Top2Stuff = Top1Stuff
		Top1Stuff = newest
		addEventHandler("onClientRender",getRootElement(), FourthTopAnnounce )
		timer4 = setTimer(FourthTopAnnounceDown,3000,1)
		timer1111 = setTimer(FirstTopAnnounceDown,6000,1)
		timer222 = setTimer(SecondTopAnnounceDown,5000,1)
		timer33 = setTimer(ThirdTopAnnounceDown,4000,1)
	elseif Top1Use and Top2Use and Top3Use and Top4Use and not Top5Use then
		Top5Use = true
		Top5Stuff = Top4Stuff
		Top4Stuff = Top3Stuff
		Top3Stuff = Top2Stuff
		Top2Stuff = Top1Stuff
		Top1Stuff = newest
		addEventHandler("onClientRender",getRootElement(), FifthTopAnnounce )
		timer5 = setTimer(FifthTopAnnounceDown,1500,1)
		timer11111 = setTimer(FirstTopAnnounceDown,6000,1)
		timer2222 = setTimer(SecondTopAnnounceDown,5000,1)
		timer333 = setTimer(ThirdTopAnnounceDown,4000,1)
		timer44 = setTimer(FourthTopAnnounceDown,2000,1)
	elseif Top1Use and Top2Use and Top3Use and Top4Use and Top5Use then
		Top1Use = true
		Top5Stuff = Top4Stuff
		Top4Stuff = Top3Stuff
		Top3Stuff = Top2Stuff
		Top2Stuff = Top1Stuff
		Top1Stuff = newest
		addEventHandler("onClientRender",getRootElement(), FirstTopAnnounce )
		timer111111 = setTimer(FirstTopAnnounceDown,6000,1)
		timer22222 = setTimer(SecondTopAnnounceDown,5000,1)
		timer3333 = setTimer(ThirdTopAnnounceDown,4000,1)
		timer444 = setTimer(FourthTopAnnounceDown,2000,1)
		timer55 = setTimer(FifthTopAnnounceDown,1500,1)
end
end
addEvent( "onAnnouncementComing", true )
addEventHandler( "onAnnouncementComing", getRootElement(), TakeAnnouncement )
	
function getCol(color)
	if tostring(color) == "verde" then
	r = 0
	g = 255
	b = 0
	elseif tostring(color) == "branco" then
	r = 255
	g = 255
	b = 255
	elseif tostring(color) == "vermelho" then
	r = 255
	g = 0
	b = 0
	elseif tostring(color) == "amarelo" then
	r = 255
	g = 255
	b = 0
	elseif tostring(color) == "azul" then
	r = 0
	g = 0
	b = 255
end
return r,g,b
end
----------------------------------- Left one
-------I made them as two diffrent scripts because of my own reasons :P
------------------yeey
Left1Use = false
Left2Use = false
Left3Use = false
Left4Use = false
Left5Use = false

Left1Stuff = {nil,nil,nil,nil,nil}

    function FirstLeftAnnounce()
        dxDrawText(Left1Stuff[1]..": "..Left1Stuff[2],65,y/2-80,721.0,569.0,tocolor(Left1Stuff[3],Left1Stuff[4],Left1Stuff[5],255),1.9,"arial","left","top",false,false,false)
    end
    
	    function SecondLeftAnnounce()
	   		dxDrawText(Left2Stuff[1]..": "..Left2Stuff[2],65,y/2-60,721.0,569.0,tocolor(Left2Stuff[3],Left2Stuff[4],Left2Stuff[5],255),1.9,"arial","left","top",false,false,false)
	    end
    
		    function ThirdLeftAnnounce()
		   		dxDrawText(Left3Stuff[1]..": "..Left3Stuff[2],65,y/2-40,721.0,569.0,tocolor(Left3Stuff[3],Left3Stuff[4],Left3Stuff[5],255),1.9,"arial","left","top",false,false,false)
		    end
    
			    function FourthLeftAnnounce()
			   		dxDrawText(Left4Stuff[1]..": "..Left4Stuff[2],65,y/2-20,721.0,569.0,tocolor(Left4Stuff[3],Left4Stuff[4],Left4Stuff[5],255),1.9,"arial","left","top",false,false,false)
			    end
    
				    function FifthLeftAnnounce()
				   		dxDrawText(Left5Stuff[1]..": "..Left5Stuff[2],65,y/2,721.0,569.0,tocolor(Left5Stuff[3],Left5Stuff[4],Left5Stuff[5],255),1.9,"arial","left","top",false,false,false)
				    end
    
		function FirstLeftAnnounceDown ()
		Left1Use = false
		removeEventHandler("onClientRender",getRootElement(), FirstLeftAnnounce )
		end
		
		function SecondLeftAnnounceDown ()
		Left2Use = false
		removeEventHandler("onClientRender",getRootElement(), SecondLeftAnnounce )
		end
		
		function ThirdLeftAnnounceDown ()
		Left3Use = false
		removeEventHandler("onClientRender",getRootElement(), ThirdLeftAnnounce )
		end
		
		function FourthLeftAnnounceDown ()
		Left4Use = false
		removeEventHandler("onClientRender",getRootElement(), FourthLeftAnnounce )
		end
		
		function FifthLeftAnnounceDown ()
		Left5Use = false
		removeEventHandler("onClientRender",getRootElement(), FifthLeftAnnounce )
		end

function TakeAnnouncementLeft (name,text,color)

	r,g,b = getCol(color)

	text = table.concat (text, " ")

	newest = {name,text,r,g,b}
	--test probably i will forgot to removeCommandHandler
     killTimer(timer6)
     killTimer(timer66)
     killTimer(timer666)
     killTimer(timer6666)
     killTimer(timer66666)
     killTimer(timer666666)
     killTimer(timer7)
     killTimer(timer77)
     killTimer(timer777)
     killTimer(timer7777)
     killTimer(timer77777)
     killTimer(timer8)
     killTimer(timer88)
     killTimer(timer888)
     killTimer(timer8888)
     killTimer(timer9) 
     killTimer(timer99)
     killTimer(timer999)
     killTimer(timer10)
     killTimer(timer1010)
	--test end
	if not Left1Use then
		Left1Use = true
		Left1Stuff = newest
		addEventHandler("onClientRender",getRootElement(), FirstLeftAnnounce )
		timer6 = setTimer(FirstLeftAnnounceDown,6000,1)
	elseif Left1Use and not Left2Use then
		Left2Use = true
		Left2Stuff = Left1Stuff
		Left1Stuff = newest
		addEventHandler("onClientRender",getRootElement(), SecondLeftAnnounce )
		timer7 = setTimer(SecondLeftAnnounceDown,5000,1)
		timer66 = setTimer(FirstLeftAnnounceDown,6000,1)
	elseif Left1Use and Left2Use and not Left3Use then
		Left3Use = true
		Left3Stuff = Left2Stuff
		Left2Stuff = Left1Stuff
		Left1Stuff = newest
		addEventHandler("onClientRender",getRootElement(), ThirdLeftAnnounce )
		timer8 = setTimer(ThirdLeftAnnounceDown,4000,1)
		timer666 = setTimer(FirstLeftAnnounceDown,6000,1)
		timer77 = setTimer(SecondLeftAnnounceDown,5000,1)
	elseif Left1Use and Left2Use and Left3Use and not Left4Use then
		Left4Use = true
		Left4Stuff = Left3Stuff
		Left3Stuff = Left2Stuff
		Left2Stuff = Left1Stuff
		Left1Stuff = newest
		addEventHandler("onClientRender",getRootElement(), FourthLeftAnnounce )
		timer9 = setTimer(FourthLeftAnnounceDown,3000,1)
		timer6666 = setTimer(FirstLeftAnnounceDown,6000,1)
		timer7777 = setTimer(SecondLeftAnnounceDown,5000,1)
		timer88 = setTimer(ThirdLeftAnnounceDown,4000,1)
	elseif Left1Use and Left2Use and Left3Use and Left4Use and not Left5Use then
		Left5Use = true
		Left5Stuff = Left4Stuff
		Left4Stuff = Left3Stuff
		Left3Stuff = Left2Stuff
		Left2Stuff = Left1Stuff
		Left1Stuff = newest
		addEventHandler("onClientRender",getRootElement(), FifthLeftAnnounce )
		timer5 = setTimer(FifthLeftAnnounceDown,1500,1)
		timer66666 = setTimer(FirstLeftAnnounceDown,6000,1)
		timer7777 = setTimer(SecondLeftAnnounceDown,5000,1)
		timer888 = setTimer(ThirdLeftAnnounceDown,4000,1)
		timer99 = setTimer(FourthLeftAnnounceDown,2000,1)
	elseif Left1Use and Left2Use and Left3Use and Left4Use and Left5Use then
		Left1Use = true
		Left5Stuff = Left4Stuff
		Left4Stuff = Left3Stuff
		Left3Stuff = Left2Stuff
		Left2Stuff = Left1Stuff
		Left1Stuff = newest
		addEventHandler("onClientRender",getRootElement(), FirstLeftAnnounce )
		timer666666 = setTimer(FirstLeftAnnounceDown,6000,1)
		timer77777 = setTimer(SecondLeftAnnounceDown,5000,1)
		timer8888 = setTimer(ThirdLeftAnnounceDown,4000,1)
		timer999 = setTimer(FourthLeftAnnounceDown,2000,1)
		timer1010 = setTimer(FifthLeftAnnounceDown,1500,1)
end
end
addEvent( "onAnnouncementComingLeft", true )
addEventHandler( "onAnnouncementComingLeft", getRootElement(), TakeAnnouncementLeft )