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
  local dlg =
    Dialog("Matrix for Aseprite")
      :button{
        id = "getSize",
        text = "Show canvas size"
      }

      :button{
        id = "tPose",
        text = "Transpose"
      }

      :show()

  local data = dlg.data

  if data.getSize then
    local row, column = sprite.height, sprite.width
    local result = string.format("%d : %d", row, column)
    app.alert(result)
  elseif data.tPose then
    transpose(sprite)
  end

end

function transpose(sprite)
  app.alert(sprite.cels)
end

function inverse()
end

function exit(plugin)
end