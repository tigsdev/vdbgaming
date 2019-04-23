
addEventHandler ( "onResourceStop", root, function ( r )
    for i, v in pairs ( getElementsByType ( "3DText" ) ) do
        if ( r == getElementData ( v, "sourceResource" ) ) then
            destroyElement ( v )
        end 
    end 
end )

function create3DText ( str, pos, color, parent, settings, imagem, nametipe, avatar ) 
    if str and pos and color then
        local text = createElement ( '3DText' )
		if avatar then 
        setElementData ( text, "avatar", avatar )
		end
		if (not imagem)then
		imagem = "sem"
		end
		
		if (not nametipe)then
		nametipe = "N/A"
		end
		
        local settings = settings or  { }
        setElementData ( text, "text", str )
        setElementData ( text, "position", pos )
        setElementData ( text, "color", color )
        if ( not parent ) then
            parent = nil
        else
            if ( isElement ( parent ) ) then
                parent = parent
            else
                parent = nil
            end
        end
        setElementData ( text, "Settings", settings )
		setElementData ( text, "image", imagem )
		setElementData ( text, "nametipe", nametipe )
        setElementData ( text, "parentElement", parent )
        setElementData ( text, "sourceResource", sourceResource or getThisResource ( ))
        return text
    end
    return false
end
