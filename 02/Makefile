LINKER := ld
bin := solver
object := solver.o
source := solver.s

$(object): $(source)
	nasm -felf64 solver.s

$(bin): $(object)
	$(LINKER) $(object) -o $(bin)

all: $(bin)

clean:
	rm -rf $(bin) $(object)
