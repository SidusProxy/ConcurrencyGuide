//
//  ContentView.swift
//  ConcurrencyGuide
//
//  Created by Giuseppe Carannante on 31/03/22.
//

import SwiftUI

struct ContentView: View {
    var examActor = ExamActor()
    var body: some View {
        Text("Hello, world!")
            .padding().onTapGesture {
                Task{
                    try? await examActor.updateExam(oldName: "LSO", newName: "INGSW")
                }
            }
            .task {
                
                try? await examActor.updateExam(oldName: "LSO", newName: "INGSW")
                
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
