//
//  ContentView.swift
//  Assignment Note Book
//
//  Created by Avery Zakson on 2/9/21.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var assignmentList = AssignmentList()
    @State private var showAddview = false
    
    var body: some View {
        NavigationView{
            List {
                ForEach(assignmentList.items) { item in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(item.classes)
                                .font(.headline)
                            Text(item.description)
                        }
                        Spacer()
                        Text(item.dueDate, style: .date)
                    }
                }
                .onMove(perform: { indices, newOffset in
                    assignmentList.items.move(fromOffsets: indices, toOffset: newOffset)
                })
                .onDelete(perform: { indexSet in
                    assignmentList.items.remove(atOffsets: indexSet)
                })
            }
            .sheet(isPresented: $showAddview, content: {
                AddView(assignmentList: assignmentList)
            })
            navigationBarTitle("Assignment Notebook")
            navigationBarItems(leading: EditButton(), trailing: Button(action: {
                                                                        showAddview = true }) {
                Image(systemName: "plus" )
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
    var classes = String()
    var description = String()
    var dueDate = Date()
}
