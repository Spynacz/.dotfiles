import pikepdf

# Open both PDFs
pdf_base = pikepdf.Pdf.open("Cyberpunk RED v1_25.pdf")
pdf_images = pikepdf.Pdf.open("Cyberpunk RED v1_24.pdf")

# Loop through all pages
for page_base, page_images in zip(pdf_base.pages, pdf_images.pages):
    xobjects_base = page_base.Resources.get("/XObject", {})
    xobjects_images = page_images.Resources.get("/XObject", {})

    for name, xobj in xobjects_images.items():
        if "/Subtype" in xobj and xobj["/Subtype"] == "/Image":
            # Copy the image object into the base PDF
            new_xobj = pdf_base.copy_foreign(xobj)
            xobjects_base[name] = new_xobj

# Save the result
pdf_base.save("merged.pdf")

