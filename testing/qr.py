import segno

if __name__ == "__main__":
     qrcode = segno.make_qr("Hello, World!")
     qrcode.save("hello_world.png")
