# This Python file uses the following encoding: utf-8
import sys
from pathlib import Path
from PySide6.QtWidgets import QApplication
from PySide6.QtQml import QQmlApplicationEngine

from PySide6.QtCore import QObject, Signal, Property,Slot

class DataHolder(QObject):
    categoriesChanged = Signal()
    valuesChanged = Signal()

    def __init__(self):
        super().__init__()
        self._categories = [] #initial _categories are set to empty lists
        self._values = []   #initial _values are set to empty lists

    @Property(list, notify=categoriesChanged)
    def categories(self):       #getter method
        return self._categories

    @categories.setter
    def setCategories(self, value):         #setter method
        self._categories = value
        self.categoriesChanged.emit()

    @Property(list, notify=valuesChanged)
    def values(self):               #getter method
        return self._values

    @values.setter
    def setValues(self, value):         #setter method
        self._values = value
        self.valuesChanged.emit()

class Backend(QObject):
    @Slot(str)
    def handleInput(self, boltCount):
        boltCount = int(boltCount)  # Convert the received boltCount to an integer
        print("Received boltCount:", boltCount)

        # Initialize an empty list to store the numbers
        number_list = []

        # Use a for loop to generate the list of numbers
        for i in range(1, boltCount + 1):
            number_list.append(i)

        data_holder.setCategories = number_list

        # Print the list
        print("Number of bolts: ", number_list)

if __name__ == "__main__":
    app = QApplication(sys.argv)
    engine = QQmlApplicationEngine()

    data_holder = DataHolder()
    backend = Backend()
    engine.rootContext().setContextProperty("dataHolder", data_holder)
    engine.rootContext().setContextProperty("backend", backend)

#    new_categories = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15"]
    new_values = [10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 12, 9, 11, 9, 11, 11, 17, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 12, 9, 11, 9, 11, 11, 17, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 12, 9, 11, 9, 11, 11, 17, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 12, 9, 11, 9, 11, 11, 17, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 12, 9, 11, 9, 11, 11, 17, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 12, 9, 11, 9, 11, 11, 17, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 12, 9, 11, 9, 11, 11, 17]
    data_holder.setValues = new_values
#    data_holder.setCategories = new_categories  #Set the context properties through the DataHolder object
#    data_holder.setValues = new_values  #Set the context properties through the DataHolder object

    qml_file = Path(__file__).resolve().parent / "main.qml"
    engine.load(qml_file)
    if not engine.rootObjects():
        sys.exit(-1)

    sys.exit(app.exec())
