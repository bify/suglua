local midW, midH = ScrW() / 2, ScrH() / 2

--s0lum is cool 8)


local colors = {
    white = Color(255, 255, 255),
    red = Color(255, 0, 0),
    crimson = Color(175,0,42),
    green = Color(0, 255, 0),
    greener = Color(132,222,2),
    blue = Color(0, 0, 255),
    lightblue = Color(114, 160, 193),
    grey = Color(155, 155, 155),
    orange = Color(255, 126, 0),
    purple = Color(160, 32, 240), 
    violet = Color(178,132,190),
    seafoam = Color(201, 255, 229),
    black = Color(0, 0, 0),
    darkgrey = Color(28, 28, 28),
    aliceblue = Color(240, 248, 255),
    newblue = Color(0, 250, 250)
}


--START OF CONFIGING SECTION (IF YALL WANNA SHARE CONFIGS OR SUM JUST COPY AND PASTE INTO HERE)
local ss = {

    bhop = true,

    txtespPLAYER = false,
    txtespPROP = false,

    chams = true,
    chams_col = Color(255,255,255),
    chams_a = 255, 
    chams_lighting = false,

    pchams = true,
    pchams_col = Color(0,255,255),
    pchams_a = 150,
    pchams_lighting = true,

    random_col = Color(0,255,255, 255),


    hchams_col = Color(0, 255, 255, 255),
    hands = true,

    box_col = Color(0, 255, 255, 255),

    menu_col = Color(0, 255, 255, 255),

    glow_col = Color(0, 255, 255, 255),

    tps = 0,
    tps_y = 0,
    tps_h = 0, 
    tps_collision = false,
    box = false,

    wallsx = true,
    wallsxb = true,
    wallsxp = false,

    getgood = false,
    watermark = true,

    toggle = false,

    grabber = false,
    fullbright = false,

    speclist = false,

    nightmode = true,

    crosshair = false,


    esp_hitboxes = false,
    eyetrace = false,

    skelly = false,

    circlehead = false,

    gdance = true,

    fillbox = true,

    glow = false,
    
    boxesphealth = false,
    boxesps = false,

    material = 'models/debug/debugwhite',
    
    

 
    fov = 120,
}
--END OF CONFIG SECTION



surface.CreateFont( "Specialneeds", {
    font = "Arial", 
    extended = false,
    size = 15,
    weight = 500,
    blursize = 0,
    scanlines = 0,
    antialias = true,
    underline = false,
    italic = false,
    strikeout = false,
    symbol = false,
    rotary = false,
    shadow = false,
    additive = false,
    outline = false,
} )

surface.CreateFont( "titles", {
    font = "Arial", 
    extended = false,
    size = 25,
    weight = 750,
    blursize = 0,
    scanlines = 0,
    antialias = true,
    underline = false,
    italic = false,
    strikeout = false,
    symbol = false,
    rotary = false,
    shadow = false,
    additive = false,
    outline = true,
} )

surface.CreateFont( "Specialneeds2", {
    font = "Arial", 
    extended = false,
    size = 13,
    weight = 500,
    blursize = 0,
    scanlines = 0,
    antialias = true,
    underline = false,
    italic = false,
    strikeout = false,
    symbol = false,
    rotary = false,
    shadow = false,
    additive = false,
    outline = false,
} )


local function ConsolePrintRainbow( frequency, str )
	
	local text = {}
	
	for i = 1, #str do
		table.insert( text, HSVToColor( i * frequency % 360, 1, 1 ) )
		table.insert( text, string.sub( str, i, i ) )
	end
	
	table.insert( text, "\n" )
	
	MsgC( unpack( text ) )
	
end

ConsolePrintRainbow( 10, "get good get sugoma! Https://sugoma.solutions/")

print([[
Sugoma is cool cheat made by marge(STEAM_0:0:556353067) with help from big cool dude s0lum!
Sugoma has a propkill base with a aimbot and many visual options so it will work for propkill and sandboxes.
Sugoma has not in any way try to stop screengrab or triggering anti cheats so like, y'know!
To open menu do ss_menu in console and to edit colors open your context menu!

]])


local DebugWhite = Material("models/debug/debugwhite")
local Wireframe = Material("models/wireframe")
local IsDrawingWireframe = false
local lply = LocalPlayer()
local hooks = {}
local function RandomString() return tostring(math.random(-9999999999, 9999999999)) end

local function makeHook(txt, fnc)
    local sys,txsz = tostring((util.CRC(math.random(10^4)+SysTime())) )..'',#txt
    hook.Add(txt,'IRON|'..util.CRC(math.random(10^4)+SysTime()),fnc) 
end

local dbg = {
    view = Angle(),
    curprop = nil,
    lastprop = nil,
    beampos = Vector(),
    beamang = Angle(),
}

local function isValid(object)
    if ( not object ) then return false end
    local isvalid = object.IsValid
    if ( not isvalid ) then return false end
    return isvalid( object )
end

local function AddHook(event, name, func)
    hooks[name] = event
    hook.Add(event, name, func)
end

local function DrawRect(parent, color, color2, w, h, x, y) 
    if color then 
        surface.SetDrawColor(color) 
    else 
        surface.SetDrawColor(Color(46,46,46,240)) 
    end

    surface.DrawRect(x or 0, y or 0, w or parent:GetWide(), h or parent:GetTall() )

    if col2 then 
        surface.SetDrawColor(color2) 
    else 
        surface.SetDrawColor(colors.black) 
    end

    surface.DrawOutlinedRect(x or 0, y or 0, w or parent:GetWide(), h or parent:GetTall())
end





--[[-------------------------------------------------------------------------
    Menu Element func
---------------------------------------------------------------------------]]
-------
local function checkbox( name, tooltip, val, x, y, parent )
    local checkbox = vgui.Create( 'DCheckBoxLabel', parent )
    checkbox:SetText(name)
    checkbox:SetPos( x, y )
    checkbox:SetFont('Specialneeds2')
    checkbox:SetTextColor(colors.white)
    checkbox:SetChecked( ss[val] )
    if isstring( tooltip ) then
        checkbox:SetTooltip( tooltip )
    end
    function checkbox:OnChange(bval)
        ss[val] = bval
    end
    function checkbox:PaintOver()
    draw.RoundedBox( 0, 0, 0, 15, 15, colors.black )
        if checkbox:GetChecked() then
            draw.RoundedBox( 0, 4, 4, 7.5, 7.5, Color(ss.menu_col.r, ss.menu_col.g, ss.menu_col.b) )
        end
    end
end


local function slider( name, val, min, max, x, y, w, h, parent)
    local DOCK = vgui.Create("DPanel", parent)
        DOCK:SetSize(w, h)
        DOCK:SetPos(x, y)
        DOCK:SetBackgroundColor( Color(0,0,0,0) )
    local slider = vgui.Create( 'DNumSlider', DOCK)
        slider:SetMin( min )
        slider:SetMax( max )
        slider:SetText( '' )
        slider:Dock(FILL)
        slider:SetValue( ss[val] )
        slider:SetDecimals(0)
    function slider.Slider.Knob:Paint()
        DrawRect(self, Color(ss.menu_col.r, ss.menu_col.g, ss.menu_col.b), Color(52,61,70), self:GetWide() / 2, self:GetTall(), 7)
    end
    function DOCK:Paint(w, h)
        draw.SimpleText(name, 'Specialneeds2', 10, 0, colors.white, 0, 0)
    end
    function slider:OnValueChanged( num )
        ss[val] = num
    end
end

local function colorthing( val, x, y, w, h, parent)
    local DOCK = vgui.Create("DPanel", parent)
        DOCK:SetSize(w, h)
        DOCK:SetPos(x, y)
        DOCK:SetBackgroundColor( Color(0,0,0,0) )
    local colorbox = vgui.Create( 'DColorMixer', DOCK)
        colorbox:Dock(FILL)                    -- Make Mixer fill place of Frame
        colorbox:SetPalette(false)              -- Show/hide the palette                 DEF:true
        colorbox:SetAlphaBar(false)             -- Show/hide the alpha bar                 DEF:true
        colorbox:SetWangs(false)                 -- Show/hide the R G B A indicators     DEF:true
        colorbox:SetColor(Color(30,100,160))     -- Set the default color
    function colorbox:Paint()
        DrawRect(self, colors.newblue, Color(52,61,70), self:GetWide() / 2, self:GetTall(), 7)
    end
    --[[function DOCK:Paint(w, h)
        draw.SimpleText(name, 'labelFONT', 10, 0, colors.white, 0, 0)
    end]]
    function colorbox:ValueChanged( col )
        ss[val] = col
    end

end

--[[Mixer:Dock(FILL)                    -- Make Mixer fill place of Frame
Mixer:SetPalette(true)              -- Show/hide the palette                 DEF:true
Mixer:SetAlphaBar(true)             -- Show/hide the alpha bar                 DEF:true
Mixer:SetWangs(true)                 -- Show/hide the R G B A indicators     DEF:true
Mixer:SetColor(Color(30,100,160))     -- Set the default color]]




