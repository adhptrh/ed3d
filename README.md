# ed3d
ed3d

### Screenshot
![sample](/img/sample.png)

### Example Code (no comments)
Scroll down to see example code with comments
```lua
loadstring(getInternet().getURL("https://raw.githubusercontent.com/adhptrh/ed3d/main/ed3d.lua"))()

local d3dobject = ed3d.createD3DHook()
ed3d.createForm("myform","This is form",d3dobject,300,170)
ed3d.createCheckbox("cb1","My Hack","myform", 10,30, d3dobject)
ed3d.formOnTop(ed3d.getForm("myform"))

d3dobject.onclick = function (sender,x,y)
   ed3d.formDragToggle("myform",sender,x,y)
   ed3d.checkboxClicked(sender,"cb1","myform",
      function()
      end,
      function()
      end
      )
end

d3dobject.onkeydown = function(vkey,char)
   ed3d.guihideshow(81,vkey)
end
```

### Example Code (with comments)
```lua
loadstring(getInternet().getURL("https://raw.githubusercontent.com/adhptrh/ed3d/main/ed3d.lua"))()
--execute ed3d online

local d3dobject = ed3d.createD3DHook()
--declare new d3dobject

ed3d.createForm("myform","This is form",d3dobject,300,170)
--ed3d.createForm(formname, caption, d3dobejct, width, height)
--this create a form

ed3d.createCheckbox("cb1","My Hack","myform", 10,30, d3dobject)
--ed3d.createCheckbox(checkbox_name ,checkbox_caption, formname, left, top, d3dobject)
--this create checkbox

ed3d.formOnTop(ed3d.getForm("myform"))
--this make the form to the top than other form

--V this will get what object you click V
d3dobject.onclick = function (sender,x,y)

   ed3d.formDragToggle("myform",sender,x,y)
   --make your form drag able when u click the form

   --V this will set your checkbox V
   ed3d.checkboxClicked(sender,"cb1","myform",
      function()
         --do some script if checkbox is checked
      end,
      function()
         --do some script if checkbox is not checked
      end
      )
   --ed3d.checkboxClicked(sender,checkbox_name,form_name,functionenable,functiondisable)

end

--V this will record keydown V
d3dobject.onkeydown = function(vkey,char)
   ed3d.guihideshow(81,vkey)
   -- this will gui hide and show by pressing ctrl + q = 81
   --ed3d.guihideshow(vkeycode, vkey)
end
```
