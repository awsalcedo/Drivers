//
//  RemoteDriversView.swift
//  Drivers
//
//  Created by usradmin on 23/3/26.
//

import SwiftUI

struct RemoteDriversView: View {
    /*@State var drivers: [Driver] = []
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
     }*/
    
    // MARK: - State
    
    @State private var viewModel: DriversListViewModel
    
    // MARK: - Initializers
    
    init(interactor: DriversListInteractorProtocol = DriversListInteractor()) {
        self.viewModel = DriversListViewModel(interactor: interactor)
    }
    
    var body: some View {
        NavigationStack {
            Group {
                if viewModel.isLoading && viewModel.drivers.isEmpty {
                    loadingView
                } else if let errorMessage = viewModel.errorMessage, viewModel.drivers.isEmpty {
                    errorView(message: errorMessage)
                } else if viewModel.drivers.isEmpty {
                    emptyView
                } else {
                    contentView
                }
            }
            .navigationTitle("Pilotos")
            .alert(
                L10n.Error.title,
                isPresented: Binding(
                    get: { viewModel.errorMessage != nil && !viewModel.drivers.isEmpty },
                    set: { if !$0 { viewModel.errorMessage = nil } }
                )
            ) {
                Button(L10n.Common.ok, role: .cancel) {
                    viewModel.errorMessage = nil
                }
                
                Button(L10n.Common.retry) {
                    Task {
                        await viewModel.loadDrivers()
                    }
                }
            } message: {
                if let errorMessage = viewModel.errorMessage {
                    Text(errorMessage)
                }
            }
            .task {
                await viewModel.loadDrivers()
            }
        }
    }
    
    // MARK: - Private Views
    
    private var contentView: some View {
        List {
            ForEach(viewModel.drivers) { driver in
                RemoteDriverRowView(driver: driver)
            }
        }
        .listStyle(.plain)
    }
    
    private var loadingView: some View {
        ProgressView(L10n.Common.loading)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    private var emptyView: some View {
        ContentUnavailableView(
            "No hay pilotos",
            systemImage: "car",
            description: Text("No se encontraron pilotos para mostrar.")
        )
    }
    
    private func errorIcon(for message: String) -> String {
        switch message {
        case L10n.Error.network:
            return "wifi.exclamationmark"
        case L10n.Error.timeout:
            return "clock.badge.exclamationmark"
        default:
            return "exclamationmark.triangle"
        }
    }
    
    private func errorView(message: String) -> some View {
        ContentUnavailableView(
            L10n.Error.title,
            systemImage: errorIcon(for: message),
            description: Text(message)
        )
        .overlay(alignment: .bottom) {
            Button(L10n.Common.retry) {
                Task {
                    await viewModel.loadDrivers()
                }
            }
            .buttonStyle(.borderedProminent)
            .padding(.bottom, 40)
        }
    }
}



struct RemoteDriverRowView: View {
    
    let driver: Driver
    
    // MARK: - Body
    
    var body: some View {
        ZStack {
            HStack {
                AsyncImage(url: URL(string: "https://f1demoapp.s3.eu-west-3.amazonaws.com/fotos/\(driver.imagen).heic")
                ) { fase in
                    switch fase {
                    case .empty:
                        ProgressView()
                    case .success(let image):
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                    case .failure(_):
                        Image(systemName: "car")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .padding(12)
                    @unknown default:
                        Image(systemName: "car")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .padding(12)
                        
                    }
                }
                .frame(width: 56, height: 56)
                .clipShape(Circle())
                
                
                
                VStack(alignment: .leading) {
                    Text(driver.nombre)
                        .font(.headline)
                        .lineLimit(1)
                        .minimumScaleFactor(0.8)
                    
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
