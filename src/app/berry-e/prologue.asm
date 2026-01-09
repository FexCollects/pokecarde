SECTION "app/berry-e/prologue", ROM0

UnknownPalette::
    INCBIN "gfx/berry-e/unknown.gbapal"
BackgroundSprite::
    INCBIN "build/gfx/berry-e/background.4bpp"
BackgroundTilemap::
    INCBIN "gfx/berry-e/background.tilemap"
BackgroundPalette::
    INCBIN "build/gfx/berry-e/background.gbapal"

ds 72
