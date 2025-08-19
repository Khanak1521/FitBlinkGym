//
//  CustomWebView.swift
//  FitBlinkGym
//
//  Created by Dipang Sheth on 11/08/25.
//

import SwiftUI
import WebKit

struct CustomWebView: View {
    @State private var path: [ViewRouter] = []

    var body: some View {
        WebView(urlString: "https://www.google.com")
            .edgesIgnoringSafeArea(.all)
    }
}

#Preview {
    CustomWebView()
}


struct WebView: UIViewRepresentable {
    let urlString: String
    
    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }
    
    func updateUIView(_ webView: WKWebView, context: Context) {
        if let url = URL(string: urlString) {
            let request = URLRequest(url: url)
            webView.load(request)
        }
    }
}
