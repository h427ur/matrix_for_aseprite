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
  local checked_cels = {}

  GenerateCheckbox(dlg, layers)
  
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

function GenerateCheckbox(dlg, layers)
  -- 내부에서 테이블을 선언하고, 반환하기
  local checked_cels = {}

  for i = #layers, 1, -1 do
    local name = layers[i].name

    dlg:label{
      id = string.format("layer_%s%02d", name, i),
      label = name,
    }

    --레이어가 그룹으로 이루어져있다면 재귀 호출한 후, 건너뛰기
    if layers[i].isGroup then
      -- 딕셔너리 병합
      local cels = GenerateCheckbox(dlg, layers[i].layers)
      checked_cels = MergeDict(checked_cels, cels)
      goto continue
    --아니면 그대로 진행
    end

    for j = 1, #layers[i].cels do
      local identifier = string.format("cel_%s%02d", name, j)
      
      dlg:check{
        id = identifier,
        selected = false,
        onclick = function()
          local data = dlg.data
          local cel = layers[i].cels[j]

          if data[identifier] then
            checked_cels[identifier] = cel
          else
            checked_cels[identifier] = nil
          end
        end
      }
    end

    ::continue::
  end
  
  return checked_cels
end

function MergeDict(t1, t2)
    for k, v in pairs(t2) do 
      t1[k] = v
    end
    
    return t1
end

function exit(plugin)
end