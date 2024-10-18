//
//  ContentView.swift
//  Project5_DavidPerez
//
//  Created by David Perez on 10/13/24.
//

import SwiftUI

struct ContentView: View {
    enum Category: String, CaseIterable, Identifiable {
        case generalknowledge, books, films, music, musicalsandtheatres, television, videogames, boardgames, scienceandnature, computers, mathematics, mythology, sports, geography, history, politics, art, celebrities, animals, vehicles, comics, gadgets, japaneseanimeandmanga, cartoonandanimations
        var id: Self { self }
    }
    
    enum QuestionType: String, CaseIterable, Identifiable {
        case any, boolean, multiple
        var id: Self { self }
    }
    
    enum Duration: String, CaseIterable, Identifiable {
        case thirtySecs, sixtySecs, onehundredtwentySecs, threehundredSecs, oneHour
        var id: Self { self }
    }

    @State private var selectedCategory: Category = .generalknowledge
    @State private var selectedDifficulty: Double = 0
       
    @State private var selectedQuestionType: QuestionType = .boolean
    @State private var selectedTimeDuration: Duration = .thirtySecs
    
    @State var numQuestions = ""
    @State var showGame = false
    @State var questions : [Question] = []
    @StateObject var triviaVM = TriviaViewModel()
    
    var body: some View {
        NavigationStack{
            VStack {
                Text("Trivia Game")
                    .font(.title)

                List(content: {
                    TextField("Number of Questions", text: $numQuestions)
                    Picker("Select Category", selection: $selectedCategory) {
                        Text("General Knowledge").tag(Category.generalknowledge)
                        Text("Entertainment: Books").tag(Category.books)
                        Text("Entertainment: Film").tag(Category.films)
                        Text("Entertainment: Music").tag(Category.music)
                        Text("Entertainment: Musicals & Theatres").tag(Category.musicalsandtheatres)
                        Text("Entertainment: Television").tag(Category.television)
                        Text("Entertainment: Video Games").tag(Category.videogames)
                        Text("Entertainment: Board Games").tag(Category.boardgames)
                        Text("Science & Nature").tag(Category.scienceandnature)
                        Text("Science: Computers").tag(Category.computers)
                        Text("Science: Mathematics").tag(Category.mathematics)
                        Text("Mythology").tag(Category.mythology)
                        Text("Sports").tag(Category.sports)
                        Text("Geography").tag(Category.geography)
                        Text("History").tag(Category.history)
                        Text("Politics").tag(Category.politics)
                        Text("Art").tag(Category.art)
                        Text("Celebrities").tag(Category.celebrities)
                        Text("Animals").tag(Category.animals)
                        Text("Vehicles").tag(Category.vehicles)
                        Text("Entertainment: Comics").tag(Category.comics)
                        Text("Science: Gadgets").tag(Category.gadgets)
                        Text("Entertainment: Japanese Anime & Manga").tag(Category.japaneseanimeandmanga)
                        Text("Entertainment: Cartoon & Animations").tag(Category.cartoonandanimations)
                    }
                    HStack{
                        Text("Difficulty: \(difficultyText())")
                        
                        Slider(value: $selectedDifficulty, in: 0...2, step: 1, label: {
                            Text("Hello")
                                .foregroundStyle(.black)
                        })
                    }
                    Picker("Select Type", selection: $selectedQuestionType) {
                        Text("Any Type").tag(QuestionType.any)
                        Text("True or False").tag(QuestionType.boolean)
                        Text("Multiple Choice").tag(QuestionType.multiple)
                        
                    }
                    
                    Picker("Time Duration", selection: $selectedTimeDuration) {
                        Text("").tag("")
                        Text("30 seconds").tag(Duration.thirtySecs)
                        Text("60 seconds").tag(Duration.sixtySecs)
                        Text("120 seconds").tag(Duration.onehundredtwentySecs)
                        Text("300 seconds").tag(Duration.threehundredSecs)
                        Text("1 hour").tag(Duration.oneHour)
                    }
                    
                    
                })
                .frame(maxHeight: .infinity)
                .foregroundStyle(.black)
                .ignoresSafeArea()
                .tint(.gray)
                
                Button(action: {
                    triviaVM.getTriviaQuestions(questionCount: numQuestions, category: selectedCategory.rawValue, difficulty: difficultyText(), type: selectedQuestionType.rawValue, completion:  { fetchedQuestions in
                        self.questions = fetchedQuestions
                        showGame = true
                    })
                    
                    
                }, label: {
                    Rectangle()
                        .frame(height: 50)
                        .foregroundStyle(.green)
                        .tint(.green)
                        .clipShape(.capsule)
                        .overlay(content: {
                            Text("Start Trivia")
                        })
                        .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                })
                .padding()
            }
            
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(content: {
                Color.blue
                    .ignoresSafeArea()
            })
            .foregroundStyle(.white)
            .tint(.white)
            .navigationDestination(isPresented: $showGame, destination: {
                
                GameView(timeRemaining: timeSelectedConvert(), questions: questions)
            })
        }
    }
    func difficultyText() -> String {
        switch selectedDifficulty {
        case 0:
            return "easy"
        case 1:
            return "medium"
        case 2:
            return "hard"
        default:
            return "Easy"
        }
    }
    
    func timeSelectedConvert() -> Int {
        switch selectedTimeDuration {
        case .thirtySecs:
            return 30
        case .sixtySecs:
            return 60
        case .onehundredtwentySecs:
            return 120
        case .threehundredSecs:
            return 300
        case .oneHour:
            return 3600
        }
    }
}

#Preview {
    ContentView()
}
