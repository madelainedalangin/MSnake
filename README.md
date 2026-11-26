# MSnake

Madelaine's Hungry Snake: a snake game in the style of the Nokia 5110 and the other Nokia phones that made snake popular in the late 1990s and early 2000s. Instead of pressing 2, 4, 6 and 8 on a keypad, you steer the snake by swiping.


## How to play

- The snake moves on its own. Swipe on the grid to change its direction.
  - On iPhone or iPad, swipe with your finger.
  - On a Mac, click and drag on the grid with your trackpad or mouse.
- Eat the food to grow longer and score a point. The food is a random pick of steak, banana, taco, mango or a rat.
- The snake speeds up every time it eats.
- Hitting a wall or your own body ends the game. Press **Play Again** to start over.

## Run it

You need a Mac with Xcode 16 or later.

1. Open `MSnake.xcodeproj` in Xcode.
2. Choose where to run it at the top of the window: an iPhone or iPad simulator, or **My Mac (Designed for iPad)** on an Apple silicon Mac.
3. Press **Cmd+R**.

To run it on your own iPhone or iPad (iOS 18.5 or later), select your team under **Signing & Capabilities** first.

## How it works

The whole game lives in `ContentView.swift`, built with SwiftUI.

- **Board:** a 12 by 12 grid. The snake is an array of grid positions, with the head first.
- **Movement:** a `Timer` moves the snake one cell per tick. Each move adds a new head in the current direction and removes the tail, unless the snake just ate, which is how it grows.
- **Speed:** the time between moves starts at 0.5 seconds and shrinks by a quarter with each piece of food, down to a minimum of 0.02 seconds. After eating $n$ pieces of food:

```math
t_n = \max\left(0.02,\ 0.5 \times 0.75^{n}\right) \text{ seconds}
```

- **Swipes:** a `DragGesture` compares the horizontal and vertical distance of each swipe and turns the snake in the larger direction. It ignores swipes that would reverse the snake straight into itself.
- **Game over:** the game ends when the next head position is off the grid or already part of the snake.
- **Food:** spawns at a random empty cell, never on the snake.

## Project structure

```
MSnake/
  MSnakeApp.swift      app entry point
  ContentView.swift    game logic and interface
  Assets.xcassets      app icon and colours
MSnakeTests/           unit test target
MSnakeUITests/         UI test target
```
