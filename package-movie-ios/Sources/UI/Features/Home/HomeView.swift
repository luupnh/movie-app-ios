//
//  HomeView.swift
//  
//
//  Created by Luu Phan on 28/02/2023.
//

import SwiftUI
import Resources
import DependencyKit

public struct HomeView: View {
    
    @Environment(\.theme) var theme: AppTheme
    
    @ObservedObject var viewModel:HomeViewModel
    
    @StateObject var carouselViewModel = Container.carouselViewModel()
    
    @StateObject var categoriesViewModel = Container.categoriesViewModel()
    
    public init(viewModel:HomeViewModel) {
        self.viewModel = viewModel
    }
    
    public var body: some View {
        TabView(selection: $viewModel.homeTab) {
            VStack(alignment: .leading) {
                HomeHeaderView()
                    .padding(.horizontal, 16)
                SearchHomeView()
                    .padding(.horizontal, 16)
                    .padding(.vertical, 16)
                CarouselView(viewModel: carouselViewModel)
                CategoriesView(viewModel: categoriesViewModel)
                Spacer()
            }
            .tag(HomeTab.home)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(theme.primary)
            
            Text("Search")
                .font(.system(size: 40, weight: .bold, design: .default))
                .tag(HomeTab.search)
            
            Text("Download")
                .font(.system(size: 40, weight: .bold, design: .default))
                .tag(HomeTab.download)
            
            Text("Profile")
                .font(.system(size: 40, weight: .bold, design: .default))
                .tag(HomeTab.profile)
        }
        .foregroundColor(theme.primary)
        .overlay {
            VStack {
                Spacer()
                HStack(alignment: .center) {
                    
                    ForEach(HomeTab.allCases, id: \.self) { tab in
                        buildTab(tab)
                            .padding(.horizontal, 8)
                    }
                    
                    
                }
                .padding(.horizontal, 45)
                .frame(height: 60)
                .frame(maxWidth: .infinity,alignment: .bottom)
                .background(theme.primary)
            }
            .animation(.easeInOut, value: viewModel.homeTab)
            
        }
        //        TabView {
        //            VStack(alignment: .leading) {
        //                HomeHeaderView()
        //                    .padding(.horizontal, 16)
        //                SearchHomeView()
        //                    .padding(.horizontal, 16)
        //                    .padding(.vertical, 16)
        //                CarouselView(viewModel: carouselViewModel)
        //                CategoriesView(viewModel: categoriesViewModel)
        //                Spacer()
        //            }
        //            .frame(maxWidth: .infinity, maxHeight: .infinity)
        //            .background(theme.primary)
        //        }
    }
    
    @ViewBuilder
    func buildTab(_ tab: HomeTab) -> some View {
        let info = infoTab(tab)
        HStack {
            Image(systemName: info.image)
            if tab == viewModel.homeTab {
                Text(info.text)
                    .font(.system(size: 12))
                    .lineLimit(1)
            }
        }
        .foregroundColor(theme.blue12CDD9)
        .padding(.horizontal, 10)
        .frame(height: 40)
        .background(theme.blue252836)
        .cornerRadius(16)
        .onTapGesture {
            viewModel.goTab(tab: tab)
        }
    }
    
    func infoTab(_ tab: HomeTab) -> (image: String, text: String) {
        switch tab {
        case .home:
            return (image: "house.fill", text: "Home")
        case .search:
            return (image: "magnifyingglass", text: "Search")
        case .download:
            return (image: "arrow.down.to.line.compact", text: "Download")
        case .profile:
            return (image: "person.fill", text: "Profile")
        }
    }
}
//struct HomeView_Previews: PreviewProvider {
//    static var previews: some View {
//        HomeView(viewModel: HomeViewModel())
//    }
//}
