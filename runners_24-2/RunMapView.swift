import SwiftUI
import NMapsMap
import CoreLocation
import WebKit

struct RunMapView: View {
    @State private var mapView: NMFMapView?
    @State private var elapsedTime: TimeInterval = 0
    @State private var distanceTraveled: Double = 0.0
    @State private var timer: Timer?
    @State private var isRunning: Bool = false
    @State private var showStartDialog: Bool = false
    @State private var showWebView: Bool = false
    @State private var routeCoordinates: [NMGLatLng] = []
    @State private var polylineOverlay: NMFPolylineOverlay?

    var body: some View {
        ZStack {
            NaverMapView(
                mapView: $mapView,
                onUpdateDistance: updateDistance,
                routeCoordinates: $routeCoordinates,
                polylineOverlay: $polylineOverlay
            )
            .frame(width: UIScreen.main.bounds.width, height: 500)
            .cornerRadius(10)
            .padding(.top, -355)
            .padding()
            
            VStack {
                Spacer()
                
                VStack {
                    Text("⏱ 러닝 시간").font(.headline)
                    Text(formatElapsedTime(elapsedTime))
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding(.bottom, 8)
                    Text("🏃 달린거리").font(.headline)
                    Text(String(format: "%.2f Km", distanceTraveled))
                        .font(.largeTitle)
                        .fontWeight(.bold)
                }
                .frame(maxWidth: 300)
                .padding()
                .background(Color.white.opacity(0.8))
                .cornerRadius(15)
                .padding(.bottom, 15)
                
                Button(action: {
                    if isRunning {
                        toggleStopwatch()
                    } else {
                        showStartDialog = true
                    }
                }) {
                    Text(isRunning ? "Stop" : "Start")
                        .frame(maxWidth: 200)
                        .padding()
                        .background(isRunning ? Color.gray : Color.accentColor)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding(.horizontal, 16)
                .padding(.bottom, 30)
                .alert(isPresented: $showStartDialog) {
                    Alert(
                        title: Text("러닝 시작").font(.headline),
                        message: Text("어떻게 러닝을 시작하시겠습니까?").font(.subheadline),
                        primaryButton: .default(Text("달리러 가기")) {
                            startSoloRun()
                        },
                        secondaryButton: .default(Text("약속잡기")) {
                            showWebView = true
                        }
                    )
                }
            }
        }
        .sheet(isPresented: $showWebView) {
            MyWebview(urlToLoad: "https://runnershigh-web.vercel.app/", token: "")
        }
    }
    
    //경로 표시
    private func startSoloRun() {
        toggleStopwatch()
        routeCoordinates = [
            NMGLatLng(lat: 35.141612152574226, lng: 129.03352576835152),//시작점
            NMGLatLng(lat: 35.14424218715414, lng: 129.0344657897943),//경유지
            NMGLatLng(lat: 35.15037900574702, lng: 129.03923512382765)//도착지
        ]
    }

    func toggleStopwatch() {
        if isRunning {
            // Stop 상태 처리
            stopStopwatch()
            removeOverlay()
            isRunning = false // 상태를 마지막에 업데이트
            print("Stopped: Current isRunning state: Stopped")
        } else {
            // Start 상태 처리
            isRunning = true // 상태를 먼저 업데이트
            startStopwatch()
            addOverlay()
            print("Started: Current isRunning state: Running")
        }
    }

    private func addOverlay() {
        guard !routeCoordinates.isEmpty, polylineOverlay == nil else { return }
        let polyline = NMFPolylineOverlay(routeCoordinates)
        polyline?.color = UIColor.red
        polyline?.width = 5.0
        polyline?.mapView = mapView
        polylineOverlay = polyline
        print("Overlay added to map.")
    }

    private func removeOverlay() {
        if let polyline = polylineOverlay {
            polyline.mapView = nil
            polylineOverlay = nil
            print("Overlay removed from map.")
        }
    }


    func updateUIView(_ uiView: NMFMapView, context: UIViewRepresentableContext<NaverMapView>) {
        if routeCoordinates.isEmpty {
            // 경로가 비어 있으면 오버레이 제거
            if let existingOverlay = polylineOverlay {
                existingOverlay.mapView = nil
                polylineOverlay = nil
                print("Overlay removed from map.")
            }
        } else {
            // 경로가 있으면 오버레이 추가
            if polylineOverlay == nil {
                let newPolyline = NMFPolylineOverlay(routeCoordinates)
                newPolyline?.color = UIColor.red
                newPolyline?.width = 5.0
                newPolyline?.mapView = uiView
                polylineOverlay = newPolyline
                print("Overlay added to map.")
            }
        }
    }
    
    private func startStopwatch() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            elapsedTime += 1
        }
    }
    
    private func stopStopwatch() {
        timer?.invalidate()
        timer = nil
    }
    
    private func formatElapsedTime(_ time: TimeInterval) -> String {
        let hours = Int(time) / 3600
        let minutes = (Int(time) % 3600) / 60
        let seconds = Int(time) % 60
        return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
    }
    
    private func updateDistance(newDistance: Double) {
        distanceTraveled += newDistance
    }
}


