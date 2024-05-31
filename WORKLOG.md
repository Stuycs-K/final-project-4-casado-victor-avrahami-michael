# Work Log

## Victor Casado

### date 5/22

Made GamePiece Class

Note: canMove method has to be in game class, not in GamePiece class


## Michael Avrahami

### date 5/22

Added accessor methods to GamePiece class
Created five subclasses of GamePiece and filled in code for them
Uncommented "name" instance variable as it could be useful for toString or display


## Victor Casado

### date 5/23

Added methods to GamePiece class (set new location)
Made Game Class, added instance variable, check if queens are surrounded, toggling turn, set queen reference


## Michael Avrahami

### date 5/23

Created an inlaid hexagon board display in processing.
Wrote logic to only display pieces in array
Temporarily customized different piece display

## Victor Casado

### date 5/23

Added method isHiveConnected() to Game class and all helper methods necessary   
the method checks if the hive is connected, to be used when checking if a piece can move
utilizes depth-first-search

### date 5/24

Added piece specific movement for Ant, Spider, and Queen
added a way to find a neighbor based on a direction for grasshopper movement
still have to test all of it so remains on branch

### date 5/28
grasshopper specific movement and merged with main
added images for each piece

## Michael Avrahami
### date 5/28
put all classes except beetle into processing

## Victor Casado
### date 5/29 
found legal placements, detect if placement is legal, whether a piece can move

## Michael Avrahami
### date 5/29
Created border between unplaced and placed pieces
Wrote makeAction function, which detects which piece has been clicked and makes an action based on it

## Michael Avrahami
### date 5/30
Finished addPiece part of the game loop
- Set up function for movePiece as well

## Victor Casado
### date 5/30 
pieces have images now, fixed bug that would crash game
### date 5/31
fixed ant image, add piece checks legality (kinda broke but fixable)
fixed a nullPointerException bug

## Michael Avrahami
### date 5/31
Worked on addPiece and fixed bugs in it
Fixed bugs in various other functions like findAction
