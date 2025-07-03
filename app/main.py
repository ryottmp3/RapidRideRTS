# main.py
# Main entry point for the RapidRide QML application
# Exposes Python backend and page controller to QML

import os
import sys
from PySide6.QtWidgets import QApplication, QMainWindow
from PySide6.QtPdf import QPdfDocument
from PySide6.QtPdfWidgets import QPdfView
from PySide6.QtQml import QQmlApplicationEngine
from PySide6.QtCore import QObject, Slot, QUrl, Property, QCoreApplication
from PySide6.QtGui import QDesktopServices, QGuiApplication, QPalette, QColor
from theme_manager import ThemeManager

# ---- Theme Binding ----

class ThemeController(QObject):
    def __init__(self):
        super().__init__()
        self._theme_manager = ThemeManager()
        self._current_theme = self._theme_manager.get_theme()

    @Slot(str)
    def setTheme(self, name):
        self._theme_manager.set_theme(name)
        self._current_theme = name
        self.applyPalette(name)

    @Property(str)
    def currentTheme(self):
        return self._current_theme

    def applyPalette(self, theme):
        palette = QGuiApplication.palette()
        if theme == "Light":
            palette.setColor(QPalette.Window, QColor("#fdf6e3"))
            palette.setColor(QPalette.WindowText, QColor("#002b36"))
        elif theme == "Solarized Light":
            palette.setColor(QPalette.Window, QColor("#eee8d5"))
            palette.setColor(QPalette.WindowText, QColor("#073642"))
        elif theme == "Dark":
            palette.setColor(QPalette.Window, QColor("#121212"))
            palette.setColor(QPalette.WindowText, QColor("#ffffff"))
        elif theme == "Solarized Dark":
            palette.setColor(QPalette.Window, QColor("#002b36"))
            palette.setColor(QPalette.WindowText, QColor("#839496"))
        elif theme == "OLED":
            palette.setColor(QPalette.Window, QColor("#000000"))
            palette.setColor(QPalette.WindowText, QColor("#ffffff"))

        QGuiApplication.setPalette(palette)


class Controller(QObject):
    """Handles navigation between QML pages using a Loader"""

    def __init__(self, loader):
        super().__init__()
        self.loader = loader

    @Slot(str)
    def loadPage(self, page):
        print(f"[Controller] Switching to page: {page}")
        self.loader.setProperty("source", page)


class AppBackend(QObject):
    """Exposes Python-side functionality like viewing PDFs, ticket management"""

    def __init__(self):
        super().__init__()
        self._windows = []

    @Slot(str)
    def open_pdf_viewer(self, fname):
        """Opens the requested PDF in an external viewer"""
        pdf_path = f"assets/routes/{fname}-map2025.pdf"
        viewer = QPdfView(pdf_path)
        viewer.show()
        self._windows.append(viewer)

    @Slot(str)
    def purchase_ticket(self, ticket_type):
        print(f"[Backend] Requested ticket: {ticket_type}")
        # Future: call HTTP API or show purchase QML screen


if __name__ == "__main__":
    QCoreApplication.setOrganizationName("RapidRide")
    QCoreApplication.setApplicationName("RTS Client")
    app = QApplication(sys.argv)
    engine = QQmlApplicationEngine()

    # Load main QML
    engine.load("main.qml")
    if not engine.rootObjects():
        sys.exit(-1)

    # Grab Loader from QML
    root = engine.rootObjects()[0]
    loader = root.findChild(QObject, "pageLoader")
    if loader is None:
        print("[Error] Loader with objectName 'pageLoader' not found.")
        sys.exit(-1)

    # Create and expose Controller and Backend
    controller = Controller(loader)
    backend = AppBackend()
    engine.rootContext().setContextProperty("controller", controller)
    engine.rootContext().setContextProperty("backend", backend)
    theme_controller = ThemeController()
    theme_controller.applyPalette(theme_controller.currentTheme)

    # Load QML
    engine.rootContext().setContextProperty("ThemeController", theme_controller)

    sys.exit(app.exec())
