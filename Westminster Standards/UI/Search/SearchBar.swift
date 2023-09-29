//
//  ContentView.swift
//  Westminster Standards
//
//  Created by Matt Robertson on 1/7/22.
//

import SwiftUI

struct SearchBar: UIViewRepresentable {

    @Binding var text: String
    @Binding var tab: WestminsterContent

    class Coordinator: NSObject, UISearchBarDelegate {

        @Binding var text: String

        init(text: Binding<String>) {
            _text = text
        }

        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            text = searchText
        }
        
        func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
            UIApplication.shared.endEditing()
        }
    }

    func makeCoordinator() -> SearchBar.Coordinator {
        return Coordinator(text: $text)
    }

    func makeUIView(context: UIViewRepresentableContext<SearchBar>) -> UISearchBar {
        let searchBar = UISearchBar(frame: .zero)
        searchBar.delegate = context.coordinator
        searchBar.searchBarStyle = .minimal
        switch tab {
        case .wcf:
            searchBar.placeholder = "Search the Confession"
        case .wlc:
            searchBar.placeholder = "Search the Larger Catechism"
        case .wsc:
            searchBar.placeholder = "Search the Shorter Catechism"
        }
        
        return searchBar
    }

    func updateUIView(_ searchBar: UISearchBar, context: UIViewRepresentableContext<SearchBar>) {
        searchBar.text = text
        
        switch tab {
        case .wcf:
            searchBar.placeholder = "Search the Confession"
        case .wlc:
            searchBar.placeholder = "Search the Larger Catechism"
        case .wsc:
            searchBar.placeholder = "Search the Shorter Catechism"
        }
    }
}

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
