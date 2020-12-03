//
//  TabsView.swift
//  fastgi
//
//  Created by Hegaro on 04/11/2020.
//

import SwiftUI

struct TabsView: View {
    @State private var selectedTab = 0
    @Binding var currentBtnEm: BtnEm
    //header
    @ObservedObject var loginVM = LoginViewModel()
    @State var menu : Bool = false
    
    //new datauser
    @ObservedObject var userDataVM = UserDataViewModel()
    var body: some View {
        NavigationView{
            TabView(selection: $selectedTab) {
                
                HomeView(currentBtnEm: $currentBtnEm)
                    .tabItem {
                        Image(self.selectedTab == 0 ? "home.fill" : "home")
                        Text("Inicio")
                    }.tag(0)
                HistoryView()
                    .tabItem {
                        Image(systemName: self.selectedTab == 1 ? "chart.bar.fill" : "chart.bar")
                        Text("Historial")
                    }.tag(1)
                MembershipView()
                    .tabItem {
                        Image("handshakes")
                        Text("Afiliarse")
                    }.tag(2)
                SettingsView()
                    .tabItem {
                        Image(systemName: self.selectedTab == 3 ? "person.circle.fill" : "person.circle")
                        Text("Ajustes")
                    }.tag(3)
            }
            .accentColor(Color("primary"))
            .navigationBarTitle(self.titulo(), displayMode: .inline)
             .navigationBarItems(
                leading:
                    self.headerIzquierda(),
                 trailing:
                    self.headerDerecha()
             )
        }
        /*.onAppear{
            self.loginVM.DatosUser()
        }*/
      
    }
    
}


struct TabsView_Previews: PreviewProvider {
    static var previews: some View {
        TabsView(currentBtnEm: .constant(.Entel))
        
    }
}


extension TabsView{
    func titulo() -> String {
        if self.selectedTab == 0{
            return "" //"Home"
        }else if self.selectedTab == 1{
            return ""//"History"
        }else if self.selectedTab == 2{
            return ""//"Afiliarse"
        }else if self.selectedTab == 3{
            return ""//"Perfil"
        }
        return "no funciona"
    }
    func headerDerecha() -> AnyView{
       if self.selectedTab == 3{
            return AnyView(
                VStack{
                    Button(action: {
                        self.menu = true
                    }){
                        VStack{
                            Image(systemName: "ellipsis")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20)
                                .padding(.trailing,6)
                            //.font(.title)
                        }
                        .frame(minWidth: 50, minHeight: 50, alignment: .trailing)
                        //.background(Color.red.opacity(0.5))
                    }
                    .buttonStyle(PlainButtonStyle())
                    NavigationLink(destination: MenuView(), isActive: $menu) {
                        EmptyView()
                    }.isDetailLink(false)
                }
            )
        }
        return AnyView(EmptyView())
    }
    
    func headerIzquierda() -> AnyView{
        if self.selectedTab == 0 || self.selectedTab == 1 || self.selectedTab == 2 {//} || self.selectedTab == 3{
            return AnyView(HeaderUserView(text: "\(self.userDataVM.user.nombres) \(self.userDataVM.user.apellidos)", _id :self.userDataVM.user._id))
        }
        return AnyView(EmptyView())
        
    }
}


