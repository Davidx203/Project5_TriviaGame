//
//  QuestionViewModel.swift
//  Project5_DavidPerez
//
//  Created by David Perez on 10/13/24.
//
struct TriviaResponse: Codable {
    let response_code: Int
    let results: [Question]
}

import Foundation

class TriviaViewModel: ObservableObject {
    @Published var questions: [Question] = []
    @Published var urlString = "https://opentdb.com/api.php?amount="
    
    
    func getTriviaQuestions(questionCount: String, category: String, difficulty: String, type: String, completion: @escaping ([Question]) -> Void) {
        if(questionCount != ""){
            urlString += "\(questionCount)"
        } else {
            urlString += "10"
        }
        
        if(category != ""){
            var categoryInNum = 9
            if(category == "generalknowledge"){
                categoryInNum = 9
            } else if(category == "books"){
                categoryInNum = 10
            } else if(category == "films"){
                categoryInNum = 11
            } else if(category == "music"){
                categoryInNum = 12
            } else if(category == "musicalsandtheatres"){
                categoryInNum = 13
            } else if(category == "television"){
                categoryInNum = 14
            } else if(category == "videogames"){
                categoryInNum = 15
            } else if(category == "boardgames"){
                categoryInNum = 16
            } else if(category == "scienceandnature"){
                categoryInNum = 17
            } else if(category == "computers"){
                categoryInNum = 18
            } else if(category == "mathematics"){
                categoryInNum = 19
            } else if(category == "mythology"){
                categoryInNum = 20
            } else if(category == "sports"){
                categoryInNum = 21
            } else if(category == "geography"){
                categoryInNum = 22
            } else if(category == "history"){
                categoryInNum = 23
            } else if(category == "politics"){
                categoryInNum = 24
            } else if(category == "art"){
                categoryInNum = 25
            } else if(category == "celebrities"){
                categoryInNum = 26
            } else if(category == "animals"){
                categoryInNum = 27
            } else if(category == "vehicles"){
                categoryInNum = 28
            } else if(category == "comics"){
                categoryInNum = 29
            } else if(category == "gadgets"){
                categoryInNum = 30
            } else if(category == "japanseseanimeandmanga"){
                categoryInNum = 31
            } else if(category == "cartoonandanimations"){
                categoryInNum = 32
            }
            
            urlString += "&category=\(categoryInNum)"
        }
        
        if(difficulty != ""){
            //urlString += "&difficulty=\(difficulty)"
        }
        
        if(type != ""){
            urlString += "&type=\(type)"
        }
        
        print("url string: \(urlString)")
        
        //urlString = "https://opentdb.com/api.php?amount=10&category=10"
        
        //print("url string: \(urlString)")
        guard let url = URL(string: urlString) else {
            completion([])
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                // 3. Decode the JSON response
                do {
                    let decodedResponse = try JSONDecoder().decode(TriviaResponse.self, from: data)
                    print("decoded response: \(decodedResponse)")
                    DispatchQueue.main.async {
                        completion(decodedResponse.results)
                    }
                } catch {
                    print("Error decoding data: \(error)")
                    completion([]) // Return empty if error
                }
            } else{
                completion([]) // Return empty if there's a network issue
            }
        }.resume()
        urlString = "https://opentdb.com/api.php?amount="
    }
    
    
}
