.PHONY: book
book:
	./surroundings.sh
	emacs --batch --eval "(progn (load \"~/giovanni-diary/giovanni-diary.el\") (giovanni-diary-export-latex))"
	./surroundings-patch.sh
