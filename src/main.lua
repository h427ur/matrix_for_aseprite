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
  --즉 행의 각 요소를 각 행의 1번째에 배치한다.
  --  lua는 인덱스가 1부터 시작한다.

  --일단 디버깅용으로 출력해보기
  local layers = sprite.layers
  local cels = layers[1].cels
  local image = cels[1].image

  -- 이미지 범위는 0부터 시작한다

  --테이블 생성
  local pxTable = {}
  for i in image:pixels() do
    local px = i()
    table.insert(pxTable, px)
  end

  local pxc = app.pixelColor

  --새 테이블 생성
  for i = 0, image.height - 1 do
    --전치행렬; 각 행의 첫 번째 요소를 열에 나열한다.
    for j = 0, image.width - 1 do
      local idx = (j * image.width) + i + 1
      image:drawPixel(j, i, pxTable[idx])
    end
  end

  -- app.alert(string.format("%d, %d, %d, %d", red, grn, blu, alp))

end

function inverse()
end

function exit(plugin)
end