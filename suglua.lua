MsgC(Color(255,0,0), [[
_-.    _.._ _.-'`                         Sugoma.Solutions
.-; \ \-'`    ` _..-'                      monkey hook
_.-\_\-'`__...__..'
-'   __.--'` /
_.'`   \_ _/                               not skid no skid
 |  \
 ;   \    .-'```'-.
  \"  \  /   "   " \
   \"  \| ".--.--.  |
    \_  ; / _   _ \ ;                      https://sugoma.solutions/
     | ( (  e _ e  ) )
      \ '-|   T   |-'_
       \" \   =   /"  `\
        \  '-...-' ,  " \
         Y  "    "  \    \
         |"  .     " \  " \
         |      " _.-'   " )
         \ "/\._;'    "_.;`
          \_\_\.> ".''`  |
          /_/|_) .'    " /---..
           \ '--'    "     "   `\
      .-""-.>     "       ,   "  |
     / "      "       "    |     /
     \   "  \  " _.`--...-'|   "/
      '."    \.-'         / " .'
        '-. " \       __.'  .'
           )   `\    (_   "(
          /   /\_)     `\   \
         (((_/           \_)))


]])

print([[
Sugoma is cool cheat made by marge(STEAM_0:0:556353067) with help from big cool dude s0lum!
Sugoma better then mamaphine.solution dont worry too much visual hack for you 8)
To open menu do ss_menu in console and to edit colors open your context menu!

IF IN THE MENU IT SAYS (SG) IT IS SCREENGRABABLE

]])

local ss = {
    bhop = false,
    autostrafe = true,
    txtespPLAYER = true,
    txtespPROP = false,
    chams = false,
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
    watermark = false,
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
    glow = false,
    boxesphealth = false,
    boxesps = true,
    keypads = false,
    fire = false,
    aimkey = KEY_DOWN, --place holder cuz nobody uses this key
    swasthair = false,
    animcham = false,
    hitmarker = false,
    hitsound = false,
    rainbowphys = false,
    material = 'models/debug/debugwhite',
    aimpos = 'eyes',
    fov = 120,
}

local midW, midH = ScrW() / 2, ScrH() / 2
lply = LocalPlayer()

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

local function makelabel(name, string, font, w, h, x, y, color, parent)
  local name = vgui.Create( "DLabel", parent )
  name:SetPos( x, y )
  name:SetSize( w, h)
  name:SetColor(color)
  name:SetFont(font)
  name:SetText(string)
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

local function checkbox( name, tooltip, val, x, y, parent )
    local checkbox = vgui.Create( 'DCheckBoxLabel', parent )
    checkbox:SetText(name)
    checkbox:SetPos( x, y )
    checkbox:SetFont('DermaDefault')
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
        draw.SimpleText(name, 'DermaDefault', 10, 0, colors.white, 0, 0)
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
        colorbox:Dock(FILL)
        colorbox:SetPalette(false)
        colorbox:SetAlphaBar(false)
        colorbox:SetWangs(false)
        colorbox:SetColor(Color(30,100,160))
    function colorbox:Paint()
        DrawRect(self, colors.newblue, Color(52,61,70), self:GetWide() / 2, self:GetTall(), 7)
    end

    function colorbox:ValueChanged( col )
        ss[val] = col
    end

end

surface.CreateFont( "titles", {
    font = "coolvetica",extended = false,size = 25,weight = 750,blursize = 0,scanlines = 0,antialias = true,underline = false,italic = false,
    strikeout = false,symbol = false,rotary = false,shadow = false,additive = false,outline = true,
} )
surface.CreateFont( "Specialneeds2", {
    font = "Arial",extended = false,size = 13,weight = 500,blursize = 0,scanlines = 0,antialias = true,underline = false,italic = false,
    strikeout = false,symbol = false,rotary = false,shadow = false,additive = false,outline = false,
} )
surface.CreateFont( "Propsenseamon", {
    font = "Arial",extended = false,size = 20,weight = 200,blursize = 0,scanlines = 0,antialias = true,underline = false,italic = false,
    strikeout = false,symbol = false,rotary = false,shadow = false,additive = false,outline = false,
} )

