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
    text = "Show canvas size"
  }
  
  dlg:button{
    id = "tPose",
    text = "Transpose"
  }
  
  dlg:show()
  
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
  --반복문으로 처리한다
  --캔버스 전체를 변수에 저장한다
  --행의 각 요소를 열의 요소로 배치한다
  --즉 행의 각 요소를 각 행의 0번째에 배치한다.

  --일단 디버깅용으로 출력해보기
  local cels = sprite.cels
  -- local layer  = sprite.layer
  app.alert(cels[0])
end

function inverse()
end

function exit(plugin)
end