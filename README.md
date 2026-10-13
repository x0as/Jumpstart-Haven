# Jumpstart Haven

just a simple 2d platformer i made in godot for jumpstart haven

## whats the game

you got 60 seconds to collect as many coins as u can. coins spawn on the platforms and when u grab one a new one pops up somewhere else. when the timer hits 0 the game freezes and shows ur score. press enter or space to play again

i originally tried making a 2d tag game with an enemy that chases u but i got stuck on the pathfinding so i scrapped it and made this instead

## play it

demo (in browser): https://whozaifa.itch.io/jump-start-haven

## controls

- move: arrow keys or a/d
- jump: space or up arrow

## run it locally

1. download godot 4.6 (or newer 4.x) from https://godotengine.org/download
2. clone the repo
   ```
   git clone https://github.com/x0as/Jumpstart-Haven.git
   ```
3. open godot, hit import and pick the project.godot file in the folder
4. press F5 to play

## files

- hud.gd - timer, score and the game over screen
- coin.gd - the coin
- coin_spawner.gd - puts coins on the platforms

made with godot 4.6
