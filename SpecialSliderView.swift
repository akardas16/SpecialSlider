//
//  ExampleView.swift
//  TalkAI
//
//  Created by Abdullah Kardaş on 11.06.2023.
//

import SwiftUI

struct SpecialSliderView: View {

    @State var progress:CGFloat = 0.4
    @State private var currentValue = 50.0
    @State var fontWeight:Font.Weight = .medium
    var body: some View {
        ZStack {
            LinearGradient(colors: [Color(hex: "#1F2937"),Color(hex: "#1f576e")], startPoint: .top, endPoint: .bottom).ignoresSafeArea()
            VStack {
              
                
                Text("SwiftUI").font(.system(size: 80, weight: fontWeight, design: .rounded)).foregroundColor(.white).frame(height: 200).animation(.linear(duration: 0.3), value: fontWeight)
               
                
                SpecialSlider(value: $currentValue)
                    .frame(maxWidth: .infinity).frame(height: 18).padding(.horizontal)
                    .onChange(of: currentValue) { newValue in
                      
                        if currentValue < 11 {
                            fontWeight = .ultraLight
                        }else if currentValue < 22 {
                            fontWeight = .thin
                        }else if currentValue < 33 {
                            fontWeight = .light
                        }else if currentValue < 44 {
                            fontWeight = .regular
                        }else if currentValue < 55 {
                            fontWeight = .medium
                        }else if currentValue < 66 {
                            fontWeight = .semibold
                        }else if currentValue < 77 {
                            fontWeight = .bold
                        }else if currentValue < 88 {
                            fontWeight = .heavy
                        }else {
                            fontWeight = .black
                        }
                    }
                
                
            }
        }
    }
}

struct SpecialSliderView_Previews: PreviewProvider {
    static var previews: some View {
        SpecialSliderView()
    }
}


struct SliderBack: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.size.width
        let height = rect.size.height
        path.move(to: CGPoint(x: 2.1, y: (height / 2) - 2.1))
        
        path.addLine(to: CGPoint(x: (width - (height / 2)), y: 0))
        path.addQuadCurve(to: CGPoint(x: (width - (height / 2)), y: height), control: CGPoint(x: width, y: height / 2))
      
        path.addLine(to: CGPoint(x: (width - (height / 2)), y: height))
        path.addLine(to: CGPoint(x: 2.1, y: (height / 2) + 2.1))
        
        path.addQuadCurve(to: CGPoint(x: 2.1, y: (height / 2) - 2.1), control: CGPoint(x: 0, y: 0.5 * height))
       
        path.closeSubpath()
        return path
    }
}


struct SpecialSlider: View {
    @Binding var value: Double
    
    @State var lastCoordinateValue: CGFloat = 0.0
    var sliderRange: ClosedRange<Double> = 1...100
    
    var body: some View {
        GeometryReader { gr in
            let thumbSize = gr.size.height * 0.8
            let minValue = gr.size.width * 0.0005
            let maxValue = (gr.size.width * 0.98) - thumbSize
            
            let scaleFactor = (maxValue - minValue) / (sliderRange.upperBound - sliderRange.lowerBound)
            let lower = sliderRange.lowerBound
            let sliderVal = (self.value - lower) * scaleFactor + minValue
            
            ZStack {
                SliderBack().fill(.gray).frame(maxWidth: .infinity).frame(height: 18)
                HStack {
                    Circle()
                        .foregroundColor(Color.white)
                        .frame(width: 27, height: 27)
                        .offset(x: sliderVal)
                        .gesture(
                            DragGesture(minimumDistance: 0)
                                .onChanged { v in
                                    if (abs(v.translation.width) < 0.1) {
                                        self.lastCoordinateValue = sliderVal
                                    }
                                    if v.translation.width > 0 {
                                        let nextCoordinateValue = min(maxValue, self.lastCoordinateValue + v.translation.width)
                                        self.value = ((nextCoordinateValue - minValue) / scaleFactor)  + lower
                                    } else {
                                        let nextCoordinateValue = max(minValue, self.lastCoordinateValue + v.translation.width)
                                        self.value = ((nextCoordinateValue - minValue) / scaleFactor) + lower
                                    }
                                    
                                }
                        )
                    Spacer()
                }
            }
        }
    }
}



