function init(plugin)
  plugin:newMenuSeparator{
    group = "edit_transform"
  }

  plugin:newCommand{
    id="matrix_for_aseprite",
    title="Matrix for Aseprite",
    group="edit_transform",
    onclick = function()
      Matrix4Ase()

    end,
    onenabled = function()
      return app.sprite ~= nil

    end
  }
  
end

function Matrix4Ase()
  local dlg =
    Dialog("Matrix for Aseprite")
      :button{
        id = "show_size",
        text = "Show canvas size"
      }

      :show()

  local data = dlg.data

  if data.show_size then
    local sprite = app.sprite

    local row, column = sprite.height, sprite.width
    local result = string.format("%d : %d", row, column)
    app.alert(result)
  end

end

function transpose()
end

function inverse()
end

function exit(plugin)
end