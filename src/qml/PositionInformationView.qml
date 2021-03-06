import QtQuick 2.6
import QtQuick.Controls 1.2
import QtPositioning 5.3
import QtQuick.Layouts 1.1
import org.qgis 1.0

Item {
  property PositionSource positionSource
  property CRS crs

  property CoordinateTransform _coordinateTransform: CoordinateTransform {
    sourceCRS: CRS {
      srid: 4326
    }
    destinationCRS: crs
  }
  property point _currentPosition

  width: childrenRect.width + 8 * dp
  height: childrenRect.height + 8 * dp

  GridLayout {
    columns: 2
    x: 4 * dp
    y: 4 * dp

    Text {
      text: qsTr( "Altitude" )
    }
    Text {
      text: positionSource.position.altitudeValid ? positionSource.position.coordinate.altitude.toFixed(3) : qsTr( "N/A" )
    }

    Text {
      text: qsTr( "Accuracy" )
    }
    Text {
      text: positionSource.position.horizontalAccuracyValid ? positionSource.position.horizontalAccuracy.toFixed(3) + " m" : qsTr( "N/A" )
    }

    Text {
      Layout.fillWidth: true
      text: qsTr("Coordinates")
      Layout.columnSpan: 2
    }
    Column{
      Layout.columnSpan: 2
      Text {
        leftPadding: 8 * dp
        text: positionSource.position.latitudeValid ? Number( _currentPosition.x ).toLocaleString( Qt.locale(), 'f', 3 ) : qsTr( "N/A" )
      }
      Text {
        leftPadding: 8 * dp
        text: positionSource.position.longitudeValid ? Number( _currentPosition.y ).toLocaleString( Qt.locale(), 'f', 3 ) : qsTr( "N/A" )
      }
    }
    Text {
      text: qsTr( "Speed" )
    }
    Text {
      text: positionSource.position.speedValid ? positionSource.position.speed.toFixed(3) + " m/s" : qsTr( "N/A" )
    }
  }

  Connections {
    target: positionSource.position
    onCoordinateChanged: _updatePosition()
  }
  onCrsChanged: _updatePosition()

  function _updatePosition() {
    _currentPosition = _coordinateTransform.transform( Qt.point( positionSource.position.coordinate.longitude, positionSource.position.coordinate.latitude ) )
  }
}
