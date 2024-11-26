import SwiftUI
import NMapsMap
import CoreLocation

struct RunMapView: View {
    var body: some View {
        VStack {
            // 네이버 지도 뷰
            NaverMapView()
                .frame(width: UIScreen.main.bounds.width, height: 800)
                .cornerRadius(10)
                .padding(.top, -60)
        }
        .padding()
    }
}

struct NaverMapView: UIViewRepresentable {
    class Coordinator: NSObject, CLLocationManagerDelegate {
        var parent: NaverMapView
        let locationManager = CLLocationManager()
        
        init(parent: NaverMapView) {
            self.parent = parent
            super.init()
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.requestWhenInUseAuthorization()  // 위치 권한 요청 추가
        }
        
        // 위치 정보 업데이트 성공 시 호출
        func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            guard let location = locations.last else { return }
            let lat = location.coordinate.latitude
            let lng = location.coordinate.longitude
            
            DispatchQueue.main.async {
                // 위치 업데이트
                self.parent.mapView?.locationOverlay.location = NMGLatLng(lat: lat, lng: lng)
                
                // 카메라 업데이트 (현재 위치 중심으로 지도 이동)
                let southWest = NMGLatLng(lat: lat - 0.01, lng: lng - 0.01)
                let northEast = NMGLatLng(lat: lat + 0.01, lng: lng + 0.01)
                let bounds = NMGLatLngBounds(southWest: southWest, northEast: northEast)
                let cameraUpdate = NMFCameraUpdate(fit: bounds, padding: 50.0)
                self.parent.mapView?.moveCamera(cameraUpdate)
                
                // 내 위치 주변에 원 추가
                let circleOverlay = NMFCircleOverlay(NMGLatLng(lat: lat, lng: lng), radius: 500)
                circleOverlay.fillColor = UIColor.blue.withAlphaComponent(0.3) // 반투명 파란색
                circleOverlay.outlineColor = UIColor.blue // 테두리 파란색
                circleOverlay.outlineWidth = 2 // 테두리 두께
                circleOverlay.mapView = self.parent.mapView
            }
        }
        
        // 위치 정보 업데이트 실패 시 호출
        func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
            print("Error: \(error.localizedDescription)")
        }
    }
    
    @State private var mapView: NMFMapView?
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }
    
    // NMFMapView 생성 및 초기 설정
    func makeUIView(context: Context) -> NMFMapView {
        let mapView = NMFMapView()
        self.mapView = mapView
        
        // 위치 업데이트 요청
        context.coordinator.locationManager.startUpdatingLocation()
        
        /*// 지도 초기 설정 (서울 중심)
        let cameraPosition = NMFCameraPosition(
            NMGLatLng(lat: 37.5666102, lng: 126.9783881),
            zoom: 17
        )
        mapView.moveCamera(NMFCameraUpdate(position: cameraPosition))
        */
         
        // 내 위치 표시 (위치 서비스가 활성화되면)
        let locationOverlay = mapView.locationOverlay
        locationOverlay.hidden = false
        
        return mapView
    }
    
    // 지도 뷰 업데이트
    func updateUIView(_ uiView: NMFMapView, context: Context) {
        if let location = context.coordinator.locationManager.location {
            let lat = location.coordinate.latitude
            let lng = location.coordinate.longitude
            
            // 위치 정보 업데이트
            uiView.locationOverlay.location = NMGLatLng(lat: lat, lng: lng)
            
            // 카메라 업데이트 (현재 위치 중심으로)
            let southWest = NMGLatLng(lat: lat - 0.01, lng: lng - 0.01)
            let northEast = NMGLatLng(lat: lat + 0.01, lng: lng + 0.01)
            let bounds = NMGLatLngBounds(southWest: southWest, northEast: northEast)
            let cameraUpdate = NMFCameraUpdate(fit: bounds, padding: 50.0)
            uiView.moveCamera(cameraUpdate)
            
            // 내 위치 주변에 원 추가
            let circleOverlay = NMFCircleOverlay(NMGLatLng(lat: lat, lng: lng), radius: 500)
            circleOverlay.fillColor = UIColor.blue.withAlphaComponent(0.3)
            circleOverlay.outlineColor = UIColor.blue
            circleOverlay.outlineWidth = 2
            circleOverlay.mapView = uiView
        }
    }
}
