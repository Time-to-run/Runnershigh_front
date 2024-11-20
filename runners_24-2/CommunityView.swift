import SwiftUI

struct CommunityView: View {
    var body: some View {
        VStack {
            // 상단 제목과 현재 위치
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Button(action: {
                        // 뒤로가기 액션 (필요 시 추가)
                    }) {
                        Image(systemName: "arrow.left")
                            .foregroundColor(.black)
                    }
                    Spacer()
                    Button(action: {
                        // 메뉴 버튼 액션 (필요 시 추가)
                    }) {
                        Image(systemName: "line.3.horizontal")
                            .foregroundColor(.black)
                    }
                }
                .padding(.horizontal)

                Text("게시판")
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(.white)
                    .padding(.horizontal)
                
                Text("현재위치: 부산광역시 부산진구 엄광로 176")
                    .font(.subheadline)
                    .foregroundColor(.white)
                    .padding(.horizontal)
            }
            .padding()
            .background(Color.orange)
            .cornerRadius(16)
            
            // 날짜 선택 UI
            HStack(spacing: 20) {
                Button(action: {
                    // 날짜 선택 액션
                }) {
                    VStack {
                        Text("12")
                            .font(.title)
                            .bold()
                        Text("화")
                            .font(.subheadline)
                    }
                    .padding()
                    .background(Color.orange)
                    .cornerRadius(16)
                    .foregroundColor(.white)
                }
                
                VStack {
                    Text("13")
                        .font(.title)
                        .bold()
                    Text("수")
                        .font(.subheadline)
                }
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(Color.orange, lineWidth: 2)
                )
                
                VStack {
                    Text("14")
                        .font(.title)
                        .bold()
                    Text("목")
                        .font(.subheadline)
                }
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(Color.orange, lineWidth: 2)
                )
            }
            .padding()
            
            // 게시판 리스트
            ScrollView {
                ForEach(0..<6) { index in
                    HStack {
                        VStack(alignment: .leading) {
                            Text("11:00")
                                .font(.headline)
                            Text("부산 광안리해수욕장")
                                .font(.subheadline)
                                .bold()
                            Text("남녀 모두")
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                        Spacer()
                        Button(action: {
                            // 신청 버튼 액션
                        }) {
                            Text(index == 1 ? "마감임박!" : "신청가능")
                                .font(.subheadline)
                                .padding()
                                .background(index == 1 ? Color.red : Color.orange)
                                .foregroundColor(.white)
                                .cornerRadius(8)
                        }
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(16)
                    .shadow(color: .gray.opacity(0.2), radius: 5, x: 0, y: 2)
                    .padding(.horizontal)
                }
            }
            .padding(.top)
        }
        .background(Color.white)
    }
}

struct CommunityView_Previews: PreviewProvider {
    static var previews: some View {
        CommunityView()
    }
}
