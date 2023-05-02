//
//  ContentView.swift
//  BurningBuddy
//
//  Created by 김동현 on 2023/05/02.
//

import SwiftUI


class UserSettings: ObservableObject {
    @Published var pageNum = 0
    @Published var nickName = "admin"
    @Published var characterName = "DDolDDoli"
}

struct ContentView: View {
    @ObservedObject var settings = UserSettings()
    
    var body: some View {
        if settings.pageNum == 0 {
            NicknameSettingView()
                .environmentObject(settings)
                .background(.black) // 고급진 까만것이 필요할 듯
        } else if settings.pageNum == 1 {
            CharacterSettingView()
                .environmentObject(settings)
                .background(.black)
        } else {
            MainView()
                .environmentObject(settings)
                .background(.black)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
