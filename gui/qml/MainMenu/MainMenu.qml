import QtQuick 2.5

import "/js/Global.js" as Global
import "../BaseMenu"

Menu
{
    id: mainMenu

    menus: [
                {text: qsTr("New Intrants"),          link: "newIntrants"},
                {text: qsTr("Incubated Intrants"),    link: "incubation.browse"},
                {text: qsTr("References"),            link: "references.browse"},
                {text: qsTr("Projects"),              link: "projects.browse"},
                {text: qsTr("Next Actions"),          link: "nextActions.browse"},
                {text: qsTr("Agenda"),                link: "agenda"}
            ]

    menuFontMetrics: myMenuFontMetrics

    MenuFontMetrics
    {
        id: myMenuFontMetrics
        myMenu: mainMenu
    }

    Component.onCompleted:
    {
        windowFooter.activateBackArrow(Global.history.length >= 2)
        windowFooter.activateHome(false)
        windowHeader.text = qsTr("Home")

        Global.menuHeight = mediator.height / mainMenu.menus.length

        buildMenu(Global.menuHeight)

        dataManager.load(appConfiguration.dataDir)
    }
}