--[[-------------------------------------------------------------------------
    Menu func
---------------------------------------------------------------------------]]

local menuderma
function SUGUI()
    menuderma = vgui.Create( "DFrame" )
    menuderma:SetSize(  725, 520 )
    menuderma:SetPos( 10, 10 )
    menuderma:SetTitle( " " )
    menuderma:MakePopup()
    menuderma:InvalidateParent(true)
    menuderma:SetDeleteOnClose( false )
    menuderma:ShowCloseButton(false)
    menuderma.Paint = function(s , w , h)
        draw.RoundedBox(1,5,0,w , h,Color(25,25,25, 250))
        draw.RoundedBox( 0, 10, 5, 710, 35, Color(40,40,40, 255) )
        draw.RoundedBox( 0, 10, 45, 710, 470, Color(40,40,40, 255) )

        draw.RoundedBox( 0, 15, 65, 180, 75, Color(255,255,255, 255) )
        draw.RoundedBox( 0, 16, 66, 178, 73, Color(40,40,40, 255) )

        draw.RoundedBox( 0, 15, 180, 180, 120, Color(255,255,255, 255) )
        draw.RoundedBox( 0, 16, 181, 178, 118, Color(40,40,40, 255) )

        draw.RoundedBox( 0, 225, 210, 180, 90, Color(255,255,255, 255) )
        draw.RoundedBox( 0, 226, 211, 178, 88, Color(40,40,40, 255) )

        draw.RoundedBox( 0, 15, 330, 180, 180, Color(255,255,255, 255) )
        draw.RoundedBox( 0, 16, 331, 178, 178, Color(40,40,40, 255) )

        draw.RoundedBox( 0, 225, 330, 180, 90, Color(255,255,255, 255) )
        draw.RoundedBox( 0, 226, 331, 178, 88, Color(40,40,40, 255) )

        draw.RoundedBox( 0, 225, 450, 180, 60, Color(255,255,255, 255) )
        draw.RoundedBox( 0, 226, 451, 178, 58, Color(40,40,40, 255) )

        draw.RoundedBox( 0, 225, 65, 180, 114, Color(255,255,255, 255) )
        draw.RoundedBox( 0, 226, 66, 178, 112, Color(40,40,40, 255) )

        draw.RoundedBox( 0, 435, 65, 280, 235, Color(255,255,255, 255) )
        draw.RoundedBox( 0, 436, 66, 278, 233, Color(40,40,40, 255) )

        draw.RoundedBox( 0, 435, 330, 280, 180, Color(255,255,255, 255) )
        draw.RoundedBox( 0, 436, 331, 278, 178, Color(40,40,40, 255) )


    end

    local DLabels = vgui.Create( "DLabel", menuderma )
    DLabels:SetPos( 15, 50 )
    DLabels:SetSize( 50, 10)
    DLabels:SetColor(colors.red)
    DLabels:SetFont('Specialneeds2')
    DLabels:SetText( "Aimbot" )

    local DLabels = vgui.Create( "DLabel", menuderma )
    DLabels:SetPos( 225, 50 )
    DLabels:SetSize( 150, 10)
    DLabels:SetColor(colors.red)
    DLabels:SetFont('Specialneeds2')
    DLabels:SetText( "ESP Settings" )

    local DLabels = vgui.Create( "DLabel", menuderma )
    DLabels:SetPos( 435, 50 )
    DLabels:SetSize( 150, 10)
    DLabels:SetColor(colors.red)
    DLabels:SetFont('Specialneeds2')
    DLabels:SetText( "ESP Misc Plr" )

    local DLabelss = vgui.Create( "DLabel", menuderma )
    DLabelss:SetPos( 15, 160 )
    DLabelss:SetSize( 50, 10)
    DLabelss:SetColor(colors.red)
    DLabelss:SetFont('Specialneeds2')
    DLabelss:SetText( "ESP" )

    local DLabelsss = vgui.Create( "DLabel", menuderma )
    DLabelsss:SetPos( 225, 190 )
    DLabelsss:SetSize( 200, 10)
    DLabelsss:SetColor(colors.red)
    DLabelsss:SetFont('Specialneeds2')
    DLabelsss:SetText( "ESP Sliders" )

    local DLabelssss = vgui.Create( "DLabel", menuderma )
    DLabelssss:SetPos( 225, 315 )
    DLabelssss:SetSize( 200, 10)
    DLabelssss:SetColor(colors.red)
    DLabelssss:SetFont('Specialneeds2')
    DLabelssss:SetText( "Client Sliders" )

    local DLabelssss = vgui.Create( "DLabel", menuderma )
    DLabelssss:SetPos( 225, 435 )
    DLabelssss:SetSize( 200, 10)
    DLabelssss:SetColor(colors.red)
    DLabelssss:SetFont('Specialneeds2')
    DLabelssss:SetText( "Movement" )

    local DLabelsssss = vgui.Create( "DLabel", menuderma )
    DLabelsssss:SetPos( 435, 315 )
    DLabelsssss:SetSize( 200, 10)
    DLabelsssss:SetColor(colors.red)
    DLabelsssss:SetFont('Specialneeds2')
    DLabelsssss:SetText( "Client Visuals" )

    local cbutton = vgui.Create('DButton', menuderma)
    cbutton:SetText('')
    cbutton:SetTextColor(colors.black)
    cbutton:SetSize(16, 16)
    cbutton:SetPos(menuderma:GetWide() - cbutton:GetWide() - 10, 15)
    function cbutton:DoClick()
        menuderma:Close()
    end
    function cbutton:Paint()
        draw.RoundedBox(5, 0, 0, self:GetWide(), self:GetTall(), colors.red)
    end

    local cbuttons = vgui.Create('DButton', menuderma)
    cbuttons:SetText('')
    cbuttons:SetTextColor(colors.black)
    cbuttons:SetSize(16, 16)
    cbuttons:SetPos(menuderma:GetWide() - cbuttons:GetWide() - 30, 15)
    function cbuttons:DoClick()
        RunConsoleCommand('ss_cmenu')
    end
    function cbuttons:Paint()
        draw.RoundedBox(5, 0, 0, self:GetWide(), self:GetTall(), colors.newblue)
    end


    checkbox("MOV:Bhop", "Toggle Bhop", 'bhop', 230, 455, menuderma )
    checkbox("CLI:Grabber", "Toggle Grabber/prop prediction", 'grabber', 440, 455, menuderma )
    checkbox("CLI:Crosshair", "shootbox", 'crosshair', 440, 425, menuderma )
    checkbox("ESP:Hitbox", "Player Hitbox", 'esp_hitboxes', 440, 70, menuderma )
    checkbox("ESP:Eye Tracer", "Trace enemy eyes", 'eyetrace', 440, 130, menuderma )
    checkbox("ESP:Skeleton", "Draw bones on model", 'skelly', 440, 100, menuderma )
    checkbox("CLI:Hand Cham", "Toggle Hand Cham", 'hands', 440, 485, menuderma )
    checkbox("ESP:Player Names", "Toggle Names", 'txtespPLAYER', 20, 215, menuderma )
    checkbox("ESP:Player Chams", "Toggle Chams", 'chams', 20, 185, menuderma )
    checkbox("ESP:Prop Names", "Toggle Prop Names", 'txtespPROP', 20, 275, menuderma )
    checkbox("ESP:Prop Cham", "Toggle Prop Chams", 'pchams', 20, 245, menuderma )
    checkbox("ESP:3D Box", "Toggle Box Esp", 'box', 440, 160, menuderma )

    checkbox("CLI:ThirdPerson(TP)", "its like view", 'tps', 440, 395, menuderma )
    checkbox("ESP:Head Circle", "its like circle", 'circlehead',440, 220, menuderma )
    checkbox("ESP:Glow", "its like glowing", 'glow',440, 250, menuderma )
    checkbox("CLI:Menu Animate", "its like dance", 'gdance', 580, 335, menuderma )
    checkbox("ESP:2D Box", "Player boxes", 'boxesps', 580, 70, menuderma )
    checkbox("ESP:2D Box(Health)", "Player Boxes", 'boxesphealth', 580, 100, menuderma )
    checkbox("ESP:3D Box Fill", "Fill 3D Box ESP", 'fillbox', 440, 190, menuderma )

    checkbox("ESP:Ply Walls", "its like view", 'wallsx', 230, 130, menuderma )
    checkbox("ESP:Prop Walls", "its like view", 'wallsxp', 230, 160, menuderma )

    checkbox("CLI:Info", "its like debig", 'getgood', 440, 365, menuderma )
    checkbox("CLI:Watermark", "its like mark", 'watermark', 440, 335, menuderma )

    checkbox("ESP:Ply Flat", "Toggle PNames", 'chams_lighting', 230, 70, menuderma )
    checkbox("ESP:Prop Flat", "Toggle PNames", 'pchams_lighting', 230, 100, menuderma )
    checkbox("AIM:Legit Aimlock", "Toggle aimlock", 'toggle', 20, 110, menuderma )

    slider( "CLI:FOV", "fov", 1, 170, 230, 335, 190, 20, menuderma)
    slider( "ESP:Ply  A", "chams_a", 1, 255, 230, 230, 190, 20, menuderma)
    slider( "ESP:Prop A", "pchams_a", 1, 255, 230, 260, 190, 20, menuderma)
    
    slider('CLI:TP Yaw', 'tps_y', 0, 360, 230, 365, 190, 20, menuderma)
    slider('CLI:TP Hight', 'tps_h', 0, 100, 230, 395, 190, 20, menuderma)

    local ptbox = vgui.Create( 'DComboBox', menuderma )
    ptbox:SetPos( 440, 270 )
    ptbox:SetSize( 115, 20 )
    ptbox:SetValue( 'Cham Material' )
    ptbox:AddChoice('models/debug/debugwhite')
    ptbox:AddChoice('models/screenspace')
    ptbox:AddChoice('models/player/shared/gold_player')
    ptbox:AddChoice('models/player/shared/ice_player')
    ptbox:AddChoice('models/XQM/LightLinesRed_tool')
    ptbox:AddChoice('models/props_combine/com_shield001a')
    ptbox:AddChoice('models/props_combine/tprings_globe')

    function ptbox:OnSelect( _, mat )
        ss.material = mat
    end 
    function ptbox:Paint()
        draw.RoundedBox(5, 0, 0, self:GetWide(), self:GetTall(), colors.black)
    end


    
    
    --doMenuModel(MyDerma:GetX()+4JUdGzvrMFDWrUUwY3toJATSeNwjn54LkCnKBPRzDuhzi5vSepHfUckJNxRL2gjkNrSqtCoRUrEDAgRwsQvVCjZbRyFTLRNyDmT1a1boZVred, MyDerma)

    local icon = vgui.Create( "DModelPanel", menuderma )
    icon:SetSize( 200, 200 )
    icon:SetPos(15, 310)
    icon:SetModel( "models/player/hostage/hostage_04.mdl" )
    function icon:LayoutEntity( ent )
        if ss.gdance then
            ent:SetSequence( ent:LookupSequence( "taunt_laugh" ) )
            if( ent:GetCycle() > 0.97 ) then ent:SetCycle( 0.02 ) end
            icon:RunAnimation()
        end
    end
    function icon.Entity:GetPlayerColor() return Vector(ss.hchams_col.r / 255, ss.hchams_col.g / 255, ss.hchams_col.b / 255) end

    local DLabelw = vgui.Create( "DLabel", menuderma )
    DLabelw:SetPos( 20, -78 )
    DLabelw:SetSize( 200, 200)
    DLabelw:SetColor(colors.white)
    DLabelw:SetFont('titles')
    DLabelw:SetText( "sug.sol | " )

    local DLabelw = vgui.Create( "DLabel", menuderma )
    DLabelw:SetPos( 110, -78 )
    DLabelw:SetSize( 200, 200)
    DLabelw:SetColor( Color(ss.menu_col.r, ss.menu_col.g, ss.menu_col.b) )
    DLabelw:SetFont('titles')
    DLabelw:SetText( LocalPlayer():Name() )

    local DLabel = vgui.Create( "DLabel", menuderma )
    DLabel:SetPos( 20, 80 )
    DLabel:SetSize( 100, 10)
    DLabel:SetColor(colors.white)
    DLabel:SetFont('Specialneeds2')
    DLabel:SetText( "Aimbot key:" )


    -----------------------------------


    local binder = vgui.Create( "DBinder", menuderma )
    binder:SetSize( 40, 15 )
    binder:SetPos( 80, 80 )
    binder:SetText('key')
    function binder:Paint()
        DrawRect(self, colors.darkgrey, colors.white, self:GetWide(), self:GetTall())
    end


    function binder:OnChange( num )
        LocalPlayer():ChatPrint("Aimbot bound to: "..input.GetKeyName( num )) ss.aimkey = num
    end

    
