import SwiftUI

struct ContentView: View {
    @State private var selectedTab = 0

    var body: some View {
        TabView(selection: $selectedTab) {
            RankingView() // 홈 화면
                .tabItem {
                    Image(systemName: "trophy")
                    Text("랭킹")
                }
                .tag(0)
            
            CommunityView() // 같이뛰기 페이지
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
            
            MissionView() // 미션리스트
                .tabItem {
                    Image(systemName: "list.bullet.clipboard")
                    Text("미션")
                }
                .tag(3)
        }
        .accentColor(.accentColor) // 탭 선택 색상 설정
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
