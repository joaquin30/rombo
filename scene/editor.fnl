; globales
(local newText (require "utils.text"))
(local matrix (require "utils.matrix"))

(local mat (matrix.ceros))
(local canvas (love.graphics.newCanvas (* tilesize tiles_w) (* tilesize tiles_h)))

(fn keypressed [key])

(fn keyreleased [key]
  (if (= key "z")
    (matrix.save mat "editor.fnl")))

(fn update []
  (when (love.mouse.isDown 1)
    (let [(x y) (love.mouse.getPosition)
          i (lume.clamp (math.floor (/ y _G.tilesize)) 0 _G.tiles_h)
          j (lume.clamp (math.floor (/ x _G.tilesize)) 0 _G.tiles_w)]
      (tset (. mat i) j 1)
      (matrix.updateCanvas mat canvas true)))

  (when (love.mouse.isDown 2)
    (let [(x y) (love.mouse.getPosition)
          i (lume.clamp (math.floor (/ y _G.tilesize)) 0 _G.tiles_h)
          j (lume.clamp (math.floor (/ x _G.tilesize)) 0 _G.tiles_w)]
      (tset (. mat i) j 2)
      (matrix.updateCanvas mat canvas true)))

  (when (love.mouse.isDown 3)
    (let [(x y) (love.mouse.getPosition)
          i (lume.clamp (math.floor (/ y _G.tilesize)) 0 tiles_h)
          j (lume.clamp (math.floor (/ x _G.tilesize)) 0 tiles_w)]
      (tset (. mat i) j 0)
      (matrix.updateCanvas mat canvas true))))

(fn draw []
  (love.graphics.draw canvas)
  (love.graphics.setColor 0 0 0)
  (let [(x y) (love.mouse.getPosition)
          i (lume.clamp (math.floor (/ y _G.tilesize)) 0 tiles_h)
          j (lume.clamp (math.floor (/ x _G.tilesize)) 0 tiles_w)]
    (love.graphics.print (.. (tostring j) " ; " (tostring i))))
  (love.graphics.setColor 1 1 1))

{
  : keypressed
  : keyreleased
  : update
  : draw
}
