#!/bin/zsh

PROJECT="pdfkeygen"

echo "Creating project: $PROJECT"

mkdir -p $PROJECT

cd $PROJECT || exit 1

# File list
FILES=(
  "main.c"
  "pdf_entropy.c"
  "pdf_entropy.h"
  "ripemd160.c"
  "ripemd160.h"
  "secp256k1.c"
  "secp256k1.h"
  "util.c"
  "util.h"
  "Makefile"
)

# Create files if they do not exist
for f in $FILES; do
  if [[ ! -f "$f" ]]; then
    echo "Creating $f"
    touch "$f"
  else
    echo "Skipping $f (already exists)"
  fi
done

# Populate Makefile template
cat > Makefile << 'EOF'
CC=clang
CFLAGS=-O3 -Wall

OBJS = main.o pdf_entropy.o secp256k1.o ripemd160.o util.o

all: pdfkeygen

pdfkeygen: $(OBJS)
	$(CC) $(CFLAGS) -o pdfkeygen $(OBJS)

clean:
	rm -f *.o pdfkeygen
EOF

# Template for headers
for hdr in pdf_entropy.h ripemd160.h secp256k1.h util.h; do
  cat > $hdr << EOF
#ifndef ${${hdr:r}:u}_H
#define ${${hdr:r}:u}_H

// $hdr — auto-generated placeholder header

#endif
EOF
done

# Main.c placeholder
cat > main.c << 'EOF'
#include <stdio.h>

int main() {
    printf("pdfkeygen project initialized.\n");
    return 0;
}
EOF

# Set permissions
chmod -R u+rw .

echo "Project structure created."
echo "You can now paste implementations into the generated files."

