//
//  TabView.swift
//  WalmartSearch
//
//  Created by Qicheng Geng on 2/1/24.
//

import SwiftUI

struct TabView: View {
    var body: some View {
        HStack {
            Spacer()
            
            VStack(spacing: 3) {
                Image(systemName: "house")
                    .imageScale(.large)
                Text("Shop")
            }
            
            Spacer()
            
            VStack(spacing: 3) {
                Image(systemName: "heart")
                    .imageScale(.large)
                Text("My Items")
            }
            
            Spacer()
            
            VStack(spacing: 3) {
                Image(systemName: "text.magnifyingglass")
                    .imageScale(.large)
                Text("Search")
            }
            .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
            
            Spacer()
            
            VStack(spacing: 3) {
                Image(systemName: "command")
                    .imageScale(.large)
                Text("Services")
            }
            
            Spacer()
            
            VStack(spacing: 3) {
                Image(systemName: "person.crop.circle")
                    .imageScale(.large)
                Text("Account")
            }
            
            Spacer()
        }
        .font(.caption)
        .fontWeight(.bold)
        .foregroundColor(.secondary)
        .padding(.top, 1)
        .frame(maxWidth: .infinity, maxHeight: 50)

        .overlay(
            Divider().padding(.top, -5),
            alignment: .top
        )
    }
}

#Preview {
    TabView()
}
