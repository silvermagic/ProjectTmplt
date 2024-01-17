#pragma once

#include <string>
#include <vector>

#include "sample_lib/define.h"

namespace sample_lib {

SAMPLE_API std::vector<std::string> FindFiles(const std::string &path);

}