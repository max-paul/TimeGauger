//
//  TimeGaugerApp.swift
//  TimeGauger
//
//  Created by Max Paul on 11/27/23.
//

import SwiftUI

struct Task {
    var name: String
    var time: Double
}

class TaskManager: ObservableObject {
    @Published var tasks: [Task] = []
    @Published var totalAvailableTime: Double = 24 // Assuming a day has 24 hours

    func addTask(name: String, time: Double) {
        tasks.append(Task(name: name, time: time))
    }

    func calculateTimeUsed() -> Double {
        return tasks.reduce(0) { $0 + $1.time }
    }
}



struct GaugeView: View {
    var timeUsed: Double
    var totalAvailableTime: Double

    var body: some View {
        VStack {
            Text("Gauge")
                .font(.title)
                .fontWeight(.bold)

            if timeUsed <= totalAvailableTime {
                Text("You have sufficient spare time.")
                    .foregroundColor(.green)
            } else {
                Text("You are too busy.")
                    .foregroundColor(.red)
            }

            ProgressView(value: timeUsed, total: totalAvailableTime)
                .padding()
        }
    }
}

struct EditDayView: View {
    var dayIndex: Int?

    var body: some View {
        Text("Edit Day \(dayIndex ?? 0) Info")
            .navigationTitle("Edit Day")
    }
}

@main
struct TimeGaugerApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
