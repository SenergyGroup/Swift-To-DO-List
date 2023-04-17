//
//  ListView.swift
//  To Do List
//
//  Created by Aaron Reinke on 4/17/23.
//

import SwiftUI
import CoreData

struct ListView: View {
    @Environment(\.managedObjectContext) private var viewContext
        
    @FetchRequest(
        entity: Task.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \Task.title, ascending: true)]
    ) private var tasks: FetchedResults<Task>
        
    @State private var showAlert = false
    @State private var inputText = ""
   
    var body: some View {
        NavigationView {
            List {
                ForEach(tasks, id: \.self) { task in
                    Text(task.title ?? "")
                }
                .onDelete(perform: deleteTasks)
            }
            .navigationBarTitle("To Do List")
            .navigationBarItems(trailing: Button(action: {
                showAlert = true
            }, label: {
                Image(systemName: "plus")
            }))
        }
        .overlay(
            Group {
                if showAlert {
                    Color.black.opacity(0.3)
                        .edgesIgnoringSafeArea(.all)
                    
                    TextInputAlertView(showAlert: $showAlert) { newTask in
                        addTask(title: newTask)
                    }
                }
            }
        )
    }
    
    // Add Tasks function
    private func addTask(title: String) {
        let newTask = Task(context: viewContext)
        newTask.title = title

        do {
            try viewContext.save()
        } catch {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
    }
    
    // Delete Tasks function
    private func deleteTasks(offsets: IndexSet) {
            withAnimation {
                offsets.map { tasks[$0] }.forEach(viewContext.delete)

                do {
                    try viewContext.save()
                } catch {
                    let nserror = error as NSError
                    fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
                }
            }
        }
}


struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView()
    }
}
