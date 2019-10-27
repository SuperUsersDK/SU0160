#include <stdlib.h>
#include <stdio.h>

int main(void) {
    for (int i = 0;; i++) {
	printf("%d\n",i);
        calloc(1024*1024,1);
    } 
    return EXIT_SUCCESS;
}
