;; Inicializando variables globales
(require "utils.globals")

;; escenas
(local sceneManager (require "utils.scene"))
(var scene (sceneManager.load "menu"))
(var background nil)

(fn love.load []
  (love.audio.play _G.music)
  (love.graphics.setBackgroundColor _G.colors.white)

  ; crear fondo
  (set background (love.graphics.newCanvas _G.W _G.H))
  (love.graphics.setCanvas background)
  (love.graphics.clear)
  (love.graphics.setColor _G.colors.lightblue)
  (for [x 0 (- _G.tiles_w 1)]
      (for [y 0 (- _G.tiles_h 1)]
          (love.graphics.rectangle "line"
            (* x _G.tilesize) (* y _G.tilesize)
            _G.tilesize _G.tilesize)))
  (love.graphics.setCanvas)
  (love.graphics.setColor [1 1 1 1]))

(var accum 0)
(fn love.update [dt]
  (set accum (+ accum dt))
  (while (>= accum _G.dt)
    (let [newscene (scene.update)]
      (when newscene
        (set scene (sceneManager.load newscene))))
    (set accum (- accum _G.dt))))

(fn love.keypressed [key]
  (when (= key "escape")
    (love.event.quit))
  (scene.keypressed key))

(fn love.keyreleased [key]
  (scene.keyreleased key))

(fn love.mousepressed [x y button]
  (when scene.mousepressed
    (scene.mousepressed x y button)))

(fn love.draw []
  (love.graphics.setBlendMode "alpha" "premultiplied")
  (love.graphics.draw background _G.offset_x _G.offset_y)
  (love.graphics.setBlendMode "alpha")
  (scene.draw))
  ;(print (tostring (love.timer.getFPS))))
