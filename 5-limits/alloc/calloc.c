#include <stdlib.h>
#include <stdio.h>

int main(void) {
    for (int i = 0;; i++) {
	printf("%d\n",i);
        if (calloc(1024*1024,1) == NULL) break;
    } 
    return EXIT_SUCCESS;
}
