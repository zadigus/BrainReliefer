import QtQuick 2.5

Item
{
    id: mainMenu
    anchors.fill: parent

    property var menus:
    [
        "New Intrants",
        "Incubated Intrants",
        "References",
        "Projects",
        "Next Actions",
        "Agenda"
    ]

    signal handle(string name)

    Component.onCompleted:
    {
        setOptimalFontSize()

        var y = 0
        for(var i = 0; i < mainMenu.menus.length; ++i)
        {
            var component = Qt.createComponent("MenuItem.qml")
            var rect = component.createObject(mainMenu, {"width": getMediator().getWidth(), "height": getMediator().getHeight() / mainMenu.menus.length})
            rect.menuText = menus[i]
            rect.menuFont = menuFontMetrics.font
            rect.menuX = (rect.width - menuFontMetrics.boundingRect(rect.menuText).width) / 2
            rect.menuY = (rect.height - menuFontMetrics.boundingRect(rect.menuText).height) / 2
            rect.y = y
            y += rect.height
        }
    }

    FontMetrics
    {
        id: menuFontMetrics
        font.family: "Arial"
    }

    function switchTo(name)
    {
        handle(name)
    }

    function getBiggestStringId()
    {
        var idx = 0
        var maxLength = 0
        for(var i = 0; i < mainMenu.menus.length; ++i)
        {
            if(mainMenu.menus[i].length > maxLength)
            {
                idx = i
                maxLength = mainMenu.menus[i].length
            }
        }
        return idx
    }

    function setOptimalFontSize()
    {
        var pixelSize = fixedPoint(mainMenu.menus[getBiggestStringId()])
        menuFontMetrics.font.pixelSize = pixelSize
    }

    function textWidth(pixelSize, text)
    {
        menuFontMetrics.font.pixelSize = pixelSize
        return menuFontMetrics.tightBoundingRect(text).width
    }

    function fixedPointFunction(pixelSize, text)
    {
//        console.log("pixel size = " + pixelSize + " text width = " + textWidth(pixelSize, text) + " rect width = " + getMediator().getWidth())
        return pixelSize - 0.001 * (textWidth(pixelSize, text) - (getMediator().getOffsetWidth()))
    }

    function fixedPoint(text)
    {
        var pixelSize = 0
        var newPixelSize = getMediator().getOffsetWidth()
        do
        {
//            console.log(Math.abs(pixelSize - newPixelSize))
            pixelSize = newPixelSize
            newPixelSize = fixedPointFunction(pixelSize, text)
        } while(textWidth(newPixelSize, text) > getMediator().getOffsetWidth())

        return newPixelSize
    }

    function getMediator()
    {
        return mainMenu.parent
    }
}
