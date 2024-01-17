#pragma once

#if defined(_MSC_VER)
#pragma warning(push)
#pragma warning(disable : 4251)
#endif

#if defined(_MSC_VER)
#ifdef SAMPLE_LIB
#define SAMPLE_API __declspec(dllexport)
#else
#define SAMPLE_API __declspec(dllimport)
#endif
#elif defined(__GNUC__)
#ifdef SAMPLE_LIB
#define SAMPLE_API __attribute__((visibility("default")))
#else
#define SAMPLE_API
#endif
#endif

#define UNUSED(x) (void)(x)