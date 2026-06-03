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

      -- return (app.sprite != nil)

    end
  }
  
end

-- 시험 삼아 대화창 띄우기
function Matrix4Ase()
  local dlg =
    Dialog("Matrix for Aseprite")
      -- 대화창 버튼1
      :button{
        id = "show_size",
        text = "Show canvas size"
      }

      -- 대화창 보여주기
      :show()

  local data = dlg.data

  -- 클릭 시 캔버스 사이즈 띄우기
  if data.show_size then
    local sprite = app.sprite

    if sprite == nil then
      app.alert("There's no active sprite or something else.")
      return
    end

    -- 행, 열
    local row, column = sprite.height, sprite.width
    local result = string.format("%d : %d", row, column)
    app.alert(result)
  end

end

function exit(plugin)
end