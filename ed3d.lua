_G["ed3d"] = {}

ed3d.createD3DHook =
function()
   local dobj = createD3DHook()
   if dobj == nil then print("Failed to create D3DHook, make sure the game run directx9 or newer and dont forget to attch the game") return end
   while dobj.width == 0 do end

   dobj.p = {}
   dobj.p.guishow = false
   dobj.p.forms = {}
   dobj.p.fonts = {}
   dobj.p.maxzorder = 0

   if dobj.p.timer ~= nil then dobj.p.timer.destroy() end
   dobj.p.timer = createTimer(nil)
   dobj.p.timer.interval = 1;
   dobj.p.timer.enabled = false

   dobj.p.timerfunc = function(sender)
      local nowX, nowY = getMousePos()
      dobj.moveForm(dobj.p.mtarget,dobj.p.xxx + (nowX-dobj.p.xx),dobj.p.yyy +(nowY-dobj.p.yy))
   end

   dobj.p.timer.ontimer = dobj.p.timerfunc


   dobj.p.xx = 0
   dobj.p.yy = 0
   dobj.p.xxx = 0
   dobj.p.yyy = 0
   dobj.p.mtarget = ""

local cbactive = createFont()
cbactive.color = 0xffff00
cbactive.quality = 'fqNonAntialiased'
cbactive.size = 12
cbactive.name = "Courier New"

dobj.p.fonts.cbactive = cbactive

local cbdeactive = createFont()
cbdeactive.color = 0xdddd00
cbdeactive.quality = 'fqNonAntialiased'
cbdeactive.size = 12
cbdeactive.name = "Courier New"

dobj.p.fonts.cbdeactive = cbdeactive

local normal = createFont()
normal.color = 0xffff00
normal.quality = 'fqNonAntialiased'
normal.size = 12
normal.name = "Courier New"