end

concommand.Add('ss_menu', SUGUI)


--[[ --old menu
local MyDerma
function ui()
    MyDerma = vgui.Create( "DFrame" )
    MyDerma:SetSize( 750, 450 )
    MyDerma:SetPos( midW - ( MyDerma:GetWide() / 2 ), midH - ( MyDerma:GetTall() / 2) )
    MyDerma:SetTitle( " " )
    MyDerma:MakePopup()
    MyDerma:InvalidateParent(true)
    MyDerma:SetDeleteOnClose( false )
    MyDerma:ShowCloseButton(false)
    MyDerma.Paint = function(s , w , h)
        draw.RoundedBox(5,5,0,w , h,Color(40,40,40, 250))
        draw.RoundedBox( 0, 325, 15, 230, 320, Color(25,25,25, 170) )
    end

    local cbutton = vgui.Create('DButton', MyDerma)
    cbutton:SetText('X')
    cbutton:SetTextColor(colors.black)
    cbutton:SetSize(16, 16)
    cbutton:SetPos(MyDerma:GetWide() - cbutton:GetWide() - 5, 5)
    function cbutton:DoClick()
        MyDerma:Close()
    end
    function cbutton:Paint()
        draw.RoundedBox(5, 0, 0, self:GetWide(), self:GetTall(), colors.red)
    end

    local cbuttons = vgui.Create('DButton', MyDerma)
    cbuttons:SetText('C')
    cbuttons:SetTextColor(colors.black)
    cbuttons:SetSize(16, 16)
    cbuttons:SetPos(MyDerma:GetWide() - cbuttons:GetWide() - 5, 25)
    function cbuttons:DoClick()
        RunConsoleCommand('ss_cmenu')
    end
    function cbuttons:Paint()
        draw.RoundedBox(5, 0, 0, self:GetWide(), self:GetTall(), colors.orange)
    end


    checkbox("Bhop", "Toggle Bhop", 'bhop', 10, 10, MyDerma )
    checkbox("Grabber PK", "Toggle Grabber/prop prediction", 'grabber', 10, 50, MyDerma )
    checkbox("Crosshair", "shootbox", 'crosshair', 10, 90, MyDerma )
    checkbox("Hitbox ESP", "Player Hitbox", 'esp_hitboxes', 10, 130, MyDerma )
    checkbox("Eye Tracer", "Trace enemy eyes", 'eyetrace', 10, 170, MyDerma )
    checkbox("Skeleton ESP", "Draw bones on model", 'skelly', 10, 210, MyDerma )
    checkbox("Hand Cham", "Toggle Hand Cham", 'hands', 100, 210, MyDerma )
    checkbox("Esp Names", "Toggle Names", 'txtespPLAYER', 100, 10, MyDerma )
    checkbox("Esp Chams", "Toggle Chams", 'chams', 100, 50, MyDerma )
    checkbox("Prop Names", "Toggle Prop Names", 'txtespPROP', 100, 90, MyDerma )
    checkbox("Prop Chams", "Toggle Prop Chams", 'pchams', 100, 130, MyDerma )
    checkbox("3d Box ESP", "Toggle Box Esp", 'box', 100, 170, MyDerma )

    checkbox("Perspective", "its like view", 'tps', 575, 90, MyDerma )
    checkbox("Head ESP", "its like circle", 'circlehead', 575, 130, MyDerma )
    checkbox("Menu Animate", "its like dance", 'gdance', 575, 170, MyDerma )
    checkbox("Fill 3D Box ESP", "Fill 3D Box ESP", 'fillbox', 575, 210, MyDerma )

    checkbox("Player Walls", "its like view", 'wallsx', 200, 90, MyDerma )
    checkbox("Prop Walls", "its like view", 'wallsxp', 200, 130, MyDerma )

    checkbox("Info", "its like debig", 'getgood', 575, 10, MyDerma )
    checkbox("Watermark", "its like mark", 'watermark', 575, 50, MyDerma )

    checkbox("Cham Light", "Toggle PNames", 'chams_lighting', 200, 10, MyDerma )
    checkbox("Prop Cham Light", "Toggle PNames", 'pchams_lighting', 200, 50, MyDerma )
    checkbox("Legit Aimlock", "Toggle aimlock", 'toggle', 200, 170, MyDerma )

    slider( "FOV", "fov", 1, 170, 10, 300, 250, 20, MyDerma)
    slider( "Chams Alpha", "chams_a", 1, 255, 10, 350, 250, 20, MyDerma)
    slider( "PChams Alpha", "pchams_a", 1, 255, 10, 400, 250, 20, MyDerma)
    
    slider('Tp Yaw', 'tps_y', 0, 360, 300, 350, 250, 20, MyDerma)
    slider('Tp Height', 'tps_h', 0, 100, 300, 400, 250, 20, MyDerma)


    
    
    --doMenuModel(MyDerma:GetX()+4JUdGzvrMFDWrUUwY3toJATSeNwjn54LkCnKBPRzDuhzi5vSepHfUckJNxRL2gjkNrSqtCoRUrEDAgRwsQvVCjZbRyFTLRNyDmT1a1boZVred, MyDerma)

    local icon = vgui.Create( "DModelPanel", MyDerma )
    icon:SetSize( 225, 225 )
    icon:SetPos(330, 110)
    icon:SetModel( "models/player/gman_high.mdl" )
    function icon:LayoutEntity( ent )
        if ss.gdance then
            ent:SetSequence( ent:LookupSequence( "taunt_dance" ) )
            if( ent:GetCycle() > 0.97 ) then ent:SetCycle( 0.02 ) end
            icon:RunAnimation()
        end
    end
    function icon.Entity:GetPlayerColor() return Vector(ss.hchams_col.r / 255, ss.hchams_col.g / 255, ss.hchams_col.b / 255) end

    local DLabel = vgui.Create( "DLabel", MyDerma )
    DLabel:SetPos( 200, 210 )
    DLabel:SetSize( 100, 10)
    DLabel:SetColor(colors.white)
    DLabel:SetFont('Specialneeds2')
    DLabel:SetText( "Aimbot key:" )

    local DLabel2 = vgui.Create( "DLabel", MyDerma )
    DLabel2:SetPos( 330, 20 )
    DLabel2:SetSize( 230, 20)
    DLabel2:SetColor(colors.white)
    DLabel2:SetFont('Specialneeds2')
    DLabel2:SetText("Name:"..LocalPlayer():Name())

    local DLabel3 = vgui.Create( "DLabel", MyDerma )
    DLabel3:SetPos( 330, 35 )
    DLabel3:SetSize( 230, 20)
    DLabel3:SetColor(colors.white)
    DLabel3:SetFont('Specialneeds2')
    DLabel3:SetText("SteamID:"..LocalPlayer():SteamID())

    local DLabel31 = vgui.Create( "DLabel", MyDerma )
    DLabel31:SetPos( 330, 50 )
    DLabel31:SetSize( 230, 20)
    DLabel31:SetColor(colors.white)
    DLabel31:SetFont('Specialneeds2')
    DLabel31:SetText("SteamID64:"..LocalPlayer():SteamID64())

    local DLabel32 = vgui.Create( "DLabel", MyDerma )
    DLabel32:SetPos( 330, 65 )
    DLabel32:SetSize( 230, 20)
    DLabel32:SetColor(colors.white)
    DLabel32:SetFont('Specialneeds2')
    DLabel32:SetText("Team:"..team.GetName( LocalPlayer():Team() ))

    local DLabel321 = vgui.Create( "DLabel", MyDerma )
    DLabel321:SetPos( 330, 80 )
    DLabel321:SetSize( 230, 20)
    DLabel321:SetColor(colors.white)
    DLabel321:SetFont('Specialneeds2')
    DLabel321:SetText("GUIFrameTime:"..VGUIFrameTime())

    local DLabel323 = vgui.Create( "DLabel", MyDerma )
    DLabel323:SetPos( 330, 95 )
    DLabel323:SetSize( 230, 20)
    DLabel323:SetColor(colors.white)
    DLabel323:SetFont('Specialneeds2')
    DLabel323:SetText("FrameNumber:"..FrameNumber())
    
    local DLabel324 = vgui.Create( "DLabel", MyDerma )
    DLabel324:SetPos( 330, 110 )
    DLabel324:SetSize( 230, 20)
    DLabel324:SetColor(colors.white)
    DLabel324:SetFont('Specialneeds2')
    DLabel324:SetText("FrameTime:"..RealFrameTime())

    local DLabel324 = vgui.Create( "DLabel", MyDerma )
    DLabel324:SetPos( 330, 125 )
    DLabel324:SetSize( 230, 20)
    DLabel324:SetColor(colors.white)
    DLabel324:SetFont('Specialneeds2')
    DLabel324:SetText("SrvrPing:"..LocalPlayer():Ping())

    -----------------------------------


    local binder = vgui.Create( "DBinder", MyDerma )
    binder:SetSize( 40, 15 )
    binder:SetPos( 260, 210 )
    binder:SetText('key')
    function binder:Paint()
        DrawRect(self, colors.darkgrey, colors.white, self:GetWide(), self:GetTall())
    end


    function binder:OnChange( num )
        LocalPlayer():ChatPrint("Aimbot bound to: "..input.GetKeyName( num )) ss.aimkey = num
    end

    
end

concommand.Add('ss_menu', ui)

]]

