//
//  CommentView.swift
//  WalmartSearch
//
//  Created by Qicheng Geng on 2/3/24.
//

import SwiftUI

struct CommentView: View {
    @ObservedObject var viewModel: ProductViewModel
    @State private var showingCommentInput = false
    @State private var newCommentText = ""

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            ForEach(viewModel.comments) { comment in
                HStack {
                    Text(comment.user.profileImage)
                        .font(.largeTitle)
                    VStack(alignment: .leading) {
                        Text(comment.user.userName).fontWeight(.bold)
                        Text(comment.commentString)
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                    Spacer()
                    Text("\(comment.timestamp, formatter: itemFormatter)")
                        .font(.caption2)
                        .foregroundColor(.secondary)
                }
                .padding(.vertical, 4)
            }
            
            Button("Say something...") {
                showingCommentInput = true
                newCommentText = ""
            }
            .padding(.horizontal, 40)
            .padding(.vertical, 15)
            .background(Color.cyan)
            .foregroundColor(.white)
            .cornerRadius(38)
            .padding(.top, 12)
            .padding(.leading, 50)
            .font(.title2)
            .alert("New Comment", isPresented: $showingCommentInput, actions: {
                Button("Post", action: postComment)
                Button("Cancel", role: .cancel) { }
                TextField("Enter your comment", text: $newCommentText)
            }, message: {
                
            })
        }
        .padding()
    }
    
    private func postComment() {
        let newComment = Comment(user: User(profileImage: "👤", userName: "Anonymous"), timestamp: Date(), commentString: newCommentText)
        viewModel.comments.append(newComment)
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .short
    return formatter
}()

#Preview {
    CommentView(viewModel: ProductViewModel())
}
