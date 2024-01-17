#include <fmt/format.h>
#include <sample_lib/sample.h>

int main(int argc, char* argv[]) {
  if (argc != 2) {
    fmt::print("Usage: {} <path>\n", argv[0]);
    return -1;
  }

  auto files = sample_lib::FindFiles(argv[1]);
  fmt::print("Found {} files:\n", files.size());
  for (auto file : files) {
    fmt::print("{}\n", file);
  }
  return 0;
}
