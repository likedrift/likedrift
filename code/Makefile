main:main.o add.o sub.o mul.o div.o
	gcc main.o add.o sub.o mul.o div.o -o main
main.o:main.c
	gcc -c main.c -o main.o
add.o:add.c
	gcc -c add.c -o add.o
sub.o:sub.c
	gcc -c sub.c -o sub.o
mul.o:mul.c
	gcc -c mul.c -o mul.o
div.o:div.c
	gcc -c div.c -o div.o
.PHONY:clean rebuild
rebuild:clean main
clean:
	rm -f main.o add.o sub.o mul.o div.o main
