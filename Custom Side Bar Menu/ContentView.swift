//
//  ContentView.swift
//  Custom Side Bar Menu
//
//  Created by Admin on 9/5/20.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Home()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct Home: View {
    
    @State var edges = UIApplication.shared.windows.first?.safeAreaInsets
    @State var width = UIScreen.main.bounds.width
    @State var show = false
    @State var selectedIndex = ""
    @State var min: CGFloat = 0
    
    var body: some View {
        ZStack {
            VStack {
                ZStack {
                    HStack {
                        Button(action: {}, label: {
                            Image(systemName: "line.horizontal.3")
                                .foregroundColor(.black)
                                .font(.system(size: 22))
                        })
                        
                        Spacer()
                        
                        Button(action: {
                            withAnimation(.spring()) {
                                show.toggle()
                            }
                        }, label: {
                            Image("pic")
                                .resizable()
                                .renderingMode(.original)
                                .frame(width: 35, height: 35)
                                .clipShape(Circle())
                        })
                    }
                    
                    Text("Home")
                        .font(.title2)
                        .fontWeight(.semibold)
                }
                .padding()
                .padding(.top, edges!.top)
                .background(Color.white)
                .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 5)
                
                Spacer()
                
                Text(selectedIndex)
                
                Spacer()
            }
            HStack(spacing: 0) {
                Spacer()
                VStack {
                    HStack {
                        Spacer()
                        Button(action: {
                            withAnimation(.spring()) {
                                show.toggle()
                            }
                        }, label: {
                            Image(systemName: "xmark")
                                .foregroundColor(.white)
                                .font(.system(size: 22, weight: .bold))
                        })
                    }
                    .padding()
                    .padding(.top, edges!.top)
                    
                    HStack(spacing: 15) {
                        GeometryReader { reader in
                            Image("pic")
                                .resizable()
                                .frame(width: 75, height: 75)
                                .clipShape(Circle())
                                .onAppear( perform: {
                                    self.min = reader.frame(in: .global).minY
                                })
                        }
                        .frame(width: 75, height: 75)
                        
                        VStack(alignment: .leading, spacing: 5, content: {
                            Text("Nick")
                                .font(.title)
                                .fontWeight(.semibold)
                            Text("nick@gmail.com")
                                .fontWeight(.semibold)
                        })
                        .foregroundColor(.white)
                        
                        Spacer()
                    }
                    .padding(.horizontal)
                    
                    VStack(alignment: .leading, spacing: 5, content: {
                        MenuButtons(image: "cart", title: "My Orders", show: $show, selectedIndex: $selectedIndex)
                        MenuButtons(image: "person", title: "My Profile", show: $show, selectedIndex: $selectedIndex)
                        MenuButtons(image: "mappin", title: "Delivery Address", show: $show, selectedIndex: $selectedIndex)
                        MenuButtons(image: "creditcard", title: "Payment Methods", show: $show, selectedIndex: $selectedIndex)
                        MenuButtons(image: "envelope", title: "Contact Us", show: $show, selectedIndex: $selectedIndex)
                        MenuButtons(image: "gear", title: "Settings", show: $show, selectedIndex: $selectedIndex)
                        MenuButtons(image: "info.circle", title: "Help & FAQs", show: $show, selectedIndex: $selectedIndex)
                    })
                    .padding(.top)
                    .padding(.leading, 45)
                    
                    Spacer()
                }
                .frame(width: width - 80)
                .background(Color("Color1"))
                .clipShape(CustomShape(min: $min))
                .offset(x: show ? 0 : width - 80)
            }
            .background(Color.black.opacity(show ? 0.3 : 0))
        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct MenuButtons: View {
    
    var image: String
    var title: String
    @Binding var show: Bool
    @Binding var selectedIndex: String
    
    var body: some View {
        Button(action: {
            withAnimation(.spring()) {
                selectedIndex = title
                show.toggle()
            }
        }, label: {
            HStack(spacing: 15) {
                Image(systemName: image)
                    .font(.system(size: 22))
                    .frame(width: 25, height: 25)
                Text(title)
                    .font(.title3)
                    .fontWeight(.semibold)
            }
            .padding(.vertical)
            .padding(.trailing)
        })
        // For Smaller Size iPhones...
        .padding(.top, UIScreen.main.bounds.width < 750 ? 0 : 5)
        .foregroundColor(.white)
    }
}

struct CustomShape: Shape {
    
    @Binding var min: CGFloat
    
    func path(in rect: CGRect) -> Path {
        return Path { path in
            path.move(to: CGPoint(x: rect.width, y: 0))
            path.addLine(to: CGPoint(x: rect.width, y: rect.height))
            path.addLine(to: CGPoint(x: 35, y: rect.height))
            path.addLine(to: CGPoint(x: 35, y: 0))
            
            path.move(to: CGPoint(x: 35, y: min - 15))
            path.addQuadCurve(to: CGPoint(x: 35, y: min + 90), control: CGPoint(x: -35, y: min + 35))
        }
    }
}
