//
//  ContentView.swift
//  Assignment Note Book
//
//  Created by Avery Zakson on 2/9/21.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var assignmentsList = AssignmentList()
    @State private var showingAddView = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(assignmentsList.items) {item in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(item.course)
                                .font(.headline)
                            Text(item.description)
                        }
                        Spacer()
                        Text(item.dueDate, style: .date)
                    }
                }
                .onMove(perform: { indices, newOffset in
                    assignmentsList.items.move(fromOffsets: indices, toOffset: newOffset)
                })
                .onDelete(perform: { indexSet in
                    assignmentsList.items.remove(atOffsets: indexSet)
                })
            }
            .sheet(isPresented: $showingAddView, content: {
                SwiftUIView(assignmentsList: assignmentsList)
            })
            .navigationBarTitle("Assignments")
            .navigationBarItems(leading: EditButton(),
                                trailing: Button(action: {
                                                    showingAddView = true }) {
                                    Image(systemName: "plus")
                                })
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct Assignment: Identifiable, Codable {
    var id = UUID()
    var course = String()
    var description = String()
    var dueDate = Date()
}



