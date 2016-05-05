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

        for(var i = 0; i < mainMenu.menus.length; ++i)
        {
            var component = Qt.createComponent("MenuItem.qml")
            var rect = component.createObject(mainMenu, {"width": getMediator().getWidth(), "height": getMediator().getHeight() / mainMenu.menus.length})
            rect.menuText = menus[i]
            rect.menuFont = menuFontMetrics.font
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

    function itemIndex(item)
    {
        if (item.parent == null)
            return -1
        var siblings = item.parent.children
        for (var i = 0; i < siblings.length; ++i)
            if (siblings[i] == item)
                return i
        return -1 //will never happen
    }

    function previousItem(item)
    {
        if (item.parent == null)
            return null
        var index = itemIndex(item)
        return (index > 0) ? item.parent.children[itemIndex(item) - 1] : null
    }

    function nextItem(item)
    {
        if (item.parent == null)
            return null

        var index = itemIndex(item)
        var siblings = item.parent.children

        return (index < siblings.length - 1) ? siblings[index + 1] : null
    }

    function getMediator()
    {
        return mainMenu.parent
    }
}
