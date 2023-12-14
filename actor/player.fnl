(local gravity 2)

(fn collFilter [player object]
  (if (= object.type "tile") "slide" nil))

(fn jump [player]
  (when player.colls.down
    (love.audio.play _G.jump)
    (set player.vy -30)))

(fn update [player]
  (set player.vx (if player.mov.right 6 player.mov.left -6 0))

  (set player.colls {:up false :down false :left false :right false})

  (let [goalx (lume.clamp (+ player.x player.vx) 0 (- _G.width player.w))
        goaly (+ player.y player.vy)
        (actualx actualy) (player.world:move player goalx goaly collFilter)]
    (when (< goalx actualx)
      (set player.colls.right true))
    (when (> goalx actualx)
      (set player.colls.left true))
    (when (< goaly actualy)
      (set player.colls.up true))
    (when (> goaly actualy)
      (set player.colls.down true))
    (set player.x actualx)
    (set player.y actualy))

  (when (or player.colls.up player.colls.down)
    (set player.vy 0))

  (set player.vy (math.min 20 (+ player.vy gravity)))

  (let [(items _) (player.world:queryRect player.x player.y player.w player.h)]
    (each [_ item (ipairs items)]
      (when (or (and (= item.type "spike") player.spikes) (= item.type "saw"))
        (love.audio.play _G.death)
        (set player.dead true)))))

(fn draw [self]
  (love.graphics.draw _G.images.rombo
    (math.floor self.x) (math.floor self.y) 0
    _G.scale _G.scale))

(fn newPlayer [x y world]
  (let [player {
    :type "player"
    :x (* x _G.tilesize) :y (* y _G.tilesize)
    :w (* 2 _G.tilesize) :h (* 4 _G.tilesize)
    :vx 0 :vy 0
    :dead false
    : world
    :mov {:left false :right false}
    :colls {:up false :down false :left false :right false}
    :spikes true
    : jump
    : update
    : draw
  }]
    (world:add player player.x player.y player.w player.h)
    player))
