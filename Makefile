all: compressed normal buildjs

buildjs: src/
	tsc -b src

normal: css/angry.scss
	sassc css/angry.scss angry.css

compressed: css/angry.scss
	sassc -t compressed css/angry.scss angry.min.css

custom: css/grid.scss
	sassc -t compressed css/angry.scss custom.min.css
