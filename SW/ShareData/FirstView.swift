//
//  ViewA.swift
//  SW
//
//  Created by Jie liang Huang on 2020/10/20.
//

import SwiftUI

struct FirstView: View {

    @State private var showingSecondVC = false
    @ObservedObject var videoIdea = VideoIdea()
    @EnvironmentObject var channelData: ChannelData

    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                Text(videoIdea.title)
                    .font(.title)
                Text(videoIdea.contentIdea)
                    .font(.subheadline)
                Divider()
                NavigationLink(
                    destination: ChannelView(),
                    label: {
                        Text("Add Channel")
                    })
                Button(action: {
                    showingSecondVC.toggle()
                }) {
                    Text("Add new idea")
                }.sheet(isPresented: $showingSecondVC) {
                    SecondView(videoTitle: $videoIdea.title,
                               veideoContent: $videoIdea.contentIdea)
                        .environmentObject(channelData)
                }
                Spacer()
            }.padding()
            .navigationBarTitle("\(channelData.channelName)")
        }
    }
}

struct FirstView_Preview: PreviewProvider {

    static var previews: FirstView {
        return FirstView()
    }

}

import Combine

class VideoIdea: ObservableObject {

    @Published var title: String = ""
    @Published var contentIdea: String = ""

}

class ChannelData: ObservableObject {
    @Published var channelName: String = "Youtube Channel"
}
