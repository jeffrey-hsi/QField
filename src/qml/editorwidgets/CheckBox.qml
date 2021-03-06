import QtQuick 2.0
import QtQuick.Controls 1.2

CheckBox {
  signal valueChanged( var value, bool isNull )

  checked: value === config['CheckedState']

  onCheckedChanged: {
    valueChanged( checked ? config['CheckedState'] : config['UncheckedState'], false )
  }
}

