#include <time.h>
#include <stdbool.h>

#define uint unsigned int

uint getrand(uint min, uint max) {
	static bool initialized = false;
	if (!initialized) {
		srand((unsigned int)time(NULL));
		initialized = true;
	}
	if (max == min)
		return min;
	return (((uint)rand() << 16) + (uint)rand()) % (max - min) + min;
}