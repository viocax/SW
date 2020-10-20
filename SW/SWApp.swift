//
//  SWApp.swift
//  SW
//
//  Created by Jie liang Huang on 2020/9/7.
//

import SwiftUI

@main
struct SWApp: App {
    let channelData = ChannelData()
    var body: some Scene {
        WindowGroup {
            FirstView().environmentObject(channelData)
        }
    }
}
