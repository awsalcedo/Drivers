//
//  DriversRowView.swift
//  Drivers
//
//  Created by ALEX WLADIMIR SALCEDO SILVA on 14/3/25.
//

import SwiftUI

struct DriversRowView: View {
    let drivers: [Driver]
    
    var body: some View {
        List {
            ForEach(drivers) { driver in
                DriverRowView(driver: driver)
            }
            
        }
    }
}

struct DriverRowView: View {
    
    let driver: Driver
    
    var body: some View {
        ZStack {
            HStack {
                Image("drivers/\(driver.imagen)")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 52)
                    .clipShape(.circle)
                
                VStack(alignment: .leading) {
                    Text(driver.nombre)
                        .font(.title)
                        .lineLimit(1)
                        .minimumScaleFactor(0.5)
                    
                    Text(driver.nacionalidad)
                }
                // Evitar usar el Spacer en su lugar usar frame
                // Es decir la pila VStack se tome todo el ancho que pueda
                // y con eso empuja a Edad hacia la derecha.
                // Luego uso el alignment para colocar el VStack a la izquierda
                .frame(maxWidth: .infinity, alignment: .leading)
                VStack {
                    Text(driver.equipo)
                        .font(.footnote)
                        .textCase(.uppercase)
                        .bold()
                        .padding(5) // en lo posible usar el padding sin nada
                        .overlay {
                            Capsule()
                                .stroke(style: .init(lineWidth: 1.5))
                        }
                        .foregroundStyle(Color(.gray))
                        .opacity(0.6)
                    Text("Edad: \(driver.edad)")
                }
            }
        }
    }
}

#Preview {
    DriversRowView(drivers: try! Drivers.cargar())
}
