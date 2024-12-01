import SwiftUI

struct Join1: View {
    var body: some View {
        ZStack {
            Color.white.edgesIgnoringSafeArea(.all) // 배경색
            
            VStack(spacing: 20) { // 각 섹션 간 간격 조정
                // 상단 텍스트
                Text("It’s time to\nRun !")
                    .font(Font.custom("PartialSansKR-Regular", size: 51))
                    .foregroundColor(Color(red: 1, green: 0.45, blue: 0.33))
                    .shadow(color: .gray.opacity(0.5), radius: 5, x: 2, y: 2)
                    .frame(maxWidth: .infinity)

                Spacer().frame(height: 10) // 추가 간격
                
                // Name 섹션
                VStack(alignment: .leading, spacing: 5) {
                    Text("Name")
                        .font(Font.custom("Inria Sans", size: 23))
                        .foregroundColor(Color(red: 1, green: 0.32, blue: 0.16))
                    
                    ZStack {
                        Rectangle()
                            .foregroundColor(.clear)
                            .frame(width: 310, height: 51)
                            .background(Color(red: 0.26, green: 0.26, blue: 0.26).opacity(0.20))
                            .cornerRadius(23)
                            .overlay(
                                RoundedRectangle(cornerRadius: 23)
                                    .stroke(Color(red: 0.52, green: 0.49, blue: 0.49), lineWidth: 0.50)
                            )
                            .opacity(0.52)
                        
                        Text("Running_Man")
                            .font(Font.custom("Inria Sans", size: 21))
                            .foregroundColor(.gray)
                            .opacity(0.8)
                    }
                }
                
                // Email 섹션
                VStack(alignment: .leading, spacing: 5) {
                    Text("Email")
                        .font(Font.custom("Inria Sans", size: 23))
                        .foregroundColor(Color(red: 1, green: 0.32, blue: 0.16))
                    
                    ZStack {
                        Rectangle()
                            .foregroundColor(.clear)
                            .frame(width: 310, height: 51)
                            .background(Color(red: 0.26, green: 0.26, blue: 0.26).opacity(0.20))
                            .cornerRadius(23)
                            .overlay(
                                RoundedRectangle(cornerRadius: 23)
                                    .stroke(Color(red: 0.52, green: 0.49, blue: 0.49), lineWidth: 0.50)
                            )
                            .opacity(0.52)
                        
                        Text("Runner’sHigh@example.com")
                            .font(Font.custom("Inria Sans", size: 21))
                            .foregroundColor(.gray)
                            .opacity(0.8)
                    }
                }
                
                // Gender 섹션
                VStack(alignment: .leading, spacing: 10) {
                    Text("Gender")
                        .font(Font.custom("Inria Sans", size: 23))
                        .foregroundColor(Color(red: 1, green: 0.32, blue: 0.16))
                    
                    HStack(spacing: 60) {
                        Circle()
                            .fill(Color.gray.opacity(0.2))
                            .frame(width: 40, height: 40)
                        Text("Male")
                            .font(Font.custom("Inter", size: 18))
                            .foregroundColor(.gray)
                        
                        Circle()
                            .fill(Color.gray.opacity(0.2))
                            .frame(width: 40, height: 40)
                        Text("Female")
                            .font(Font.custom("Inter", size: 18))
                            .foregroundColor(.gray)
                    }
                }
                
                // 약관 동의
                HStack(spacing: 10) {
                    Circle()
                        .stroke(Color.gray, lineWidth: 1)
                        .frame(width: 24, height: 24)
                    
                    Text("개인정보 이용 동의")
                        .font(Font.custom("Jalnan Gothic", size: 18))
                        .foregroundColor(.gray)
                        .opacity(0.8)
                }
                
                Spacer()
                
                // Next 버튼
                NavigationLink(destination: Join2()) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color(red: 1, green: 0.32, blue: 0.16), lineWidth: 1.5)
                            .frame(width: 157, height: 76)
                            .shadow(color: Color.black.opacity(0.25), radius: 4, y: 4)
                        
                        Text("Next")
                            .font(Font.custom("Jalnan Gothic", size: 32))
                            .foregroundColor(Color(red: 1, green: 0.32, blue: 0.16))
                    }
                }
                
            }
            .padding(.horizontal, 20)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}
