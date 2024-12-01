import SwiftUI

struct Login: View {
 @State private var id: String = ""  // ID 값을 저장할 상태 변수
 @State private var pw: String = ""  // PW 값을 저장할 상태 변수
 @State private var token: String? = nil // 토큰 저장 상태 변수
 @State private var isLoading: Bool = false // 로딩 상태 변수
 
 var body: some View {
 NavigationView {
 ZStack {
 Color.white.edgesIgnoringSafeArea(.all) // 배경색
 
 VStack(spacing: 10) {
 // 상단 로고 및 배치
 ZStack {
 Ellipse()
 .foregroundColor(Color(red: 1, green: 0.45, blue: 0.33))
 .frame(width: 140, height: 134)
 .offset(y: -20)
 Image("User")
 .offset(y: -20)
 }
 .padding(.top, 30)
 
 // 입력 필드: ID
 VStack(alignment: .leading, spacing: 5) {
 ZStack {
 Rectangle()
 .foregroundColor(.clear)
 .frame(width: 310, height: 51)
 .background(Color(red: 0.26, green: 0.26, blue: 0.26).opacity(0.20))
 .cornerRadius(23)
 .overlay(
 RoundedRectangle(cornerRadius: 23)
 .inset(by: 0.50)
 .stroke(Color(red: 0.52, green: 0.49, blue: 0.49), lineWidth: 0.50)
 )
 .opacity(0.52)
 TextField("Enter your ID", text: $id)
 .padding(.horizontal)
 .frame(width: 300, height: 40)
 .foregroundColor(.black)
 }
 }
 
 // 입력 필드: PW
 VStack(alignment: .leading, spacing: 5) {
 ZStack {
 Rectangle()
 .foregroundColor(.clear)
 .frame(width: 310, height: 51)
 .background(Color(red: 0.26, green: 0.26, blue: 0.26).opacity(0.20))
 .cornerRadius(23)
 .overlay(
 RoundedRectangle(cornerRadius: 23)
 .inset(by: 0.50)
 .stroke(Color(red: 0.52, green: 0.49, blue: 0.49), lineWidth: 0.50)
 )
 .opacity(0.52)
 SecureField("Enter your Password", text: $pw)
 .padding(.horizontal)
 .frame(width: 300, height: 40)
 .foregroundColor(.black)
 }
 }
 
 Spacer().frame(height: 10)
 
 // Log In 버튼
 Button(action: {
 // 로그인 버튼이 눌렸을 때 ID와 PW 값을 서버에 전송
 login(id: id, pw: pw)
 }) {
 ZStack {
 Rectangle()
 .foregroundColor(.clear)
 .frame(width: 295, height: 56)
 .background(Color(red: 1, green: 0.32, blue: 0.16).opacity(0.80))
 .cornerRadius(23)
 .shadow(
 color: Color(red: 0, green: 0, blue: 0, opacity: 0.25), radius: 4, y: 2
 )
 Text("Log In")
 .font(Font.custom("Jalnan Gothic", size: 26))
 .foregroundColor(.white)
 }
 }
 
 // Join Us 버튼
 NavigationLink(destination: Join1()) {
 ZStack {
 Rectangle()
 .foregroundColor(.clear)
 .frame(width: 295, height: 56)
 .background(Color(red: 1, green: 0.99, blue: 0.99))
 .cornerRadius(23)
 .overlay(
 RoundedRectangle(cornerRadius: 23)
 .inset(by: 1)
 .stroke(Color(red: 1, green: 0.32, blue: 0.16), lineWidth: 1)
 )
 .shadow(
 color: Color(red: 0, green: 0, blue: 0, opacity: 0.25), radius: 4, y: 2
 )
 Text("Join Us")
 .font(Font.custom("Jalnan Gothic", size: 26))
 .foregroundColor(Color(red: 1, green: 0.32, blue: 0.16))
 }
 }
 }.offset(y: -20)
 .frame(width: 402, height: 874)
 
 if isLoading {
 ProgressView("Logging in...")
 .frame(width: 150, height: 100)
 .background(Color.white)
 .cornerRadius(12)
 .shadow(radius: 10)
 }
 }
 }
 }
 
 // 로그인 API 요청 함수
 func login(id: String, pw: String) {
 guard let url = URL(string: "http://113.198.230.24:3338/user/login") else {
 return
 }
 
 // 서버가 요구하는 변수명으로 JSON 데이터 구성
 let parameters: [String: String] = ["userID": id, "userPW": pw]
 guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else {
 return
 }
 
 var request = URLRequest(url: url)
 request.httpMethod = "POST"
 request.httpBody = httpBody
 request.setValue("application/json", forHTTPHeaderField: "Content-Type")
 
 // API 요청 보내기
 URLSession.shared.dataTask(with: request) { data, response, error in
 if let error = error {
 print("Error: \(error.localizedDescription)")
 return
 }
 
 if let data = data {
 if let json = try? JSONSerialization.jsonObject(with: data, options: []),
 let responseDict = json as? [String: Any] {
 print("Response: \(responseDict)")
 } else {
 print("Invalid JSON response")
 }
 }
 }.resume()
 }
 
 }
 
