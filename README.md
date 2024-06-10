[![Review Assignment Due Date](https://classroom.github.com/assets/deadline-readme-button-24ddc0f5d75046c5622901739e7c5dd533143b0c8e959d652212380cedb1ea36.svg)](https://classroom.github.com/a/syDSSnTt)
# Hive - APCS2 Final Project
## Group Info   
**Group Name:** Miners of Moria   
**Group Members:** Michael Avrahami, Victor Casado
## Overview
Our project is to replicate the not-too-well-known board game Hive in processing. Hive is a strategy game similar to chess, where each piece has different movement types, except there is no board. Instead, the pieces make up the board, and you can place new pieces next to your existing ones. The goal of the game is to surround the opponent's Queen (Queen Bee because Hive is bug-themed) with other pieces, which is equivalent to a checkmate in chess.
## Instructions
**Running the Project:** Simply open processing, open the testGame folder in processing, and press run.   
**Rules:** The rules of the game of hive can be found at this link: https://www.gen42.com/download/rules/hive/Hive_English_Rules.pdf

In general, the program will show only legal moves and will force you to play only legal moves. The game will also end when it is supposed to. However, it is worth noting that the first piece can be placed anywhere on the board, and the second piece (player 2's first piece) must be placed next to player 1's. After that, the normal one hive and only placing your piece next to your pieces rules apply (see rules).

Click on a piece in the sidebar to select it, then click on a legal empty hexagon in the board to place it down. Alternatively, if you want to move a piece instead, click on a piece in the board, then click on a legal empty hexagon in the board to move it there. Keep in mind that if a beetle moves over a piece, the piece underneath it is still there, even though it is not visible. The game will prevent you from making an illegal move. **Note:** If you select a piece and realize you don't want to place or move it anywhere, clicking anywhere that is not a legal move will deselect the piece. The game will not allow you from selecting a piece you cannot move or place.

Keep in mind that the game **will** force you to place your queen by your fourth turn if you haven't already, and that it will not let you move pieces until you have placed your queen.

If a player cannot move on a certain turn, click anywhere on the screen and the game will automatically shift to the next player's turn. (only if the player really cannot move)

The colored bar represents whose turn it is.

Press r to restart the game at any time.

## Presentation Link
https://drive.google.com/file/d/1qtStETaygVFMd0bHVzobtm6KbsPrsyqi/view?usp=sharing
## Major Bugs
+ Clicking outside the bounds of the board may result in the game breaking
+ Clicking on a piece / hexagon must be within the center of the piece / hexagon, as the click detection detects a rectangle in the center of each hexagon
  
While they are not bugs, the following are features of our game that are different from the regular board game, due to difficulty implementing
+ The space is limited to a 12x23 board. This changes the strategy of the game by bringing edges and corners into play, and makes it easier to trap pieces.
+ Spiders not only have to move exactly three spaces, they can only move to a space which is three spaces away. In the board game, spiders can move to hexagons less than 3 three spaces away if they can get there by moving three spaces.
