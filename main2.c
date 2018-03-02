#include <stdio.h>
#include <string.h>
#include <stdlib.h>	
#define	BUFFER_SIZE	(128)

extern int calc_div(int buf1, int buf2);

int check (int x, int k){
    if ((x<0) || (k<=0) ||(k>31)){
        return 0;
    }
    return 1;
}

int main(int argc, char** argv)
{
  int x,k;
  char buf1[BUFFER_SIZE];
  char buf2[BUFFER_SIZE];
  fflush(stdout);

  fgets(buf1, BUFFER_SIZE, stdin);
  x = atoi(buf1);
  fgets(buf2, BUFFER_SIZE, stdin);
  k = atoi(buf2);
  calc_div(x, k);

  return 0;
}
