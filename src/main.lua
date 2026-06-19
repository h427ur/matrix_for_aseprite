pxc = app.pixelColor

function init(plugin)
  plugin:newMenuSeparator{
    group = "edit_transform"
  }

  plugin:newCommand{
    id="matrix_for_aseprite",
    title="Matrix for Aseprite",
    group="edit_transform",
    onclick = function()
      mat4ase(app.sprite)

    end,
    onenabled = function()
      return app.sprite ~= nil
      
    end
  }

end

function mat4ase(sprite)
  local dlg = Dialog("Matrix for Aseprite")
  
  dlg:button{
    id = "getSize",
    text = "Show canvas size",
    onclick = function()
      local row, column = sprite.height, sprite.width
      local result = string.format("%d : %d", row, column)
      app.alert(result)
      
    end
  }
  
  dlg:button{
    id = "tPose",
    text = "Transpose",
    onclick = transpose(sprite)
  }

  dlg:show() -- {wait = false}
end

function transpose(sprite)
  local layers = sprite.layers
  local cels = layers[1].cels
  local image = cels[1].image

  local newImage = Image(image.height, image.width, image.colorMode)
  for i = 0, image.height - 1 do
    for j = 0, image.width - 1 do
      local px = image:getPixel(i, j)
      newImage:drawPixel(j, i, px)
    end
  end

  cels[1].image = newImage

end

function inverse()
end

function exit(plugin)
end