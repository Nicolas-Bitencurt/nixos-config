import QtQuick

// Tela de carregamento (KSplash). O Plasma vai subindo "stage" de 1 a 6
// conforme carrega as partes da sessao; usamos isso pra barra de progresso.
Rectangle {
    id: root
    color: "#14101f"           // fundo escuro, puxando pro roxo do papel de parede
    property int stage

    onStageChanged: {
        if (stage == 1) introAnimation.running = true
    }

    Item {
        id: content
        anchors.fill: parent
        opacity: 0

        Image {
            id: logo
            anchors.centerIn: parent
            anchors.verticalCenterOffset: -40
            source: "logo.svg"
            sourceSize.width: 256
            sourceSize.height: 256
            width: 160
            height: 160
            fillMode: Image.PreserveAspectFit
        }

        Text {
            anchors.top: logo.bottom
            anchors.topMargin: 28
            anchors.horizontalCenter: parent.horizontalCenter
            text: "SUA DISTRO"     // trocar pelo nome quando decidir
            color: "#ffffff"
            font.pointSize: 20
            font.weight: Font.Light
            font.letterSpacing: 4
        }

        // Barra fina de progresso, cresce com o stage.
        Rectangle {
            anchors.bottom: parent.bottom
            anchors.bottomMargin: parent.height * 0.18
            anchors.horizontalCenter: parent.horizontalCenter
            width: 240
            height: 3
            radius: 1.5
            color: "#33ffffff"

            Rectangle {
                width: parent.width * Math.min(root.stage, 6) / 6
                height: parent.height
                radius: 1.5
                color: "#ffffff"
                Behavior on width { NumberAnimation { duration: 250 } }
            }
        }
    }

    OpacityAnimator {
        id: introAnimation
        running: false
        target: content
        from: 0
        to: 1
        duration: 600
        easing.type: Easing.InOutQuad
    }
}
