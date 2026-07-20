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
      Mat4ase(app.sprite)

    end,
    onenabled = function()
      return app.sprite ~= nil
      
    end
  }

end

function Mat4ase(sprite)
  local dlg = Dialog{
    title = "Matrix for Aseprite",
    resizeable = false
  }

  local layers = sprite.layers
  checked_cels = {}

  for i = #layers, 1, -1 do
    local name = layers[i].name

    dlg:label{
      id = string.format("layer_%s%02d", name, i),
      label = name,
    }

    for j = 1, #layers[i].cels do
      --id 변수
      local identifier = string.format("cel_%s%02d", name, j)
      
      dlg:check{
        id = identifier,
        selected = false,
        onclick = function()
          local data = dlg.data
          local cel = layers[i].cels[j]

          if data[identifier] then
            --딕셔너리에 id:cel 쌍으로 집어넣기
            checked_cels[identifier] = cel
            --app.alert(string.format("%s checked", selected_cels[identifier]))
          else
            --app.alert(string.format("%s unchecked", selected_cels[identifier]))
            checked_cels[identifier] = nil
          end
        end
      }
    end

  end
  
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
    onclick = function()
      Transpose(checked_cels)
    end
  }

  dlg:show{
    wait = false
  }

end

function Transpose(cels)
  for key, value in pairs(cels) do
    local image = value.image
    app.alert(string.format("%d : %d", image.height, image.width))
    local newImage = Image(image.height, image.width, image.colorMode)
    
    for i = 0, image.height - 1 do
      for j = 0, image.width - 1 do
        local px = image:getPixel(i, j)
        newImage:drawPixel(j, i, px)
      end
    end
  
    value.image = newImage
    
  end

end

function inverse()
end

function exit(plugin)
end