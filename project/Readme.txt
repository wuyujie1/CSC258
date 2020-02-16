Project name: Snake Battle

Project description: Normal snake game but has two modes:single player mode and multiplayer mode, using the monitor to display the game and keyboard to
control the movement of the snake.(WASD and 8456 on the numberpad)
 
Top level module name:singleBoxDisplay

Project Design:
gameState: FSM of the whole game, including draw border, change mode, display snake and snack, update score, check game over and 
restart the game.
singlePlayerMode: Control the behaviour of the snake in the single player mode.
multiPlayer: Control the behaviour of the two snakes in the multi player mode.
collisionDetect: Detect if there is a collision happens in the single player mode, which means the snake touches the border.
multiPlayerCollisionDetect: Detect if there is a collision happens in the multi player mode, which means the snake touches the border
or touches the body of the other snake.
border: Draw the border of the game.
wholePagePrint: Print the whole page with one color, which is used to indicate game over or the winning snake color.
cleanP2Score: Clean the score in the multiplayer mode when swithing from multimode to single mode.
snack: Generate the snack.
snackLocationGenerator: This module is a submodule of snack, its function is to generate the snack randomly on the screen.
myMux6to1: A 6-to-1 mux, used to display different output on the screen.
myMux2to1: A basic 2-to-1 mux.
vgaDelayCounter2: A counter to delay the state.

snake:snake: A snake module to control the movement and the logic of a single snake, including the controlunit and the datapath.
multiSnake: Multisnake module to control the movement and the logic of two snakes, including the controlunit and the datapath
snakeBodyDataPath: The dataPath described in snake module, output the location and the color of the snake.
snakeBodyControlPath: The Controlunit containing the FSM to control several states of the single player mode:print, erase, check
collision, update location and score, print snack.
multiSnakeControlPath: similar to snakeBodyControlPath, but control the states of multiplayer.
gameSpeedMux: Mux to control the speed of the game, in other words, the speed of the snake may increase as the body lenght increases.
headLocationCounter: Update the location of the snake head.
snakeBodyShifter: 60 shift registers to store the location of the snake body.
bodyLengthCounter: Increase the snake body length.
bodyUnitOutputCounter: Output the part of the body that is going to be printed.
bodyUnitOutputDelayCounter: Delay the bodyUnitOutputCounter.
gameSpeedCounter: Counter used in the gameSpeed Mux.
updateLocationCounter: Counter used in the multiSnakeBodyControlPath.
vgaDelayCounter: Counter to delay the vga display.
vgaDelayCounter1: Similar to vgaDelayCounter.
shifterBit7bits: Shift registers used in the snakeBodyShifter.
mux2to1: 2-to-1 mux.
register7bits: Small module used in shifterBit7bits.
score: Display the score on the right of the screen, which also represents the length of the snake.
number: Display the number in the score.
hex: The lookup table for number module to know which segment to turn on.
single: Display a single number according to the lookup table.

Verilog modules were not created by us: VGA adapter, keyboard.

Also, we delete all the delay counter when doing the simulation, otherwise it will take a very long time.