surface.CreateFont( "boosls", {
    font = "Arial",extended = false,size = 14,weight = 200,blursize = 0,scanlines = 0,antialias = true,underline = false,italic = false,
    strikeout = false,symbol = false,rotary = false,shadow = false,additive = false,outline = false,
} )

surface.CreateFont( "booslssd", {
    font = "Arial",extended = false,size = 16,weight = 200,blursize = 0,scanlines = 0,antialias = true,
    underline = false,italic = false,strikeout = false,symbol = false,rotary = false,shadow = false,additive = false,outline = false,
} )

surface.CreateFont( "Propsenseamon2", {
    font = "Arial",extended = false,size = 20,weight = 400,blursize = 0,scanlines = 0,antialias = true,underline = false,italic = false,
    strikeout = false,symbol = false,rotary = false,shadow = false,additive = false,outline = false,
} )

surface.CreateFont( "infos", {
    font = "coolvetica",extended = true,size = 25,weight = 100,blursize = 0,scanlines = 0,antialias = false,underline = false,italic = false,
    strikeout = false,symbol = false,rotary = false,shadow = false,additive = false,outline = false,
} )

surface.CreateFont( "infotitle", {
    font = "coolvetica",extended = false,size = 25,weight = 100,blursize = 0,scanlines = 0,antialias = true,underline = false,italic = false,
    strikeout = false,symbol = false,rotary = false,shadow = false,additive = false,outline = false,
} )

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


    end

    local PropertySheet = vgui.Create( "DColumnSheet", menuderma )
    PropertySheet:SetPos( 10, 45 )
    PropertySheet:SetSize( 710, 470 )
    PropertySheet.Paint = function( self, w, h ) draw.RoundedBox( 0, 0, 0, w, h, Color( 40, 40, 40, self:GetAlpha() ) ) end

    local panel1 = vgui.Create( "DPanel", PropertySheet )
    panel1:Dock( FILL )
    panel1.Paint = function( self, w, h )
      draw.RoundedBox( 4, 0, 0, w, h, Color( 30, 30, 30, self:GetAlpha() ) )
      surface.SetDrawColor(255,255,255,255)
      surface.DrawOutlinedRect( 10, 20, 350, 450, 2 )
      surface.DrawOutlinedRect( 370, 20, 215, 450, 2 )
      draw.DrawText( "Self", "DermaDefault", 10, 5, Color( 255, 255, 255, 255 ), 0 )
      draw.DrawText( "Others", "DermaDefault", 370, 5, Color( 255, 255, 255, 255 ), 0 )
    end
    PropertySheet:AddSheet( "Visuals", panel1, "icon16/photo.png" )

    local panel2 = vgui.Create( "DPanel", PropertySheet )
    panel2:Dock( FILL )
    panel2.Paint = function( self, w, h )
      draw.RoundedBox( 4, 0, 0, w, h, Color( 30, 30, 30, self:GetAlpha() ) )
      surface.SetDrawColor(255,255,255,255)
      surface.DrawOutlinedRect( 10, 20, 350, 450, 2 )
      surface.SetDrawColor(0,255,0,255)
      surface.DrawOutlinedRect( 410, 120, 107.5, 225, 1 )
      draw.DrawText( "Name: "..lply:Name(), "DermaDefault", 410, 105, Color( 0, 255, 0, 255 ), 0 )
      draw.DrawText( "Misc", "DermaDefault", 10, 5, Color( 255, 255, 255, 255 ), 0 )
    end
    PropertySheet:AddSheet( "Misc", panel2, "icon16/pill.png" )

    local guy = vgui.Create( "DModelPanel", panel2 )
    guy:SetSize( 200, 400 )
    guy:SetPos(380, 25)
    guy:SetModel( "models/player/hostage/hostage_04.mdl" )
    function guy:LayoutEntity( ent )
        if ss.gdance then
            ent:SetSequence( ent:LookupSequence( "taunt_laugh" ) )
            if( ent:GetCycle() > 0.97 ) then ent:SetCycle( 0.02 ) end
            guy:RunAnimation()
        end
    end

    local panel3 = vgui.Create( "DPanel", PropertySheet )
    panel3:Dock( FILL )
    panel3.Paint = function( self, w, h )
      draw.RoundedBox( 4, 0, 0, w, h, Color( 30, 30, 30, self:GetAlpha() ) )
      surface.SetDrawColor(255,255,255,255)
      surface.DrawOutlinedRect( 235, 20, 350, 450, 2 )
      surface.DrawOutlinedRect( 10, 20, 215, 450, 2 )
      draw.DrawText( "Toggles", "DermaDefault", 10, 5, Color( 255, 255, 255, 255 ), 0 )
      draw.DrawText( "Customization", "DermaDefault", 235, 5, Color( 255, 255, 255, 255 ), 0 )
    end
    PropertySheet:AddSheet( "Aimbot", panel3, "icon16/user.png" )

    local panel4 = vgui.Create( "DPanel", PropertySheet )
    panel4:Dock( FILL )
    panel4.Paint = function( self, w, h )
      draw.RoundedBox( 4, 0, 0, w, h, Color( 30, 30, 30, self:GetAlpha() ) )
      surface.SetDrawColor(255,255,255,255)
      draw.DrawText( "Sliders", "DermaDefault", 10, 5, Color( 255, 255, 255, 255 ), 0 )
      surface.DrawOutlinedRect( 10, 20, 575, 450, 2 )
    end
    PropertySheet:AddSheet( "Sliders", panel4, "icon16/text_linespacing.png" )

    local panel5 = vgui.Create( "DPanel", PropertySheet )
    panel5:Dock( FILL )
    panel5.Paint = function( self, w, h )
      draw.RoundedBox( 4, 0, 0, w, h, Color( 30, 30, 30, self:GetAlpha() ) )
    end
    PropertySheet:AddSheet( "Colors", panel5, "icon16/ruby.png" )

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

    local ebutton = vgui.Create('DButton', panel1)
    ebutton:SetText('Entity Menu')
    ebutton:SetTextColor(colors.grey)
    ebutton:SetSize(100, 16)
    ebutton:SetPos(380, 330)
    function ebutton:DoClick()
          concommand.Run( LocalPlayer(), "entlist", 0, 0 )
    end
    function ebutton:Paint()
        draw.RoundedBox(5, 0, 0, self:GetWide(), self:GetTall(), colors.black)
    end


    -- end of VGUI start of checks and stuff
    checkbox("ESP:Player Chams(SG)", "Toggle Chams", 'chams', 380, 30, panel1 )
    checkbox("ESP:Prop Cham(SG)", "Toggle Prop Chams", 'pchams', 380, 45, panel1 )
    checkbox("ESP:Player Names", "Toggle Names", 'txtespPLAYER', 380, 60, panel1 )
    checkbox("ESP:Prop Names", "Toggle Prop Names", 'txtespPROP', 380, 75, panel1 )
    checkbox("ESP:Hitbox(SG)", "Player Hitbox", 'esp_hitboxes', 380, 90, panel1 )
    checkbox("ESP:Eye Tracer", "Trace enemy eyes", 'eyetrace', 380, 105, panel1 )
    checkbox("ESP:Head Circle", "its like circle", 'circlehead',380, 120, panel1 )
    checkbox("ESP:Skeleton", "Draw bones on model", 'skelly', 380, 135, panel1 )
    checkbox("ESP:3D Box", "Toggle Box Esp", 'box', 380, 150, panel1 )
    checkbox("ESP:3D Box Fill", "Fill 3D Box ESP", 'fillbox', 380, 165, panel1 )
    checkbox("ESP:2D Box", "Player boxes", 'boxesps', 380, 180, panel1 )
    checkbox("ESP:2D Box(Health)", "Player Boxes", 'boxesphealth', 380, 195, panel1 )
    checkbox("ESP:Ply Walls(SG)", "its like view", 'wallsx', 380, 210, panel1 )
    checkbox("ESP:Prop Walls(SG)", "its like view", 'wallsxp', 380, 225, panel1 )
    checkbox("ESP:Ply Flat(SG)", "Toggle PNames", 'chams_lighting', 380, 240, panel1 )
    checkbox("ESP:Prop Flat(SG)", "Toggle PNames", 'pchams_lighting', 380, 255, panel1 )
    checkbox("ESP:Glow(SG)", "its like glowing", 'glow',380, 270, panel1 )
    checkbox("CLI:Info", "its like debig", 'getgood', 20, 45, panel1 )
    checkbox("CLI:Watermark", "its like mark", 'watermark', 20, 30, panel1 )
    checkbox("CLI:Crosshair", "shootbox", 'crosshair', 20, 60, panel1 )
    checkbox("CLI:Swasthair", "its like german", 'swasthair', 20, 75, panel1 )
    checkbox("CLI:Animate Hand(SG)", "its like hand but anim", 'animcham', 20, 90, panel1 )
    checkbox("CLI:Hand Cham(SG)", "Toggle Hand Cham", 'hands', 20, 105, panel1 )
    checkbox("CLI:Gay Physgun(SG)", "its like raindno", 'rainbowphys', 20, 120, panel1 )
    checkbox("CLI:ThirdPerson(SG)", "its like view", 'tps', 20, 135, panel1 )
    checkbox("CLI:Menu Animate", "its like dance", 'gdance', 20, 150, panel1 )
    checkbox("CLI:Nightmode(SG)", "its like night", 'nightmode', 20, 165, panel1 )
    checkbox("CLI:Grabber", "its like grab pred", 'grabber', 20, 180, panel1 )
    local ptbox = vgui.Create( 'DComboBox', panel1 )
    ptbox:SetPos( 380, 300 )
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
    checkbox("MSC:Keypad Logger", "its like Keypads", 'keypads', 20, 30, panel2 )
    checkbox("MSC:Legit Bhop", "Toggle Bhop", 'bhop', 20, 45, panel2 )
    checkbox("MSC:Hitmarker", "Player Hitmark", 'hitmarker', 20, 90, panel2 )
    checkbox("MSC:Hitsound", "Player Hitsound", 'hitsound', 20, 75, panel2 )
    checkbox("MSC:Rage Bhop", "Toggle Autostrafe", 'autostrafe', 20, 60, panel2 )
    checkbox("AIM:Fire", "Toggle Aimbot fire", 'fire', 20, 30, panel3 )
    makelabel("aimkes", "Aimbot Key:", 'Specialneeds2', 100, 10, 245, 30, colors.white, panel3)
    local binder = vgui.Create( "DBinder", panel3 )
    binder:SetSize( 40, 15 )
    binder:SetPos( 305, 30 )
    binder:SetText('key')
    function binder:Paint()
        DrawRect(self, colors.darkgrey, colors.white, self:GetWide(), self:GetTall())
    end
    function binder:OnChange( num )
        LocalPlayer():ChatPrint("Aimbot bound to: "..input.GetKeyName( num )) ss.aimkey = num
    end
    slider( "SLI:CLI:FOV", "fov", 1, 170, 20, 30, 190, 20, panel4)
    slider( "SLI:ESP:Ply  A", "chams_a", 1, 255, 20, 45, 190, 20, panel4)
    slider( "SLI:ESP:Prop A", "pchams_a", 1, 255, 20, 60, 190, 20, panel4)
    colorthing('chams_col', 20, 30, 150, 150, panel5)
    colorthing('pchams_col', 20, 200, 150, 150, panel5)
    colorthing('hchams_col', 360, 30, 150, 150, panel5)
    colorthing('box_col', 190, 30, 150, 150, panel5)
    colorthing('glow_col', 190, 200, 150, 150, panel5)
    colorthing('menu_col', 360, 200, 150, 150, panel5)
    makelabel("pcham", "Player Chams", 'Specialneeds2', 230, 30, 20, 10, colors.white, panel5)
    makelabel("pbox", "Box", 'Specialneeds2', 230, 30, 190, 10, colors.white, panel5)
    makelabel("prcham", "Props Chams", 'Specialneeds2', 230, 30, 20, 180, colors.white, panel5)
    makelabel("glsa", "Glow", 'Specialneeds2', 230, 30, 190, 180, colors.white, panel5)
    makelabel("hao", "Hands and Others", 'Specialneeds2', 230, 30, 360, 10, colors.white, panel5)
    makelabel("mens", "Menu", 'Specialneeds2', 230, 30, 360, 180, colors.white, panel5)
    local DLabelw = vgui.Create( "DLabel", menuderma )
    DLabelw:SetPos( 20, -78 )
    DLabelw:SetSize( 200, 200)
    DLabelw:SetColor(colors.white)
    DLabelw:SetFont('titles')
    DLabelw:SetText( "sug.sol | " )
    local DLabelw = vgui.Create( "DLabel", menuderma )
    DLabelw:SetPos( 105, -78 )
    DLabelw:SetSize( 200, 200)
    DLabelw:SetColor( Color(ss.menu_col.r, ss.menu_col.g, ss.menu_col.b) )
    DLabelw:SetFont('titles')
    DLabelw:SetText( LocalPlayer():Name() )
