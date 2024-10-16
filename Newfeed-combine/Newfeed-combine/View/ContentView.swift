//
//  ContentView.swift
//  Newfeed-combine
//
//  Created by JaeKi on 10/16/24.
//

import SwiftUI

struct ContentView: View {
  @StateObject
  private var viewModel = NewsViewModel()

  var body: some View {
    NavigationView {
      if viewModel.isLoading {
        ProgressView("뉴스를 불러오는 중..")
          .navigationTitle("Latest News")
      } else {
        List(viewModel.articles) { article in
          VStack(alignment: .leading) {
            Text(article.title)
              .font(.headline)

            if let description = article.description {
              Text(description)
                .font(.subheadline)
            }
          }
        }
        .navigationTitle("Latest News")
        .onAppear {
          viewModel.fetchNews()
        }
        .alert(isPresented: $viewModel.isError) {
          Alert(
            title: Text("오류"),
            message: Text(viewModel.errorMessage),
            dismissButton: .default(Text("확인"))
          )
        }
      }
    }
  }
}

#Preview {
  ContentView()
}
