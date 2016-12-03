all: compressed normal

normal: css/angry.scss
	sassc css/angry.scss angry.css

compressed: css/angry.scss
	sassc -t compressed css/angry.scss angry.min.css
