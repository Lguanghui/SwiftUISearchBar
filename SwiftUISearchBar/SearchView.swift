//
//  SearchView.swift
//  SwiftUISearchBar
//
//  Created by Guanghui Liang on 2024/4/13.
//

import SwiftUI

struct SearchEntranceView: View {
    @ObservedObject var dataSource = SearchDataSource()
    
    @State var isPopoverPresented: Bool = false
        
    var body: some View {
        HStack {
            Text(dataSource.currentText)
                .frame(alignment: .trailing)
            Image(systemName: "slider.horizontal.3")
                .resizable()
                .frame(width: 12, height: 12)
                .scaledToFit()
                .padding(.bottom, -1)
        }
        .foregroundStyle(.black)
        .onTapGesture {
            isPopoverPresented.toggle()
        }
        .popover(isPresented: $isPopoverPresented, arrowEdge: .bottom, content: {
            SearchView { val in
                isPopoverPresented.toggle()
                dataSource.currentText = val
            }
            .environmentObject(dataSource)
            .frame(maxHeight: .infinity)
            .padding()
        })
    }
}


struct SearchView: View {
    typealias Value = String
    
    @State var searchText: Value = ""
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    @EnvironmentObject var dataSource: SearchDataSource

    var clickBlock: ((Value) -> Void)?
    
    static var size: GridItem.Size {
        get {
            .flexible(minimum: 85, maximum: .infinity)
        }
    }
    
    let columns = [
            GridItem(size),
            GridItem(size),
            GridItem(size),
            GridItem(size),
            GridItem(size),
            GridItem(size)
        ]
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "magnifyingglass")
                    .padding(.leading, 3)
                
                TextField("search", text: $searchText, prompt: Text("Input text to search."))
                    .textFieldStyle(.plain)
            }
            .frame(height: 30)
            .padding(.all, 3)
            .clipShape(.rect(cornerRadius: 8, style: .continuous), style: FillStyle())
            .overlay {
                RoundedRectangle(cornerRadius: 8)
                                    .inset(by: 1)
                                    .strokeBorder( colorScheme == .light ? .black.opacity(0.2) : .white, lineWidth: 1, antialiased: true)
            }
            
            LazyVGrid(columns: columns, alignment: .center, spacing: 8) {
                ForEach(searchText == "" ? dataSource.values : dataSource.values.filter({ $0.lowercased().contains(searchText.lowercased()) || $0.lowercased().contains(searchText.lowercased()) }), id: \.self) { val in
                    Button(val) {
                        clickBlock?(val)
                    }
                    .buttonStyle(.plain)
                    .font(.system(size: 11))
                }
            }
            
            Spacer()
        }
    }
}

#Preview {
    SearchEntranceView()
        .frame(width: 100, height: 50)
}

#Preview {
    SearchView()
        .frame(width: 500, height: 300)
        .padding()
        .environmentObject(SearchDataSource())
}


