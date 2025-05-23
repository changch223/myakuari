import SwiftUI

struct ContentView: View {
    @State private var isPressed = false

    var body: some View {
        NavigationView {
            ZStack {
                // 背景：漸層
                LinearGradient(gradient: Gradient(colors: [
                    Color(red: 1.0, green: 0.85, blue: 0.85),
                    Color(red: 1.0, green: 0.95, blue: 0.9)
                ]),
                startPoint: .top,
                endPoint: .bottom)
                .ignoresSafeArea()

                Color.white.opacity(0.2)
                    .ignoresSafeArea()
                    .blur(radius: 30)

                VStack(spacing: 0) {
                    Spacer(minLength: 40) // 頂部留一點空間（避免貼太緊）
                    
                    VStack(spacing: 30) {
                        // Logo
                        Image("logo")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 120, height: 120)
                            .shadow(radius: 5)

                        // 標題 & 副標題
                        VStack(spacing: 16) {
                            Text("title_text")
                                .font(.system(size: 34, weight: .semibold))
                                .foregroundColor(Color(red: 0.5, green: 0.3, blue: 0.3))
                                .multilineTextAlignment(.center)
                                .shadow(color: .white.opacity(0.5), radius: 3, x: 0, y: 1)

                            Text("subtitle_text")
                                .font(.system(size: 18, weight: .regular))
                                .foregroundColor(Color(red: 0.6, green: 0.4, blue: 0.4).opacity(0.8))
                                .multilineTextAlignment(.center)
                                .shadow(radius: 1)
                        }

                        // 按鈕
                        NavigationLink(destination: AnalysisView()) {
                            Text("button_text")
                                .font(.headline)
                                .foregroundColor(.white)
                                .padding(.vertical, 16)
                                .padding(.horizontal, 36)
                                .background(
                                    Color(red: 1.0, green: 0.6, blue: 0.7)
                                        .cornerRadius(24)
                                        .shadow(radius: 8)
                                )
                            
                                .overlay(
                                    RoundedRectangle(cornerRadius: 24)
                                        .stroke(Color.white.opacity(0.6), lineWidth: 1)
                                )
                                .scaleEffect(isPressed ? 0.95 : 1.0)
                                .animation(.easeInOut(duration: 0.2), value: isPressed)
                        }
                        .simultaneousGesture(
                            DragGesture(minimumDistance: 0)
                                .onChanged { _ in
                                    isPressed = true
                                    ButtonSoundPlayer.playSound()
                                }
                                .onEnded { _ in
                                    isPressed = false
                                }
                        )
                    }
                    .padding(.horizontal, 24)

                    Spacer() // 撐開中間
                    
                    // 廣告放底部
                    BannerAdView(adUnitID: "ca-app-pub-9275380963550837/6056788210")
                        .frame(height: 50)
                }
                .padding(.bottom, 0) // 廣告直接貼底，不額外加 padding
            }
            .navigationBarHidden(true)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

