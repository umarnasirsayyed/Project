import QtQuick
import QtQuick.Window
import QtCharts
import QtQuick.Controls

Window {
    id:gwindow
    width: 1700
    height: 900
    visible: true
    title: qsTr("BOLT PROFILE")
    color: "gray"

    function handleButtonClick()
    {
        var boltCount = parseInt(inputField.text);
        backend.handleInput(boltCount);
    }
    Text
    {
        font.bold: true
        font.pointSize: 30
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        anchors.centerIn: parent
        text: "GRAPH WILL BE DISPLAYED HERE."

    }
    Rectangle
    {
        id:rect1
        anchors.top: parent.top
        anchors.left: parent.left
        height: 100
        width: 600
        color: gwindow.color

        Column
        {
            TextField
            {
                id: inputField
                width: 300
                height: 20
                placeholderText: "Enter Number of bolts(Maximum bolts: 70)"
            }
            Button
            {
                id:ipbutton
                text: "Enter"
                width: 100
                height: 40
                onClicked:
                {
                    handleButtonClick()
                    chart.visible = true;
                }
            }
        }
    }

    Rectangle {
        id: rectBoltsProfile
        width: 1500
        height: 800
        property var colors: []
        property point currentPos
        property var graphPen: graphController.grayPen
        property var values: []
        anchors.centerIn: parent
        color: "#00000000"
        radius: 6

        Component.onCompleted: {
            axisXBar.max = graphController.boltsProfile.bpGraphXMax;
            if (graphController.boltsProfile.bpInitialSetting === 1) {
                axisY.min = graphController.crossProfile.cpGraphYMin;
                axisY.max = graphController.crossProfile.cpGraphYMax;
            } else if (graphController.boltsProfile.bpInitialSetting === 2) {
                axisY.min = graphController.cpTwiceTolMin;
                axisY.max = graphController.cpTwiceTolMax;
            }
        }

        Component {
            id: compBoxSet

            BoxSet {
                values: [0, 0, 0, 0, 0]
            }
        }

        Connections {
            function onCpTwiceTolMaxChanged(max) {
                if (graphController.boltsProfile.bpInitialSetting === 2) {
                    axisY.max = max;
                }
            }

            function onCpTwiceTolMinChanged(min) {
                if (graphController.boltsProfile.bpInitialSetting === 2) {
                    axisY.min = min;
                }
            }

            function onNegToleranceChanged(negTolerance) {
                lineseriesNegTol.clear();
                lineseriesNegTol.append(0, negTolerance);
                lineseriesNegTol.append(graphController.endPos, negTolerance);
            }

            function onNoOfDiesChanged(dieNum) {
                axisXBar.max = Number(dieNum).toLocaleString();
            }

            function onPosToleranceChanged(posTolerance) {
                lineseriesPosTol.clear();
                lineseriesPosTol.append(0, posTolerance);
                lineseriesPosTol.append(graphController.endPos, posTolerance);
            }

            function onSetValueChanged(setValue) {
                lineseriesSetValue.clear();
                lineseriesSetValue.append(0, setValue);
                lineseriesSetValue.append(graphController.endPos, setValue);
            }

            target: graphController
        }

        Connections {
            function onBpArrayDataChanged(bolts) {
                boltsProfileSeries.clear();
                for (var i = 0; i < bolts.length; ++i) {
                    boltsProfileSeries.append(compBoxSet.createObject(boltsProfileSeries, {
                                "label": bolts[i].label,
                                "values": bolts[i].values,
                                "modified": true,
                                "labelUp": bolts[i].isLabelUp,
                                "labelVisible": bolts[i].isLabelVisible,
                                "fillColor": bolts[i].fillColor,
                                "pen": graphPen
                            }));
                }
            }

            function onBpGraphXMaxChanged() {
                axisXBar.max = graphController.boltsProfile.bpGraphXMax;
            }

            function onBpGraphYMaxChanged(max) {
                axisY.max = max;
            }

            function onBpGraphYMinChanged(min) {
                axisY.min = min;
            }

            function onClearGraphsChanged() {
                boltsProfileSeries.clear();
            }

            function onResetMinMaxGraphsChanged() {
                axisY.min = graphController.crossProfile.cpGraphYMin;
                axisY.max = graphController.crossProfile.cpGraphYMax;
                axisX.min = 0;
                axisX.max = graphController.endPos;
                var dieNum = graphController.noOfDies;
                axisXBar.max = Number(dieNum).toLocaleString();
                chart.zoomReset();
            }

            function onResetTolGraphsChanged() {
                axisY.min = graphController.cpTwiceTolMin;
                axisY.max = graphController.cpTwiceTolMax;
                axisX.min = 0;
                axisX.max = graphController.endPos;
                var dieNum = graphController.noOfDies;
                axisXBar.max = Number(dieNum).toLocaleString();
                chart.zoomReset();
            }

            target: graphController.boltsProfile
        }

        Connections {
            function onCpGraphYMaxChanged(max) {
                if (graphController.boltsProfile.bpInitialSetting === 1) {
                    axisY.max = max;
                }
            }

            function onCpGraphYMinChanged(min) {
                if (graphController.boltsProfile.bpInitialSetting === 1) {
                    axisY.min = min;
                }
            }

            target: graphController.crossProfile
        }

        ChartView {
            id: chart
            theme: ChartView.ChartThemeLight
            animationOptions: ChartView.AllAnimations
            visible: false
            antialiasing: true
            backgroundRoundness: 0
            dropShadowEnabled: true
            legend.visible: false
            title: ""
//            backgroundRoundness: 0
            clip: true
//            dropShadowEnabled: true
            smooth: true

            anchors {
                bottomMargin: 2.5
                fill: parent
                leftMargin: 5
                rightMargin: 5
                topMargin: 5
            }

            margins {
                left: 30
                top: 40
            }

//            LMTooltip {
//                id: tpBoltsProfile

//                visible: false
//            }

            Rectangle {
                id: rectZoom

                color: "#000000"
                opacity: 0.6
                visible: false
            }

            MouseArea {
                anchors.fill: parent
                hoverEnabled: true

                //            onWheel: function (wheel) {
                //                if (wheel.angleDelta.y > 0) {
                //                    chart.zoomIn()
                //                } else if (wheel.angleDelta.y < 0) {
                //                    chart.zoomOut()
                //                }
                //            }
                onDoubleClicked: {
                    chart.zoomReset();
                }
                onMouseXChanged: {
                    rectZoom.width = mouseX - rectZoom.x;
//                    currentPos = Qt.point(mouseX, mouseY);
                }
                onMouseYChanged: {
                    rectZoom.height = mouseY - rectZoom.y;
//                    currentPos = Qt.point(mouseX, mouseY);
                }
                onPressed: {
                    rectZoom.x = mouseX;
                    rectZoom.y = mouseY;
                    rectZoom.visible = true;
                }
                onReleased: {
                    chart.zoomIn(Qt.rect(rectZoom.x, rectZoom.y, rectZoom.width, rectZoom.height));
                    rectZoom.visible = false;
                }
            }

            PinchArea {
                id: pa

                anchors.fill: parent

                onPinchUpdated: {
                    chart.zoomReset();
                    var center_x = pinch.center.x;
                    var center_y = pinch.center.y;
                    var width_zoom = height / pinch.scale;
                    var height_zoom = width / pinch.scale;
                    var r = Qt.rect(center_x - width_zoom / 2, center_y - height_zoom / 2, width_zoom, height_zoom);
                    chart.zoomIn(r);
                }
            }

            ValuesAxis {
                id: axisY

                labelsFont: Style.lmFontFamily
            }

            ValuesAxis {
                id: axisX

                max: graphController.endPos
                min: 0
                visible: false
            }

            BarCategoryAxis {
                id: axisXBar

                labelsAngle: -35
                labelsFont: Style.lmFontFamily
            }

//            BarSeries {
//                axisX: BarCategoryAxis { categories: ["1","2","3","4","5","6","7","8","9","10","11","12","13","14","15"] }
//                BarSet {
//                    id: barSet
//                    values: [12, 10, 9, 10, 10,11,10, 9, 11, 11, 10,10, 10, 11, 10, 17]
//                }
//            }


            BarSeries {
                axisX: BarCategoryAxis { categories:dataHolder.categories }
                BarSet {
                    id: barSet
                    values:dataHolder.values
                }
            }
            Timer
            {
                interval: 5000
                running: true
                repeat: true
                onTriggered: {
                    // Update BarSet values with new random values
                    for (var i = 0; i < barSet.values.length; i++) {
                        barSet.values[i] = Math.floor(Math.random() * 20); // Adjust the range as needed
                    }
                }
            }



            LineSeries
            {
                id: lineseriesNegTol
                capStyle: Qt.RoundCap
                color:"red"
                width: 2
//                XYPoint {y:10}
                XYPoint { x: 1; y: 11.5 }
                XYPoint { x: 2; y: 11.5 }
                XYPoint { x: 3; y: 11.5 }
                XYPoint { x: 4; y: 11.5 }
            }

            LineSeries
            {
                id: lineseriesSetValue
                capStyle: Qt.RoundCap
                color:"dark blue"
                width: 2
//                XYPoint {y:10}
                XYPoint { x: 1; y: 10 }
                XYPoint { x: 2; y: 10 }
                XYPoint { x: 3; y: 10 }
                XYPoint { x: 4; y: 10 }
            }

            LineSeries
            {
                id: lineseriesPosTol
                capStyle: Qt.RoundCap
                color:"red"
                width: 2
//                XYPoint {y:10}
                XYPoint { x: 1; y: 8.5 }
                XYPoint { x: 2; y: 8.5}
                XYPoint { x: 3; y: 8.5 }
                XYPoint { x: 4; y: 8.5 }
            }
            //            LineSeries {
            //                id: lineseriesNegTol

            //                axisX: axisX
            //                axisY: axisY
            //                capStyle: Qt.RoundCap
            //                color: Style.toleranceColor
            //                width: 2
            //            }

            //            LineSeries {
            //                id: lineseriesSetValue

            //                axisX: axisX
            //                axisY: axisY
            //                capStyle: Qt.RoundCap
            //                color: Style.setValueColor
            //                width: 2
            //            }


//                   BarCategoryAxis {
//                       categories: ["1","2","3","4","5","6","7","8","9","10","11","12","13","14","15"]
//                   }

//                   ValuesAxis {
//                       min: 0
//                       max: 25
//                       labelFormat: "%.0f"
//                   }

//            StackedBarSeries
//            {
//                id: mySeries

//                axisX: BarCategoryAxis { categories: ["1","2","3","4","5","6","7","8","9","10","11","12","13","14","15"] }
//                BarSet                      {values: [12, 10, 9, 10, 10,11,10, 9, 11, 11, 10,10, 10, 11, 10, 20]}
//                barWidth: axisX.cellWidth
//            }

//            BoxPlotSeries {
//                id: boltsProfileSeries

//                axisX: axisXBar
//                axisY: axisY

//                onHovered: function (status, boxset) {
//                    values = [];
//                    colors = [];
//                    values.push("Max. Th: " + boxset.values[4].toFixed(2));
//                    values.push("Curr. Th: " + boxset.values[2].toFixed(2));
//                    values.push("Min. Th: " + boxset.values[0].toFixed(2));
//                    colors.push(boxset.fillColor);
//                    colors.push(boxset.fillColor);
//                    colors.push(boxset.fillColor);
//                    var p = chart.mapToValue(currentPos, boltsProfileSeries);
//                    tpBoltsProfile.heading = "Bolt: " + boxset.label;
//                    tpBoltsProfile.valuesList = values;
//                    tpBoltsProfile.colorList = colors;
//                    tpBoltsProfile.x = currentPos.x;
//                    tpBoltsProfile.y = p.y - tpBoltsProfile.height;
//                    tpBoltsProfile.visible = status;
//                }

//                BoxSet {
//                    values: [0, 0, 0, 0, 0]
//                }

//                BoxSet {
//                    values: [0, 0, 0, 0, 0]
//                }

//                BoxSet {
//                    values: [0, 0, 0, 0, 0]
//                }

//                BoxSet {
//                    values: [0, 0, 0, 0, 0]
//                }

//                BoxSet {
//                    values: [0, 0, 0, 0, 0]
//                }

//                BoxSet {
//                    values: [0, 0, 0, 0, 0]
//                }

//                BoxSet {
//                    values: [0, 0, 0, 0, 0]
//                }

//                BoxSet {
//                    values: [0, 0, 0, 0, 0]
//                }

//                BoxSet {
//                    values: [0, 0, 0, 0, 0]
//                }

//                BoxSet {
//                    values: [0, 0, 0, 0, 0]
//                }

//                BoxSet {
//                    values: [0, 0, 0, 0, 0]
//                }

//                BoxSet {
//                    values: [0, 0, 0, 0, 0]
//                }

//                BoxSet {
//                    values: [0, 0, 0, 0, 0]
//                }

//                BoxSet {
//                    values: [0, 0, 0, 0, 0]
//                }

//                BoxSet {
//                    values: [0, 0, 0, 0, 0]
//                }

//                BoxSet {
//                    values: [0, 0, 0, 0, 0]
//                }

//                BoxSet {
//                    values: [0, 0, 0, 0, 0]
//                }

//                BoxSet {
//                    values: [0, 0, 0, 0, 0]
//                }

//                BoxSet {
//                    values: [0, 0, 0, 0, 0]
//                }

//                BoxSet {
//                    values: [0, 0, 0, 0, 0]
//                }

//                BoxSet {
//                    values: [0, 0, 0, 0, 0]
//                }

//                BoxSet {
//                    values: [0, 0, 0, 0, 0]
//                }

//                BoxSet {
//                    values: [0, 0, 0, 0, 0]
//                }

//            }

//            LineSeries {
//                id: lineseriesPosTol

//                axisX: axisX
//                axisY: axisY
//                capStyle: Qt.RoundCap
//                color: Style.toleranceColor
//                width: 2
//            }

//            LineSeries {
//                id: lineseriesNegTol

//                axisX: axisX
//                axisY: axisY
//                capStyle: Qt.RoundCap
//                color: Style.toleranceColor
//                width: 2
//            }

//            LineSeries {
//                id: lineseriesSetValue

//                axisX: axisX
//                axisY: axisY
//                capStyle: Qt.RoundCap
//                color: Style.setValueColor
//                width: 2
//            }

            Text {
                id: txtName

                color: Style.textColor
                text: qsTr("BOLT PROFILE")

                font {
                    family: Style.lmFontFamily
                    pixelSize: 16
                    weight: Font.Bold
                }

                anchors {
                    left: parent.left
                    leftMargin: 30
                    top: parent.top
                    topMargin: 20
                }
            }

            Rectangle {
                id: rectExpand

                color: "transparent"
                height: width
                width: 30

                anchors {
                    right: parent.right
                    rightMargin: 30
                    top: parent.top
                    topMargin: 16
                }

                Image {
                    id: imgExpand

                    anchors.fill: parent
                    anchors.margins: 5
                    antialiasing: true
                    fillMode: Image.PreserveAspectFit
                    smooth: true
                    source: root.graphExpanded ? "qrc:/lm/gauge/core/assets/graphs/close.png" : "qrc:/lm/gauge/core/assets/graphs/expand.png"
                    sourceSize: Qt.size(width * 2, height * 2)
                }

                MouseArea {
                    id: maExpand

                    anchors.fill: parent
                    hoverEnabled: true

                    onClicked: {
                        if (root.graphExpanded) {
                            graphPopupLoader.sourceComponent = blankComponent;
                            root.graphExpanded = false;
                        } else {
                            graphPopupLoader.sourceComponent = compBoltsProfile;
                            root.graphExpanded = true;
                        }
                    }
                    onEntered: {
                        rectExpand.color = Style.mouseHoverColor;
                    }
                    onExited: {
                        rectExpand.color = Style.transparentColor;
                    }
                }
            }

            Rectangle {
                id: rectSettings

                color: "transparent"
                height: width
                width: 30

                anchors {
                    right: rectExpand.left
                    rightMargin: 20
                    top: parent.top
                    topMargin: 16
                }

                Image {
                    id: imgSettings

                    anchors.fill: parent
                    anchors.margins: 5
                    antialiasing: true
                    fillMode: Image.PreserveAspectFit
                    smooth: true
                    source: "qrc:/lm/gauge/core/assets/graphs/graph_settings.svg"
                    sourceSize: Qt.size(width * 2, height * 2)
                }

                MouseArea {
                    id: maSettings

                    anchors.fill: parent
                    hoverEnabled: true

                    onClicked: {
                        popBPSettings.open();
                    }
                    onEntered: {
                        rectSettings.color = Style.mouseHoverColor;
                    }
                    onExited: {
                        rectSettings.color = Style.transparentColor;
                    }
                }
            }

            Rectangle {
                id: rectSnapshot

                color: "transparent"
                height: width
                width: 30

                anchors {
                    right: rectSettings.left
                    rightMargin: 20
                    top: chart.top
                    topMargin: 16
                }

                Image {
                    id: imgSnapshot

                    anchors.fill: parent
                    anchors.margins: 5
                    antialiasing: true
                    fillMode: Image.PreserveAspectFit
                    smooth: true
                    source: "qrc:/lm/gauge/core/assets/graphs/snapshot.png"
                    sourceSize: Qt.size(width * 2, height * 2)
                }

                MouseArea {
                    id: maSnapshot

                    anchors.fill: parent
                    hoverEnabled: true

                    onClicked: {
                        lmplPrinter.homescreenSnapName = "/BoltsProfile_" + Qt.formatDateTime(new Date(), "d_M_yy_hh_mm_ss");
                        console.log(lmplPrinter.homescreenSavePath);
                        chart.grabToImage(function (result) {
                                result.saveToFile(lmplPrinter.homescreenSavePath + lmplPrinter.homescreenSnapName + ".png");
                            });
                        cstmIPSnap.open();
                    }
                    onEntered: {
                        rectSnapshot.color = Style.mouseHoverColor;
                    }
                    onExited: {
                        rectSnapshot.color = Style.transparentColor;
                    }
                }
            }
        }

//        InformationPopup {
//            id: cstmIPSnap

//            anchors.centerIn: parent
//            infoTxt: qsTr("Snapshot Captured !")
//        }
    }


}
