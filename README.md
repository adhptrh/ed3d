# ed3d
easy d3dhook mod menu using cheat engine

changes/fix/idea? make a pull request!

### Demo
![sample](https://i.imgur.com/DcLuAXj.gif)

### Example Code
```lua
loadstring(getInternet().getURL("https://raw.githubusercontent.com/adhptrh/ed3d/main/versions/ed3d_v1.lua"))()

local d3dobject = ed3d.createD3DHook()

d3dobject.createForm("f1","My First Form",350,170) -- formname,caption,width,height
d3dobject.createForm("f2","My Second Form",250,90)

d3dobject.createOnOffToggle("oot1","This is on off toggle 1","f1", 10,30) --name,caption,formname,x,y
d3dobject.createOnOffToggle("oot2","This is on off toggle 2","f1", 10,50)

d3dobject.createButton("btn1","This is button","f1",50,110) 

d3dobject.createLabel("lbl1","this is only label","f2",10,30,12) -- name,caption,formname,size,x,y
d3dobject.createLabel("lbl2","this label 2","f2",10,50,12)

d3dobject.formToTop("f2") -- make form "f2" on top

d3dobject.onclick = function (sender,x,y)

   d3dobject.formDragToggleClick("f1",sender,x,y) -- make the form drag mode if the form clicked
   d3dobject.formDragToggleClick("f2",sender,x,y)

   d3dobject.OnOffToggleClicked(sender,"oot1","f1",
      function()
         -- on
         d3dobject.getComponent("lbl1","f2").text = "kool"
      end,
      function()
         -- off
         d3dobject.getComponent("lbl1","f2").text = "yes"
      end
   )

   d3dobject.OnOffToggleClicked(sender,"oot2","f1",
      function()
         -- on
         d3dobject.getComponent("lbl2","f2").text = "kool"
      end,
      function()
         -- off
         d3dobject.getComponent("lbl2","f2").text = "yes"
      end
   )

   d3dobject.buttonClicked(sender,"btn1","f1",function()
      -- clicked
      d3dobject.getComponent("lbl1","f2").text = "cool btn1 clicked"
      d3dobject.getComponent("lbl2","f2").text = "cool btn1 clicked"
   end)

end


d3dobject.onkeydown = function(vkey,char)
   d3dobject.guihideshow(81,vkey) --press ctrl + q to hide/show gui
end
```
