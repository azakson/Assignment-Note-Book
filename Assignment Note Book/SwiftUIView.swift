//
//  SwiftUIView.swift
//  Assignment Note Book
//
//  Created by Avery Zakson on 2/9/21.
//

import SwiftUI

struct AddView: View {
    @ObservedObject var assignmentList: AssignmentList
    @State private var course = ""
    @State private var description = ""
    @State private var dueDate = Date()
    @Environment(\.presentationMode) var presentationMode
    static let courses = ["Math", "Graphic Design", "Mobile Apps", "Physics", "English", "Chinese", "Computer Science"]
    
    var body: some View {
        NavigationView {
            Form {
                Picker("Course", selection: $course) {
                    ForEach(Self.courses, id: \.self) { course in
                        Text(course)
                    }
                }
                TextField("Description", text: $description)
                DatePicker("DueDate", selection: $dueDate, displayedComponents: .date)
            }
            .navigationBarTitle("New Assignment")
            .navigationBarItems(trailing: Button("Save") {
                if course.count > 0 && description.count > 0 {
                    let item = Assignment(id: UUID(), classes: course, description: description, dueDate: dueDate)
                    assignmentList.items.append(item)
                    presentationMode.wrappedValue.dismiss()
                }
            })
        }
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(assignmentList: AssignmentList())
    }
}
