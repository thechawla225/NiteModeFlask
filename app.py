from flask import Flask, render_template, request, send_file
from werkzeug.utils import secure_filename
import os
import DarkModePdf
from PyPDF3 import PdfFileMerger
import shutil
import git

app = Flask(__name__)
uploadsPath = '/home/thechawla225/mysite/uploads/'
app.config['UPLOAD_FOLDER'] = uploadsPath
BASE_DIR = '/home/thechawla225/mysite/'

# Check for working Webhook again and again and again


@app.route('/')
def hello_world():
    return render_template('index.html')


@app.route('/uploader', methods=['GET', 'POST'])
def upload_file():
    if request.method == 'POST':
        f = request.files['file']

        # Save File
        f.save(os.path.join(
            app.config['UPLOAD_FOLDER'], secure_filename(f.filename)))

        # PDF to images
        DarkModePdf.pdf_to_images(f.filename, uploadsPath, uploadsPath)

        # Merge Images to pdf
        num_pages = DarkModePdf.image_to_pdf(
            f.filename, uploadsPath, uploadsPath)

        # merge pdfs:
        merger = PdfFileMerger()
        for i in range(num_pages):
            name = uploadsPath + "temp" + str(i) + ".pdf"
            with open(name, "rb") as file:
                merger.append(file)

        merger.write(BASE_DIR + 'DarkFile.pdf')
        merger.close()

        path_to_file = os.path.join(BASE_DIR, 'DarkFile.pdf')
        shutil.rmtree(uploadsPath)
        if not os.path.exists(uploadsPath):
            os.makedirs(uploadsPath)
        return send_file(path_to_file)


@app.route('/update_server', methods=['POST'])
def webhook():
    if request.method == 'POST':
        repo = git.Repo('https://github.com/thechawla225/NiteModeFlask')
        origin = repo.remotes.origin
        origin.pull()
        return 'Updated PythonAnywhere successfully', 200

    else:
        return 'Wrong event type', 400


if __name__ == '__main__':
    app.run(debug=True)
