//
//  TopBarView.swift
//  WalmartSearch
//
//  Created by Qicheng Geng on 2/1/24.
//

import SwiftUI

struct TopBarView: View {
    var body: some View {
        VStack {
            HStack{
                Image(systemName: "chevron.backward")
                    .foregroundColor(.white)
                    .padding(.leading, 18)
                    .fontWeight(.bold)

                SearchView(viewModel: ProductViewModel())
                
                Image(systemName: "cart")
                    .foregroundColor(.white)
                    .padding(.trailing, 17)
                    .fontWeight(.bold)
            }
            .padding(.top, 11)
            .padding(.bottom, 7)
            HStack {
                Image(systemName: "head.profile.arrow.forward.and.visionpro")
                    .foregroundColor(.yellow)
                    .fontWeight(.bold)
                    .padding(.leading, 20)
                
                Spacer()
                
                Text("How do you want your items? |27517")
                    .foregroundColor(.white)
                    .fontWeight(.light)
                    .padding(.leading, -10)
                
                Spacer()
                
                Image(systemName: "chevron.down")
                    .foregroundColor(.white)
                    .padding(.trailing, 18)
            }
            .padding(.bottom, 9)
        }
        .background(.blue)
    }
}

#Preview {
    TopBarView()
}
