//
//  SearchCatechismView.swift
//  Westminster Standards
//
//  Created by Matt Robertson on 1/7/22.
//

import SwiftUI

struct SearchCatechismView: View {

    var catechism: Catechism
    @Binding var searchText: String

    @EnvironmentObject var theme: Theme
    
    init(_ catechism: Catechism, search searchText: Binding<String>) {
        self.catechism = catechism
        self._searchText = searchText
    }

    var body: some View {
        VStack {
            ForEach(catechism.questions.indices, id: \.self) { i in
                let question = catechism.questions[i].question
                let answer = catechism.questions[i].answer
                
                let matchesQuestion = question.localizedCaseInsensitiveContains(searchText)
                let matchesAnswer = answer.localizedCaseInsensitiveContains(searchText)

                if matchesQuestion || matchesAnswer {
                    VStack(alignment: .leading) {
                        Group {
                            Text("Q\(i + 1). ") + highlightSearchHits(
                                matchedText: question,
                                searchText: searchText,
                                theme: theme
                            )
                        }
                        .font(.system(size: 18, weight: .bold))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Group {
                            Text("A. ") + highlightSearchHits(
                                matchedText: answer,
                                searchText: searchText,
                                theme: theme
                            )
                        }
                        .font(.system(size: 18))
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top)
                }
            }
        }
    }
}
