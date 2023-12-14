;(love.graphics.setDefaultFilter "nearest")

(global lume (require "lib.lume"))

(set _G.tiles_w (* 16 3))
(set _G.tiles_h (* 9 3))

(set _G.dt (/ 1 60)) ; 60FPS

(set (_G.W _G.H) (love.window.getDesktopDimensions))

(set _G.tilesize
  (math.min
    (math.floor (/ _G.W _G.tiles_w))
    (math.floor (/ _G.H _G.tiles_h))))

(set _G.width (* _G.tilesize _G.tiles_w))
(set _G.height (* _G.tilesize _G.tiles_h))
(set _G.scale (/ _G.tilesize 32))

(set _G.font_normal
  (love.graphics.newFont "assets/RockSalt-Regular.ttf" _G.tilesize))
(_G.font_normal:setLineHeight 0.8)
(love.graphics.setFont _G.font_normal)

(set _G.font_title
  (love.graphics.newFont "assets/RockSalt-Regular.ttf" (* _G.tilesize 2)))
(_G.font_title:setLineHeight 0.8)

(set _G.font_dialogue
  (love.graphics.newFont "assets/RockSalt-Regular.ttf" (math.floor (* _G.tilesize .6))))
(_G.font_dialogue:setLineHeight 0.8)

(set _G.colors {
  :lightblue [.1 .5 1]
  :white [.9 .9 .9]
  :transparent_gray [0 0 0 .3]
})

(set _G.images {
  :box (love.graphics.newImage "assets/box.png")
  :editbox (love.graphics.newImage "assets/editbox.png")
  :rombo (love.graphics.newImage "assets/rombo.png")
  :spike (love.graphics.newImage "assets/spike.png")
  :star (love.graphics.newImage "assets/star.png")
  :saw (love.graphics.newImage "assets/saw.png")
})

(local newText (require "utils.text"))
(set _G.text_edit (newText "MODO EDICION" _G.font_title [0 0 0 .7] 0 0))

(set _G.music (love.audio.newSource "assets/audio/music.wav" "static"))
(_G.music:setLooping true)
(set _G.death (love.audio.newSource "assets/audio/death.wav" "static"))
(set _G.jump (love.audio.newSource "assets/audio/jump.wav" "static"))
