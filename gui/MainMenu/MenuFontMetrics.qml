import QtQuick 2.5

FontMetrics
{
    font.family: "Arial"

    property var myMenu

    function setOptimalFontSize()
    {
        var pixelSize = fixedPoint(myMenu.menus[myMenu.getBiggestStringId()])
        font.pixelSize = pixelSize
    }

    function textWidth(pixelSize, text)
    {
        font.pixelSize = pixelSize
        return tightBoundingRect(text).width
    }

    function fixedPointFunction(pixelSize, text)
    {
    //        console.log("pixel size = " + pixelSize + " text width = " + textWidth(pixelSize, text) + " rect width = " + getMediator().getWidth())
        return pixelSize - 0.001 * (textWidth(pixelSize, text) - (myMenu.getMediator().getOffsetWidth()))
    }

    function fixedPoint(text)
    {
        var pixelSize = 0
        var newPixelSize = myMenu.getMediator().getOffsetWidth()
        do
        {
    //            console.log(Math.abs(pixelSize - newPixelSize))
            pixelSize = newPixelSize
            newPixelSize = fixedPointFunction(pixelSize, text)
        } while(textWidth(newPixelSize, text) > myMenu.getMediator().getOffsetWidth())

        return newPixelSize
    }
}
