//
//  ContentView.swift
//  MSnake
//
//  Created by Madelaine Dalangin on 2025-06-01.
//

import SwiftUI

struct Grid: Equatable, Hashable {
    var col: Int
    var row: Int
}

enum Direction {
    case down, left, right, up
}

struct ContentView: View {
    let gridSize = 12
    let cellSize: CGFloat = 30
    
    @State var snake: [Grid] = [Grid(col: 5, row: 5)]
    @State private var snakeFood: Grid = Grid(col: 2, row: 5)
    @State private var direction: Direction = .right
    @State private var isGameOver: Bool = false
    @State private var score: Int = 0
    @State private var highScore: Int = 0
    @State private var timer: Timer? = nil
    @State private var fasterSnake: Double = 0.5
    
    //Random foods for funsies
    let food = ["🥩", "🍌", "🌮", "🥭", "🐀"]
    @State private var foodCurrentlyShown: String = "🐀"

    var body: some View {
        ZStack {
            //Game Background
            LinearGradient(
                gradient: Gradient(
                    colors: [.blue, .black]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing,)
            .edgesIgnoringSafeArea(.all)
            
            //Big header
            VStack(spacing: 16) {
                HStack {
                    Spacer()
                    Text("Bubu's Hungry Snake")
                        .font(.largeTitle.bold())
                        .foregroundStyle(
                            LinearGradient(gradient: Gradient(colors: [.purple, .mint]),
                            startPoint: .leading, endPoint: .trailing))
                        .shadow(radius: 4)
                    Spacer()
                }
                
                
                //Snake Grid
                ZStack {
                    ForEach(0..<gridSize, id: \.self) { row in
                        ForEach(0..<gridSize, id: \.self) { col in
                            Rectangle()
                                .fill(Color.black.opacity(0.2)) // optional styling
                                .stroke(Color.black.opacity(0.1), lineWidth: 1)
                                .frame(width: cellSize, height: cellSize)
                                .position(
                                    x: CGFloat(col) * cellSize + cellSize / 2,
                                    y: CGFloat(row) * cellSize + cellSize / 2
                                )
                        }
                    }
                    //Snek body
                    ForEach(snake, id: \.self) { segment in
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color.green)
                            .frame(width: cellSize, height:cellSize)
                            .position(
                                x: CGFloat(segment.col) * cellSize + cellSize / 2,
                                y: CGFloat(segment.row) * cellSize + cellSize / 2
                            )
                    }
                    //Snake Food
                    Text(foodCurrentlyShown)
                        .font(.system(size: cellSize))
                        .position(
                            x: CGFloat(snakeFood.col) * cellSize + cellSize / 2,
                            y: CGFloat(snakeFood.row) * cellSize + cellSize / 2
                        )
                }
                .frame(
                    width: CGFloat(gridSize) * cellSize,
                    height: CGFloat(gridSize) * cellSize)
                .gesture(swiping)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            .onAppear {
                startTimer()
            }
            .onDisappear {
                timer?.invalidate()
            }
        }
    }
    //Timer
    func startTimer(){
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: fasterSnake, repeats: true) { _ in
            moveSnake()
        }
    }
    //Snek movement
    func moveSnake() {
        if isGameOver {
            return
        }
        var newHead = snake[0]
        switch direction {
        case .up:
            newHead.row -= 1
        case .down:
            newHead.row += 1
        case .left:
            newHead.col -= 1
        case .right:
            newHead.col += 1
        }
        //Collisions
        if newHead.col < 0 || newHead.col >= gridSize || newHead.row < 0 || newHead.row >= gridSize || snake.contains(newHead){
            isGameOver = true
            timer?.invalidate()
            return
        }
        snake.insert(newHead, at: 0)
        if newHead == snakeFood {
            spawnFood()
            fasterSnake = max(0.02, fasterSnake * 0.75)
            startTimer()
        } else {
            snake.removeLast()
        }
    }
    func spawnFood(){
        var newFood: Grid
        repeat {
            newFood = Grid(col: Int.random(in: 0..<gridSize), row: Int.random(in: 0..<gridSize))
        } while snake.contains(newFood)
        snakeFood = newFood
        foodCurrentlyShown = food.randomElement() ?? "🍎"
    }
    
    var swiping: some Gesture {
        DragGesture(minimumDistance: 10)
            .onEnded { gesture in
                let translation = gesture.translation
                if abs(translation.width) > abs(translation.height) {
                    if translation.width > 0 && direction != .left {
                        direction = .right
                    } else if translation.width < 0 && direction != .right {
                        direction = .left
                    }
                } else {
                    if translation.height > 0 && direction != .up {
                        direction = .down
                    } else if translation.height < 0 && direction != .down {
                        direction = .up
                    }
                }
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
                
