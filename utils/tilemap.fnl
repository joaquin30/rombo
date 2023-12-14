(local matrix (require "utils.matrix"))

(fn newTilemap [init_mat world]
  (let [tilemap {
    : world
    :stack [(matrix.copy init_mat)]
    :stack_nblocks [15]
    :nblocks 15
    :size 1
    :canvas (love.graphics.newCanvas _G.width _G.height)
    :spikes true

    :push (fn [self mat]
      (set self.size (+ self.size 1))
      (tset self.stack self.size (matrix.copy mat))
      (tset self.stack_nblocks self.size self.nblocks)
      (self:updateCanvas)
      (self:updateColls))

    :pop (fn [self mat]
      (when (> self.size 1)
        ;(tset self.stack_nblocks self.size nil)
        ;(tset self.stack self.size nil)
        (set self.size (- self.size 1))
        (set self.nblocks (. self.stack_nblocks self.size))
        (self:updateCanvas)
        (self:updateColls)))

    :top (fn [self]
      (. self.stack self.size))

    :updateCanvas (fn [self]
      (matrix.updateCanvas (self:top) self.canvas self.spikes))

    :updateColls (fn [self]
      (let [mat (self:top)
            items (self.world:getItems)]
        (each [_ item (ipairs items)]
          (when (= item.type "tile")
            (self.world:remove item)))
        (matrix.addColls mat self.world)))

    :draw (fn [self]
      (love.graphics.draw self.canvas))
    }]
      (tilemap:updateCanvas)
      (tilemap:updateColls)
      tilemap))
