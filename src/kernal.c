static const int VGA_WIDTH = 80;

void main() {
    // Print an X on line two of the screen
    char* video_memory = (char*) 0xb8000 + VGA_WIDTH * 2;
    *video_memory = 'X';
}