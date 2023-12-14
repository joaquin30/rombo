; globales
(local newText (require "utils.text"))

(var text_title nil)
(var text_play nil)
(var text_autor nil)
(var exit false)

(fn init []
  (set exit false)
  (set text_title
    (newText "Rombo y la Persistencia\nCuadrática" _G.font_title [1 0 0] 0 -5))
  (set text_play
    (newText "Pulsa  C  para jugar" _G.font_normal [0 0 0] 0 2))
  (set text_autor
    (newText "Hecho por Joaquin" _G.font_dialogue [0 0 0] 19 12)))

(fn keypressed [key])

(fn keyreleased [key]
  (if (= key "c")
    (set exit true)))

(fn update []
  (when exit "tutorial"))

(fn draw []
  (text_title:draw)
  (text_play:draw)
  (text_autor:draw))

{
  : init
  : keypressed
  : keyreleased
  : update
  : draw
}
