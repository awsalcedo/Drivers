//
//  DriverView.swift
//  Drivers
//
//  Created by ALEX WLADIMIR SALCEDO SILVA on 14/3/25.
//

import SwiftUI

struct DriverFixedRowView: View {
    var body: some View {
        ZStack {
            Text("McLaren")
                .textCase(.uppercase)
                .bold()
                .padding(5) // en lo posible usar el padding sin nada
                .overlay {
                    Capsule()
                        .stroke(style: .init(lineWidth: 2))
                }
                .foregroundStyle(Color(.blue))
                .rotationEffect(.degrees(-25))
                .opacity(0.4)
            
            HStack {
                Image(.Drivers.piastri)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 52)
                    .clipShape(.circle)
                
                VStack(alignment: .leading) {
                    Text("Oscar **Piastri**")
                        .font(.title)
                    Text("Australiano")
                }
                // Evitar usar el Spacer en su lugar usar frame
                // Es decir la pila VStack se tome todo el ancho que pueda
                // y con eso empuja a Edad hacia la derecha.
                // Luego uso el alignment para colocar el VStack a la izquierda
                .frame(maxWidth: .infinity, alignment: .leading)
                Text("Edad: \(22)")
            }
        }
    }
}

struct DriverVariableRowView: View {
    
    let driver: DriverF1
    
    var body: some View {
        ZStack {
            HStack {
                Image(.Drivers.verstappen)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 52)
                    .clipShape(.circle)
                
                VStack(alignment: .leading) {
                    Text("\(driver.name) **\(driver.surname)**")
                        .font(.title)
                    Text(driver.country)
                }
                // Evitar usar el Spacer en su lugar usar frame
                // Es decir la pila VStack se tome todo el ancho que pueda
                // y con eso empuja a Edad hacia la derecha.
                // Luego uso el alignment para colocar el VStack a la izquierda
                .frame(maxWidth: .infinity, alignment: .leading)
                VStack {
                    Text(driver.team)
                        .textCase(.uppercase)
                        .bold()
                        .padding(5) // en lo posible usar el padding sin nada
                        .overlay {
                            Capsule()
                                .stroke(style: .init(lineWidth: 1.5))
                        }
                        .foregroundStyle(Color(.gray))
                        .opacity(0.6)
                    Text("Edad: \(driver.age)")
                }
            }
        }
    }
}

struct DriverF1 {
    let name: String
    let surname: String
    let team: String
    let age: Int
    let country: String
    let image: String
}

let verstappen = DriverF1(name: "Max", surname: "Verstappen", team: "Red Bull", age: 27, country: "Holandés", image: "verstappen")

#Preview {
    List {
        DriverFixedRowView()
        DriverVariableRowView(driver: verstappen)
    }
    .listStyle(.plain)
}
