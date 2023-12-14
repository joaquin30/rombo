{
  :save (fn [mat file]
    (let [(file err) (io.open file "w")]
      (when file
        (file:write "{\n")
        (for [i 0 _G.tiles_h]
          (file:write (.. (tostring i) " { "))
          (for [j 0 _G.tiles_w]
            (file:write (.. (tostring j) " " (tostring (. (. mat i) j)) " ")))
          (file:write "}\n"))
        (file:write "}\n")
        (file:flush)
        (file:close))
      (when (not file)
        (print err))))


  :copy (fn [mat]
    (let [cmat []]
      (for [i 0 _G.tiles_h]
        (tset cmat i [])
        (for [j 0 _G.tiles_w]
          (tset (. cmat i) j (. (. mat i) j))))
      cmat))

  :ceros (fn []
    (let [mat []]
      (for [i 0 _G.tiles_h]
        (tset mat i [])
        (for [j 0 _G.tiles_w]
          (tset (. mat i) j 0)))
      mat))

  :updateCanvas (fn [mat canvas spikes]
    (love.graphics.setCanvas canvas)
    (love.graphics.clear)
    (for [i 0 _G.tiles_h]
      (for [j 0 _G.tiles_w]
        (let [v (. (. mat i) j)]
          (if
            (= v 1)
              (love.graphics.draw _G.images.box (* j _G.tilesize) (* i _G.tilesize) 0 _G.scale _G.scale)
            (and (= v 2) spikes)
              (love.graphics.draw _G.images.spike (* j _G.tilesize) (* i _G.tilesize) 0 _G.scale _G.scale)
            (= v 3)
              (love.graphics.draw _G.images.editbox (* j _G.tilesize) (* i _G.tilesize) 0 _G.scale _G.scale)))))
    (love.graphics.setCanvas))

  :addColls (fn [mat world]
    (for [i 0 _G.tiles_h]
      (for [j 0 _G.tiles_w]
        (let [val (. (. mat i) j)]
          (when (~= val 0)
            (world:add {:type (if (= val 2) "spike" "tile")} (* j tilesize) (* i tilesize) tilesize tilesize))))))

  :set (fn [mat x y v]
    (let [j (lume.clamp (math.floor (/ x _G.tilesize)) 0 _G.tiles_w)
          i (lume.clamp (math.floor (/ y _G.tilesize)) 0 _G.tiles_h)]
      (tset (. mat i) j v)))

  :get (fn [mat x y]
    (let [j (lume.clamp (math.floor (/ x _G.tilesize)) 0 _G.tiles_w)
          i (lume.clamp (math.floor (/ y _G.tilesize)) 0 _G.tiles_h)]
      (. (. mat i) j)))
}
