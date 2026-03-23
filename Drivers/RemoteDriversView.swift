//
//  RemoteDriversView.swift
//  Drivers
//
//  Created by usradmin on 23/3/26.
//

import SwiftUI

struct RemoteDriversView: View {
    @State var drivers: [Driver] = []
    @State private var isErrorPresented = false
    @State private var error: ServerError? = nil
    
    var body: some View {
        List {
            ForEach(drivers) { driver in
                RemoteDriverRowView(driver: driver)
            }
        }
        .alert(isPresented: $isErrorPresented, error: error) {
            Button("Ok") {
                
            }
        }
        .listStyle(.plain)
            .task {
                do {
                    drivers = try await Drivers.cargarDelServidor()
                } catch {
                    self.error = .error(error)
                    isErrorPresented = true
                }
            }
    }
}

enum ServerError: LocalizedError {
    case error(Error)
}

struct RemoteDriverRowView: View {
    let driver: Driver
    
    var body: some View {
        ZStack {
            HStack {
                AsyncImage(url: URL(
                    string: "https://f1demoapp.s3.eu-west-3.amazonaws.com/fotos/\(driver.imagen).heic")
                                   ) { content in
                    content.resizable()
                                   } placeholder: {
                                       Image(systemName: "car")
                                   }
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
    RemoteDriversView()
}

#Preview {
    List {
        RemoteDriverRowView(driver: try! Drivers.cargar().first!)
    }
}
