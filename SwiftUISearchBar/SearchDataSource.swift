//
//  SearchDataSource.swift
//  SwiftUISearchBar
//
//  Created by Guanghui Liang on 2024/4/13.
//

import Foundation

final class SearchDataSource: ObservableObject {
    
    @Published var currentText: String = "Initial Value"
    
    let values = [
        "Tom",
        "Jerry",
        "Bob",
        "John",
        "Peter",
        "Marry",
        "Lucy",
        "Tony",
        "Smith",
        "Harry",
        "Hermione",
        "Ron",
        "Apple",
        "banana",
        "Watermelon",
        "Pear",
        "Orange",
        "Tomato",
        "Mango",
        "Cherry",
        "Strawberry"
    ]
}
