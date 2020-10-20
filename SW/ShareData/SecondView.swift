//
//  SecondView.swift
//  SW
//
//  Created by Jie liang Huang on 2020/10/20.
//

import SwiftUI

struct SecondView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @Binding var videoTitle: String
    @Binding var veideoContent: String
    @EnvironmentObject var channelData: ChannelData
    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: nil, content: {
                TextField("Video Text", text: $videoTitle)
                TextField("Video Content", text: $veideoContent)
                Divider()
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Text("Disiss this VC")
                }
                Spacer()
            })
            .padding()
            .navigationBarTitle("\(channelData.channelName) Video")
        }
    }
}

//struct SecondView_Previews: PreviewProvider {
//    @State private var videoTitle: String
//    @State private var veideoContent: String
//    static var previews: some View {
//        return SecondView(videoTitle: $videoTitle, veideoContent: $veideoContent)
//    }
//}
