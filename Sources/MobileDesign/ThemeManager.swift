//
// ThemeManager.swift
//
// Copyright © 2022 New Media Group. All rights reserved.
//

import Foundation

protocol ThemeManageable {
    associatedtype ImplementationType
    var currentTheme: NMGThemeable { get }
    func applyTheme(_ theme: NMGThemeable)
}

public enum Theme: String {
    case ED
    case WW
    case KISS
    case MORE
    case GOTRIP
    case OS
    case NM
}

extension Theme {
    var themeableColors: any NMGThemeableColors {
        switch self {
        case .ED:
            return EDColors()
        case .WW:
            return WWColors()

        case .KISS:
            return KISSColors()
        case .MORE:
            return MOREColors()
        case .GOTRIP:
            return GOTRIPColors()
        case .OS:
            return OSColors()
        case .NM:
            return NMColors()
        }
    }
}

public final class ThemeManager: ThemeManageable {
    public typealias ImplementationType = ThemeManager
    public enum Static {
        public static var instance: ImplementationType?
    }

    public static var shared: ImplementationType {
        guard let instance = Static.instance else {
            Static.instance = ThemeManager()
            return Static.instance!
        }
        return instance
    }

    public var currentTheme: NMGThemeable {
        if _currentTheme == nil {
            _currentTheme = NMGDefaultTheme()
        }
        return _currentTheme
    }

    public func applyTheme(_ theme: Theme) {
        _currentTheme = NMGDefaultTheme({
            theme.themeableColors
        }, {
            NMGDefaultFonts()
        }, {
            NMGDefaultIcons()
        })
    }

    public func applyTheme(_ theme: NMGThemeable) {
        _currentTheme = theme
    }

    private var _currentTheme: NMGThemeable!
}
