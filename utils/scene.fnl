{
  ; Cargar nueva escena que se encuentra en la carpeta scenes
  ; Si existe una funcion init en la escena lo ejecuta
  :load (fn [name ...]
    (let [scene (require (.. "scene." name))]
      (when scene.init (scene.init ...))
        scene))
}
