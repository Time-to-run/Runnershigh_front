import SwiftUI

struct Join2: View {
  var body: some View {
    ZStack() {
        //Group {
            Text("Confirm Password")
                .font(Font.custom("Inria Sans", size: 23))
                .foregroundColor(Color(red: 1, green: 0.32, blue: 0.16))
                .offset(x: -16, y: 93)
            Text("Password")
                .font(Font.custom("Inria Sans", size: 23))
                .foregroundColor(Color(red: 1, green: 0.32, blue: 0.16))
                .offset(x: -79.50, y: -24)
            Text("ID")
                .font(Font.custom("Inria Sans", size: 23))
                .foregroundColor(Color(red: 1, green: 0.32, blue: 0.16))
                .offset(x: -107.50, y: -141)
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
                .offset(x: 0, y: 20.50)
                .opacity(0.52)
            
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
                .offset(x: 0, y: 138.50)
                .opacity(0.52)
            
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
                .offset(x: 0, y: -97.50)
                .opacity(0.52)
            
            NavigationLink(destination: MyWebview(urlToLoad: "https://www.naver.com", token: "token")) {
                ZStack {
                    Rectangle()
                        .foregroundColor(.clear)
                        .frame(width: 302, height: 76)
                        .background(.white)
                        .cornerRadius(30)
                        .overlay(
                            RoundedRectangle(cornerRadius: 30)
                                .inset(by: 1.50)
                                .stroke(Color(red: 1, green: 0.32, blue: 0.16), lineWidth: 1.50)
                        )
                        .shadow(
                            color: Color(red: 0, green: 0, blue: 0, opacity: 0.25), radius: 2, y: 4
                        )
                    
                    Text("Let’s Run!")
                        .font(Font.custom("Jalnan Gothic", size: 38))
                        .foregroundColor(Color(red: 1, green: 0.32, blue: 0.16))
                }
                .offset(y: 269) // 오프셋은 외부에서 설정
            }

        //}
        Group {
        Text("It’s time to\nRun !")
          .font(Font.custom("Partial Sans KR", size: 51))
          .foregroundColor(Color(red: 1, green: 0.45, blue: 0.33))
          .offset(x: -0.50, y: -281)
      }
    }
    .frame(width: 390, height: 844)
    .background(.white);
  }
}
