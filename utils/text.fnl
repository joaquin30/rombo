(fn newText [text font color offset_x offset_y]
  {
    : text : font : color
    :x (+ (math.floor (/ (- _G.W (font:getWidth text)) 2)) (* offset_x _G.tilesize))
    :y (+ (math.floor (/ (- _G.H (font:getHeight)) 2)) (* offset_y _G.tilesize))
    :w (font:getWidth text)

    :draw (fn [self]
      (let [(r g b a) (love.graphics.getColor)]
        (love.graphics.setColor self.color)
        (love.graphics.printf self.text self.font self.x self.y self.w "center")
        (love.graphics.setColor r g b a)))
  })