end
concommand.Add('ss_menu', SUGUI)


--not my ent list 8)
local showing = true

concommand.Add("ShowEnts", function()
	if showing then
		showing = false
	else
		showing = true
	end
end)
local EntsToShow = {}
local OtherEnts = {}
concommand.Add("entlist", function(ply, cmd, args)
	function Reload(startX, startY)
		table.Empty(OtherEnts)
		for k,v in pairs(ents.GetAll()) do
			local addToAllEnts = true

			for i,p in pairs(EntsToShow) do
				if p == v:GetClass() then
					addToAllEnts = false
				end
			end

			for i,p in pairs(OtherEnts) do
				if p == v:GetClass() then
					addToAllEnts = false
				end
			end

			if addToAllEnts then
				table.insert(OtherEnts, v:GetClass())
			end
		end
		local main = vgui.Create( "DFrame" )
		main:SetSize( 400, 250 )
		if startX and startY then
			main:SetPos(startX, startY)
		else
			main:Center()
		end
		main:SetTitle( "" )
		main:SetVisible( true )
		main:SetDraggable( true )
		main:ShowCloseButton( false )
		main:MakePopup()
		main.Paint = function()
			draw.RoundedBox( 8, 0, 0, main:GetWide(), main:GetTall(), Color( 40, 40, 40, 255 ) )
		end
    local cbutton2 = vgui.Create('DButton', main)
    cbutton2:SetText('')
    cbutton2:SetTextColor(colors.black)
    cbutton2:SetSize(16, 16)
    cbutton2:SetPos(375, 5)
    function cbutton2:DoClick()
        main:Close()
    end
    function cbutton2:Paint()
        draw.RoundedBox(5, 0, 0, self:GetWide(), self:GetTall(), colors.red)
    end
		DermaList = vgui.Create( "DPanelList", main )
		DermaList:SetPos( 25,25 )
		DermaList:SetSize( 700, 500 )
		DermaList:SetSpacing( 75 )
		DermaList:EnableHorizontal( false )
		DermaList:EnableVerticalScrollbar( true )
		local SelectedEnts = vgui.Create("DListView")
		SelectedEnts:SetSize(150, 200)
		SelectedEnts:SetPos(0, 0)
		SelectedEnts:SetMultiSelect(false)
		SelectedEnts:AddColumn("Ents to show")
		for k,v in pairs(EntsToShow) do
			SelectedEnts:AddLine(v)
		end
		SelectedEnts.DoDoubleClick = function(parent, index, list)
			table.remove(EntsToShow, index)
			main:Close()
			local x, y = main:GetPos()
			Reload(x, y)
		end
		DermaList:Add(SelectedEnts)
		local AllEnts = vgui.Create("DListView")
		AllEnts:SetSize(150, 200)
		AllEnts:SetPos(200, 0)
		AllEnts:SetMultiSelect(false)
		AllEnts:AddColumn("Ents not to show")
		for k,v in pairs(OtherEnts) do
			AllEnts:AddLine(v)
		end
		AllEnts.DoDoubleClick = function(parent, index, list)
			table.insert(EntsToShow, OtherEnts[index])
			main:Close()
			local x, y = main:GetPos()
			Reload(x, y)
		end
		DermaList:Add(AllEnts)
	end
	Reload()
end)
makeHook("SHUDPaint", function()
	if showing then
		for k,v in pairs(ents.GetAll()) do
			local drawing = false

			for i,p in pairs(EntsToShow) do
				if v:GetClass() == p then
					drawing = true
				end
			end

			if drawing then
				local stuff = v:GetPos():ToScreen()

				surface.SetTextPos( stuff.x - 15, stuff.y )
				surface.SetFont("default")
				local text = v:GetClass()
				surface.DrawText( text )

				local Width, Height = surface.GetTextSize(text)

				surface.SetDrawColor( 255, 0, 0, 255)
				surface.DrawOutlinedRect( stuff.x - 20, stuff.y, Width + 10, Height + 5)
			end
		end
	end
end)

