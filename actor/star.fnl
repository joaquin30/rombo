(fn draw [self]
  (when self.alive
  (love.graphics.draw _G.images.star
    (math.floor self.x) (math.floor self.y) 0
    _G.scale _G.scale)))

(fn destroy [self]
  (set self.alive false)
  (self.world:remove self))

(fn newStar [x y bump_world]
  (let [star {
    :type "star"
    :world bump_world
    :x (* x _G.tilesize) :y (* y _G.tilesize)
    :w (* 2 _G.tilesize) :h (* 2 _G.tilesize)
    :alive true
    : destroy
    : draw
  }]
    (print star.x star.y star.w star.h)
    (star.world:add star star.x star.y star.w star.h)
    star))
