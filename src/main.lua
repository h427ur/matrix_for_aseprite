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
  local dlg = Dialog{
    title = "Matrix for Aseprite",
    resizeable = false
  }

  --레이어를 변수로 저장
  local layers = sprite.layers
  
  --선택된 셀들을 저장할 테이블
  local selected_cels = {}

  -- 반복문으로 처리해보자
  for i = #layers, 1, -1 do
    local name = layers[i].name
    local identifier = string.format("layer_%s%02d", name, i)
    dlg:label{
      id = identifier,
      label = name,
    }

    for j = 1, #layers[i].cels do
      local identifier = string.format("cel_%s%02d", name, j)
      dlg:check{
        id = identifier,
        onclick = function()
          table.insert(selected_cels, identifier)
        end
      }
    end

  end
  -- 
  
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
      local data = dlg.data
      for i = 1, #selected_cels do
        local identifier = selected_cels[i]
        
      end
      transpose(sprite)
    end
  }

  dlg:show{
    wait = false
  }
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