local function bhop(cmd)
    if LocalPlayer():GetMoveType() == MOVETYPE_NOCLIP or LocalPlayer():InVehicle() or LocalPlayer():GetMoveType() == 8 then return end
    if cmd:CommandNumber() ~= 0 then
        if not LocalPlayer():IsOnGround() and cmd:KeyDown(IN_JUMP) then cmd:RemoveKey(IN_JUMP) end
    end
end

local origAngle = Angle(0,0,0)
makeHook("CreateMove",function(ucmd)
  if ss.autostrafe then
    if(!IsValid(LocalPlayer())) then return end
    if (!origAngle) then origAngle = ucmd:GetViewAngles() end
    origAngle = (origAngle + Angle(ucmd:GetMouseY() * 0.023, ucmd:GetMouseX() * -0.023, 0))
    origAngle.p, origAngle.y, origAngle.x = math.Clamp(origAngle.p, -89, 89), math.NormalizeAngle(origAngle.y), math.NormalizeAngle(origAngle.x)

    if(ucmd:CommandNumber() == 0) then
        ucmd:SetViewAngles(origAngle)
        return
    end
    if(!input.IsKeyDown(KEY_SPACE) or LocalPlayer():IsOnGround()) then return end
    ucmd:RemoveKey(IN_JUMP)
    if(engine.TickCount() % 2 == 0) then
        ucmd:SetSideMove(10000)
        ucmd:SetViewAngles(LerpAngle(0.6,ucmd:GetViewAngles(),Angle(0,origAngle.y + 3,0)))
    else
        ucmd:SetSideMove(-10000)
        ucmd:SetViewAngles(LerpAngle(0.6,ucmd:GetViewAngles(),Angle(0,origAngle.y - 3,0)))
    end
  end
end)