struct NaverMapView: UIViewRepresentable {
    @Binding var mapView: NMFMapView?
    var onUpdateDistance: (Double) -> Void // 거리 업데이트 콜백
    @Binding var routeCoordinates: [NMGLatLng]
    @Binding var polylineOverlay: NMFPolylineOverlay?

    static func CurrentLocationButton(action: @escaping () -> Void) -> some View {
        Button(action: action) {
            Image(systemName: "location.fill")
                .padding()
                .background(Color.white)
                .clipShape(Circle())
                .shadow(radius: 3)
        }
    }
    
    struct WebView: UIViewRepresentable {
        let url: URL

        func makeUIView(context: Context) -> WKWebView {
            let webView = WKWebView()
            let request = URLRequest(url: url)
            webView.load(request)
            return webView
        }

        func updateUIView(_ uiView: WKWebView, context: Context) {}
    }

    class Coordinator: NSObject, CLLocationManagerDelegate {
        var parent: NaverMapView
        let locationManager = CLLocationManager()
        private var lastLocation: CLLocation?
        
        init(parent: NaverMapView) {
            self.parent = parent
            super.init()
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.requestWhenInUseAuthorization()
        }
        
        @MainActor func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            guard let location = locations.last else { return }
            
            // 지도 이동 및 내 위치 업데이트
            DispatchQueue.main.async {
                guard let mapView = self.parent.mapView else { return }
                
                // 지도 위치 업데이트
                let cameraUpdate = NMFCameraUpdate(scrollTo: NMGLatLng(lat: location.coordinate.latitude, lng: location.coordinate.longitude))
                cameraUpdate.animation = .easeIn
                mapView.moveCamera(cameraUpdate)
                mapView.locationOverlay.location = NMGLatLng(lat: location.coordinate.latitude, lng: location.coordinate.longitude)
            }
            
            // 거리 계산
            if let lastLocation = lastLocation {
                let distance = location.distance(from: lastLocation) / 1000 // meters to kilometers
                parent.onUpdateDistance(distance)
            }
            
            // 마지막 위치 업데이트
            lastLocation = location
        }
        
        func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
            print("Location update failed: \(error.localizedDescription)")
        }
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }
    
    func makeUIView(context: UIViewRepresentableContext<NaverMapView>) -> NMFMapView {
        let mapView = NMFMapView()
        self.mapView = mapView

        // 초기 위치 설정
        let initialPosition = NMGLatLng(lat: 35.141612152574226, lng: 129.03352576835152)
        let cameraPosition = NMFCameraPosition(initialPosition, zoom: 15)
        mapView.moveCamera(NMFCameraUpdate(position: cameraPosition))

        // 내 위치 오버레이 구성
        let locationOverlay = mapView.locationOverlay
        locationOverlay.hidden = false
        locationOverlay.location = initialPosition
        locationOverlay.heading = 0
        locationOverlay.circleRadius = 10
        locationOverlay.circleColor = UIColor.blue.withAlphaComponent(0.3)

        return mapView
    }
    
    func updateUIView(_ uiView: NMFMapView, context: Context) {
        if routeCoordinates.isEmpty {
            // 경로가 비어 있으면 오버레이 제거
            if let existingOverlay = polylineOverlay {
                existingOverlay.mapView = nil
                polylineOverlay = nil
                print("Overlay removed from map.")
            }
        } else {
            // 경로가 있으면 오버레이 추가
            if polylineOverlay == nil {
                let newPolyline = NMFPolylineOverlay(routeCoordinates)
                newPolyline?.color = UIColor.red
                newPolyline?.width = 5.0
                newPolyline?.mapView = uiView
                polylineOverlay = newPolyline
                print("Overlay added to map.")
            }
        }
    }

}

struct RunMapView_Previews: PreviewProvider {
    static var previews: some View {
        RunMapView()
    }
}
