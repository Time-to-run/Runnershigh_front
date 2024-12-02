import SwiftUI

/*struct ContentView: View {
 @State private var isLaunch: Bool = true
 @State private var isLogin: Bool = true // 로그인 화면 표시 여부를 위한 상태
 @State private var selectedTab = 0
 
 var body: some View {
 VStack {
 if isLaunch {
 LaunchView(isLaunch: $isLaunch) // LaunchView에 상태를 전달
 } else if isLogin {
 Login() // 로그인 화면 표시
 } else {
 // Login 뷰가 끝난 후 TabView 표시
 TabView(selection: $selectedTab) {
 MyWebview(urlToLoad: "https://runnershigh-web.vercel.app/ranking") // 홈 화면
 .tabItem {
 Image(systemName: "trophy")
 Text("랭킹")
 }
 .tag(0)
 
 MyWebview(urlToLoad: "https://runnershigh-web.vercel.app/") // 같이뛰기 페이지
 .tabItem {
 Image(systemName: "person.3.fill")
 Text("같이뛰기")
 }
 .tag(1)
 
 RunMapView() // 지도페이지
 .tabItem {
 Image(systemName: "figure.run")
 Text("Run")
 }
 .tag(2)
 
 MyWebview(urlToLoad: "https://runnershigh-web.vercel.app/mission") // 미션리스트
 .tabItem {
 Image(systemName: "list.bullet.clipboard")
 Text("미션")
 }
 .tag(3)
 }
 .accentColor(.accentColor) // 탭 선택 색상 설정
 }
 }
 }
 }
 
 struct ContentView_Previews: PreviewProvider {
 static var previews: some View {
 ContentView()
 }
 }
 */

/*struct ContentView: View {
 @State private var isLaunch: Bool = true
 @State private var isLogin: Bool = true // 로그인 화면 표시 여부를 위한 상태
 @State private var selectedTab = 0
 
 var body: some View {
 VStack {
 if isLaunch {
 LaunchView(isLaunch: $isLaunch) // LaunchView에 상태를 전달
 } else if isLogin {
 Login() // 로그인 화면 표시
 } else {
 // Login 뷰가 끝난 후 TabView 표시
 TabView(selection: $selectedTab) {
 MyWebview(urlToLoad: "https://runnershigh-web.vercel.app/ranking") // 홈 화면
 .tabItem {
 Image(systemName: "trophy")
 Text("랭킹")
 }
 .tag(0)
 
 MyWebview(urlToLoad: "https://runnershigh-web.vercel.app/") // 같이뛰기 페이지
 .tabItem {
 Image(systemName: "person.3.fill")
 Text("같이뛰기")
 }
 .tag(1)
 
 RunMapView() // 지도페이지
 .tabItem {
 Image(systemName: "figure.run")
 Text("Run")
 }
 .tag(2)
 
 MyWebview(urlToLoad: "https://runnershigh-web.vercel.app/mission") // 미션리스트
 .tabItem {
 Image(systemName: "list.bullet.clipboard")
 Text("미션")
 }
 .tag(3)
 }
 .accentColor(.accentColor) // 탭 선택 색상 설정
 }
 }
 }
 }
 
 struct ContentView_Previews: PreviewProvider {
 static var previews: some View {
 ContentView()
 }
 }
 */

struct ContentView: View {
    @State private var isLaunch: Bool = true
    @State private var isLogin: Bool = true // 로그인 화면 표시 여부를 위한 상태
    @State private var token: String? = nil // API 토큰 저장
    @State private var selectedTab = 0

    var body: some View {
        VStack {
            if isLaunch {
                LaunchView(isLaunch: $isLaunch) // LaunchView에 상태를 전달
            } else if isLogin {
                Login(token: $token) // Login 뷰에서 token을 전달받음
                    .onChange(of: token) { newToken in
                        // 토큰이 업데이트되면 로그인 상태를 false로 변경
                        if newToken != nil {
                            isLogin = false
                        }
                    }
            } else {
                // Login 뷰가 끝난 후 TabView 표시
                TabView(selection: $selectedTab) {
                    MyWebview(urlToLoad: "https://runnershigh-web.vercel.app/ranking", token: token ?? "") // 홈 화면
                        .tabItem {
                            Image(systemName: "trophy")
                            Text("랭킹")
                        }
                        .tag(0)
                    MyWebview(urlToLoad: "https://runnershigh-web.vercel.app?token=", token: token ?? "") // 같이뛰기 페이지
                        .tabItem {
                            Image(systemName: "person.3.fill")
                            Text("같이뛰기")
                        }
                        .tag(1)
                    
                    RunMapView() // 지도페이지
                        .tabItem {
                            Image(systemName: "figure.run")
                            Text("Run")
                        }
                        .tag(2)
                    
                    MyWebview(urlToLoad: "https://runnershigh-web.vercel.app/mission", token: token ?? "") // 미션리스트
                        .tabItem {
                            Image(systemName: "list.bullet.clipboard")
                            Text("미션")
                        }
                        .tag(3)
                }
                .accentColor(.accentColor) // 탭 선택 색상 설정
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