dobj.p.fonts.normal = normal

   dobj.sayHello = function()
      print(dobj.width)
   end

   dobj.moveForm = function(name,x,y)
      for k,v in pairs (dobj.p.forms[name].components) do
         dobj.p.forms[name].components[k].x = x + dobj.p.forms[name].components[k].prop.subx
         dobj.p.forms[name].components[k].y = y + dobj.p.forms[name].components[k].prop.suby
      end
      dobj.p.forms[name].x = x
      dobj.p.forms[name].y = y
   end

   dobj.countForm = function()
      local c = 0
      for k,v in pairs(dobj.p.forms) do
         c = c + 1
      end
      return c + 1
   end

   dobj.createForm = function (name,caption,w,h)
      local pict = createPicture()
      pict.bitmap.width = w
      pict.bitmap.height = h
      pict.bitmap.canvas.brush.color = 0x0a0a00
      pict.bitmap.canvas.pen.color = 0xffff00
      pict.bitmap.canvas.fillRect(0,0,w,h)
      pict.bitmap.canvas.line(0,0,0,h)
      pict.bitmap.canvas.line(0,0,w,0)
      pict.bitmap.canvas.line(w-1,0,w-1,h-1)
      pict.bitmap.canvas.line(0,h-1,w-1,h-1)
      pict.bitmap.canvas.line(0,25,w,25)
      pict.bitmap.canvas.pen.color = 0x505000
      --//form background
      pict.bitmap.canvas.line(0,125,100,125)
      pict.bitmap.canvas.line(100,125,150,175)
      pict.bitmap.canvas.line(100,125,150,75)
      pict.bitmap.canvas.line(150,175,300,175)
      pict.bitmap.canvas.line(150,75,300,75)

      dobj.p.forms[name] = dobj.createSprite(dobj.createTexture(pict))
      dobj.p.forms[name].x = 50 + dobj.countForm() * 25
      dobj.p.forms[name].y = 50 + dobj.countForm() * 25
      dobj.p.forms[name].alphablend = 0.9
      dobj.p.forms[name].components = {}
      dobj.p.forms[name].caption = caption
      dobj.p.forms[name].dragMode = false
      dobj.p.forms[name].name = name
      dobj.p.maxzorder = dobj.p.forms[name].zorder

      dobj.p.forms[name].components.title =
         dobj.createTextContainer(dobj.createFontmap(dobj.p.fonts.normal),
         dobj.p.forms[name].x+10,dobj.p.forms[name].y+4,dobj.p.forms[name].caption)
      dobj.p.maxzorder = dobj.p.forms[name].zorder
      dobj.p.forms[name].components.title.prop = {}
      dobj.p.forms[name].components.title.prop.subx = 10
      dobj.p.forms[name].components.title.prop.suby = 4
   end

   dobj.getForm = function(name) return dobj.p.forms[name] end

   dobj.getComponent = function(name,formname)
      return dobj.getForm(formname).components[name]
   end

   dobj.createOnOffToggle = function(name,caption,formname,x,y)
      dobj.getForm(formname).components[name] =
         dobj.createTextContainer(dobj.createFontmap(dobj.p.fonts.cbdeactive),
         dobj.getForm(formname).x + x,
         dobj.getForm(formname).y + y,"[OFF] - "..caption)
      dobj.p.maxzorder = dobj.getComponent(name,formname).zorder
      dobj.getComponent(name,formname).prop = {}
      dobj.getComponent(name,formname).prop.checked = false
      dobj.getComponent(name,formname).prop.dobj = dobj
      dobj.getComponent(name,formname).prop.subx = x
      dobj.getComponent(name,formname).prop.suby = y
   end

   dobj.createButton = function(name,caption,formname,x,y)
      local pict = createPicture()
      local w = #caption * 11
      local h = 30

      pict.bitmap.width = w
      pict.bitmap.height = h

      pict.bitmap.canvas.brush.color = 0x0a0a00
      pict.bitmap.canvas.pen.color = 0xffff00
      pict.bitmap.canvas.fillRect(0,0,w,h)
      pict.bitmap.canvas.line(0,0,0,h)
      pict.bitmap.canvas.line(0,0,w,0)
      pict.bitmap.canvas.line(w-1,0,w-1,h-1)
      pict.bitmap.canvas.line(0,h-1,w-1,h-1)
      pict.bitmap.canvas.Font.color = 0xffff00
      pict.bitmap.canvas.Font.quality = 'fqNonAntialiased'
      pict.bitmap.canvas.Font.size = 12
      pict.bitmap.canvas.Font.name = "Courier New"
      pict.bitmap.canvas.textOut(6,5,caption)

      dobj.getForm(formname).components[name] = dobj.createSprite(dobj.createTexture(pict))
      dobj.getComponent(name,formname).x = dobj.getForm(formname).x + x
      dobj.getComponent(name,formname).y = dobj.getForm(formname).y + y
      dobj.getComponent(name,formname).prop = {}
      dobj.getComponent(name,formname).prop.subx = x
      dobj.getComponent(name,formname).prop.suby = y

      dobj.p.maxzorder = dobj.getComponent(name,formname).zorder
   end

   dobj.createLabel = function(name,caption,formname,x,y,size)
      local font = createFont()
      font.color = 0xffff00
      font.quality = 'fqNonAntialiased'
      font.size = size
      font.name = "Courier New"

      dobj.getForm(formname).components[name] =
         dobj.createTextContainer(dobj.createFontmap(font),
         dobj.getForm(formname).x + x,
         dobj.getForm(formname).y + y,caption)
      dobj.p.maxzorder = dobj.getComponent(name,formname).zorder
      dobj.getComponent(name,formname).prop = {}
      dobj.getComponent(name,formname).prop.subx = x
      dobj.getComponent(name,formname).prop.suby = y
   end

   dobj.countFormComponents = function(formname)
      local c = 0
      for i in pairs(dobj.getForm(formname).components) do
         c = c + 1
      end
      return c
   end

   dobj.formToTop = function(formname)
      local cc = 0
      for i in pairs(dobj.p.forms) do
         if i == formname then
            local s = dobj.p.maxzorder - dobj.countFormComponents(formname)
            dobj.p.forms[i].zorder = s
            local c = 1
            for ii in pairs(dobj.p.forms[i].components) do
               dobj.p.forms[i].components[ii].zorder = s + c
               c = c + 1
            end
         else
            dobj.p.forms[i].zorder = cc
            cc = cc + 1
            for ii in pairs(dobj.p.forms[i].components) do
               dobj.p.forms[i].components[ii].zorder = cc
               cc = cc + 1
            end
         end
      end
   end


   dobj.dragFormMode = function(formname,x,y,tf)
      if tf == true then
         dobj.formToTop(formname)
         dobj.p.xx, dobj.p.yy = getMousePos()
         dobj.getForm(formname).dragMode = true
         dobj.p.mtarget = formname
         dobj.p.xxx = dobj.getForm(formname).x
         dobj.p.yyy = dobj.getForm(formname).y
         dobj.p.timer.enabled = true
      else
         dobj.getForm(formname).dragMode = false
         dobj.p.timer.enabled = false
      end
   end

   dobj.formDragToggleClick = function(name,sender,x,y)
      if sender == dobj.getForm(name) or sender == dobj.getForm(name).components.title then
         sender = dobj.getForm(name)
         if sender.dragMode == false then
            dobj.dragFormMode(name,x,y,true)
         else
            dobj.dragFormMode(name,x,y,false)
         end
      end
   end

   dobj.setOnOffToggleState = function(name,formname,tf)
      if tf == true then
         dobj.getComponent(name,formname).fontmap = dobj.createFontmap(dobj.p.fonts.cbactive)
         dobj.getComponent(name,formname).prop.checked = true
         dobj.getComponent(name,formname).text = dobj.getComponent(name,formname).text:gsub("OFF","ON")
      elseif tf == false then
         dobj.getComponent(name,formname).fontmap = dobj.createFontmap(dobj.p.fonts.cbdeactive)
         dobj.getComponent(name,formname).prop.checked = false
         dobj.getComponent(name,formname).text = dobj.getComponent(name,formname).text:gsub("ON","OFF")
      end
   end

   dobj.OnOffToggleClicked = function(sender,cbname,formname,active,deactive)
      if sender == dobj.getComponent(cbname,formname) then
         sender = dobj.getComponent(cbname,formname)
         if sender.prop.checked == true then
            dobj.setOnOffToggleState(cbname,formname,false)
            deactive()
         else
            dobj.setOnOffToggleState(cbname,formname,true)
            active()
         end
      end
   end

   dobj.buttonClicked = function(sender,name,formname,active)
      if sender == dobj.getComponent(name,formname) then
         sender = dobj.getComponent(name,formname)
         active()
      end
   end
   dobj.guihideshow = function(kcode,vkey)
      if vkey == kcode then
         if dobj.p.guishow == true then
            dobj.p.guishow = false
            for i in pairs(dobj.p.forms) do
               dobj.p.forms[i].visible = false
               for ii in pairs(dobj.p.forms[i].components) do
                  dobj.p.forms[i].components[ii].visible = false
               end
            end
         else
            dobj.p.guishow = true
            for i in pairs(dobj.p.forms) do
               dobj.p.forms[i].visible = true
               for ii in pairs(dobj.p.forms[i].components) do
                  dobj.p.forms[i].components[ii].visible = true
               end
            end
         end
      end
   end

   return dobj
end