makeHook("CreateMove", function(cmd)
    if ss.bhop then bhop(cmd) end
end)

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
makeHook("CalcView", function( p, o, a, f )
    local view = {}
    local fov = ss.fov - ( GetConVar ("fov_desired"):GetFloat() - f )
    view.fov = fov
    return view
end)

local function sdrawtext( string, font,  x, y, color )
      surface.SetFont( font )
      surface.SetTextColor( color )
      surface.SetTextPos( x,y )
      surface.DrawText( string )
end
makeHook("Think", function()
    health = lply:Health()
    armor = lply:Armor()
    kills = lply:Frags()
    deaths = lply:Deaths()
    velocity = math.Round(lply:GetVelocity():Length())
    playerlist = player.GetCount()
    fps = math.floor(1 / FrameTime())
    --Ping
end)

local function watermark()
        if ss.watermark then
            draw.RoundedBox(0,1746,6,155+8 , 25 + 8,Color(90,90,90))
            draw.RoundedBox(0,1750,10,155,25,Color(25,25,25))
            DrawText(Color(255, 255, 255),1760, 12,"Sugoma.Solutions","Propsenseamon")
        end
    end

local function infoshow()
        if ss.getgood then
          draw.RoundedBox( 5, 10, 10, 200, 40, Color(30,30,30))
            draw.RoundedBox( 5, 10, 10, 200, 350, Color(30,30,30,230))
            draw.RoundedBox( 0, 10, 50, 200, 2, Color(255,255,255))
            sdrawtext("Info", "infotitle", 200/2-5, 25, Color(255,255,255))
            local healthColor = math.Clamp(lply:Health(), 0, 100)
            sdrawtext("Health", "infos", 15, 60, Color(255,255,255))
            sdrawtext(health, "infos", 80, 60, HSVToColor( healthColor / 100 * 120, 1, 1 ))
            sdrawtext("Armor:", "infos", 15, 95, Color(255,255,255))
            local armorColor = math.Clamp(lply:Armor(), 100, 100)
            sdrawtext(armor, "infos", 80, 95, HSVToColor(armorColor / 100 * 56,225,225))
            sdrawtext("Kills:", "infos", 15, 130, Color(255,255,255))
            sdrawtext(kills, "infos", 55, 130, Color(255,255,255))
            sdrawtext("Deaths:", "infos", 15, 165, Color(255,255,255))
            sdrawtext(deaths, "infos", 85, 165, Color(255,255,255))
            sdrawtext("Velocity:", "infos", 15, 200, Color(255,255,255))
            sdrawtext(velocity, "infos", 95, 200, Color(255,255,255))
                if velocity >= 1000 then
                    sdrawtext(velocity, "infos", 95, 200, HSVToColor((CurTime() * 300 ) % 360, 1, 1 ))
                end
            sdrawtext("FPS:", "infos", 15, 235, Color(255,255,255))
            sdrawtext(fps, "infos", 59, 235, Color(255,255,255))
                if fps <= 60 then
                    sdrawtext(fps, "infos", 59, 235, Color(255,0,0))
                end
            sdrawtext("Ping:", "infos", 15, 270, Color(255,255,255))
            sdrawtext(lply:Ping(), "infos", 61, 270, Color(255,255,255))
            sdrawtext("Players:", "infos", 15, 305, Color(255,255,255))
            sdrawtext(playerlist, "infos", 88, 305, Color(255,255,255))
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
end)

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

