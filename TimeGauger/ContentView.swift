//
//  ContentView.swift
//  TimeGauger
//
//  Created by Max Paul on 11/27/23.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var taskManager = TaskManager()

    @State private var taskName = ""
    @State private var taskTime = ""
    @State private var editingDayIndex: Int?

    var body: some View {
        NavigationView {
            VStack {
                Text("Time Gauger!")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding()
                    .multilineTextAlignment(.center)
                GaugeView(timeUsed: taskManager.calculateTimeUsed(), totalAvailableTime: taskManager.totalAvailableTime)
                    .padding()

                List {
                    ForEach(0..<taskManager.tasks.count, id: \.self) { index in
                        Text("\(taskManager.tasks[index].name): \(taskManager.tasks[index].time) hours")
                    }
                    .onDelete { indexSet in
                        taskManager.tasks.remove(atOffsets: indexSet)
                    }
                }
                .padding()

                HStack {
                    TextField("Task Name", text: $taskName)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()

                    TextField("Time (hours)", text: $taskTime)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .keyboardType(.numberPad)
                        .padding()

                    Button("Add Task") {
                        if let time = Double(taskTime) {
                            taskManager.addTask(name: taskName, time: time)
                            taskName = ""
                            taskTime = ""
                        }
                    }
                    .padding()
                }

            }
        }
    }
}
