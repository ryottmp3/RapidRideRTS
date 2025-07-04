# theme_manager.py
# Handles loading and saving the selected theme persistently within the app directory.
# Provides simple accessors for the currently selected theme.

import json
from pathlib import Path

class ThemeManager:
    THEMES = ["Light", "Solarized Light", "Dark", "Solarized Dark", "OLED", "Nord Dark", "Monokai"]
    DEFAULT_THEME = "OLED"

    def __init__(self):
        self.config_dir = Path(__file__).resolve().parent / "config"
        self.config_dir.mkdir(exist_ok=True)
        self.config_path = self.config_dir / "theme.json"
        self.colors_path = self.config_dir / "colors.json"
        self._theme = self._load_theme()
        self._colors = self._load_colors()

    def _load_theme(self):
        if self.config_path.exists():
            try:
                with open(self.config_path, "r") as f:
                    data = json.load(f)
                    theme = data.get("theme")
                    if theme in self.THEMES:
                        return theme
            except Exception as e:
                print(f"Error reading theme config: {e}")
        return self.DEFAULT_THEME

    def _load_colors(self):
        try:
            with open(self.colors_path, "r") as f:
                return json.load(f)
        except Exception as e:
            print(f"[ThemeManager] Failed to load colors.json: {e}")
            return {}

    def save_theme(self, theme):
        try:
            with open(self.config_path, "w") as f:
                json.dump({"theme": theme}, f)
        except Exception as e:
            print(f"Error saving theme: {e}")

    def set_theme(self, theme):
        if theme in self.THEMES:
            self._theme = theme
            self.save_theme(theme)

    def get_theme(self):
        return self._theme

    def get_theme_data(self):
        try:
            with open(self.colors_path, "r") as f:
                themes = json.load(f)
                return themes.get(self._theme, {})
        except Exception as e:
            print(f"Error loading theme data: {e}")
            return {}


    def get_color(self, key):
        return self._colors.get(self._theme, {}).get(key, "#ff00ff")  # Magenta fallback

    def available_themes(self):
        return list(self._colors.keys())

