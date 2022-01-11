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

    txtespPLAYER = true,
    txtespPROP = false,

    chams = true,
    chams_col = Color(255,255,255),
    chams_a = 255,
    chams_lighting = false,

    pchams = false,
    pchams_col = Color(0,255,255),
    pchams_a = 150,
    pchams_lighting = true,

    random_col = Color(0,255,255, 255),


    hchams_col = Color(255, 0, 0, 255),
    hands = false,

    box_col = Color(255, 255, 255, 255),

    menu_col = Color(0, 255, 255, 255),

    glow_col = Color(0, 255, 255, 255),

    tps = 1,
    box = false,

    wallsx = false,
    wallsxb = true,
    wallsxp = false,

    getgood = false,
    watermark = true,

    toggle = false,

    grabber = false,

    speclist = false,

    nightmode = false,

    crosshair = false,


    esp_hitboxes = false,
    eyetrace = false,

    skelly = false,

    circlehead = false,

    gdance = true,

    fillbox = true,

    glow = true,

    boxesphealth = false,
    boxesps = true,
    keypads = false,

    fire = false,

    swasthair = false,
    animcham = false,

    hitmarker = false,
    hitsound = false,

    rainbowphys = false,



    material = 'models/debug/debugwhite',
    aimpos = 'eyes',

    fov = 120,
}
--END OF CONFIG SECTION

