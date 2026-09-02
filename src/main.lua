function init(plugin)
  plugin:newMenuSeparator{
    group = "edit_transform"
  }

  plugin:newCommand{
    id="matrix_for_aseprite",
    title="Matrix for Aseprite",
    group="edit_transform",
    onclick = function()
      matase(app.sprite)

    end,
    onenabled = function()
      return app.sprite ~= nil
      
    end
  }

end

function matase(sprite)
  local dlg = Dialog{
    title = "Matrix for Aseprite",
    resizeable = false
  }

  local layers = sprite.layers
  local checked_cels = gen_checkbox(dlg, layers)
  
  dlg:button{
    id = "get_size",
    text = "Show canvas size",
    onclick = function()
      local row, column = sprite.height, sprite.width
      local result = string.format("%d : %d", row, column)
      app.alert(result)
    end
  }
  
  dlg:button{
    id = "transpose",
    text = "Transpose",
    onclick = function()
      tpose(checked_cels)
    end
  }

  
  dlg:button{
    id = "inverse",
    text = "Inverse",
    onclick = function()
      inverse(checked_cels)
    end
  }

  dlg:show{
    wait = false
  }

end

function tpose(cels)
  for _, val in pairs(cels) do
    local img = val.image
    local newimg = Image(img.height, img.width, img.colorMode)
    
    for i = 0, img.height - 1 do
      for j = 0, img.width - 1 do
        local px = img:getPixel(j, i)
        newimg:drawPixel(i, j, px)
      end
    end
  
    val.image = newimg
    
  end

end

function inverse(cels)
  for _, val in pairs(cels) do
    local img = val.image
    local name = val.layer.name

    if img.width ~= img.height then
      local errmsg = string.format("This cel of [%s] must be square(%d : %d)", name, img.width, img.height)
      app.alert(errmsg)
    else
      app.alert("this function is not complete yet")
    end

  end
end

function gen_checkbox(dlg, layers, checked_cels, path)
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

    if layer.isGroup then
      gen_checkbox(dlg, layer.layers, checked_cels, cur_path)
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