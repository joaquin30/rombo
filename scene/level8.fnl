;; Librerias
(local newText (require "utils.text"))
(local matrix (require "utils.matrix"))
(local newTilemap (require "utils.tilemap"))
(local bump (require "lib.bump"))
(local bumpDraw (require "utils.bump_draw"))
(local newPlayer (require "actor.player"))
(local newStar (require "actor.star"))
(local newSaw (require "actor.saw"))

(var texts nil)
(var tilemap nil)
(var world nil)
(var edit_mode false)
(var edited? false)
(var mat nil)
(var player nil)
(var star nil)
(var saws nil)

(fn init []
  (set edit_mode false)
  (set edited? false)
  (set world (bump.newWorld))
  (set tilemap (newTilemap (require "map.8") world))
  (set player (newPlayer 1 1 world))
  (set star (newStar 43 5 world))
  (set texts [])
  ;(lume.push texts)
  (set saws [])
  (lume.push saws
    (newSaw 18 5 world)
    (newSaw 30 5 world)
    (newSaw 16 21 world)
    (newSaw 26 21 world)))


(fn keypressed [key]
  (if
    (= key "left")
      (set player.mov.left true)
    (= key "right")
      (set player.mov.right true)
    (= key "c")
      (player:jump)))

(fn keyreleased [key]
  (if
    (= key "left")
      (set player.mov.left false)
    (= key "right")
      (set player.mov.right false))

  (when (= key "x")
      (when (not edit_mode)
        (tilemap:push (tilemap:top))
        (set edited? false))
      (when edit_mode
        (if edited?
          (tilemap:updateColls)
          (let [nblocks tilemap.nblocks]
            (tilemap:pop)
            (tset tilemap.stack_nblocks tilemap.size nblocks)
            (set tilemap.nblocks nblocks))))
      (set edit_mode (not edit_mode)))
  (when (and (= key "z") (not edit_mode))
    (tilemap:pop)))

(fn update []
  (when edit_mode
    (when (love.mouse.isDown 1)
      (let [(x y) (love.mouse.getPosition)]
        (when (and (= (matrix.get (tilemap:top) x y) 0) (> tilemap.nblocks 0))
          (set tilemap.nblocks (- tilemap.nblocks 1))
          (set edited? true)
          (matrix.set (tilemap:top) x y 3)
          (tilemap:updateCanvas)))))

  (when (not edit_mode)
    (each [_ saw (ipairs saws)]
      (saw:update))
    (player:update)
    (when star
      (let [(items len) (world:queryRect star.x star.y star.w star.h)]
        (when (> len 1)
          (star:destroy)
          (set tilemap.spikes false)
          (tilemap:updateCanvas)
          (set player.spikes false)))))

  ;escenas
  (if
    (> player.y _G.height) "fin"
    player.dead "level8"))

(fn draw []
  (tilemap:draw)

  (when (not edit_mode)
    (each [_ text (ipairs texts)]
      (text:draw)))

  (when edit_mode
    (love.graphics.setColor _G.colors.transparent_gray)
    (love.graphics.rectangle "fill" 0 0 _G.width _G.height)
    (_G.text_edit:draw))

  (each [_ saw (ipairs saws)]
      (saw:draw))

  (love.graphics.setColor 0 0 0 .9)
  (love.graphics.print (.. (tostring tilemap.nblocks) " bloques") _G.font_dialogue tilesize tilesize)
  (love.graphics.setColor 1 1 1)

  (player:draw)
  (star:draw))
  ;(bumpDraw world))

{
  : init
  : keypressed
  : keyreleased
  : update
  : draw
}
