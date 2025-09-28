#include <stdbool.h>

#define uint unsigned int

extern void gcd(uint a, uint b, uint* c);
extern void ext_gcd(uint a, uint b, uint* k, uint* l, uint* c);
extern uint fast_pow(uint x, uint m, uint n);
extern bool judge_prime(uint n);
extern uint generate_prime(uint min, uint max);
extern void generate_key(uint* private_key, uint* public_key, uint* public_modulus);
extern void encrypt(uint public_key, uint public_modulus, char* plaintext, char* ciphertext);
extern void decrypt(uint private_key, uint public_modulus, char* ciphertext, char* plaintext);