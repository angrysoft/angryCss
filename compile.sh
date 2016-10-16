#!/bin/sh

sassc -t compressed css/angry.scss angry.min.css
sassc css/angry.scss angry.css
du -hs angry.min.css
du -hs angry.css
