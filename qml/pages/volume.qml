/*
  Copyright (C) 2013 Jolla Ltd.
  Contact: Thomas Perl <thomas.perl@jollamobile.com>
  All rights reserved.

  You may use this file under the terms of BSD license as follows:

  Redistribution and use in source and binary forms, with or without
  modification, are permitted provided that the following conditions are met:
    * Redistributions of source code must retain the above copyright
      notice, this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above copyright
      notice, this list of conditions and the following disclaimer in the
      documentation and/or other materials provided with the distribution.
    * Neither the name of the Jolla Ltd nor the
      names of its contributors may be used to endorse or promote products
      derived from this software without specific prior written permission.

  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
  ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
  WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
  DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDERS OR CONTRIBUTORS BE LIABLE FOR
  ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
  (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
  LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
  ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/

import QtQuick 2.0
import Sailfish.Silica 1.0

Page {
    id: page
    property string resulttext;

    onStatusChanged: {
        if (status == PageStatus.Active) {
//            if (pageStack._currentContainer.attachedContainer == null) {
//                pageStack.pushAttached(Qt.resolvedUrl("FirstPage.qml"))
//            }
            calcABV()
        }
    }

    function calcABV()
    {

        var vol2=liquid2Volume.text*1;
        var vol1=liquid1Volume.text*1;
        var abv1=liquid1Slider.value;
        var abv2=liquid2Slider.value;
        var result=0;

        if(vol2==0)
        {
            result=abv1;
        }
        else{
            result=Math.round((((vol1*abv1/100)+(vol2*abv2/100))/(vol1+vol2)*100)*10)/10;
        }
        resultLabel.text=qsTr("Dilution")+": "+"\n"+result+qsTr(" % abv");
        app.result="<html><center><p>"+qsTr("Dilution")+": "+"</p><p>"+result+qsTr(" % abv")+"</p></center></html>";
    }

    SilicaFlickable {
        anchors.fill: parent

        PullDownMenu {
            MenuItem {
                text: qsTr("about SailBottle")
                onClicked: pageStack.push(Qt.resolvedUrl("about.qml"))
            }
        }

        // Tell SilicaFlickable the height of its content.
        contentHeight: column.height

        Column {
            id: column

            width: page.width
            spacing: Theme.paddingLarge
            PageHeader {
                title: qsTr("calculate abv in dilution")
            }
            Row{
                x: Theme.paddingSmall
                spacing: Theme.paddingLarge
                height: liquid1Label.height
                Image
                {
                    source: Qt.resolvedUrl("../bottle-small.png")
                    scale: 0.4
                    anchors.horizontalCenter: parent.AlignRight
                    anchors.verticalCenter: parent.verticalCenter
                }
                Label {
                    id: liquid1Label
                    x: Theme.paddingLarge
                    text: qsTr("Liquor")
                    color: Theme.secondaryHighlightColor

                }
            }

            Slider{
                id: liquid1Slider
                x: Theme.paddingLarge
                value: 46
                label: sliderValue +" "+ qsTr(" % abv")
                handleVisible: true
                width: parent.width-2*Theme.paddingLarge
                maximumValue:100
                minimumValue : 0
                stepSize:0.1
                onSliderValueChanged: sliderValue + qsTr("% abv")
                onValueChanged: {
                    liquid1Slider._updateValueToDraggable()
                    calcABV();
                }
            }
            TextField {
                id: liquid1Volume
                placeholderText: qsTr("enter liquor volume in ml")
                label: qsTr(" ml")+" "+qsTr("Liquor")
                text:"20"
                validator: RegExpValidator { regExp: /^[]0-9]*\.?\,?[0-9]{0,1}$/ }
                EnterKey.iconSource: "image://theme/icon-m-enter-close"
                EnterKey.onClicked: focus = false
                color: errorHighlight? "red" : Theme.primaryColor
                inputMethodHints: Qt.ImhFormattedNumbersOnly
                width: parent.width-2*Theme.paddingLarge
                x: Theme.paddingLarge
                onTextChanged: calcABV()
            }
            Row{
                x: Theme.paddingSmall
                spacing: Theme.paddingLarge
                height: liquid2Label.height
                Image
                {
                    source: Qt.resolvedUrl("../drop-small.png")
                    scale: 0.4
                    anchors.horizontalCenter: parent.AlignRight
                    anchors.verticalCenter: parent.verticalCenter
                }
                Label {
                    id: liquid2Label
                    x: Theme.paddingLarge
                    text: qsTr("Solvent")
                    color: Theme.secondaryHighlightColor
                }

            }
            Slider{
                id: liquid2Slider
                x: Theme.paddingLarge
                value: 0
                label: sliderValue +" "+ qsTr("% abv")
                handleVisible: true
                width: parent.width-2*Theme.paddingLarge
                maximumValue:100
                minimumValue : 0
                stepSize:0.1
                onSliderValueChanged: sliderValue + qsTr("% abv")
                onValueChanged: {
                    liquid2Slider._updateValueToDraggable()
                    calcABV();
                }
            }
            TextField {
                id: liquid2Volume
                placeholderText: qsTr("enter solvent volume in ml")
                label: qsTr(" ml")+" "+qsTr("Solvent")
                text:"0"
                validator: RegExpValidator { regExp: /^[]0-9]*\.?\,?[0-9]{0,1}$/ }
                EnterKey.iconSource: "image://theme/icon-m-enter-close"
                EnterKey.onClicked: focus = false
                color: errorHighlight? "red" : Theme.primaryColor
                inputMethodHints: Qt.ImhFormattedNumbersOnly
                width: parent.width-2*Theme.paddingLarge
                x: Theme.paddingLarge
                onTextChanged: calcABV()
            }
            Row{
                x: Theme.paddingSmall
                spacing: Theme.paddingLarge
                height: resultLabel.height
                Image
                {
                    source: Qt.resolvedUrl("../glas-small.png")
                    scale: 0.4
                    anchors.horizontalCenter: parent.AlignRight
                    anchors.verticalCenter: parent.verticalCenter
                }
                Label {
                    id: resultLabel
                    x: Theme.paddingLarge
                    text: qsTr("Dilution")+": "
                    //color: Theme.secondaryHighlightColor

                }
            }
        }
    }
}


