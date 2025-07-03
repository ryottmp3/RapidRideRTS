# app/network.py
#!/usr/bin/env python3
"""
network.py

I provide a QObject-based NetworkManager for QML.  All HTTP interactions with
the FastAPI backend happen here, and I emit signals to notify QML of results
or errors.  No business logic in QML—everything stays in Python.
"""

import requests
from PySide6.QtCore import QObject, Signal, Slot

class NetworkManager(QObject):
    """
    Handles authentication and ticket operations against the RapidRide server.

    Signals:
      ticketGenerated(str)   — Emitted with the base64 ticket payload on success.
      ticketsFetched(list)   — Emitted with a list of tickets on success.
      errorOccurred(str)     — Emitted with an error message on failure.
    """
    ticketGenerated = Signal(str)
    ticketsFetched  = Signal(list)
    errorOccurred   = Signal(str)

    def __init__(self, base_url: str):
        super().__init__()
        # Base URL of the FastAPI backend
        self.base_url = base_url
        # Storage for the JWT after login or registration
        self._auth_header = None

    @Slot(str, str)
    def setToken(self, token: str, token_type: str):
        """
        Store the JWT and token type ('Bearer') for future requests.
        I prepend the type so headers are formatted correctly.
        """
        self._auth_header = f"{token_type} {token}"

    @Slot(str, str)
    def login(self, username: str, password: str):
        """
        Perform an OAuth2 password grant against /token.
        On success, I store the JWT via setToken().
        On failure, I emit errorOccurred.
        """
        try:
            response = requests.post(
                f"{self.base_url}/token",
                data={"username": username, "password": password},
                headers={"Content-Type": "application/x-www-form-urlencoded"}
            )
            response.raise_for_status()
            data = response.json()
            self.setToken(data["access_token"], data["token_type"])
        except Exception as e:
            self.errorOccurred.emit(f"Login failed: {e}")

    @Slot(str)
    def generateTicket(self, ticket_type: str):
        """
        Request a new ticket from /generate.
        I pass only ticket_type—user is resolved via JWT.
        On success, I emit ticketGenerated(payload).
        """
        if not self._auth_header:
            self.errorOccurred.emit("No auth token available")
            return

        try:
            response = requests.post(
                f"{self.base_url}/generate",
                json={"ticket_type": ticket_type},
                headers={"Authorization": self._auth_header}
            )
            response.raise_for_status()
            payload = response.json().get("payload", "")
            self.ticketGenerated.emit(payload)
        except Exception as e:
            self.errorOccurred.emit(f"Ticket generation failed: {e}")

    @Slot()
    def fetchTickets(self):
        """
        Retrieve the current user's tickets from /wallet.
        On success, I emit ticketsFetched(list_of_dicts).
        """
        if not self._auth_header:
            self.errorOccurred.emit("No auth token available")
            return

        try:
            response = requests.get(
                f"{self.base_url}/wallet",
                headers={"Authorization": self._auth_header}
            )
            response.raise_for_status()
            tickets = response.json()
            self.ticketsFetched.emit(tickets)
        except Exception as e:
            self.errorOccurred.emit(f"Fetch tickets failed: {e}")

