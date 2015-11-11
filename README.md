# pdf_forms

## Overview

User should be able to print the 1099 forms (PDF based) from within VersAccounts. 

To do this, we will take the actual form issued by IRS (https://www.irs.gov/pub/irs-pdf/f1099msc.pdf) and create fillalbe forms called FDF forms. See http://www.adobe.com/devnet/acrobat/fdftoolkit.html. We would use an Adobe software to define fillable regions on the pdf form. Then we can create a FDF file that will be used to populate the form on the PDF Form.  

We will use a library called PDFTk https://www.pdflabs.com/tools/pdftk-server/ from command line in a rails app that will take the PDF forms and then a list of hash values. Write the hash values into a FDF file and then use pdftk to generate a final PDF with all the form values filled in.


## Tasks

Create a generic class that will abstract the task of filling out a PDF form using FDF files. The class will take the name of the PDF (path to local file), and a list of form values in a hash(Key value pair)

You can use the sample forms provied by Adobe http://www.adobe.com/devnet/acrobat/fdftoolkit.html for testing. There are example of fillable forms and the FDF files in the toolkit. The class should have a method that will allow a caller to create a final PDF.  There should be another method to create a PDF that contains many pages of the same PDF document with the form filled in. We can pass an array of hash with each hash used to populate the PDF file once. You create as many pdf files as the length of the array and then use PDFtk to combine the many pdfs into one big PDF. 

Create a simple Rails app that will demonstrate the pdf generation. Build a form that will ask for a PDF file and ask for a input of a hash in text format that can be used to create the FDF file. Call the class and then render the completed PDF.

________________________________________________

Name
Address
Phone Number
Email
Mothers Name
Fathers Name
Occupation
Annual

{ 
	'Name' => 'John Doe',
	'Address' => '12 High Street',
	'Phone Number' => '020 8777 8888',
	'Email' => 'john.doe@gmail.com',
	'Mothers Name' => 'Mary Doe',
	'Fathers Name' => 'Bill Doe',
	'Occupation' => 'Developer',
	'Annual Income' => '$30,000 USD'
}