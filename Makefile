
pdf: deactivate_menu_and_title generate_pdf activate_menu_and_title

generate_pdf:
	@-curl -s localhost:8000/skills     | wkhtmltopdf - pdf/skills.pdf
	@-curl -s localhost:8000/employment | wkhtmltopdf - pdf/employment.pdf
	@-curl -s localhost:8000/education  | wkhtmltopdf - pdf/education.pdf
	@-curl -s localhost:8000/interests  | wkhtmltopdf - pdf/interests.pdf
	@-rm -f pdf/elimayost-cv.pdf
	@-gs -dBATCH -dNOPAUSE -q -sDEVICE=pdfwrite -sOutputFile=pdf/elimayost-cv.pdf pdf/skills.pdf pdf/employment.pdf pdf/education.pdf pdf/interests.pdf

deactivate_menu_and_title:
	@-sed -i '' 's/.*partials\/menu.*/<!--&-->/' src/elimayost_cv/templates/skills.html
	@-sed -i '' 's/.*partials\/menu.*/<!--&-->/' src/elimayost_cv/templates/employment.html
	@-sed -i '' 's/.*partials\/menu.*/<!--&-->/' src/elimayost_cv/templates/education.html
	@-sed -i '' 's/.*partials\/menu.*/<!--&-->/' src/elimayost_cv/templates/interests.html
	@-sed -i '' 's/.*partials\/title.*/<!--&-->/' src/elimayost_cv/templates/skills.html
	@-sed -i '' 's/.*partials\/title.*/<!--&-->/' src/elimayost_cv/templates/employment.html
	@-sed -i '' 's/.*partials\/title.*/<!--&-->/' src/elimayost_cv/templates/education.html
	@-sed -i '' 's/.*partials\/title.*/<!--&-->/' src/elimayost_cv/templates/interests.html

activate_menu_and_title:
	@-sed -i '' 's/.*partials\/menu.*/\t{% include "partials\/menu.html" %}/' src/elimayost_cv/templates/skills.html
	@-sed -i '' 's/.*partials\/menu.*/\t{% include "partials\/menu.html" %}/' src/elimayost_cv/templates/employment.html
	@-sed -i '' 's/.*partials\/menu.*/\t{% include "partials\/menu.html" %}/' src/elimayost_cv/templates/education.html
	@-sed -i '' 's/.*partials\/menu.*/\t{% include "partials\/menu.html" %}/' src/elimayost_cv/templates/interests.html
	@-sed -i '' 's/.*partials\/title.*/\t{% include "partials\/title.html" %}/' src/elimayost_cv/templates/skills.html
	@-sed -i '' 's/.*partials\/title.*/\t{% include "partials\/title.html" %}/' src/elimayost_cv/templates/employment.html
	@-sed -i '' 's/.*partials\/title.*/\t{% include "partials\/title.html" %}/' src/elimayost_cv/templates/education.html
	@-sed -i '' 's/.*partials\/title.*/\t{% include "partials\/title.html" %}/' src/elimayost_cv/templates/interests.html

deploy:
	@-curl -s localhost:8000/skills     > docs/index.html
	@-curl -s localhost:8000/employment > docs/employment.html
	@-curl -s localhost:8000/education  > docs/education.html
	@-curl -s localhost:8000/interests  > docs/interests.html
	@-cp pdf/elimayost-cv.pdf docs/elimayost-cv.pdf
	@-sed -i '' "s/href='\/pdf'/href='elimayost-cv.pdf'/" docs/*.html
	@-echo "elimayost.com" > docs/CNAME
	@-git add .
	@-git commit -m 'backup'
	@-git push
