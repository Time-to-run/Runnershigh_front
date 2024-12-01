//
//  MyWebview.swift
//  SwiftUI_Webview_tutorial
//
//  Created by Jeff Jeong on 2020/07/02.
//  Copyright © 2020 Tuentuenna. All rights reserved.
//

import SwiftUI
import WebKit

/*
struct MyWebview: UIViewRepresentable {
   
    var urlToLoad: String
    
    // ui view 만들기
    func makeUIView(context: Context) -> WKWebView {
        
        // unwrapping
        guard let url = URL(string: self.urlToLoad) else {
            return WKWebView()
        }
        
        // 웹뷰 인스턴스 생성
        let webview = WKWebView()
        
        // 스와이프 제스처로 뒤로가기 및 앞으로가기 활성화
        webview.allowsBackForwardNavigationGestures = true
        
        // 웹뷰를 로드한다.
        webview.load(URLRequest(url: url))
        
        return webview
    }
    
    // 업데이트 ui view
    func updateUIView(_ uiView: WKWebView, context: UIViewRepresentableContext<MyWebview>) {
        // 필요 시 업데이트 구현
    }
}

struct MyWebview_Previews: PreviewProvider {
    static var previews: some View {
        MyWebview(urlToLoad: "https://www.naver.com")
    }
}
*/


struct MyWebview: UIViewRepresentable {
    var urlToLoad: String
    var token: String // API 토큰 전달받음

    // UIView 생성
    func makeUIView(context: Context) -> WKWebView {
        // 웹뷰 인스턴스 생성
        let webview = WKWebView()

        // URLRequest 생성 및 헤더에 토큰 추가
        if let url = URL(string: self.urlToLoad) {
            var request = URLRequest(url: url)
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
            webview.load(request)
        }

        // 스와이프 제스처로 뒤로가기 및 앞으로가기 활성화
        webview.allowsBackForwardNavigationGestures = true

        return webview
    }

    // UIView 업데이트
    func updateUIView(_ uiView: WKWebView, context: UIViewRepresentableContext<MyWebview>) {
        // 필요 시 업데이트 로직 추가
    }
}

struct MyWebview_Previews: PreviewProvider {
    static var previews: some View {
        MyWebview(urlToLoad: "https://www.naver.com", token: "token")
    }
}