local ColorDerma
function cui()
    ColorDerma = vgui.Create( "DFrame" )
    ColorDerma:SetSize( 400, 550 )
    ColorDerma:SetPos( midW - ( ColorDerma:GetWide() / 2 - 650 ), midH - ( ColorDerma:GetTall() / 2) )
    ColorDerma:SetTitle( " " )
    ColorDerma:MakePopup()
    ColorDerma:InvalidateParent(true)
    ColorDerma:SetDeleteOnClose( false )
    ColorDerma:ShowCloseButton(false)
    ColorDerma.Paint = function(s , w , h)
        draw.RoundedBox(5,5,0,w , h,Color(40,40,40, 250))
    end
    local cbutton = vgui.Create('DButton', ColorDerma)
    cbutton:SetText('X')
    cbutton:SetTextColor(colors.black)
    cbutton:SetSize(16, 16)
    cbutton:SetPos(ColorDerma:GetWide() - cbutton:GetWide() - 5, 5)
    function cbutton:DoClick()
        ColorDerma:Close()
    end
    function cbutton:Paint()
        draw.RoundedBox(5, 0, 0, self:GetWide(), self:GetTall(), colors.red)
    end


    colorthing('chams_col', 20, 30, 150, 150, ColorDerma)
    colorthing('pchams_col', 20, 200, 150, 150, ColorDerma)
    colorthing('hchams_col', 20, 370, 150, 150, ColorDerma)

    colorthing('box_col', 190, 30, 150, 150, ColorDerma)
    colorthing('glow_col', 190, 200, 150, 150, ColorDerma)
    colorthing('menu_col', 190, 370, 150, 150, ColorDerma)
--[[
    local icon = vgui.Create( "DModelPanel", ColorDerma )
    icon:SetSize( 500, 500 )
    icon:SetPos(30, 30)
    icon:SetModel( "models/player/gman_high.mdl" )
    function icon.Entity:GetPlayerColor() return Vector (255, 255, 255) end
]]
    local DLabel3224 = vgui.Create( "DLabel", ColorDerma )
    DLabel3224:SetPos( 20, 10 )
    DLabel3224:SetSize( 230, 30)
    DLabel3224:SetColor(colors.white)
    DLabel3224:SetFont('Specialneeds2')
    DLabel3224:SetText("Player Chams")
    local DLabel23224 = vgui.Create( "DLabel", ColorDerma )
    DLabel23224:SetPos( 190, 10 )
    DLabel23224:SetSize( 230, 30)
    DLabel23224:SetColor(colors.white)
    DLabel23224:SetFont('Specialneeds2')
    DLabel23224:SetText("Box")

    local DLabel32242 = vgui.Create( "DLabel", ColorDerma )
    DLabel32242:SetPos( 20, 185 )
    DLabel32242:SetSize( 230, 20)
    DLabel32242:SetColor(colors.white)
    DLabel32242:SetFont('Specialneeds2')
    DLabel32242:SetText("Props Chams")
    local DLabel322424 = vgui.Create( "DLabel", ColorDerma )
    DLabel322424:SetPos( 190, 185 )
    DLabel322424:SetSize( 230, 20)
    DLabel322424:SetColor(colors.white)
    DLabel322424:SetFont('Specialneeds2')
    DLabel322424:SetText("Glow")

    local DLabel322412 = vgui.Create( "DLabel", ColorDerma )
    DLabel322412:SetPos( 20, 353 )
    DLabel322412:SetSize( 230, 20)
    DLabel322412:SetColor(colors.white)
    DLabel322412:SetFont('Specialneeds2')
    DLabel322412:SetText("Hands and Others")
    local DLabelx322412 = vgui.Create( "DLabel", ColorDerma )
    DLabelx322412:SetPos( 190, 353 )
    DLabelx322412:SetSize( 230, 20)
    DLabelx322412:SetColor(colors.white)
    DLabelx322412:SetFont('Specialneeds2')
    DLabelx322412:SetText("Menu")
    

    
end

concommand.Add('ss_cmenu', cui)

makeHook("OnContextMenuOpen", function()
    cui()
end)

makeHook("OnContextMenuClose", function()
    if ColorDerma:IsVisible() then ColorDerma:Close() end
end)


--[[-------------------------------------------------------------------------
    Move Stuff
---------------------------------------------------------------------------]]

