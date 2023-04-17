//
//  TextInputAlertView.swift
//  To Do List
//
//  Created by Aaron Reinke on 4/17/23.
//

import SwiftUI

struct TextInputAlertView: View {
    @Binding var showAlert: Bool
    @State private var inputText: String = ""
    let onDone: (String) -> Void
    
    var body: some View {
        
            VStack {
                TextField("Enter your task", text: $inputText)
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                HStack {
                    Button("Cancel") {
                        showAlert = false
                    }
                    .padding()
                    
                    Button("Done") {
                        onDone(inputText)
                        showAlert = false
                    }
                    .padding()
                }
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color.gray.opacity(0.25)))
    }
}
