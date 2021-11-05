from pdf2jpg import pdf2jpg
import img2pdf
from PIL import Image, ImageChops
from PyPDF3 import PdfFileReader


maininputpath = ""
file_handles = []


def pdf_to_images(filename, inputpath, outputpath):
    inputpath = inputpath + filename
    pdf2jpg.convert_pdf2jpg(inputpath, outputpath, pages="ALL")


def image_to_pdf(filename, inputpath, base_dir):
    inputpath = inputpath + filename
    with open(inputpath, 'rb') as mainfile:
        pdf_reader = PdfFileReader(mainfile)
        num_pages = pdf_reader.numPages

    inputpath = inputpath + "_dir/%d_" + filename + ".jpg"

    for i in range(num_pages):
        image = Image.open(inputpath % i)
        image = ImageChops.invert(image)
        image = image.save(base_dir + 'temp.jpg')
        number = str(i)
        name = base_dir + "temp" + number + ".pdf"
        with open(name, "wb+") as f1:
            file_handles.append(open(name, "wb+"))
            f2 = open(base_dir + "temp.jpg", 'rb')
            file_handles[-1].write(img2pdf.convert(f2))

    for fh in file_handles:
        fh.close()
    return num_pages
