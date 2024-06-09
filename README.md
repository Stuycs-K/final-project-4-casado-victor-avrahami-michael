[![Review Assignment Due Date](https://classroom.github.com/assets/deadline-readme-button-24ddc0f5d75046c5622901739e7c5dd533143b0c8e959d652212380cedb1ea36.svg)](https://classroom.github.com/a/syDSSnTt)
# Hive - APCS2 Final Project
## Group Info
**Name:** Miners of Moria
**Group Members:** Michael Avrahami, Victor Casado
## Overview
Our project is to replicate the not-too-well-known board game Hive in processing. Hive is a strategy game similar to chess, where each piece has different movement types, except there is no board. Instead, the pieces make up the board, and you can place new pieces next to your existing ones. The goal of the game is to surround the opponent's Queen (Queen Bee because Hive is bug-themed) with other pieces, which is equivalent to a checkmate in chess.
## Instructions
The rules of the game of hive can be found at this link: https://www.gen42.com/download/rules/hive/Hive_English_Rules.pdf

In general, the program will show only legal moves and will force you to play only legal moves. The game will also end when it is supposed to. However, it is worth noting that the first piece can be placed anywhere on the board, and the second piece (player 2's first piece) must be placed next to player 1's. After that, the normal one hive and only placing your piece next to your pieces onlny rules apply. (see placing pieces rules)

Click on a piece in the sidebar to select it, then click on a legal empty hexagon in the board to place it down. Alternatively, if you want to move a piece instead, click on a piece in the board, then click on a legal empty hexagon in the board to move it there. The game will prevent you from making an illegal move. **Note:** If you select a piece and realize you can't place/move it anywhere, or you don't want to place or move it anywhere, select a random illegal hexagon somewhere on the board and the piece will be deselected.

Press r to restart the game at any time.

## Presentation Link
INSERT HERE
## Major Bugs
While they are not bugs, the following are features of our game that are different from the regular board game, due to difficulty implementing
+ The space is limited to a 23x23 board. This changes the strategy of the game by bringing edges and corners into play, and makes it easier to trap pieces.
+ Spiders not only have to move exactly three spaces, they can only move to a space which is three spaces away. In the board game, spiders can move to hexagons less than 3 three spaces away if they can get there by moving three spaces.
