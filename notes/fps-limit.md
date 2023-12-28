# Setting FPS Limits

*From [this thread](https://www.reddit.com/r/linux_gaming/comments/p8y979/comment/h9twa2n/?utm_source=share&utm_medium=web2x&context=3).*

If the game you're playing doesn't allow you to set the maximum frame rate, you can install MangoHud and run your application with this setting:

```bash
MANGOHUD_CONFIG=no_display,fps_limit=30 mangohud --dlsym %command%
```

This example in particular hides the mangohud HUD in the top-left and sets the maximum frame rate to 30.
