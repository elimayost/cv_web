
pdf: deactivate_menu generate_pdf activate_menu

generate_pdf:
	@-curl -s localhost:8000/skills     | wkhtmltopdf - pdf/skills.pdf
	@-curl -s localhost:8000/employment | wkhtmltopdf - pdf/employment.pdf
	@-curl -s localhost:8000/education  | wkhtmltopdf - pdf/education.pdf
	@-curl -s localhost:8000/interests  | wkhtmltopdf - pdf/interests.pdf
	@-rm -f pdf/elimayost-cv.pdf
	@-gs -dBATCH -dNOPAUSE -q -sDEVICE=pdfwrite -sOutputFile=pdf/elimayost-cv.pdf pdf/skills.pdf pdf/employment.pdf pdf/education.pdf pdf/interests.pdf

deactivate_menu:
	@-sed -i '' 's/.*partials\/menu.*/<!--&-->/' templates/skills.html
	@-sed -i '' 's/.*partials\/menu.*/<!--&-->/' templates/employment.html
	@-sed -i '' 's/.*partials\/menu.*/<!--&-->/' templates/education.html
	@-sed -i '' 's/.*partials\/menu.*/<!--&-->/' templates/interests.html

activate_menu:
	@-sed -i '' 's/.*partials\/menu.*/\t{% include "partials\/menu.html" %}/' templates/skills.html
	@-sed -i '' 's/.*partials\/menu.*/\t{% include "partials\/menu.html" %}/' templates/employment.html
	@-sed -i '' 's/.*partials\/menu.*/\t{% include "partials\/menu.html" %}/' templates/education.html
	@-sed -i '' 's/.*partials\/menu.*/\t{% include "partials\/menu.html" %}/' templates/interests.html

deploy:
	@-sed -i '' "s/href='skills'/href='\/cv_web\/'/" templates/partials/menu.html
	@-sed -i '' "s/href='employment'/href='\/cv_web\/employment.html'/" templates/partials/menu.html
	@-sed -i '' "s/href='education'/href='\/cv_web\/education.html'/" templates/partials/menu.html
	@-sed -i '' "s/href='interests'/href='\/cv_web\/interests.html'/" templates/partials/menu.html
	@-curl -s localhost:8000/skills     > docs/index.html
	@-curl -s localhost:8000/employment > docs/employment.html
	@-curl -s localhost:8000/education  > docs/education.html
	@-curl -s localhost:8000/interests  > docs/interests.html
	@-sed -i '' "s/href='\/cv_web\/'/href='skills'/" templates/partials/menu.html
	@-sed -i '' "s/href='\/cv_web\/employment.html'/href='employment'/" templates/partials/menu.html
	@-sed -i '' "s/href='\/cv_web\/education.html'/href='education'/" templates/partials/menu.html
	@-sed -i '' "s/href='\/cv_web\/interests.html'/href='interests'/" templates/partials/menu.html
