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
  local checked_cels = GenerateCheckbox(dlg, layers)
  
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
  for _, value in pairs(cels) do
    local image = value.image
    local newImage = Image(image.height, image.width, image.colorMode)
    
    for i = 0, image.height - 1 do
      for j = 0, image.width - 1 do
        local px = image:getPixel(j, i)
        newImage:drawPixel(i, j, px)
      end
    end
  
    value.image = newImage
    
  end

end

function Inverse()
end

function GenerateCheckbox(dlg, layers, checked_cels, path)
  checked_cels = checked_cels or {}
  path = path or  ""

  for i = #layers, 1, -1 do
    local layer = layers[i]
    local name = layer.name
    local cur_path = path .. "_" .. name

    dlg:label{
      id = string.format("layer_%s%02d", cur_path, i),
      label = name
    }

    --레이어가 그룹으로 이루어져있다면 재귀 호출한 후, 건너뛰기
    if layer.isGroup then
      -- 딕셔너리 병합
      GenerateCheckbox(dlg, layer.layers, checked_cels, cur_path)
    else  
      for j, cel in ipairs(layer.cels) do
        local identifier = string.format("cel_%s%02d", cur_path, j)
        
        dlg:check{
          id = identifier,
          selected = false,
          onclick = function()          
            if dlg.data[identifier] then
              checked_cels[identifier] = cel
            else
              checked_cels[identifier] = nil
            end
          end
        }
      end
      
    end

  end
  
  return checked_cels
end

function exit(plugin)
end