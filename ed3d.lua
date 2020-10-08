_G["_D3D"] = {}
_G["ed3d"] = _G["_D3D"]

if ed3d.timer ~= nil then ed3d.timer.destroy() end
ed3d.timer = createTimer(nil)
ed3d.timer.interval = 1;
ed3d.timer.enabled = false

local xx,yy
local xxx,yyy
local mtarget

ed3d.timerfunc = function(sender)
   local nowX, nowY = getMousePos()
   ed3d.moveForm(mtarget,xxx + (nowX-xx),yyy +(nowY-yy))
end
ed3d.timer.ontimer = ed3d.timerfunc

ed3d.forms = {}

ed3d.guishow = true

ed3d.maxzorder = -1

ed3d.createD3DHook =
function()
   local dobj = createD3DHook()
   while dobj.width == 0 do end

   local pict = createPicture()
   pict.bitmap.width = dobj.width
   pict.bitmap.height = dobj.height

   local texture = dobj.createTexture(pict)
   return dobj
end

ed3d.moveForm = function(name,x,y)
   for k,v in pairs (ed3d.forms[name].components) do
      ed3d.forms[name].components[k].x = x + ed3d.forms[name].components[k].prop.subx
      ed3d.forms[name].components[k].y = y + ed3d.forms[name].components[k].prop.suby
   end
   ed3d.forms[name].x = x
   ed3d.forms[name].y = y
end

ed3d.destroyForm = function(name)
   for k,v in pairs (ed3d.forms[name].components) do
      ed3d.forms[name].components[k].destroy()
   end
   ed3d.forms[name].destroy()
end

ed3d.countForm = function()
   local c = 0
   for k,v in pairs(ed3d.forms) do
      c = c + 1
   end
   return c + 1
end

ed3d.createForm =
function (name,caption,dobj,w,h)
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
   --//spider thing lol
   pict.bitmap.canvas.line(0,125,100,125)
   pict.bitmap.canvas.line(100,125,150,175)
   pict.bitmap.canvas.line(100,125,150,75)
   pict.bitmap.canvas.line(150,175,300,175)
   pict.bitmap.canvas.line(150,75,300,75)

   local texture = dobj.createTexture(pict)
   local sprite = dobj.createSprite(texture)
   ed3d.forms[name] = sprite
   ed3d.forms[name].x = 50 + ed3d.countForm() * 30
   ed3d.forms[name].y = 50 + ed3d.countForm() * 30
   ed3d.forms[name].alphablend = 0.9
   ed3d.forms[name].components = {}
   ed3d.forms[name].caption = caption
   ed3d.forms[name].dragMode = false
   ed3d.forms[name].name = name
   ed3d.maxzorder = ed3d.forms[name].zorder
   local font = createFont()
   font.color = 0xffff00
   font.quality = 'fqNonAntialiased'
   font.size = 12
   font.name = "Courier New"

   ed3d.forms[name].components.title =
      dobj.createTextContainer(dobj.createFontmap(font),
      ed3d.forms[name].x+10,ed3d.forms[name].y+4,ed3d.forms[name].caption)

   ed3d.maxzorder = ed3d.forms[name].zorder
   ed3d.forms[name].components.title.prop = {}
   ed3d.forms[name].components.title.prop.subx = 10
   ed3d.forms[name].components.title.prop.suby = 4
end

ed3d.getForm = function(name) return ed3d.forms[name] end

ed3d.countFormComponents = function(formname)
   local c = 0
   for i in pairs(ed3d.forms[formname].components) do
      c = c + 1
   end
   return c
end

ed3d.formOnTop = function(fobj)
   local cc = 0
   for i in pairs(ed3d.forms) do
      if i == fobj.name then
         local s = ed3d.maxzorder-ed3d.countFormComponents(fobj.name)
         ed3d.forms[i].zorder = s
         local c = 1
         for ii in pairs(ed3d.forms[i].components) do
            ed3d.forms[i].components[ii].zorder = s + c
            c = c + 1
         end
      else
         ed3d.forms[i].zorder = cc
         cc = cc + 1
         for ii in pairs(ed3d.forms[i].components) do
            ed3d.forms[i].components[ii].zorder = cc
            cc = cc + 1
         end
      end
   end
end

ed3d.dragFormMode = function(sender,x,y,tf)
   if tf == true then
      ed3d.formOnTop(sender)
      xx,yy = getMousePos()
      sender.dragMode = true
      mtarget = sender.name
      xxx = ed3d.getForm(sender.name).x
      yyy = ed3d.getForm(sender.name).y
      ed3d.timer.enabled = true
   else
      sender.dragMode = false
      ed3d.timer.enabled = false
   end
end

ed3d.createCheckbox = function(name,caption,formname,x,y,dobj)
   local font = createFont()
   font.color = 0xffff00
   font.quality = 'fqNonAntialiased'
   font.size = 12
   font.name = "Courier New"

   ed3d.getForm(formname).components[name] =
      dobj.createTextContainer(dobj.createFontmap(font),
      ed3d.getForm(formname).x + x,
      ed3d.getForm(formname).y + y,"[OFF] - "..caption)
   ed3d.maxzorder = ed3d.getForm(formname).components[name].zorder
   ed3d.getForm(formname).components[name].prop = {}
   ed3d.getForm(formname).components[name].prop.checked = false
   ed3d.getForm(formname).components[name].prop.subx = x
   ed3d.getForm(formname).components[name].prop.suby = y
end

ed3d.getCheckbox = function(name,formname)
   return ed3d.getForm(formname).components[name]
end

ed3d.getCheckboxChecked = function(name,formname)
   return ed3d.getForm(formname).components[name].prop.checked
end

ed3d.setCheckboxChecked = function(name,formname,tf)
   if tf == true then
      ed3d.getForm(formname).components[name].prop.checked = true
      ed3d.getForm(formname).components[name].text = ed3d.getForm(formname).components[name].text:gsub("OFF","ON")
   elseif tf == false then
      ed3d.getForm(formname).components[name].prop.checked = false
      ed3d.getForm(formname).components[name].text = ed3d.getForm(formname).components[name].text:gsub("ON","OFF")
   end
end

ed3d.formDragToggle = function(name,sender,x,y)
   if sender == ed3d.getForm(name) or sender == ed3d.getForm(name).components.title then
      sender = ed3d.getForm(name)
      if sender.dragMode == false then
         ed3d.dragFormMode(sender,x,y,true)
      else
         ed3d.dragFormMode(sender,x,y,false)
      end
   end
end

ed3d.checkboxClicked = function(sender,cbname,formname,active,deactive)
   if sender == ed3d.getCheckbox(cbname,formname) then
      sender = ed3d.getCheckbox(cbname,formname)
      if ed3d.getCheckboxChecked(cbname,formname) == true then
         ed3d.setCheckboxChecked(cbname,formname,false)
         deactive()
      else
         ed3d.setCheckboxChecked(cbname,formname,true)
         active()
      end
   end
end

ed3d.guihideshow = function(kcode,vkey)
   if vkey == kcode then
      if ed3d.guishow == true then
         ed3d.guishow = false
         for i in pairs(ed3d.forms) do
            ed3d.forms[i].visible = false
            for ii in pairs(ed3d.forms[i].components) do
               ed3d.forms[i].components[ii].visible = false
            end
         end
      else
         ed3d.guishow = true
         for i in pairs(ed3d.forms) do
            ed3d.forms[i].visible = true
            for ii in pairs(ed3d.forms[i].components) do
               ed3d.forms[i].components[ii].visible = true
            end
         end
      end
   end
end
