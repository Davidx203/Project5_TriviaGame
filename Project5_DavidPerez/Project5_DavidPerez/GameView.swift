//
//  GameView.swift
//  Project5_DavidPerez
//
//  Created by David Perez on 10/13/24.
//

import SwiftUI

struct GameView: View {
    @State var submit = false
    @State var timeRemaining: Int // The time passed from the previous view

    // Timer to decrease time remaining
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    @State var questions: [Question]

    @State var correct = 0
    @State var questionsCount = 0
    var body: some View {
        VStack {
            Text("Time Remaining: \(timeRemaining) seconds")
                .font(.headline)
                .onReceive(timer) { _ in
                    if timeRemaining > 0 {
                        timeRemaining -= 1
                    } else {
                        //submit = true
                    }
                }
            ScrollView(content: {
                VStack{
                    ForEach(questions.indices) {questionIndex in
                        Text("\(questions[questionIndex].question)")
                        ForEach(questions[questionIndex].allanswers, id: \.self) { answer in
                            GameButtonView(answer: answer, question: $questions[questionIndex])
                                
                        }
                    }
                }
                .padding()
                .background(content: {
                    Color.white
                })
                .padding()
            })
            .background(content: {
                Color.init(red: 0.95, green: 0.95, blue: 0.95)
            })
            .padding(.horizontal)
            Button(action: {
                submit = true
                
                
                for questionIndex in questions.indices {
                    if(questions[questionIndex].correct_answer == questions[questionIndex].userAnswer){
                        correct += 1
                        questionsCount += 1
                    } else {
                        questionsCount += 1
                    }
                }
            }) {
                Rectangle()
                    .frame(height: 50)
                    .foregroundColor(.green)
                    .cornerRadius(10)
                    .overlay(Text("Submit").foregroundColor(.white))
                    .shadow(radius: 10)
            }
            .padding()
            .alert("Score", isPresented: $submit) {
                Button("OK", action: {submit = false})
            } message: {
                Text("You scored \(correct) out of \(questionsCount)")
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(red: 0.8, green: 0.9, blue: 0.8).ignoresSafeArea())
        .onAppear(perform: {
            print("Questions: \(questions)")
        })
    }
}

#Preview {
    GameView(timeRemaining: 60, questions: [])
}
