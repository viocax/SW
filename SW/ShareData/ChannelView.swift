//
//  ChannelView.swift
//  SW
//
//  Created by Jie liang Huang on 2020/10/20.
//

import SwiftUI

struct ChannelView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var channelData: ChannelData
    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: nil, content: {
                TextField("Channel Name", text: $channelData.channelName)
                Divider()
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Text("Dismiss this VC")
                }
                Spacer()
            }).padding()
            .navigationBarTitle("Channel Data")
        }
    }
}

struct ChannelView_Previews: PreviewProvider {
    static var previews: some View {
        ChannelView()
    }
}


