xcodebuild \
    -scheme "MobileDesign" \
    -destination 'platform=iOS Simulator,name=iPhone 13,OS=15.4' \
    test

xcodebuild \
    -project "MobileDesignApp/MobileDesignApp.xcodeproj" \
    -scheme "MobileDesignApp" \
    -destination 'platform=iOS Simulator,name=iPhone 13,OS=15.4' \
    test