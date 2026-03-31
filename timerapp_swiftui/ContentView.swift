


import SwiftUI

struct ContentView: View {
    @AppStorage("test") private var timeCount = 0
    @State private var isRunning = false
    @State var show = false
    @State var note : [String] = UserDefaults.standard.stringArray(forKey: "notes") ?? []
    @State var indxe : Int = -1
    

    let timer = Timer.publish(every:0.002, on: .main, in: .common).autoconnect()
        
    var body: some View {
        
        ZStack{
            Rectangle()
                .fill(Color(hue: 0.641, saturation: 0.418, brightness: 0.275))
                .frame(width: 500 , height: 940)
                .ignoresSafeArea()
            VStack(spacing: 30) {
                
                Text(formattedTime)
                    .font(.system(size: 40, weight: .bold, design: .monospaced))
                    .padding(.top, 100 )
               
                ZStack{
                    ScrollView{
                        Rectangle()
                            .fill(Color(hue: 0.641, saturation: 0.418, brightness: 0.275))
                        if (!note.isEmpty){
                            VStack{
                                
                                ForEach(0 ..< note.count , id: \.self){ i in
                                    
                                    Rectangle()
                                        .fill(Color(hue: 0.674, saturation: 0.457, brightness: 0.381))
                                        .frame(width: 400 , height: 100)
                                        .overlay{
                                            Button(""){
                                            }
                                            Text("\(note[i])")
                                                .font(.title)
                                        }
                                }
                            }
                        }
                    }
                }
                HStack(spacing: 20) {
                    if (show || timeCount > 0){
                        Button(action: {
                            note.append(formattedTime)
                            UserDefaults.standard.set(note, forKey: "notes")
                            indxe += 3
                            
                        }) {
                            Image(systemName: "flag")
                                .foregroundColor(.white)
                                .font(.title)
                                .frame(width: 60, height: 60)
                                .background(Color.black)
                                .clipShape(Circle())
                        }
                    }
                    if (isRunning){
                        Button(action: {
                            if isRunning {
                                isRunning = false
                            } else {
                                isRunning = true
                            }
                            show = true
                        }) {
                            Image(systemName: "pause")
                                .foregroundColor(.white)
                                .font(.title)
                                .frame(width: 60, height: 60)
                                .background(Color.black)
                                .clipShape(Circle())
                        }
                    }
                    else{
                        Button(action: {
                            if isRunning {
                                isRunning = false
                                
                            } else {
                                isRunning = true
                               
                            }
                            show = true
                        }) {
                            Image(systemName: "play")
                                .foregroundColor(.white)
                                .font(.title)
                                .frame(width: 60, height: 60)
                                .background(Color.black)
                                .clipShape(Circle())
                        }
                    }
                    if (show || timeCount > 0){
                        Button(action: {
                            isRunning = false
                            timeCount = 0
                            show = false
                            note = []
                        }) {
                            Image(systemName: "restart")
                                .foregroundColor(.white)
                                .font(.title)
                                .frame(width: 60, height: 60)
                                .background(Color.black)
                                .clipShape(Circle())
                        }
                        
                    }
                }
                .padding(.bottom, 50.0)
            }
        }
        .ignoresSafeArea()
        .onReceive(timer) { _ in
            if isRunning {
                timeCount += 3
            }
        }
        .padding()
    }
    
    
    var formattedTime: String {
        let minute = timeCount / 60000
        let seconds = (timeCount/1000)%60
        let miliSecond = timeCount%1000
       
        return String(format: "%d.%d.%d",minute, seconds, miliSecond)
    }
   
}
#Preview {
    ContentView()
}