--local noob = surface.CreateFont("", {--[[ tdata here]]})

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

	-- table[table+1] = val
	-- table[#table+1] = val
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
local function RandomString() return tostring(math.random(-9999999999, 9999999999)) end

local function makeHook(txt, fnc)
    local sys,txsz = tostring((util.CRC(math.random(10^4)+SysTime())) )..'',#txt
    print('Hook added! ['..txt..'] '..('.'):rep((#sys+2-txsz)+20)..sys)
	local name = 'SS|'..util.CRC(math.random(10^4)+SysTime())
    hook.Add(txt,name,fnc)
end

local function dumphooks()
    for k,v in pairs(hook.GetTable()) do
        for k1,v1 in pairs(v) do
            if string.find(tostring(k1),'SS|') then
                print("hook:", k, k1)
            end
        end
    end
end

concommand.Add("dumphooks", dumphooks)

local function unload()
    for k,v in pairs(hook.GetTable()) do
        for k1,v1 in pairs(v) do
            if string.find(tostring(k1),'SS|') then
            	hook.Remove(k,k1)
            	print("unloaded: ", k, k1)
            end
        end
    end
end
concommand.Add("unload", unload)

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

local fakeRT = GetRenderTarget( "fakeRT" .. os.time(), ScrW(), ScrH() )

makeHook( "RenderScene", function( vOrigin, vAngle, vFOV )
    local view = {
        x = 0,
        y = 0,
        w = ScrW(),
        h = ScrH(),
        dopostprocess = true,
        origin = vOrigin,
        angles = vAngle,
        fov = vFOV,
        drawhud = true,
        drawmonitors = true,
        drawviewmodel = true
    }

    render.RenderView( view )
    render.CopyTexture( nil, fakeRT )

    cam.Start2D()
        hook.Run( "SHUDPaint" )
    cam.End2D()

    render.SetRenderTarget( fakeRT )

    return true
end )

makeHook( "ShutDown", function()
    render.SetRenderTarget()
end )

local tply = ss.friends

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
    local menuderma = vgui.Create( "DFrame" )
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
    checkbox("CLI:Keypad Logger", "its like Keypads", 'keypads', 580, 365, menuderma )
    checkbox("CLI:Nightmode", "its like night", 'nightmode', 580, 395, menuderma )
    checkbox("CLI:Swasthair", "its like german", 'swasthair', 580, 425, menuderma )
    checkbox("CLI:Animate Hand", "its like hand but anim", 'animcham', 580, 455, menuderma )
    checkbox("CLI:Gay Physgun", "its like raindno", 'rainbowphys', 580, 485, menuderma )
    checkbox("ESP:2D Box", "Player boxes", 'boxesps', 580, 70, menuderma )
    checkbox("ESP:2D Box(Health)", "Player Boxes", 'boxesphealth', 580, 100, menuderma )
    checkbox("ESP:Hitmarker", "Player Hitmark", 'hitmarker', 580, 130, menuderma )
    checkbox("ESP:Hitsound", "Player Hitsound", 'hitsound', 580, 160, menuderma )
    checkbox("ESP:3D Box Fill", "Fill 3D Box ESP", 'fillbox', 440, 190, menuderma )

    checkbox("ESP:Ply Walls", "its like view", 'wallsx', 230, 130, menuderma )
    checkbox("ESP:Prop Walls", "its like view", 'wallsxp', 230, 160, menuderma )

    checkbox("CLI:Info", "its like debig", 'getgood', 440, 365, menuderma )
    checkbox("CLI:Watermark", "its like mark", 'watermark', 440, 335, menuderma )

    checkbox("ESP:Ply Flat", "Toggle PNames", 'chams_lighting', 230, 70, menuderma )
    checkbox("ESP:Prop Flat", "Toggle PNames", 'pchams_lighting', 230, 100, menuderma )
    --checkbox("AIM:Legit Aimbot", "Toggle aimbot", 'softaimbot', 20, 110, menuderma )

    slider( "CLI:FOV", "fov", 1, 170, 230, 335, 190, 20, menuderma)
    slider( "ESP:Ply  A", "chams_a", 1, 255, 230, 230, 190, 20, menuderma)
    slider( "ESP:Prop A", "pchams_a", 1, 255, 230, 260, 190, 20, menuderma)

    slider('CLI:Ddos server', 'tps_y', 0, 360, 230, 365, 190, 20, menuderma)
    slider('CLI:Get ip', 'tps_h', 0, 100, 230, 395, 190, 20, menuderma)


    checkbox("AIM:Fire", "Toggle Aimbot fire", 'fire', 20, 110, menuderma )



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
    --[[
    local ptbox2 = vgui.Create( 'DComboBox', menuderma )
    ptbox2:SetPos( 90, 107 )
    ptbox2:SetSize( 90, 20 )
    ptbox2:SetValue( 'Bone' )
    ptbox2:AddChoice('nose')
    ptbox2:AddChoice('eyes')
    ptbox2:AddChoice('tie')
    ptbox2:AddChoice('chest')
    ptbox2:AddChoice('pen')
    ptbox2:AddChoice('hips')
    ptbox2:AddChoice('lefthand')
    ptbox2:AddChoice('righthand')

    function ptbox2:OnSelect( _, LookupAttachment )
        ss.aimpos = LookupAttachment
    end
    function ptbox2:Paint()
        draw.RoundedBox(5, 0, 0, self:GetWide(), self:GetTall(), colors.black)
    end]]




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



local ColorDerma = vgui.Create( "DFrame" )
function cui()
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
    if not ColorDerma:IsVisible() then
        ColorDerma:Show()
    else
        cui()
    end
end)

makeHook("OnContextMenuClose", function()
    if ColorDerma:IsVisible() then ColorDerma:Hide() end
end)


--[[
local f = vgui.Create( "DFrame" )
function fui()
    f:SetSize( 350, 75 )
    f:SetPos( midW - ( f:GetWide() / 2 - 0 ), midH - ( f:GetTall() / 2) )
    f:SetTitle( " " )
    f:MakePopup()
    f:InvalidateParent(true)
    f:SetDeleteOnClose( false )
    f:ShowCloseButton(false)
    f.Paint = function(s , w , h)
        draw.RoundedBox(5,5,0,w , h,Color(40,40,40, 250))
    end
    local cbutton = vgui.Create('DButton', f)
    cbutton:SetText('X')
    cbutton:SetTextColor(colors.black)
    cbutton:SetSize(16, 16)
    cbutton:SetPos(f:GetWide() - cbutton:GetWide() - 5, 5)
    function cbutton:DoClick()
        f:Close()
    end
    function cbutton:Paint()
        draw.RoundedBox(5, 0, 0, self:GetWide(), self:GetTall(), colors.red)
    end

    local friends = vgui.Create( 'DComboBox', f )
    friends:SetPos( 150, 20 )
    friends:SetSize( 115, 20 )
    friends:SetValue( 'Friend 2' )
    makeHook('Think' function()
        for k, v in ipairs(player.GetAll()) do
            friends:AddChoice(v:Nick())
        end
    end)


    function friends:OnSelect( _, val )
        ss.friends1 = v:Nick()
    end
    function friends:Paint()
        draw.RoundedBox(5, 0, 0, self:GetWide(), self:GetTall(), colors.black)
    end

    local friendss = vgui.Create( 'DComboBox', f )
    friendss:SetPos( 20, 20 )
    friendss:SetSize( 115, 20 )
    friendss:SetValue( 'Friend 1' )
    makeHook('Think' function()
        for k, v in ipairs(player.GetAll()) do
            friends:AddChoice(v:Nick())
        end
    end)


    function friendss:OnSelect( _, val )
        ss.friends2 = v:Nick()
    end
    function friendss:Paint()
        draw.RoundedBox(5, 0, 0, self:GetWide(), self:GetTall(), colors.black)
    end
end

concommand.Add('ss_fmenu', fui)

makeHook("OnContextMenuOpen", function()
    if not f:IsVisible() then
        f:Show()
    else
        fui()
    end
end)

makeHook("OnContextMenuClose", function()
    if f:IsVisible() then f:Hide() end
end)
]]
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





function tespProp(v)
    local text = ''
    local pos = v:LocalToWorld(v:OBBCenter()):ToScreen()

    local str = string.Explode('/', v:GetModel())
    local nn = str[#str]

    local w,h = getTextSize('Specialneeds',nn)
    DrawText(Color(255,255,255), pos.x-w/2, pos.y-h/2,nn, 'Specialneeds')
end

makeHook("SHUDPaint", function()


    local propTarget = closestEntByClass("prop_physics")
    for k, v in pairs(propTarget) do
        if ss.txtespPROP then tespProp(v) end
    end
end)



--[[-------------------------------------------------------------------------
    Fov Stuff
---------------------------------------------------------------------------]]

makeHook("CalcView", function( p, o, a, f )
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

local function watermark()
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

            surface.SetTextColor( Color(ss.menu_col.r, ss.menu_col.g, ss.menu_col.b) )
            surface.SetTextPos( 80, 2 )
            surface.SetFont( "booslssd" )
            surface.DrawText(LocalPlayer():Name())


        end

    end

local function infoshow()
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
    end

local function legitaims()
        if ss.getgood and ss.softaimbot then

            surface.SetTextColor( 255, 255, 255 )
            surface.SetTextPos( midW + 10, midH + 20)
            surface.SetFont( "boosls" )
            surface.DrawText( "LegitAim" )

        end
    end

local function aimkeys()
        if ss.getgood then

            surface.SetTextColor( 255, 255, 255 )
            surface.SetTextPos( midW + 10, midH + 10)
            surface.SetFont( "boosls" )
            surface.DrawText( "Aimbot key = "..input.GetKeyName( ss.aimkey ) )

        end
    end

local function drawcross()
        if ss.crosshair then
            draw.RoundedBox(0,midW - 1.25,midH - 15 ,2,30,Color(0,255,255,100))
            draw.RoundedBox(0,midW - 15 ,midH - 0.15,30,2,Color(0,255,255,100))
        end
    end


makeHook("SHUDPaint" , function()
    watermark()
    drawcross()
    infoshow()
    aimkeys()
    legitaims()
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

		cmd:SetViewAngles(solveAng)

end

local function doFire(cmd)
    if ss.fire then
	    cmd:SetButtons(bit.bor(cmd:GetButtons(), IN_ATTACK))
    end
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
        		endpos = v:GetAttachment(v:LookupAttachment(ss.aimpos)).Pos,
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
------------------------------------




--[[-------------------------------------------------------------------------
    esp  Stuff
---------------------------------------------------------------------------]]


local function chams(v)
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

local function pchams(v)
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


local function hitboxes(v)
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


makeHook('SHUDPaint', function()
    if ss.eyetrace then
        for i, v in pairs(player.GetAll()) do
        	if v ~= lply then
	            surface.SetDrawColor( ss.hchams_col.r, ss.hchams_col.g, ss.hchams_col.b, 255, 175 )
	            pstart = v:GetBonePosition( v:LookupBone('ValveBiped.Bip01_Head1') ):ToScreen()
	            pend = util.TraceLine(util.GetPlayerTrace(v)).HitPos:ToScreen()
	            surface.DrawLine(pstart.x,pstart.y,pend.x,pend.y)
            end
        end
    end
end)


makeHook("PreDrawViewModel", function()
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

makeHook("PreDrawHalos", function()
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
makeHook('SHUDPaint', function()
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

makeHook("SHUDPaint", function()
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

makeHook("SHUDPaint", function()
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

makeHook("SHUDPaint", function()
    if ss.txtespPLAYER then
        for k, v in pairs(player.GetAll()) do

            if not v:Alive() then continue end
            if v:IsDormant() then continue end
            if v == LocalPlayer() then continue end
            local offset = Vector(0,0,-70)
            local pos = (v:EyePos() + offset):ToScreen()

            draw.DrawText( v:Nick(), "DermaDefault", pos.x, pos.y, Color(ss.menu_col.r, ss.menu_col.g, ss.menu_col.b, 255), TEXT_ALIGN_CENTER )
        end
    end
end)
--[[]
hook.Add("HUDPaint", "ballsxcssss", function()
    if ss.txtespPLAYER then
        for k, v in pairs(player.GetAll()) do

            if not v:Alive() then continue end
            if v:IsDormant() then continue end
            if v == LocalPlayer() then continue end
            local hp = v:Health()
            local offset = Vector(0, 0, 15)
            local pos = (v:EyePos() + offset):ToScreen()
            local health = math.Clamp(v:Health(), 0, 100)
            local hpdraw = HSVToColor( health / 100 * 120, 1, 1 )

            surface.SetFont( "DermaDefault" )
            surface.SetTextColor( HSVToColor( health / 100 * 120, 1, 1 ) )
            surface.SetTextPos( pos.x, pos.y )
            surface.DrawText( hp )

        end
    end
end)
]]



makeHook('SHUDPaint', function()
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

makeHook("PostDrawViewModel", function()
   render.SetColorModulation(1, 1, 1)
   render.MaterialOverride(None)
   render.SetBlend(1)
   render.SuppressEngineLighting(false)

   if IsDrawingWireframe then return end

   IsDrawingWireframe = true
   LocalPlayer():GetViewModel():DrawModel()
   IsDrawingWireframe = false
end)

makeHook('PreDrawEffects', function()
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


makeHook("SHUDPaint", function()
    if ss.box then
        for k, v in pairs(player.GetAll()) do
            if(!v:Alive()) then continue end
            if(v:IsDormant()) then continue end
            if(v == LocalPlayer()) then continue end

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
                render.SetColorModulation(1, 1, 1)
                render.SetMaterial(nil)
                render.SuppressEngineLighting(false)
            cam.End3D()
        end
    end
end)

------------


---------------------

gameevent.Listen("player_hurt")
local function hitSound(data)
    if ss.hitsound then
        local ply = LocalPlayer()
        if data.attacker == ply:UserID() then
            surface.PlaySound("buttons/blip1.wav")
        end
    end
end

makeHook("player_hurt", hitSound)

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
makeHook("CreateMove", function(cmd)
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

makeHook("SHUDPaint", function()
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





------------------------------------------------------------------------------------------------------------------------------------------

local AKPL = (file.Read("akpl.dat") != nil && util.JSONToTable(util.Decompress(file.Read("akpl.dat"))) || {})

// internal calculations
local Col = {[-1]=Color(150,150,150,255), [0]=Color(255,0,0,255), [1]=Color(255,165,0,255), [2]=Color(0,255,0,255)}
AKPL.LP = LocalPlayer()
function AKPL.CalculateRenderPos(self)
	local pos = self:GetPos() pos:Add(self:GetForward() * self:OBBMaxs().x) pos:Add(self:GetRight() * self:OBBMaxs().y) pos:Add(self:GetUp() * self:OBBMaxs().z) pos:Add(self:GetForward() * 0.15) return pos
end
function AKPL.CalculateRenderAng(self)
	local ang = self:GetAngles() ang:RotateAroundAxis(ang:Right(), -90) ang:RotateAroundAxis(ang:Up(), 90) return ang
end
function AKPL.CalculateKeypadCursorPos(ply, ent)
	if !ply:IsValid() then return end local tr = util.TraceLine( { start = ply:EyePos(), endpos = ply:EyePos() + ply:GetAimVector() * 65, filter = ply } ) if !tr.Entity or tr.Entity ~= ent then return 0, 0 end local scale = ent.Scale || 0.02 if !scale then return 0, 0 end local pos, ang = AKPL.CalculateRenderPos(ent), AKPL.CalculateRenderAng(ent) if !pos or !ang then return 0, 0 end local normal = ent:GetForward() local intersection = util.IntersectRayWithPlane(ply:EyePos(), ply:GetAimVector(), pos, normal) if !intersection then return 0, 0 end local diff = pos - intersection local x = diff:Dot( -ang:Forward() ) / scale local y = diff:Dot( -ang:Right() ) / scale return x, y
end
local elements = {{x = 0.075, y = 0.04, w = 0.85, h = 0.25,},{x = 0.075, y = 0.04 + 0.25 + 0.03, w = 0.85 / 2 - 0.04 / 2 + 0.05, h = 0.125, text = "ABORT",},{x = 0.5 + 0.04 / 2 + 0.05, y = 0.04 + 0.25 + 0.03, w = 0.85 / 2 - 0.04 / 2 - 0.05, h = 0.125, text = "OK",}} do for i = 1, 9 do local column = (i - 1) % 3 local row = math.floor((i - 1) / 3) local element = {x = 0.075 + (0.3 * column), y = 0.175 + 0.25 + 0.05 + ((0.5 / 3) * row), w = 0.25, h = 0.13, text = tostring(i), } elements[#elements + 1] = element end end
function AKPL.GetHoveredElement(ply, ent)
	local scale = ent.Scale || 0.02 local w, h = (ent:OBBMaxs().y - ent:OBBMins().y) / scale , (ent:OBBMaxs().z - ent:OBBMins().z) / scale local x, y = AKPL.CalculateKeypadCursorPos(ply, ent) for _, element in ipairs(elements) do local element_x = w * element.x local element_y = h * element.y local element_w = w * element.w local element_h = h * element.h if  element_x < x and element_x + element_w > x and element_y < y and element_y + element_h > y then return element end end
end
// internal calculations

AKPL.KeypadCache = {}
AKPL.KeypadOwners = AKPL.KeypadOwners || {}
AKPL.AwaitingResponse = {}
AKPL.ShouldUnlockKeypad = {}

AKPL.InsertKey = function(i, p, v)
    if(!tonumber(i) || !tonumber(p) || !tonumber(v)) then return i end
    local val = i:ToTable()
    val[p] = v
    return table.concat(val)
end

AKPL.ResetLog = function(ent, validated)
    if(!validated) then
        AKPL.KeypadCache[ent]["Code"] = "0000"
    end
    AKPL.KeypadCache[ent]["Validated"] = validated && 2 || -1
    AKPL.AwaitingResponse[ent] = nil
    AKPL.ShouldUnlockKeypad[ent] = nil
end

AKPL.ValidCode = function(code)
    return (tonumber(code) != 0 && code:StartWith(code:Replace("0", "")))
end

AKPL.ValidateCode = function(ent, status)
    if(status == ent.Status_Granted) then
        local code = AKPL.KeypadCache[ent]["Code"]
        if (AKPL.ValidCode(code)) then
            AKPL.KeypadCache[ent]["Validated"] = 1
            if(AKPL.AwaitingResponse[ent]) then
                AKPL.AwaitingResponse[ent][1] = -1
            end
        end
    elseif(status == ent.Status_Denied) then
        if(AKPL.KeypadCache[ent]["Validated"] <= 0 || (AKPL.KeypadCache[ent]["Validated"] == 1 && AKPL.AwaitingResponse[ent] && AKPL.AwaitingResponse[ent][3] == 3)) then
            AKPL.ResetLog(ent)
        end
    end
end

AKPL.Logger = function(ent, name, old, new)
    local Handler = {
        ["Text"] = function(ent, old, new)
            if(AKPL.AwaitingResponse[ent]) then
                if(AKPL.AwaitingResponse[ent][3] == 1) then
                    if((new:len() - old:len()) == AKPL.AwaitingResponse[ent][1]) then
                        if(!AKPL.AwaitingResponse[ent][2]) then
                            AKPL.AwaitingResponse[ent][3] = 3
                        else
                            AKPL.AwaitingResponse[ent][3] = 2
                        end
                    else
                        AKPL.AwaitingResponse[ent] = nil
                    end
                elseif(AKPL.AwaitingResponse[ent][3] == 2) then
                    if((new:len() - old:len()) == tostring(AKPL.AwaitingResponse[ent][2]):len()) then
                        AKPL.AwaitingResponse[ent][3] = 3
                    else
                        AKPL.AwaitingResponse[ent] = nil
                    end
                end
            return end
            if(new == "" && AKPL.KeypadCache[ent]["Validated"] <= 0) && AKPL.ValidCode(AKPL.KeypadCache[ent]["Code"]) then return AKPL.ResetLog(ent) end
            if(!ent:GetSecure()) then
                for k, v in ipairs(string.ToTable(new)) do
                    AKPL.KeypadCache[ent]["Code"] = AKPL.InsertKey(AKPL.KeypadCache[ent]["Code"], k, v)
                end
            else
                for k, v in ipairs(ents.FindInSphere(ent:GetPos(), 120)) do
                    if(!v:IsPlayer()) then continue end
                    local element = AKPL.GetHoveredElement(v, ent)
                    if(element) then
                        if(tonumber(element.text)) then
                            AKPL.KeypadCache[ent]["Code"] = AKPL.InsertKey(AKPL.KeypadCache[ent]["Code"], new:len(), tonumber(element.text))
                        end
                    else
                        continue
                    end
                end
            end
            if(AKPL.KeypadCache[ent]["Validated"] != -1 && AKPL.GetEntOwner(ent)) then
                AKPL.KeypadOwners[AKPL.GetEntOwner(ent)][AKPL.RenderText(AKPL.KeypadCache[ent]["Code"])] = AKPL.KeypadCache[ent]["Validated"]
            end
        end,
        ["Status"] = function(ent, old, new)
            AKPL.ValidateCode(ent, tonumber(new))
        end,
    }
    if(Handler[name]) then
        Handler[name](ent, old, new)
    end
end

AKPL.GetPlayerByName = function(name)
    if(!name || name == "") then return false end
	name = string.lower(name)
	for _,v in ipairs(player.GetHumans()) do
		if(string.find(string.lower(v:Name()),name,1,true) != nil)
			then return v
		end
    end
    return false
end

AKPL.GetEntOwner = function(ent)
    local ply = AKPL.GetPlayerByName(ent:GetNWString("FounderName"))
    return ply && ply:AccountID() || ply
end

AKPL.RegisterCallback = function(ent)
    if(!AKPL.KeypadCache[ent] && isfunction(ent.GetStatus) && isfunction(ent.GetText)) then
        ent:NetworkVarNotify("Text", AKPL.Logger)
        ent:NetworkVarNotify("Status", AKPL.Logger)
        AKPL.KeypadCache[ent] = {["Code"]="0000", ["Validated"]=-1}
        local sid = AKPL.GetEntOwner(ent)
        if(sid == false) then return end
        if(!AKPL.KeypadOwners[sid]) then
            AKPL.KeypadOwners[sid] = {}
        end
        AKPL.KeypadOwners[sid][#AKPL.KeypadOwners[sid]+1] = ent
    end
end

AKPL.SendCommand = function(ent, c, d)
    if(ent:GetStatus() != ent.Status_None || AKPL.LP:EyePos():Distance(ent:GetPos()) >= 120 || util.NetworkStringToID(ent:GetClass()) == 0) then return end
    net.Start(ent:GetClass())
    net.WriteEntity(ent)
    net.WriteUInt(c, 4)
    if(tonumber(d)) then
        net.WriteUInt(tonumber(d), 8)
    end
    net.SendToServer()
end

AKPL.TestCodes = function(ent)
    if(AKPL.AwaitingResponse[ent] && AKPL.AwaitingResponse[ent][3] != 1) then
        if(AKPL.AwaitingResponse[ent][1] == -1) then
            AKPL.ResetLog(ent, true)
        elseif(AKPL.AwaitingResponse[ent][3] == 2) then
            AKPL.SendCommand(ent, 0, AKPL.AwaitingResponse[ent][2])
        elseif(AKPL.AwaitingResponse[ent][3] == 3) then
            AKPL.SendCommand(ent, 1)
        end
    else
        if(AKPL.KeypadCache[ent]["Validated"] == 2) then
            AKPL.ShouldUnlockKeypad[ent] = true
        end
        if(AKPL.KeypadCache[ent]["Validated"] != 1 && !AKPL.ShouldUnlockKeypad[ent]) then return end
        if(ent:GetText() != "") then
            return AKPL.SendCommand(ent, 2)
        end
        local code = AKPL.KeypadCache[ent]["Code"]:Replace("0",""):ToTable()
        local split = tonumber(table.concat({code[1], code[2], code[3]}))
        if(!split) then return end
        if(split < 2^8) then
            AKPL.AwaitingResponse[ent] = {3, code[4], 1}
        else
            split = tonumber(table.concat({code[1], code[2]}))
            AKPL.AwaitingResponse[ent] = {2, tonumber(table.concat({code[3], code[4]})), 1}
        end
        AKPL.SendCommand(ent, 0, split)
    end
end

makeHook("Tick", function()
    file.Write("akpl.dat", util.Compress(util.TableToJSON(AKPL)))
    for k, v in ipairs(ents.FindByClass("keypad*")) do
        AKPL.RegisterCallback(v)
        --AKPL.TestCodes(v) --this only works if the first 3 digits of a keypad code are under 255, TODO account for keypad cooldowns
    end
end)

AKPL.RenderText = function(str)
    if(tonumber(str) == 0) then return "Unknown" elseif(AKPL.ValidCode(str)) then return str:Replace("0", "") else return str:Replace("0", "*") end
end
AKPL.Gradient = Material( "gui/gradient" )

makeHook("SHUDPaint", function()
    if ss.keypads then

        local tr = AKPL.LP:GetEyeTrace().Entity
        if IsValid(tr) and AKPL.KeypadCache[tr] then
            local text = AKPL.RenderText(AKPL.KeypadCache[tr]["Code"])
            local color = Col[AKPL.KeypadCache[tr]["Validated"]]
            surface.SetDrawColor( Color(0,0,50,255) )
            surface.SetMaterial( AKPL.Gradient )
            surface.DrawTexturedRect( ScrW() / 2 + 57, ScrH() / 2 - 7, 50, 15 )
        end

        for k, v in pairs(AKPL.KeypadCache) do
            if(IsValid(k) && k != tr) then
                local pos = k:GetPos():ToScreen()
                if(pos.visible) then
                    local text = AKPL.RenderText(v["Code"])
                    local color = Col[v["Validated"]]
                    surface.SetDrawColor( Color(0,0,50,255) )
                    surface.SetMaterial( AKPL.Gradient )
                    surface.DrawTexturedRect( pos.x, pos.y, 50, 15 )
                    draw.SimpleText( text, "DermaDefault", pos.x + 5, pos.y + 6, color, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
                end
            end
        end
    end
end)


makeHook( "CalcView", function( ply, pos, angles, fov )
	if ss.tps then
        local view = {
            origin = pos - ( angles:Forward() * 100 ),
            angles = angles,
            fov = fov,
            drawviewer = true
        }

        return view
    end
end )

hook.Add("SetupWorldFog", "nightmode", function()
	if ss.nightmode then
        render.FogMode( 1 )
        render.FogColor( 0, 0, 0 )
        render.FogStart(0)
        render.FogEnd(0 * 100)
        render.FogMaxDensity( 0.9 )
        return true
    end
end)
hook.Add("SetupSkyboxFog", "nightmode", function()
    if ss.nightmode then
        render.FogMode( 1 )
        render.FogColor( 0, 0, 0 )
        render.FogStart(0)
        render.FogEnd(0 * 7)
        render.FogMaxDensity( 0.9 )
        return true
    end
end)
local function DEG2RAD(x) return x * math.pi / 180 end
local function RAD2DEG(x) return x * 180 / math.pi end

local rainbow = 0.00
local rotationdegree = 0.000;

local function hsv2rgb(h, s, v, a)
    local r, g, b

    local i = math.floor(h * 6);
    local f = h * 6 - i;
    local p = v * (1 - s);
    local q = v * (1 - f * s);
    local t = v * (1 - (1 - f) * s);

    i = i % 6

    if i == 0 then r, g, b = v, t, p
    elseif i == 1 then r, g, b = q, v, p
    elseif i == 2 then r, g, b = p, v, t
    elseif i == 3 then r, g, b = p, q, v
    elseif i == 4 then r, g, b = t, p, v
    elseif i == 5 then r, g, b = v, p, q
    end

    return r * 255, g * 255, b * 255, a * 255
end

local function draw_svaston(x, y, size)
    local frametime = FrameTime()
    local a = size / 60
    local gamma = math.atan(a / a)
    rainbow = rainbow + (frametime * 0.5)
    if rainbow > 1.0 then rainbow = 0.0 end
    if rotationdegree > 89 then rotationdegree = 0 end

    for i = 0, 4 do
        local p_0 = (a * math.sin(DEG2RAD(rotationdegree + (i * 90))))
        local p_1 = (a * math.cos(DEG2RAD(rotationdegree + (i * 90))))
        local p_2 =((a / math.cos(gamma)) * math.sin(DEG2RAD(rotationdegree + (i * 90) + RAD2DEG(gamma))))
        local p_3 =((a / math.cos(gamma)) * math.cos(DEG2RAD(rotationdegree + (i * 90) + RAD2DEG(gamma))))

        surface.SetDrawColor(hsv2rgb(rainbow,1, 1, 1))
        surface.DrawLine(x, y, x + p_0, y - p_1)
        surface.DrawLine(x + p_0, y - p_1, x + p_2, y - p_3)
    end
    rotationdegree = rotationdegree + (frametime * 150)
end

hook.Add("SHUDPaint","1",function()
    if ss.swasthair then
        local screenW, screenH = ScrW() ,ScrH()
        draw_svaston(screenW / 2, screenH / 2, screenH /2)
    end
end)

local weaponparams = {
    ["$basetexture"] = "sprites/physbeam",
    ["$nodecal"] = 1,
    ["$model"] = 1,
    ["$additive"] = 1,
    ["$nocull"] = 1,
    Proxies = {
        TextureScroll = {
            texturescrollvar = "$basetexturetransform",
            texturescrollrate = 0.4,
            texturescrollangle = 70,
        }
    }
}

local armparams = {
    ["$basetexture"] = "models/inventory_items/dreamhack_trophies/dreamhack_star_blur",
    ["$nodecal"] = 1,
    ["$model"] = 1,
    ["$additive"] = 1,
    ["$nocull"] = 1,
    Proxies = {
        TextureScroll = {
            texturescrollvar = "$basetexturetransform",
            texturescrollrate = 0.2,
            texturescrollangle = 50,
        }
    }
}


local IsDrawingGlow = false
local Glow = CreateMaterial("edgeglow","UnlitGeneric",weaponparams)
local GlowTwo = CreateMaterial("edgeglow2","UnlitGeneric", armparams)

hook.Add("PreDrawViewModel", "PreViewModelChams", function()
    if ss.animcham then
        render.SuppressEngineLighting(true)
        if IsDrawingGlow then
            render.SetColorModulation(1, 5, 20)
            render.MaterialOverride(Glow)
        else
            render.SetColorModulation(1, 1, 1)
        end
        render.SetBlend(1)
    end
end)

hook.Add("PostDrawViewModel", "PostViewModelChams", function()
    if ss.animcham then
        render.SetColorModulation(1, 1, 1)
        render.MaterialOverride(None)
        render.SetBlend(1)
        render.SuppressEngineLighting(false)

        if IsDrawingGlow then return end

        IsDrawingGlow = true
        LocalPlayer():GetViewModel():DrawModel()
        IsDrawingGlow = false
    end
end)

local atttime = 0.2

local lastwep = LocalPlayer():GetActiveWeapon()

local function propkill()

    if LocalPlayer():GetActiveWeapon():GetClass() ~= "weapon_physgun" then
        RunConsoleCommand("use", "weapon_physgun")
        timer.Simple(0.3, function()
            RunConsoleCommand("use", lastwep:GetClass())
        end)
    end


    hook.Add("CreateMove", "PKill", function(cmd)
        cmd:SetMouseWheel(100)
    end)

    RunConsoleCommand("gm_spawn", "models/props_c17/concrete_barrier001a.mdl")


    timer.Simple(atttime, function()
        RunConsoleCommand("+attack")
    end)

    timer.Simple(atttime + .1, function()
        RunConsoleCommand("-attack")
    end)

    timer.Simple(0.5, function()
        hook.Remove("CreateMove", "PKill")
        RunConsoleCommand("undo")
    end)
end


concommand.Add("ss_pkill", propkill)

surface.CreateFont("45", {font = "Bahnschrift", extended = false, size = 30, weight = 1000, antialias = true})
surface.CreateFont(
    "56",
    {font = "Bahnschrift", extended = false, size = 30, blursize = 4, weight = 1000, antialias = true}
)
local a = {}
hook.Add("SHUDPaint", "123", function()
    if ss.hitmarker then
        local b = {}
            for c, d in pairs(a) do
                cam.Start3D()
                local e = d.pos:ToScreen()
                local f = e.x
                local g = e.y
                cam.End3D()
                cam.Start2D()
                surface.SetFont("56")
                local h = surface.GetTextSize(tostring(d.num))
                surface.SetTextColor(0, 0, 0, 255 * d.life)
                surface.SetTextPos(f - h / 2, g)
                surface.DrawText(tostring(d.num))
                surface.SetFont("45")
                surface.SetTextColor(255, 255 - d.num, 255 - d.num, 255 * d.life)
                surface.SetTextPos(f - h / 2, g)
                surface.DrawText(tostring(d.num))
                d.pos = d.pos + Vector(0, 0, RealFrameTime() * 32)
                d.pos = d.pos + d.vec * RealFrameTime() * 8
                d.life = d.life - RealFrameTime() * 1 / 0.75
                if d.life > 0 then
                    table.insert(b, d)
                end
                cam.End2D()
            end
            a = b
        end
    end
)
gameevent.Listen("player_hurt")
hook.Add("player_hurt", "11", function(i)
    if ss.hitmarker then
            local j = 0
            for d, l in pairs(player.GetAll()) do
                if l:UserID() == i.userid then
                    entt = l
                    j = l:Health()
                end
                if l:UserID() == i.attacker then
                    k = l
                end
            end
            if entt:Health() == 0 then
                return
            end
            if not k == LocalPlayer() then
                return
            end
            local k = entt:GetPos() + Vector(0, 0, 60)
            local m = string.Replace(i.health - j, "-", "")
            m = math.Round(m, 1)
            table.insert(a, {pos = k, life = 1, num = m, vec = VectorRand()})
        end
    end
)

hook.Add("Think","z",function()
    if ss.rainbowphys then
        local RainbowPlayer=HSVToColor(CurTime()% 6*60,1,1) LocalPlayer():SetWeaponColor(Vector(RainbowPlayer.r/255,RainbowPlayer.g/255,RainbowPlayer.b/255)) LocalPlayer():SetPlayerColor(Vector(RainbowPlayer.r/255,RainbowPlayer.g/255,RainbowPlayer.b/255))
    end
end)

local FPS_table = {}
local MS_table = {}
Max_fps_nodes = 40
Max_ms_nodes = 40
FPS_inc = 0

makeHook("SHUDPaint", function()
    if ss.getgood then
        FPS_get = (1/FrameTime())
        MS_get = LocalPlayer():Ping()

        if FPS_get > FPS_inc then FPS_inc = FPS_inc + 0.5 elseif FPS_get < FPS_inc then FPS_inc = FPS_inc - 1 end

        surface.SetDrawColor( 255,255,255,255 )
        surface.DrawRect( ScrW()/1.115, ScrH()/1.383, Max_fps_nodes * 5,300)

        surface.SetDrawColor( 50,50,50,255 )
        surface.DrawRect( ScrW()/1.115, ScrH()/1.42, Max_fps_nodes * 5,20)

        surface.SetDrawColor( 50,50,50,255 )
        surface.DrawRect( ScrW()/1.115, ScrH()/1.35, 20,1)

        surface.SetDrawColor( 50,50,50,255 )
        surface.DrawRect( ScrW()/1.115, ScrH()/1.35 + 115, 20,1)

        surface.SetFont( "Default" )
        surface.SetTextColor( 50,50,50,255 )
        surface.SetTextPos( ScrW()/1 - 20, ScrH()/1.35)
        surface.DrawText("250")

        surface.SetFont( "Default" )
        surface.SetTextColor( 50,50,50,255 )
        surface.SetTextPos( ScrW()/1 - 20, ScrH()/1.35 + 115)
        surface.DrawText("150")

        for k,v in pairs( FPS_table ) do

            surface.SetDrawColor( 50,50,50,255 )
            surface.DrawRect( ScrW()/1 + -k*5, ScrH()/1 - v, 5,5 + v)

            surface.SetFont( "TargetIDSmall" )
            surface.SetTextColor( 255,255,255,255 )
            surface.SetTextPos( ScrW()/1.11, ScrH()/1.4155)
            surface.DrawText("FPS "..math.Round(FPS_inc))

        end

        for k,v in pairs( MS_table ) do

            surface.SetDrawColor( 200,200,200,255 )
            surface.DrawRect( ScrW()/1 + -k*5, ScrH()/1 - v, 5,5 + v)

            surface.SetFont( "TargetIDSmall" )
            surface.SetTextColor( 255,255,255,255 )
            surface.SetTextPos( ScrW()/1.07, ScrH()/1.4155)
            surface.DrawText(" |    Ms "..math.Round(MS_get))

        end
    end


end)

timer.Create("timerinc",0.1, 0, function()
    if ss.getgood then
        table.insert(FPS_table,1,math.Clamp(FPS_get,0,300))

        if table.Count(FPS_table) > Max_fps_nodes then
        table.remove(FPS_table)
        end
    end
end)
timer.Create("timerms",0.1, 0, function()
    if ss.getgood then
        table.insert(MS_table,1,math.Clamp(MS_get,0,300))

        if table.Count(MS_table) > Max_ms_nodes then
        table.remove(MS_table)
        end
    end
end)

--thanks times hack lol

 print("\n")
 MsgC(Color(61, 149, 217), " ¦¦¦¦¦¦¦+¦¦+¦¦¦¦¦+¦¦¦¦¦¦¦+¦¦¦¦¦¦¦¦¦¦¦+¦¦¦¦¦¦+¦¦¦+¦¦¦¦¦\n¦¦+----+¦¦¦¦¦¦¦¦¦¦¦+----+¦¦¦¦¦¦+----+¦¦+--¦¦+¦¦¦¦¦¦¦¦\n+¦¦¦¦¦+¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦+¦¦¦¦+¦¦¦¦¦+¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦\n¦+---¦¦+¦¦¦¦¦¦¦¦¦¦¦¦¦¦+¦¦+¦¦¦¦+---¦¦+¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦\n¦¦¦¦¦¦+++¦¦¦¦¦¦+++¦¦¦¦¦¦++¦¦+¦¦¦¦¦¦+++¦¦¦¦¦++¦¦¦¦¦¦¦+\n+-----+¦¦+-----+¦¦+-----+¦+-++-----+¦¦+----+¦+------+\n")

 notification.AddLegacy("sug.sol loaded, have fun. Check console for info!", NOTIFY_HINT, 5)
 surface.PlaySound( "buttons/button15.wav" )
