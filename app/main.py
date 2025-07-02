# Main
# Copyright 2025
# MIT License

import sys
from PySide6.QtWidgets import QApplication
from PySide6.QtQml import QQmlApplicationEngine

app = QApplication(sys.argv)
engine = QQmlApplicationEngine()
engine.load("home.qml")

if not engine.rootObjects():
    sys.exit(-1)

sys.exit(app.exec())