makeHook("CreateMove", function(cmd)
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
                --render.SetColorModulation(1, 1, 1)
                --render.SetMaterial( whitemat )
                render.SuppressEngineLighting(false)
            cam.End3D()
        end
    end
end)


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

makeHook("SetupWorldFog", function()
	if ss.nightmode then
        render.FogMode( 1 )
        render.FogColor( 0, 0, 0 )
        render.FogStart(0)
        render.FogEnd(0 * 100)
        render.FogMaxDensity( 0.9 )
        return true
    end
end)
makeHook("SetupSkyboxFog", function()
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

makeHook("SHUDPaint", function()
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

makeHook("PreDrawViewModel", function()
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

makeHook("PostDrawViewModel", function()
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


    makeHook("CreateMove", function(cmd)
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
makeHook("SHUDPaint", function()
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
makeHook("player_hurt", function(i)
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

makeHook("Think", function()
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

concommand.Add( "neofetch", function()

		MsgC(Color(255,0,0), [[
            __,__
   .--.  .-"     "-.  .--.      Cheat: Sugoma Solutions v2
  / .. \/  .-. .-.  \/ .. \     Kernel: your mother
 | |  '|  /   Y   \  |'  | |    Uptime: idk you tell me
 | \   \  \ 0 | 0 /  /   / |    Packages: Who?
  \ '- ,\.-"`` ``"-./, -' /     Shell: Gmod console
   `'-' /_   ^ ^   _\ '-'`      Resolution: Asked
       |  \._   _./  |          Desktop Enviroment: Garry's mod
       \   \ `~` /   /          Memory: broke
        '._ '-=-' _.'
           '~---~'
    ]])

end)




--thanks times hack lol
 notification.AddLegacy("sug.sol loaded, have fun. Check console for info!", NOTIFY_HINT, 5)
 surface.PlaySound( "buttons/button15.wav" )
