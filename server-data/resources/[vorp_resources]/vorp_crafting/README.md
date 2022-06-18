# VORP Crafting

> A RedM crafting system for [Vorp Core](http://docs.vorpcore.com:3000/)

Join the [VORP Community Discord](https://discord.gg/23MPbQ6)

## Features
1. Config Recipes of any length
2. Config Customizable Categories
3. Custom Html/js UI
4. Location based crafting
5. Campfire based crafting
6. Use campfire from inventory
    - `/extinguish` will despawn the fire after an animation
7. Easy Locale(Language) Support
8. Font Size Presets (s, m, l)
9. Open Inventory when in crafting window (Press I) **THIS REQUIRES LATEST VERSION OF VORP_CORE-LUA**
10. Quick Close Crafting (Press esc)
11. Job Restrictions for locations, campfires, and individual items.
12. Location Restrictions for individual items.

## Screenshots
![image](https://user-images.githubusercontent.com/10902965/172357337-a6e0be47-82df-4ccd-b851-0f9fab3054cf.png)
![image](https://user-images.githubusercontent.com/10902965/172357508-ed818155-59d9-4f01-a0ff-180395df98c4.png)
![image](https://user-images.githubusercontent.com/10902965/172357712-0d486141-dcc1-40d3-ad90-1b3e8b0b5fca.png)
![image](https://user-images.githubusercontent.com/10902965/172358344-ffb05bac-c6d2-4ca4-a7d3-4a3399d25425.png)

## Installation
1. Download this repo/codebase
2. Extract and place `vorp_crafting` into your `resources` folder
3. Add `ensure vorp_crafting` to your `server.cfg` file
4. Add sql/data.sql to your database
5. Restart your server (unless you have nightly restarts)

## How-to-configure
All configurations available in `/config.lua`

## Disclaimers and Credits
- This is a was originally based on [syn_crafting](https://github.com/kamelzarandah/syn_crafting) (Made by Blue & Dungeon for Syn County RP)

## Dependency
 - Vorp Core
 - Vorp Inventory **(MUST HAVE THE LATEST)**
 - [progressBars](https://github.com/PokeSerGG/progressBars)

