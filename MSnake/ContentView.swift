//
//  ContentView.swift
//  MSnake
//
//  Created by Madelaine Dalangin on 2025-06-01.
//

import SwiftUI

struct SnakeGrid: Equatable, Hashable {
    var col: Int
    var row: Int
}

enum Direction {
    case down, left, right, up
}

struct ContentView: View {
    let gridSize = 12
    let cellSize: CGFloat = 30
    
    @State var snake: [SnakeGrid] = [SnakeGrid(col: 9, row: 9)]
    @State private var snakefood: SnakeGrid = SnakeGrid(col: 2, row: 5)
    @State private var direction: Direction = .right
    @State private var isGameOver: Bool = false
    @State private var score: Int = 0
    @State private var highScore: Int = 0
    @State private var timer = Timer.publish(every: 0.5, on: .main, in: .common)
    
    
    var body: some View {
        ZStack {
            //Game Background
            LinearGradient(
                gradient: Gradient(
                colors: [.blue, .black]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing,)
            .edgesIgnoringSafeArea(.all)
            
            //Big big header
            VStack(spacing: 16) {
                HStack {
                    Spacer()
                    Text("Madelaine's Snake")
                        .font(.largeTitle.bold())
                        .foregroundStyle(
                            LinearGradient(gradient: Gradient(colors: [.yellow, .mint]),
                                           startPoint: .leading, endPoint: .trailing))
                        .shadow(radius: 4)
                    Spacer()
                }
                
                //Grid
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
                }
                .frame(width: CGFloat(gridSize) * cellSize, height: CGFloat(gridSize) * cellSize)
            }
        }
    }
}

#Preview {
    ContentView()
}
