from flask import Flask, request, jsonify
from flask_cors import CORS
import face_recognition
import uuid
import os

app = Flask(__name__)
CORS(app)  # Allow requests from your Flutter app

@app.route("/verify", methods=["POST"])
def verify():
    # Check files
    if "document" not in request.files or "selfie" not in request.files:
        return jsonify({"error": "Files missing"}), 400

    # Get files
    doc_file = request.files["document"]
    selfie_file = request.files["selfie"]

    # Create unique temporary filenames
    doc_path = f"doc_{uuid.uuid4().hex}.jpg"
    selfie_path = f"selfie_{uuid.uuid4().hex}.jpg"
    doc_file.save(doc_path)
    selfie_file.save(selfie_path)

    try:
        # Load images
        doc_img = face_recognition.load_image_file(doc_path)
        selfie_img = face_recognition.load_image_file(selfie_path)

        # Encode faces
        try:
            doc_encoding = face_recognition.face_encodings(doc_img)[0]
        except IndexError:
            return jsonify({"verified": False, "reason": "No face found in document"})

        try:
            selfie_encoding = face_recognition.face_encodings(selfie_img)[0]
        except IndexError:
            return jsonify({"verified": False, "reason": "No face found in selfie"})

        # Compare faces
        match = face_recognition.compare_faces([doc_encoding], selfie_encoding, tolerance=0.6)[0]

        return jsonify({"verified": match})

    finally:
        # Delete temporary files
        if os.path.exists(doc_path):
            os.remove(doc_path)
        if os.path.exists(selfie_path):
            os.remove(selfie_path)

if __name__ == "__main__":
    # Run server on all network interfaces (so your phone can reach it)
    app.run(host="0.0.0.0", port=5000, debug=True)
