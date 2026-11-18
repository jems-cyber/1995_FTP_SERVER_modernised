CC = gcc
CFLAGS = -Wall -Wextra -Iinclude

all: directories bin/actsrv bin/ftpcd symlinks

directories:
	mkdir -p obj bin lib

# Ma biblio encore vide lol
lib/libcomlib.a: obj/comlib.o obj/scklib.o
	ar rcs $@ $^

# Executable du serveur d'actions
bin/actsrv: obj/actsrv.o lib/libcomlib.a
	$(CC) $(CFLAGS) -o $@ $< -Llib -lcomlib

# Executable generique du client
bin/ftpcd: obj/ftp_cmd.o lib/libcomlib.a
	$(CC) $(CFLAGS) -o $@ $< -Llib -lcomlib

symlinks: bin/ftpcd
	ln -sf ftpcd bin/ftpls
	ln -sf ftpcd bin/ftpcat

obj/%.o: src/%.c
	$(CC) $(CFLAGS) -c $< -o $@

clean:
	rm -rf obj/*.o

fclean: clean
	rm -rf bin/* lib/*

re: fclean all

.PHONY: all directories symlinks clean fclean re
