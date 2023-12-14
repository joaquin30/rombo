(fn draw [self]
  (love.graphics.draw _G.images.saw
    (math.floor self.x) (math.floor self.y) self.angle
    _G.scale _G.scale 64 64))

(fn update [self]
  (set self.angle (+ self.angle .05))
  (when (> self.angle (* 6.28))
    (set self.angle (- self.angle 6.28))))

(fn newSaw [x y bump_world]
  (let [saw {
    :type "saw"
    :world bump_world
    :x (* x _G.tilesize) :y (* y _G.tilesize)
    :w (* 4 _G.tilesize) :h (* 4 _G.tilesize)
    : draw
    : update
    :angle 0
  }]
    (print saw.x saw.y saw.w saw.h)
    (saw.world:add saw saw.x saw.y saw.w saw.h)
    saw))
