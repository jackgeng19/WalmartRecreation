//
//  RatingStarView.swift
//  WalmartSearch
//
//  Created by Qicheng Geng on 2/2/24.
//

import SwiftUI

struct RatingStarView: View {
    let rating: Double
    let maxRating: Int = 5
    let fullStar = "star.fill"
    let halfStar = "star.leadinghalf.fill"
    let emptyStar = "star"
    
    private func starType(for index: Int) -> String {
        let fullStars = Int(rating)
        let hasHalfStar = (rating - Double(fullStars)) >= 0.5
        let halfStarIndex = hasHalfStar ? fullStars : -1
        
        if index < fullStars {
            return fullStar
        } else if index == halfStarIndex {
            return halfStar
        } else {
            return emptyStar
        }
    }
    
    var body: some View {
        HStack(spacing: 2) {
            ForEach(0..<maxRating, id: \.self) { index in
                Image(systemName: starType(for: index))
                    .foregroundColor(index < Int(rating) || (index == Int(rating) && rating.truncatingRemainder(dividingBy: 1) > 0) ? .yellow : .gray)
                    .padding(.trailing, -3)
                    .font(.caption)
            }
        }
    }
}

struct RatingStarView_Previews: PreviewProvider {
    static var previews: some View {
        RatingStarView(rating: 3.3)
            .previewLayout(.sizeThatFits)
    }
}