local function bhop(cmd)
    if LocalPlayer():GetMoveType() == MOVETYPE_NOCLIP or LocalPlayer():InVehicle() or LocalPlayer():GetMoveType() == 8 then return end
    if cmd:CommandNumber() ~= 0 then
        if not LocalPlayer():IsOnGround() and cmd:KeyDown(IN_JUMP) then cmd:RemoveKey(IN_JUMP) end
    end
end

hook.Add("CreateMove", "CMoveStuff", function(cmd)
    if ss.bhop then bhop(cmd) end
end)

------



--[[-------------------------------------------------------------------------
    Esp Stuff
---------------------------------------------------------------------------]]

local function closestEntByClass(class)
    local pltbl = {}
    for _, v in pairs(ents.FindByClass(class)) do
        if v == LocalPlayer() or not v:IsValid() then continue end 
        pltbl[#pltbl+1] = v
    end
    local pos = LocalPlayer():GetPos()
    table.sort(pltbl, function(a,b)
        return (a:GetPos()-pos):LengthSqr() > (b:GetPos()-pos):LengthSqr()
    end)
    return pltbl
end

local function DrawText(col,x,y,str,font)
    surface.SetTextColor(col.r,col.g,col.b,col.a)
    surface.SetTextPos(x,y)
    surface.SetFont(font)
    surface.DrawText(str)
end

local function getTextSize(font,str)
    surface.SetFont(font)
    return surface.GetTextSize(str)
end

function tespPlayer(v)
    local text = ''
    local pos = v:EyePos(v:OBBCenter()):ToScreen()
    local n = v:Nick()
    local w,h = getTextSize('Specialneeds',n)
    DrawText(Color(255,255,255), pos.x-w/2, pos.y-h/2-20,n, 'Specialneeds')
end

function tespProp(v)
    local text = ''
    local pos = v:LocalToWorld(v:OBBCenter()):ToScreen()

    local str = string.Explode('/', v:GetModel()) 
    local nn = str[#str]

    local w,h = getTextSize('Specialneeds',nn)
    DrawText(Color(255,255,255), pos.x-w/2, pos.y-h/2,nn, 'Specialneeds')
end

hook.Add("HUDPaint", "EspHax", function()
    local playerTarget = closestEntByClass("player")
    for k, v in pairs(playerTarget) do
        if v:Alive() and v:Team() ~= TEAM_SPECTATOR and ss.txtespPLAYER then tespPlayer(v) end
    end

    local propTarget = closestEntByClass("prop_physics")
    for k, v in pairs(propTarget) do 
        if ss.txtespPROP then tespProp(v) end 
    end
end)



--[[-------------------------------------------------------------------------
    Fov Stuff
---------------------------------------------------------------------------]]

hook.Add("CalcView", "asdsagsaadhdhsehs", function( p, o, a, f )
    local view = {}
    local fov = ss.fov - ( GetConVar ("fov_desired"):GetFloat() - f )
    view.fov = fov
    return view
end)


--[[-------------------------------------------------------------------------
    Hud Stuff
---------------------------------------------------------------------------]]


surface.CreateFont( "Propsenseamon", {
    font = "Arial", 
    extended = false,
    size = 20,
    weight = 200,
    blursize = 0,
    scanlines = 0,
    antialias = true,
    underline = false,
    italic = false,
    strikeout = false,
    symbol = false,
    rotary = false,
    shadow = false,
    additive = false,
    outline = false,
} )

surface.CreateFont( "boosls", {
    font = "Arial", 
    extended = false,
    size = 14,
    weight = 200,
    blursize = 0,
    scanlines = 0,
    antialias = true,
    underline = false,
    italic = false,
    strikeout = false,
    symbol = false,
    rotary = false,
    shadow = false,
    additive = false,
    outline = false,
} )

surface.CreateFont( "booslssd", {
    font = "Arial", 
    extended = false,
    size = 16,
    weight = 200,
    blursize = 0,
    scanlines = 0,
    antialias = true,
    underline = false,
    italic = false,
    strikeout = false,
    symbol = false,
    rotary = false,
    shadow = false,
    additive = false,
    outline = false,
} )

surface.CreateFont( "Propsenseamon2", {
    font = "Arial", 
    extended = false,
    size = 20,
    weight = 400,
    blursize = 0,
    scanlines = 0,
    antialias = true,
    underline = false,
    italic = false,
    strikeout = false,
    symbol = false,
    rotary = false,
    shadow = false,
    additive = false,
    outline = false,
} )

hook.Add("HUDPaint" , "DrawMyHud" , function()

    hook.Add( "HUDPaint", "HUDPaint_DrawABox", function()
        if ss.watermark then
            draw.RoundedBox(0,1746,6,155+8 , 25 + 8,Color(90,90,90))
            draw.RoundedBox(0,1750,10,155,25,Color(25,25,25))

            surface.SetTextColor( 255, 255, 255 ) 
            surface.SetTextPos( 1760, 12 ) 
            surface.SetFont( "Propsenseamon" ) 
            surface.DrawText( "Sugoma.Solutions" )

            surface.SetTextColor( 255, 255, 255 ) 
            surface.SetTextPos( 2, 2 ) 
            surface.SetFont( "booslssd" ) 
            surface.DrawText( "Logged in as:")

            surface.SetTextColor( colors.newblue ) 
            surface.SetTextPos( 80, 2 ) 
            surface.SetFont( "booslssd" ) 
            surface.DrawText(LocalPlayer():Name())

    
        end

    end )

    hook.Add( "HUDPaint", "becool", function()
        if ss.getgood then

            surface.SetTextColor( 255, 255, 255 ) 
            surface.SetTextPos(5,35) 
            surface.SetFont( "boosls" ) 
            surface.DrawText( "FrameTime:"..RealFrameTime() )

            surface.SetTextColor( 255, 255, 255 ) 
            surface.SetTextPos(5,50) 
            surface.SetFont( "boosls" ) 
            surface.DrawText( "FrameNumber:"..FrameNumber() )

            surface.SetTextColor( 255, 255, 255 ) 
            surface.SetTextPos(5,65) 
            surface.SetFont( "boosls" ) 
            surface.DrawText( "GUIFrameTime:"..VGUIFrameTime() )

            surface.SetTextColor( 255, 255, 255 ) 
            surface.SetTextPos(5,80) 
            surface.SetFont( "boosls" ) 
            surface.DrawText( "SrvrPing:"..LocalPlayer():Ping() )

            surface.SetTextColor( 255, 255, 255 ) 
            surface.SetTextPos(5,95) 
            surface.SetFont( "boosls" ) 
            surface.DrawText( "Team:"..team.GetName( LocalPlayer():Team() ) )

            surface.SetTextColor( 255, 255, 255 ) 
            surface.SetTextPos(5,110) 
            surface.SetFont( "boosls" ) 
            surface.DrawText( "SteamID64:"..LocalPlayer():SteamID64() )

            surface.SetTextColor( 255, 255, 255 ) 
            surface.SetTextPos(5,125) 
            surface.SetFont( "boosls" ) 
            surface.DrawText( "SteamID:"..LocalPlayer():SteamID() )

            surface.SetTextColor( 255, 255, 255 ) 
            surface.SetTextPos(5,140) 
            surface.SetFont( "boosls" ) 
            surface.DrawText( "Name:"..LocalPlayer():Name() )
        end
    end )

    hook.Add( "HUDPaint", "becooler", function()
        if ss.getgood and ss.toggle then

            surface.SetTextColor( 255, 255, 255 ) 
            surface.SetTextPos( midW + 10, midH + 20) 
            surface.SetFont( "boosls" ) 
            surface.DrawText( "LegitAim" )

        end
    end )

    hook.Add( "HUDPaint", "becoolerer", function()
        if ss.getgood then

            surface.SetTextColor( 255, 255, 255 ) 
            surface.SetTextPos( midW + 10, midH + 10) 
            surface.SetFont( "boosls" ) 
            surface.DrawText( "Aimbot key = "..input.GetKeyName( ss.aimkey ) )

        end
    end )

    hook.Add("HUDPaint", "DrawCross", function()
        if ss.crosshair then
            draw.RoundedBox(0,midW - 1.25,midH - 15 ,2,30,Color(0,255,255,100))
            draw.RoundedBox(0,midW - 15 ,midH - 0.15,30,2,Color(0,255,255,100))
        end
    end)



    

    

end)



--[[-------------------------------------------------------------------------
    Aim 
    Stuff
---------------------------------------------------------------------------]]

ss.aimkey = KEY_DOWN --place holder cuz nobody uses this key

function predict(cmd,target, predPos)
    predPos = predPos + (ply:GetVelocity() * engine.TickInterval() * RealFrameTime() ) - (me:GetVelocity(me) * engine.TickInterval() * RealFrameTime() )
    return predPos
end

local function onScreen(ent)
    if lply:GetObserverMode() == 0 then
        local Width = ent:BoundingRadius()
        local Disp = ent:GetPos() -lply:GetShootPos()
        local Dist = Disp:Length()
        local MaxCos = math.abs( math.cos( math.acos( Dist /math.sqrt( Dist *Dist +Width *Width ) ) +56 *( math.pi /180 ) ) )
        Disp:Normalize()
        local dot = Disp:Dot( lply:EyeAngles():Forward() )
        return dot > MaxCos
    end
end

local function closestEntByClass(class)
    local pltbl = {}
    for _, v in pairs(ents.FindByClass(class)) do
        pltbl[#pltbl+1] = v
    end
    local pos = lply:GetPos()
    table.sort(pltbl, function(a,b)
        return (a:GetPos()-pos):LengthSqr() > (b:GetPos()-pos):LengthSqr()
    end)
    return pltbl
end

local function doAim(v, cmd)

  	local solveAng = (v:GetAttachment(v:LookupAttachment("eyes")).Pos - lply:GetShootPos()):Angle()
    --if ss.bias > 0 then solveAng = LerpAngle(1-ss.bias/100, cmd:GetViewAngles(), solveAng) end
    --local solvePos = (v:GetAttachment(v:LookupAttachment("eyes")).Pos - lply:GetShootPos()):Angle()
      print(v, solveAng)
		cmd:SetViewAngles(solveAng)
  
end

local function doFire(cmd) 
	cmd:SetButtons(bit.bor(cmd:GetButtons(), IN_ATTACK))
end

hook.Add("CreateMove","", function(cmd)
    if cmd:CommandNumber() == 0 then end
    if not input.IsKeyDown(ss.aimkey) then return end
    if not lply:IsValid() or not lply:Alive() then return end
    --getTarget()
    local players = closestEntByClass('player')
    for k, v in next, players do
        if v ~= lply and (v:IsValid() and onScreen(v) and v:Alive() and v:Team() ~= TEAM_SPECTATOR and team.GetName(v:Team()) != "Spectator" && v:GetObserverMode() == 0) then
        	local Visible = { 
          	start = lply:GetShootPos(), 
        		endpos = v:GetAttachment(v:LookupAttachment("eyes")).Pos, 
          	filter = {lply,v}, 
          	mask = MASK_SHOT
        	}
        	local tr = util.TraceLine(Visible)
        	if tr.Fraction == 1 then

        	  doAim(v, cmd)
            doFire(cmd) --if ss.triggerbot then doFire() end
        	end	
        end
    end
end)


--[[-------------------------------------------------------------------------
    Skybox Stuff
---------------------------------------------------------------------------]]

makeHook("PostDraw2DSkyBox", function()
    render.Clear(25, 25, 25, 255)
return true 
end)

makeHook("PostDrawSkyBox", function()
    render.Clear(25, 25, 25, 255)
return true 
end)


function chams(v)
    v:SetColor(Color(0,0,0,0))
    cam.IgnoreZ(ss.wallsx)
        render.MaterialOverride(Material(ss.material))
        render.SuppressEngineLighting(ss.chams_lighting)
            v:SetRenderMode( RENDERMODE_TRANSALPHA )
                render.SetColorModulation( ss.chams_col.r / 255, ss.chams_col.g / 255, ss.chams_col.b / 255)
                render.SetBlend( ss.chams_a / 255 )
            v:DrawModel()
        render.MaterialOverride(nil)
        render.SuppressEngineLighting(false)
    cam.IgnoreZ(false)
    v:SetColor(Color(255,255,255,255))
end

function pchams(v)
    v:SetColor(Color(0,0,0,0))
    cam.IgnoreZ(ss.wallsxp)
        render.MaterialOverride(Material("models/debug/debugwhite"))
        render.SuppressEngineLighting(ss.pchams_lighting)
            v:SetRenderMode( RENDERMODE_TRANSALPHA )
                render.SetColorModulation( ss.pchams_col.r / 255, ss.pchams_col.g / 255, ss.pchams_col.b / 255)
                render.SetBlend( ss.pchams_a / 255 )
            v:DrawModel()
        render.MaterialOverride(nil)
        render.SuppressEngineLighting(false)
    cam.IgnoreZ(false)
    v:SetColor(Color(255,255,255,255))
end

function hitboxes(v)
    for group = 0,v:GetHitBoxGroupCount()-1 do 
        local count = v:GetHitBoxCount(group) - 1 
        for hitbox = 0, count do 
            local bone = v:GetHitBoxBone(hitbox,group) 
            if not bone then continue end 
            local min, max = v:GetHitBoxBounds(hitbox, group) 
            local bonepos, boneang = v:GetBonePosition(bone) 
            local predpos = bonepos + (v:GetVelocity()*engine.TickInterval())*(lply:Ping()/1000 + GetConVar('cl_interp'):GetFloat())*2
            cam.Start3D()
                render.DrawWireframeBox(predpos,boneang,min,max,Color(0, math.abs(math.sin(RealTime()*15)*255), 255) )
            cam.End3D()    
        end 
    end 
end

ply = LocalPlayer()
hook.Add('HUDPaint','Tracereye', function()
    if ss.eyetrace then
        for i,v in pairs(player.GetAll()) do
        if v == ply then
        else
            surface.SetDrawColor( ss.hchams_col.r, ss.hchams_col.g, ss.hchams_col.b, 255, 175 )
            pstart = v:GetBonePosition( v:LookupBone('ValveBiped.Bip01_Head1') ):ToScreen()
            pend = util.TraceLine(util.GetPlayerTrace(v)).HitPos:ToScreen()
            surface.DrawLine(pstart.x,pstart.y,pend.x,pend.y)
            end
        end
    end
end)


hook.Add("PreDrawViewModel", "PreViewModelChams", function()
    if ss.hands then
            render.SuppressEngineLighting(true)
        if IsDrawingWireframe then
            render.SetColorModulation(0, 0, 0)
            render.MaterialOverride(Wireframe)
        else
            render.SetColorModulation(ss.hchams_col.r / 255, ss.hchams_col.g / 255, ss.hchams_col.b / 255)
            render.SetBlend( 250 )
            render.MaterialOverride(DebugWhite)
        end
        render.SetBlend(1)
    end
end)

hook.Add("PreDrawHalos", "", function()
    if ss.glow then
        for k,v in next, player.GetAll() do
            cam.IgnoreZ()
            if(v:Health() < 1) then continue; end
            if(v:IsDormant()) then continue; end
            if(v:Team() == LocalPlayer():Team()) then
                halo.Add({v}, Color(ss.glow_col.r, ss.glow_col.g, ss.glow_col.b), 2, 2, 1, false, true);
            else
                halo.Add({v}, Color(ss.glow_col.r, ss.glow_col.g, ss.glow_col.b), 2, 2, 1, false, true);
            end
        end
    end
end);

ply = LocalPlayer()
hook.Add('HUDPaint','SkeletonEsp', function()
    if ss.skelly then
        for i,v in pairs(player.GetAll()) do
        if v == ply then
        else
            surface.SetDrawColor( ss.hchams_col.r, ss.hchams_col.g, ss.hchams_col.b, 255 )
            rshoulder = v:GetBonePosition( v:LookupBone('ValveBiped.Bip01_R_UpperArm') ):ToScreen()
            lshoulder = v:GetBonePosition( v:LookupBone('ValveBiped.Bip01_L_UpperArm') ):ToScreen()
            relbow = v:GetBonePosition( v:LookupBone('ValveBiped.Bip01_R_Forearm') ):ToScreen()
            lelbow = v:GetBonePosition( v:LookupBone('ValveBiped.Bip01_L_Forearm') ):ToScreen()
            lwrist = v:GetBonePosition( v:LookupBone('ValveBiped.Bip01_L_Hand') ):ToScreen()
            rwrist = v:GetBonePosition( v:LookupBone('ValveBiped.Bip01_R_Hand') ):ToScreen()
            head = v:GetBonePosition( v:LookupBone('ValveBiped.Bip01_Head1') ):ToScreen()
            pelvis = v:GetBonePosition( v:LookupBone('ValveBiped.Bip01_Pelvis') ):ToScreen()
            rthigh = v:GetBonePosition( v:LookupBone('ValveBiped.Bip01_R_Calf') ):ToScreen()
            lthigh = v:GetBonePosition( v:LookupBone('ValveBiped.Bip01_L_Calf') ):ToScreen()
            rfoot = v:GetBonePosition( v:LookupBone('ValveBiped.Bip01_R_Foot') ):ToScreen()
            lfoot = v:GetBonePosition( v:LookupBone('ValveBiped.Bip01_L_Foot') ):ToScreen()
            surface.DrawLine(rshoulder.x,rshoulder.y,lshoulder.x,lshoulder.y)
            surface.DrawLine(rshoulder.x,rshoulder.y,relbow.x,relbow.y)
            surface.DrawLine(lshoulder.x,lshoulder.y,lelbow.x,lelbow.y)
            surface.DrawLine(relbow.x,relbow.y,rwrist.x,rwrist.y)
            surface.DrawLine(lelbow.x,lelbow.y,lwrist.x,lwrist.y)
            surface.DrawLine(head.x,head.y,pelvis.x,pelvis.y)
            surface.DrawLine(pelvis.x,pelvis.y,rthigh.x,rthigh.y)
            surface.DrawLine(pelvis.x,pelvis.y,lthigh.x,lthigh.y)
            surface.DrawLine(rthigh.x,rthigh.y,rfoot.x,rfoot.y)
            surface.DrawLine(lthigh.x,lthigh.y,lfoot.x,lfoot.y)
            end
        end
    end
end)

local ent = FindMetaTable("Entity")
local vec = FindMetaTable("Vector")
 
hook.Add("HUDPaint", "test", function() 
    if ss.boxesphealth then
        for k, v in next, player.GetAll() do
    
            if(!v:Alive()) then continue end
            if(v:IsDormant()) then continue end
            if(v == LocalPlayer()) then continue end
    
            local pos = ent.GetPos(v);
            local poss = pos + Vector(0, 0, 70); 
            local pos = vec.ToScreen(pos);         
            local poss = vec.ToScreen(poss);
            local h = pos.y - poss.y;         
            local w = h / 2; 
    
            local health = math.Clamp(v:Health(), 0, 100)
    
            surface.SetDrawColor(HSVToColor( health / 100 * 120, 1, 1 ));
            surface.DrawOutlinedRect(pos.x - w / 2, pos.y - h, w, h);
        end
    end
end)

hook.Add("HUDPaint", "ballsxcs", function() 
    if ss.boxesps then
        for k, v in next, player.GetAll() do
    
            if(!v:Alive()) then continue end
            if(v:IsDormant()) then continue end
            if(v == LocalPlayer()) then continue end
    
            local pos = ent.GetPos(v);
            local poss = pos + Vector(0, 0, 70); 
            local pos = vec.ToScreen(pos);         
            local poss = vec.ToScreen(poss);
            local h = pos.y - poss.y;         
            local w = h / 2; 
    
            local health = math.Clamp(v:Health(), 0, 100)
    
            surface.SetDrawColor(Color(ss.box_col.r, ss.box_col.g, ss.box_col.b, 255));
            surface.DrawOutlinedRect(pos.x - w / 2, pos.y - h, w, h);
        end
    end
end)


hook.Add('HUDPaint','Esp', function()
    if ss.circlehead then
        for i,v in pairs(player.GetAll()) do
        if v == ply then
        else
        size = 1
            screenpos = v:GetBonePosition( v:LookupBone('ValveBiped.Bip01_Head1') ):ToScreen()
            if ply:GetPos():Distance(v:GetPos()) < 2000 then
                size = 15-(ply:GetPos():Distance(v:GetPos()))/150
                elseif ply:GetPos():Distance(v:GetPos()) < 2000 then
                size = 2
            end
            surface.DrawCircle(screenpos.x,screenpos.y,size or 0,255,0,0,255)
            end
        end
    end
end)
   
hook.Add("PostDrawViewModel", "PostViewModelChams", function()
   render.SetColorModulation(1, 1, 1)
   render.MaterialOverride(None)
   render.SetBlend(1)
   render.SuppressEngineLighting(false)
   
   if IsDrawingWireframe then return end
   
   IsDrawingWireframe = true
   LocalPlayer():GetViewModel():DrawModel()
   IsDrawingWireframe = false
end)

hook.Add('PreDrawEffects', ';kjbhsd;ouhadlkuhaefkuhaf', function()
    local playerTarget = closestEntByClass('player')
    for k, v in pairs(playerTarget)do
        if v:Alive() and v:Team() ~= TEAM_SPECTATOR and ss.chams then chams(v) end
    end
    local propTarget = closestEntByClass('prop_physics')
    for k, v in pairs(propTarget)do
        if ss.pchams then pchams(v) end
    end
end)

makeHook('RenderScreenspaceEffects', function()
    players = closestEntByClass('player')
    for k, v in next, players do 
        if (isValid(v) and onScreen(v) and v:Alive() and v:Team() ~= TEAM_SPECTATOR and team.GetName(v:Team()) != "Spectator" && v:GetObserverMode() == 0) then 
            if ss.esp_hitboxes and v ~= lply then hitboxes(v) end
        end
    end
end)

---------------------------------------------------
--/////////////////////////////////////////////////--

local whitemat = CreateMaterial('? ' .. tostring(CurTime()), 'UnlitGeneric',{
    ['$basetexture'] = 'color/white',
    ['$model'] = 1,
    ['$alpha'] = 1,
    ['$ignorez'] = 1,
    ["$translucent"] = 1,
    ["$vertexalpha"] = 1,
    ["$vertexcolor"] =  1,
})


hook.Add("HUDPaint", "balls", function()
    if ss.box then
        for k, v in pairs(player.GetAll()) do 
            if v == LocalPlayer() then continue end
            local mins, maxs = v:OBBMins(), v:OBBMaxs()
            local pos = v:GetPos()
            cam.Start3D()
                render.SuppressEngineLighting(true)
                render.SetMaterial( whitemat )
                whitemat:SetFloat('$alpha', 0.8)
                if pos then
                    render.SetColorModulation(1, 0, 0)
                    if ss.fillbox then
                        render.DrawBox(pos, Angle(0, 0, 0), mins, maxs, colors.darkgrey)
                    end
                    render.DrawWireframeBox(pos, Angle(0, 0, 0), mins, maxs, Color(ss.box_col.r, ss.box_col.g, ss.box_col.b), false )
                end
                render.SuppressEngineLighting(false)
            cam.End3D()
        end
    end
end)

------------
local function CheckObservers()
  
    if ss.speclist then return end
 
    observingPlayers = {}
    observingPlayers.watcher = {}
    observingPlayers.spec = {}
 
    for k, v in pairs(player.GetAll()) do
        if v:IsValid() and v != LocalPlayer() then
            local Trace = {}
            Trace.start  = LocalPlayer():EyePos() + Vector(0, 0, 32)
            Trace.endpos = v:EyePos() + Vector(0, 0, 32)
            Trace.filter = {v, LocalPlayer()}
            TraceRes = util.TraceLine(Trace)
            if !TraceRes.Hit then
                if (v:EyeAngles():Forward():Dot((LocalPlayer():EyePos() - v:EyePos())) > math.cos(math.rad(45))) then
                    if !table.HasValue(observingPlayers.watcher, v) then table.insert(observingPlayers.watcher, v ) end
                end
            end
        end
        if v:GetObserverTarget() == LocalPlayer() then
            if !table.HasValue(observingPlayers.spec, v) then table.insert(observingPlayers.spec, v) end
        end
    end
end


---------------------

gameevent.Listen("player_hurt")
local function hitSound(data)
	local ply = LocalPlayer()
	if data.attacker == ply:UserID() then
		surface.PlaySound("buttons/blip1.wav")
	end
end
 
hook.Add("player_hurt", "", hitSound)

----------------------------------------------


local should_follow = CreateClientConVar( "follow", "0")
local should_draw = CreateClientConVar( "follow_draw", "1")
local follow_team = CreateClientConVar( "follow_team", "0", true, false, "0 follow any team, 1 follow same team as localplayer, 2 follow opposite team as localplayer")


function is_movement_keys_down()
	return input.IsButtonDown( 33 ) or input.IsButtonDown( 65 ) or input.IsButtonDown( 11 ) or input.IsButtonDown( 29 ) or input.IsButtonDown( 14 )
end


function moveToPos(cmd, pos)
	local world_forward = pos - LocalPlayer():GetPos()
	local ang_LocalPlayer = cmd:GetViewAngles()

	cmd:SetForwardMove( ( (math.sin(math.rad(ang_LocalPlayer[2]) ) * world_forward[2]) + (math.cos(math.rad(ang_LocalPlayer[2]) ) * world_forward[1]) ) * 300 )
	cmd:SetSideMove( ( (math.cos(math.rad(ang_LocalPlayer[2]) ) * -world_forward[2]) + (math.sin(math.rad(ang_LocalPlayer[2]) ) * world_forward[1]) ) * 300 )
end


function closest_player(team)
	best = 99999999
	current_e = nil
	for k, v in pairs(player.GetAll()) do
		dist = v:GetPos():Distance(LocalPlayer():GetPos())
		if LocalPlayer():Alive() and v:Alive() and v ~= LocalPlayer() and dist < best and v:Health() > 0 and v:GetObserverMode() == 0 then
			if team == nil then
				best = dist
				current_e = v
			elseif not team and LocalPlayer():Team() ~= v:Team() then
				best = dist
				current_e = v
			elseif team and LocalPlayer():Team() == v:Team() then
				best = dist
				current_e = v
			end
		end
	end
	return current_e
end

local target = nil
hook.Add("CreateMove", "PlayerFollow", function(cmd)
	if should_follow:GetInt() == 1 then
		if is_movement_keys_down() then return end
		
		if follow_team:GetInt() == 0 then
			target = closest_player()
		elseif follow_team:GetInt() == 1 then
			target = closest_player(true)
		elseif follow_team:GetInt() == 2 then
			target = closest_player(false)
		end
		
		if not target then return end
		moveToPos(cmd, target:GetPos())
	end
end)

hook.Add("HUDPaint", "PlayerFollow_Draw", function()
	if should_follow:GetInt() == 1 and should_draw:GetInt() == 1 then
		local pos = target:GetPos():ToScreen()
		surface.DrawCircle( pos["x"], pos["y"], 7, 0, 255, 0)
	end
end)

if ballz == 1 then
    RunConsoleCommand("follow", "1")
else
    RunConsoleCommand("follow", "0")
end

---------------


-----------------------------------------------------








makeHook('ShouldDrawLocalPlayer', function()
    return ss.tps
end)




makeHook('CalcView', function(ent, pos, angles, fov)
    if not lply:InVehicle() then
        local sideoff = ss.tps_y
        local heightoff = ss.tps_h
        local offsetangle = Angle( 0, sideoff, 0 )
        local origin

        local view = {
            origin = pos,
            angles = angles,
            fov = fov,
        }

        if ss.tps_collision then 
            local endpos = pos - ((angles - offsetangle):Forward() * heightoff)
            local tr = util.TraceHull({
                start = pos,
                endpos = endpos,
                mask = MASK_SHOT,
                filter = lply,
                ignoreworld = false,
                mins = Vector(-8, -8, -8),
                maxs = Vector(8, 8, 8)
            })
            origin = tr.HitPos + tr.HitNormal
        else
            origin = pos - ((angles - offsetangle):Forward() * heightoff)
        end

        view.origin = origin
        view.angles = angles
        view.fov = ss.fov

        return view
    end
end)


makeHook('DrawPhysgunBeam', function(ply, _, enabled, target, _, hitPos)
    if enabled and isValid(target) and ply == lply then
        dbg.curprop = target
    else
        dbg.curprop = nil
    end
    if ply == lply and isValid(target) then
        dbg.lastprop = target
        dbg.beampos = target:LocalToWorld(hitPos)
        dbg.beamang = ply:EyeAngles()
    end
end)


--[[

--------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------
-------------------------------------------------
-----------------------------------------------------------
]]
 

concommand.Add("triggerbot",function()
ss.toggle = not ss.toggle
end)

hook.Add("Think","aimbot", function()
if ss.toggle then
local ply = LocalPlayer() 
    local trace = util.GetPlayerTrace( ply )
    local traceRes = util.TraceLine( trace )
    if traceRes.HitNonWorld then
        local target = traceRes.Entity
        if target:IsPlayer() then
            local targethead = target:LookupBone("ValveBiped.Bip01_Head1")
            local targetheadpos,targetheadang = target:GetBonePosition(targethead)
            ply:SetEyeAngles((targetheadpos - ply:GetShootPos()):Angle())
        end
    end
end
end)

makeHook('PreDrawEffects', function()
    if ss.grabber then
        cam.Start3D2D(dbg.beampos,dbg.beamang+Angle(90,0,0),1) 
                surface.DrawCircle( 0, 0, 5 + math.cos( CurTime() ) * 50, colors.black )
                surface.DrawCircle( 0, 0, 5 + math.sin( CurTime() ) * 50, colors.black )
        cam.End3D2D()
        if dbg.beampos ~= nil then
            cam.Start3D()
                render.DrawWireframeSphere(dbg.beampos, 2.5, 5, 5, Color(ss.hchams_col.r, ss.hchams_col.g , ss.hchams_col.b, 255), false)
            cam.End3D()
        end
    end
    local prop = dbg.curprop or dbg.lastprop
    if isValid(prop) and ss.grabber then
        cam.Start3D()
            local sv_gravity = GetConVar('sv_gravity'):GetFloat()
            local max, min = prop:LocalToWorld(prop:OBBMaxs()), prop:LocalToWorld(prop:OBBMins())

            local minmax = max:Distance(min)

            local cCenter = prop:LocalToWorld(prop:OBBCenter())

            local vel = prop:GetVelocity()
            local vel2 = prop:GetVelocity()
            vel.z = math.min(-300, -math.abs(vel.z))
            local time = vel.z / sv_gravity

            local Vdrop = Vector(0, 0, 0.5*sv_gravity*(time^2))
            local VFwd = Vector(vel.x, vel.y, 0)
            local Vi = cCenter + Vdrop + VFwd * time

            local trace = util.TraceLine({
                start = cCenter,
                endpos = cCenter + vel,
                mask = MASK_PLAYERSOLID,
                filter = prop
            })

            local veltrace = util.TraceLine({
                start = cCenter,
                endpos = cCenter + vel2/2,
                mask = MASK_PLAYERSOLID,
                filter = prop
            })

            local final = Vi
            local t = -time
            while final.z > trace.HitPos.z and t < 10 do
                local tTime = 0.5*sv_gravity*t*t
                final = Vi + VFwd * t - Vector(0, 0, tTime)
                t = t + 0.01
            end

            local predpos = util.QuickTrace(cCenter, (final - cCenter) * 2, prop)
            render.DrawLine(cCenter, veltrace.HitPos, Color(ss.hchams_col.r, ss.hchams_col.g , ss.hchams_col.b, 255), false) 
            render.DrawLine(cCenter, predpos.HitPos, Color(ss.hchams_col.r, ss.hchams_col.g , ss.hchams_col.b, 255), false) 
        cam.End3D()
    end
end)

-------------------
if ss.speclist then
    for k, v in ipairs(observingPlayers.watcher) do
        if IsValid(v) then
            surface.SetFont("Specialneeds")
            local nameWidth, nameHeight = surface.GetTextSize("Observer: "..v:Name())
            draw.SimpleText("Observer: "..v:Name(), "Specialneeds", ScrW() - nameWidth - 2, 0 + (15 * ( k - 1 ) ), Color(255, 255, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
        end
    end
    for k, v in ipairs(observingPlayers.spec) do
        if IsValid(v) then
             surface.SetFont("Specialneeds")
            local nameWidth, nameHeight = surface.GetTextSize("Spectator: "..v:Name())
            draw.SimpleText("Spectator: "..v:Name(), "Specialneeds", ScrW() - nameWidth - 2, -15 + (15 * #observingPlayers.watcher) + (15 * k - 1), Color(255, 0, 0), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
        end
    end
end

AddHook("RenderScreenspaceEffects", RandomString(), function()
    if !ss then
        if ss.nightmode then
            local nightmode = {
                [ "$pp_colour_addr" ] = 55 * (1 / 255),
                [ "$pp_colour_addg" ] = 45 * (1 / 255),
                [ "$pp_colour_addb" ] = 66 * (1 / 255),
                [ "$pp_colour_brightness" ] = -0.2,
                [ "$pp_colour_contrast" ] = 1,
                [ "$pp_colour_colour" ] = 1,
                [ "$pp_colour_mulr" ] = 0,
                [ "$pp_colour_mulg" ] = 0,
                [ "$pp_colour_mulb" ] = 0
            }
            DrawColorModify( nightmode )
        end
    end
end)

local LightingModeChanged = false
AddHook("PreRender", RandomString(), function()
	if !ss then
		if ss.fullbright then
			render.SetLightingMode( 1 )
			LightingModeChanged = true
		end
	end
end )
 
local function EndOfLightingMod()
	if LightingModeChanged then
		render.SetLightingMode( 0 )
		LightingModeChanged = false
	end
end
AddHook("PostRender", RandomString(), EndOfLightingMod)
AddHook("PreDrawHUD", RandomString(), EndOfLightingMod)





--thanks times hack lol
  
 print("\n")
 MsgC(Color(61, 149, 217), " ¦¦¦¦¦¦¦+¦¦+¦¦¦¦¦+¦¦¦¦¦¦¦+¦¦¦¦¦¦¦¦¦¦¦+¦¦¦¦¦¦+¦¦¦+¦¦¦¦¦\n¦¦+----+¦¦¦¦¦¦¦¦¦¦¦+----+¦¦¦¦¦¦+----+¦¦+--¦¦+¦¦¦¦¦¦¦¦\n+¦¦¦¦¦+¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦+¦¦¦¦+¦¦¦¦¦+¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦\n¦+---¦¦+¦¦¦¦¦¦¦¦¦¦¦¦¦¦+¦¦+¦¦¦¦+---¦¦+¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦\n¦¦¦¦¦¦+++¦¦¦¦¦¦+++¦¦¦¦¦¦++¦¦+¦¦¦¦¦¦+++¦¦¦¦¦++¦¦¦¦¦¦¦+\n+-----+¦¦+-----+¦¦+-----+¦+-++-----+¦¦+----+¦+------+\n")
  
 notification.AddLegacy("sug.sol loaded, have fun. Check console for info!", NOTIFY_HINT, 5)
 surface.PlaySound( "buttons/button15.wav" )
 
