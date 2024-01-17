#include <fmt/format.h>

#include <boost/filesystem.hpp>

namespace fs = boost::filesystem;

std::vector<std::string> FindFiles(const std::string& path) {
  std::vector<std::string> files;

  fs::path full_path(fs::system_complete(path));
  if (!fs::exists(full_path)) {
    fmt::print("{} does not exist\n", full_path.string());
    return files;
  }

  if (fs::is_regular_file(full_path)) {
    fmt::print("{} size is {}\n", full_path.string(), file_size(full_path));
  } else if (fs::is_directory(full_path)) {
    fmt::print("{} is a directory containing:\n", full_path.string());
    fs::directory_iterator end_iter;
    for (fs::directory_iterator dir_itr(full_path); dir_itr != end_iter;
         ++dir_itr) {
      try {
        if (fs::is_directory(dir_itr->status())) {
          continue;
        }
        files.push_back(dir_itr->path().filename().string());
      } catch (const std::exception& ex) {
        fmt::print("{}: {}\n", dir_itr->path().filename().string(), ex.what());
      }
    }
  } else {
    fmt::print("{} exists, but is not a regular file or directory\n",
               full_path.string());
  }
  return files;
}

int main(int argc, char* argv[]) {
  if (argc != 2) {
    fmt::print("Usage: {} <path>\n", argv[0]);
    return -1;
  }

  auto files = FindFiles(argv[1]);
  fmt::print("Found {} files:\n", files.size());
  for (auto file : files) {
    fmt::print("{}\n", file);
  }
  return 0;
}