pragma Singleton
import QtQuick
import QtQuick.Controls

Item {
    readonly property color avegareColor: "#486377"
    readonly property color backColor: "#ECECEC"
    readonly property color backgroundColor: "#FFFFFF"
    readonly property color bgColor: "#D5D7D9"
    readonly property color bgRectColor: "#B9B9B9"
    readonly property color boltTestTextColor: "#ABABAB"

    //    Bolts Power Profile Colour Properties
    readonly property color boltsPowerColor: "#6F6F6E"
    readonly property color boltsPowerTolColor: "#800000"
    readonly property color borderColor: "#F0F0F0"
    readonly property color buttonBackColor: "#73C5C0"
    //    Generic Properties
    readonly property color buttonColor: "#73C4C0"
    readonly property color buttonHoverColor: "#3EACA7"
    readonly property color buttonPressedColor: "#0D9791"
    readonly property color darkLineColor: "#FC7225"
    readonly property color edgeCutColor: "#7B6EB4"
    readonly property color errorColor: "#F00C18"
    readonly property color highColor: "#DAD1FF"
    readonly property color highlightBoxColor: "#F9F9F9"
    readonly property color innerBgColor: "#D9D9D9"
    readonly property color kpiSetValueColor: "#516171"
    readonly property color labelColor: "#818181"
    readonly property color listBackColor: "#DEDEDE"

    //    Cross Profile Graph Colour Properties
    readonly property color liveLineseriesColor: "#75C98C"
    readonly property string lmFontFamily: "oxanium"
    readonly property color menuBarColor: "#C2C5C7"
    readonly property color miDisableColor: "#D1D2D5"
    readonly property color miDisabledColor: "#767676"
    readonly property color miEnabledColor: "#90EE90"
    readonly property color mouseHoverColor: "#ABABAB"
    readonly property color n_1ProfileColor: "#FF0096FF"
    readonly property color n_2ProfileColor: "#BF0096FF"
    readonly property color n_3ProfileColor: "#990096FF"
    readonly property color n_4ProfileColor: "#660096FF"
    readonly property color n_5ProfileColor: "#330096FF"
    readonly property color offColor: "#FF6868"

    //    Homescreen Items Colours
    readonly property color primaryColor: "#19A5FF"
    readonly property color rc1Color: "#51A2C5"
    readonly property color rc2Color: "#A7C551"
    readonly property color rc3Color: "#C56D51"
    readonly property color rc4Color: "#C551B9"
    readonly property color rc5Color: "#7D51C5"
    readonly property color scrollBarColor: "#707171"
    readonly property color secondaryColor: "#13D1FF"
    readonly property color setValueColor: "#00396D"
    readonly property color stopAnimationColor: "#58F483"
    readonly property color surfaceColor: "#F2F2F2"
    readonly property color tertiaryColor: "#FEE719"
    readonly property color textBgColor: "#6B6B6B"
    readonly property color textColor: "#3D3D3D"
    readonly property color textfldBorderColor: "#FF6868"
    readonly property color thinLineColor: "#FF9E68"
    readonly property color toleranceColor: "#CE7E1F"
    readonly property color toolTipPrimaryColor: "#000000"

    //    Trend Profile Colour Properties
    readonly property color tpAvgColor: "#51A2C5"
    readonly property color tpMaxColor: "#C56D51"
    readonly property color tpMinColor: "#A7C551"
    readonly property color tpNegTolColor: "#6F6F6E"
    readonly property color tpPosTolColor: "#C551B9"
    readonly property color tpSetValueColor: "#7B6EB4"
    readonly property color translucentColor: Qt.rgba(0.2, 0.2, 0.2, mainController.settingController.generalSetting.popupOpacity)
    readonly property color transparentColor: "#00000000"
}
