//
//  NicknameSettingView.swift
//  BurningBuddy
//
//  Created by 김동현 on 2023/05/02.
//

import Foundation
import SwiftUI

struct NicknameSettingView: View {
    //    @Binding var isMember: Bool
    @ObservedObject var nicknameLimiter = TextLimiter(limit: 8)
    @EnvironmentObject var settings: UserSettings
    
    var body: some View {
        VStack {
            Text("반갑습니다! \n닉네임을 설정해봐요!")
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(EdgeInsets(top: 50, leading: 30, bottom: 0, trailing: 0))
                .foregroundColor(.white)
                .font(.custom("본고딕-Bold", size: 30))
            Spacer()
            Spacer()
            TextField("", text: $nicknameLimiter.value, prompt: Text("닉네임은 한글 2~8자로 설정할 수 있어요!")
                .foregroundColor(.white))
            .padding(EdgeInsets(top: 0, leading: 30, bottom: 0, trailing: 30))
            .foregroundColor(.white)
            Divider()
                .overlay(Color.white)
                .padding(EdgeInsets(top: 0, leading: 30, bottom: 0, trailing: 30))
            Spacer()
            Spacer()
            Button("다음", action: {
                saveNickname()
            })
            .buttonStyle(NextButtonStyle(colorRed: 255, colorGreen: 45, colorBlue: 85, fontSize: 17))
            Spacer()
        }
        .background(Color(red: 30/255, green: 28/255, blue: 29/255)) // 고급진 까만것이 필요할 듯
    }
    
    func saveNickname() {
        settings.nickName = nicknameLimiter.value
        withAnimation(.easeInOut(duration: 0.4)){
            settings.pageNum += 1
        }
        
        
        // UserDefault에 닉네임 저장
        // 닉네임과 동시에 특별 ID 부여해야 할 듯. 중복처리가 불가능한 구조여서...
    }
}

struct NextButtonStyle: ButtonStyle {
    @State var colorRed: Double
    @State var colorGreen: Double
    @State var colorBlue: Double
    @State var fontSize: CGFloat
    @State private var pressed = false
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.custom("본고딕-Medium", size: fontSize))
            .padding()
            .frame(minWidth: 0, maxWidth: .infinity)
            .foregroundColor(.white)
            .background(RoundedRectangle(cornerRadius: 15.0).fill(Color(red: colorRed / 255, green: colorGreen / 255, blue: colorBlue / 255))
            )
    }
    
}

class TextLimiter: ObservableObject {
    private let limit: Int
    init(limit: Int) {
        self.limit = limit
    }
    
    @Published var value = "" {
        didSet {
            if value.count > self.limit {
                value = String(value.prefix(self.limit))
                self.hasReachedLimit = true
            } else {
                self.hasReachedLimit = false
            }
        }
    }
    @Published var hasReachedLimit = false
}


struct NicknameSettingView_Previews: PreviewProvider {
    @State var isMember: Bool = true
    
    static var previews: some View {
        NicknameSettingView()
    }
}

