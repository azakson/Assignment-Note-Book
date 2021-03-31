//
//  AddItemView.swift
//  to do
//
//  Created by Avery Zakson on 2/2/21.
//

import SwiftUI

struct SwiftUIView: View {
    
    @ObservedObject var assignmentsList: AssignmentList
    @State private var courses = ""
    @State private var description = ""
    @State private var dueDate = Date()
    @Environment(\.presentationMode) var presentationMode
    static let courses = ["Math", "Graphic Design", "Mobile Apps", "Physics", "English", "Chinese", "Computer Science"]
    
    var body: some View {
        NavigationView {
            Form {
                Picker("Course",  selection: $courses) {
                    ForEach(Self.courses, id: \.self) { courses in
                        Text(courses)
                    }
                }
                TextField("Description", text: $description)
                DatePicker("Due Date", selection: $dueDate, displayedComponents: .date)
            }
            .navigationBarTitle("New Assignment")
            .navigationBarItems(trailing: Button("Save") {
                if(courses.count > 0 && description.count > 0) {
                    let item = Assignment(id: UUID(),
                                        course: courses,
                                        description: description,
                                        dueDate: dueDate)
                    assignmentsList.items.append(item)
                    presentationMode.wrappedValue.dismiss()
                }
            })
        }
    }
}

struct AddItemView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIView(assignmentsList: AssignmentList())
    }
}
