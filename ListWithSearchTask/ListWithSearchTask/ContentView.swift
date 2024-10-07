//
//  ContentView.swift
//  ListWithSearchTask
//
//  Created by abishek m on 07/10/24.
//
import SwiftUI

struct ContentView: View {
    @State private var currentIndex = 0
    @State private var items = ["apple", "banana", "orange", "blueberry", "kiwi"]
    @State private var filteredItems: [String] = []
    @State private var searchText = ""
    
    let images = ["image1", "image2", "image3"]
    @State private var showStatisticsSheet = false
    
    init() {
        _filteredItems = State(initialValue: items)
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    TabView(selection: $currentIndex) {
                        ForEach(0..<images.count, id: \.self) { index in
                            Image(images[index])
                                .resizable()
                                .scaledToFit()
                                .frame(width: UIScreen.main.bounds.width)
                                .clipShape(RoundedRectangle(cornerRadius: 25, style: .continuous))
                                .tag(index)
                        }
                    }
                    .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                    .frame(height: 200)
                    .padding()
                    
                    HStack {
                        ForEach(0..<images.count, id: \.self) { index in
                            Circle()
                                .fill(currentIndex == index ? Color.blue : Color.gray)
                                .frame(width: 10, height: 10)
                                .padding(5)
                                .onTapGesture {
                                    currentIndex = index
                                }
                        }
                    }
                    
                    SearchBar(text: $searchText)
                        .padding(.top, 10)
                    
                    List(filteredItems, id: \.self) { item in
                        HStack {
                            Image(images[filteredItems.firstIndex(of: item)! % images.count])
                                .resizable()
                                .scaledToFit()
                                .frame(width: 40, height: 40)
                                .clipShape(Circle())
                            
                            Text(item)
                                .padding()
                        }
                        .padding(.vertical, 5)
                        .listRowBackground(Color.green.opacity(0.2))
                        .listRowInsets(EdgeInsets(top: 10, leading: 15, bottom: 10, trailing: 15))
                    }
                    .padding(.top, 5)
                    
                    Spacer()
                }
                
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        Button(action: {
                            showStatisticsSheet.toggle()
                        }) {
                            Image("menu")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 40, height: 40)
                                .padding()
                                .background(Circle().fill(Color.blue))
                                .foregroundColor(.white)
                                .shadow(radius: 5)
                        }
                        .padding(.bottom, 30)
                        .padding(.trailing, 30)
                    }
                }
            }
            .sheet(isPresented: $showStatisticsSheet) {
                StatisticsView(showStatisticsSheet: $showStatisticsSheet)
            }
            .onChange(of: searchText) { _ in
                searchItems()
            }
        }
    }
    
    private func searchItems() {
        if searchText.isEmpty {
            filteredItems = items
        } else {
            filteredItems = items.filter { $0.lowercased().contains(searchText.lowercased()) }
        }
    }
}

struct SearchBar: View {
    @Binding var text: String
    
    var body: some View {
        HStack {
            Spacer()
            Image(systemName: "magnifyingglass")
                .foregroundColor(.gray)
                .padding(.leading, 8)
            
            TextField("Search...", text: $text)
                .padding(7)
                .background(Color(.systemGray5))
                .cornerRadius(8)
                .padding(.horizontal, 10)
                
            Spacer()
        }
        .background(Color(.systemGray5))
        .cornerRadius(10)
        .shadow(radius: 5)
        .padding(.horizontal, 20)
    }
}

struct StatisticsView: View {
    let statistics = ["Page 1: 5 items", "Top Occurrences: a = 5, e = 4, r = 3"]
    
    @Binding var showStatisticsSheet: Bool
    
    var body: some View {
        VStack {
            Text("Statistics")
                .font(.headline)
                .padding()
            
            ForEach(statistics, id: \.self) { stat in
                Text(stat)
                    .padding(.vertical, 4)
            }
            
            Button("Close") {
                showStatisticsSheet = false
            }
            .padding()
            .background(Capsule().fill(Color.blue))
            .foregroundColor(.white)
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
