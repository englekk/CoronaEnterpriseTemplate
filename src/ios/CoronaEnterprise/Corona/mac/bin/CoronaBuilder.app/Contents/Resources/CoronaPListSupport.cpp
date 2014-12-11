// ----------------------------------------------------------------------------
// 
// CoronaPListSupport.cpp
// Copyright (c) 2009 Ansca, Inc. All rights reserved.
// 
// Reviewers:
// 		
// 
// ----------------------------------------------------------------------------

#include "Core/Rtt_Build.h"

#include "Rtt_Lua.h"

#ifndef LUAOPEN_API 
#define LUAOPEN_API 
#endif

// ----------------------------------------------------------------------------

namespace Rtt
{

// ----------------------------------------------------------------------------

static const unsigned char B1[]={
 27, 76,117, 97, 81,  0,  1,  4,  4,  4,  8,  0,  3,  0,  0,  0, 61, 63,  0,  0,
  0,  0,  0,  0,  0,  0,  0,  0,  0,  2,  5, 18,  0,  0,  0,  5,  0,  0,  0, 65,
 64,  0,  0, 28,128,  0,  1,100,  0,  0,  0,133,128,  0,  0,134,192, 64,  1,193,
  0,  1,  0,156,128,  0,  1,202,  0,  0,  0,199, 64,  1,  0,197, 64,  1,  0, 36,
 65,  0,  0,  0,  0,  0,  0,  0,  0,  0,  1,201,  0,  1,131,197, 64,  1,  0,222,
  0,  0,  1, 30,  0,128,  0,  7,  0,  0,  0,  4,  8,  0,  0,  0,114,101,113,117,
105,114,101,  0,  4,  5,  0,  0,  0,106,115,111,110,  0,  4,  3,  0,  0,  0,111,
115,  0,  4,  7,  0,  0,  0,103,101,116,101,110,118,  0,  4, 19,  0,  0,  0, 67,
 79, 82, 79, 78, 65, 95, 66, 85, 73, 76, 68, 95, 68, 69, 66, 85, 71,  0,  4, 19,
  0,  0,  0, 67,111,114,111,110, 97, 80, 76,105,115,116, 83,117,112,112,111,114,
116,  0,  4, 12,  0,  0,  0,109,111,100,105,102,121, 80,108,105,115,116,  0,  2,
  0,  0,  0,  0,  0,  0,  0, 16,  0,  0,  0, 20,  0,  0,  0,  0,  1,  0,  5, 16,
  0,  0,  0, 75,  0, 64,  0,193, 64,  0,  0,  1,129,  0,  0, 92,128,  0,  2,  0,
  0,128,  0, 75,  0, 64,  0,193,192,  0,  0,  1,  1,  1,  0, 92,128,  0,  2,  0,
  0,128,  0, 65,192,  0,  0,128,  0,  0,  0,193,192,  0,  0, 85,192,128,  0, 94,
  0,  0,  1, 30,  0,128,  0,  5,  0,  0,  0,  4,  5,  0,  0,  0,103,115,117, 98,
  0,  4,  2,  0,  0,  0, 92,  0,  4,  3,  0,  0,  0, 92, 92,  0,  4,  2,  0,  0,
  0, 34,  0,  4,  3,  0,  0,  0, 92, 34,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,
  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0, 26,  0,  0,  0,  1,  1,  0,  0,  2,
  1,  0, 29,146,  1,  0,  0, 70,  0, 64,  0,129, 64,  0,  0, 85,128,128,  0,133,
128,  0,  0,134,192, 64,  1,156,128,128,  0,195,  0,128,  1,  5,  1,  1,  0, 65,
 65,  1,  0, 28, 65,  0,  1,  5,129,  0,  0,  6,129, 65,  2, 65,193,  1,  0,128,
  1,  0,  1,193,  1,  2,  0,  0,  2,128,  0, 85,  1,130,  2, 28, 65,  0,  1,  5,
 65,  2,  0,  6,129, 66,  2, 64,  1,  0,  1,129,193,  2,  0, 28,193,128,  1, 87,
  0, 67,  2, 22,192,  6,128,139, 65, 67,  2,  1,130,  3,  0,156,129,128,  1,203,
193, 67,  2,220, 65,  0,  1,196,  1,  0,  0,198,  1,196,  3,  0,  2,  0,  3,220,
193,  0,  1, 64,  1,  0,  4,192,  0,128,  3, 23,  0,195,  1, 22, 64,  5,128,197,
  1,  1,  0,  1, 66,  4,  0, 64,  2,  0,  1,129,130,  4,  0,192,  2,128,  2, 21,
194,  2,  4,220, 65,  0,  1,197,  1,  1,  0,  1,194,  4,  0, 69,  2,  5,  0,128,
  2,  0,  3, 92,130,  0,  1, 21, 66,  2,  4,220, 65,  0,  1, 22,128,  1,128,133,
  1,  1,  0,193, 65,  5,  0,  0,  2,  0,  1, 65,130,  5,  0,128,  2,128,  2,213,
129,130,  3,156, 65,  0,  1,133,129,  0,  0,134,193, 69,  3,192,  1,  0,  1,156,
 65,  0,  1,132,  1,128,  0,154,  1,  0,  0, 22, 64,  2,128,133,  1,  1,  0,193,
  1,  6,  0,  4,  2,  0,  0,  6, 66, 70,  4, 64,  2,128,  1,138, 66,  0,  0,137,
194, 70,141, 28,130,128,  1,213,  1,130,  3,156, 65,  0,  1,134,  1, 71,  0,154,
  1,  0,  0, 22, 64,  0,128,134,  1, 71,  0,201,128,129,142,134,129, 71,  0,154,
  1,  0,  0, 22, 64,  0,128,134,129, 71,  0,201,128,129,143,134,  1, 72,  0,154,
  1,  0,  0, 22, 64,  0,128,134,  1, 72,  0,201,128,129,144,134,129, 72,  0,154,
  1,  0,  0, 22, 64,  0,128,134,129, 72,  0,201,128,129,145,134,  1, 73,  0,154,
  1,  0,  0, 22, 64,  0,128,134,  1, 73,  0,201,128,129,146,134,129,201,  1, 87,
  0, 67,  3, 22,128,  0,128,134,193, 73,  0, 87,  0, 67,  3, 22,  0,  5,128,134,
193, 73,  0, 23,  0, 67,  3, 22,  0,  0,128,129,  1, 10,  0, 25,128,129,148, 22,
  0,  0,128,141, 65, 74,  3, 87,128, 74,  3, 22, 64,  0,128, 23,192, 74,  3, 22,
  0,  1,128,202,  1,128,  0, 12,194, 74,  3,226, 65,128,  0,201,192,  1,147, 22,
  0,  1,128,202,  1,  0,  1,  1,194, 10,  0, 65,  2, 11,  0,226, 65,  0,  1,201,
192,  1,147,129, 65, 11,  0,193, 65, 11,  0,  6,130,203,  1, 23,192, 75,  4, 22,
128,  0,128,201,  0, 76,151,201,128,204,152, 22,192,  8,128,  6,130,203,  1, 87,
  0, 67,  4, 22,128,  0,128,  6,130,203,  1, 23,  0, 76,  4, 22,192,  2,128,  6,
130,203,  1, 23,  0, 76,  4, 22,128,  0,128,  1,194, 12,  0,155, 65,  0,  4, 22,
  0,  0,128,129,  1, 13,  0,  5,130,  0,  0,  6, 66, 77,  4, 65,130, 13,  0, 28,
130,  0,  1,201,  0,  2,151,  6,194, 77,  0, 26, 66,  0,  0, 22,  0,  0,128,  1,
  2, 14,  0, 70, 66,204,  1, 87,  0,195,  4, 22,128,  0,128, 70, 66,204,  1, 23,
128,204,  4, 22,192,  1,128, 70, 66,204,  1, 23,128,204,  4, 22,128,  0,128, 65,
 66, 14,  0,219, 65,128,  4, 22,  0,  0,128,193,  1, 13,  0,201,  0,130,152, 10,
 66,  0,  0, 74, 66,  0,  0, 73,  2,207,157,  9, 66,  2,157, 70, 66, 79,  0, 90,
 66,  0,  0, 22,  0,  0,128, 64,  2,  0,  4, 90,  2,  0,  0, 22,128, 32,128,134,
130,206,  4,154, 66,  0,  0, 22,  0,  0,128,134,130, 78,  4,154,  2,  0,  0, 22,
192, 19,128,198,194, 78,  5, 10,  3,  0,  0,218,  2,  0,  0, 22,192,  3,128, 65,
131, 15,  0, 87,192,130,159, 22, 64,  0,128, 23,192,  2,160, 22, 64,  0,128, 65,
 67, 16,  0, 22,128,  0,128, 23,192,  2,161, 22,  0,  0,128, 65,195, 16,  0,133,
  3, 17,  0,134, 67, 81,  7,192,  3,  0,  6,  0,  4,128,  6,156, 67,128,  1,201,
 64,  3,163,201,  0,195,163, 70,  3, 82,  5, 90,  3,  0,  0, 22,  0,  4,128,131,
  3,  0,  7, 87, 64,131,159, 22, 64,  0,128, 23, 64,  3,160, 22, 64,  0,128,129,
 67, 16,  0, 22,128,  1,128, 23, 64,  3,161, 22, 64,  0,128,129,195, 16,  0, 22,
128,  0,128, 23, 64,  3,158, 22,  0,  0,128,129,131, 15,  0,154,  3,  0,  0, 22,
  0,  0,128,201,128,131,163,201,  0,195,164,134,131, 82,  5,154,  3,  0,  0, 22,
  0,  8,128,202, 67,  1,  0,201, 67,208,159,201, 67, 80,160,201,195, 80,161,201,
131, 79,158,201,  3,211,165,  5, 68, 19,  0, 64,  4,  0,  7, 28,  4,  1,  1, 22,
  0,  5,128, 70,  5,133,  7, 90,  5,  0,  0, 22, 64,  4,128,131,  5,  0, 11,197,
 69, 19,  0,  0,  6,  0,  6,220,  5,  1,  1, 22,192,  0,128, 23, 64,133, 13, 22,
 64,  0,128,130,  5,128,  0, 22, 64,  0,128,225,133,  0,  0, 22, 64,254,127,154,
 69,  0,  0, 22,  0,  1,128,197,  5, 17,  0,198, 69,209, 11,  0,  6,  0,  6, 64,
  6,128, 10,220, 69,128,  1, 33,132,  0,  0, 22,  0,250,127,201,  0,131,164,201,
  0,  3,167,198,194,211,  4,218,  2,  0,  0, 22, 64,  0,128,198,194,211,  4,198,
  2,212,  5,218,  2,  0,  0, 22, 64,  9,128,  6, 67,204,  5, 26,  3,  0,  0, 22,
  0,  0,128,193, 65, 20,  0,  6,131,203,  5, 26,  3,  0,  0, 22,  0,  0,128,129,
 65, 20,  0,  5,131, 20,  0, 64,  3,128,  5, 28,  3,  1,  1, 22,192,  5,128, 65,
196, 20,  0,133,  4, 21,  0,192,  4,  0,  8,156,132,  0,  1, 23,  0, 81,  9, 22,
 64,  1,128,132,  4,  0,  0,134, 68, 70,  9,192,  4,  0,  8,156,132,  0,  1, 64,
  4,  0,  9, 22,192,  0,128,133,  4,  5,  0,192,  4,  0,  8,156,132,  0,  1, 64,
  4,  0,  9,133,  4,  1,  0,193, 68, 21,  0,  0,  5,128,  7, 65,133,  4,  0,128,
  5,128,  8,213,132,133,  9,156, 68,  0,  1,201,  0,132,  7, 33,131,  0,  0, 22,
 64,249,127,132,  2,128,  0,154,  2,  0,  0, 22, 64,  2,128,133,  2,  1,  0,193,
130, 21,  0,  4,  3,  0,  0,  6, 67, 70,  6, 64,  3,128,  1,138, 67,  0,  0,137,
195, 70,141, 28,131,128,  1,213,  2,131,  5,156, 66,  0,  1,133, 66,  2,  0,134,
130, 66,  5,192,  2,  0,  1,  1,195, 21,  0,156,194,128,  1, 87,  0, 67,  5, 22,
192,  4,128, 11,  3, 86,  5,132,  3,  0,  0,134, 67, 70,  7,192,  3,128,  1, 10,
 68,  0,  0,  9,196, 70,141,156,  3,128,  1, 28, 67,  0,  0, 11,195, 67,  5, 28,
 67,  0,  1,  5,131,  0,  0,  6,131, 65,  6, 65, 67, 22,  0,128,  3,128,  0,193,
131, 22,  0,  0,  4,  0,  1, 65,196, 22,  0, 85, 67,132,  6, 28, 67,  0,  1, 22,
128,  1,128,  5,  3,  1,  0, 65,  3, 23,  0,128,  3,  0,  1,193,131,  5,  0,  0,
  4,128,  5, 85,  3,132,  6, 28, 67,  0,  1,  5,131,  0,  0,  6,195, 69,  6, 64,
  3,  0,  1, 28, 67,  0,  1,  1, 67, 23,  0, 69,  3,  5,  0,133,131, 23,  0,134,
195, 87,  7,198,131,203,  1,156,  3,  0,  1, 92,131,  0,  0,129,  3, 24,  0, 21,
131,  3,  6, 69,  3,  1,  0,129, 67, 24,  0, 92, 67,  0,  1, 69,  3,  1,  0,129,
131, 24,  0,197,131, 23,  0,198,195,216,  7,  0,  4,  0,  6, 69,  4,  5,  0,134,
 68,204,  1, 92,  4,  0,  1,220,131,  0,  0,  1,  4, 25,  0, 64,  4,128,  3,129,
 68, 25,  0,149,131,  4,  7, 92, 67,  0,  1, 69,  3,  1,  0,129,131, 25,  0,197,
  3,  5,  0,  6,132,203,  1,220,131,  0,  1,  1,196, 25,  0, 64,  4,  0,  3,129,
 68, 25,  0,149,131,  4,  7, 92, 67,  0,  1, 30,  0,128,  0,104,  0,  0,  0,  4,
 14,  0,  0,  0, 97,112,112, 66,117,110,100,108,101, 70,105,108,101,  0,  4, 12,
  0,  0,  0, 47, 73,110,102,111, 46,112,108,105,115,116,  0,  4,  3,  0,  0,  0,
111,115,  0,  4,  8,  0,  0,  0,116,109,112,110, 97,109,101,  0,  4,  6,  0,  0,
  0,112,114,105,110,116,  0,  4, 23,  0,  0,  0, 67,114,101, 97,116,105,110,103,
 32, 73,110,102,111, 46,112,108,105,115,116, 46, 46, 46,  0,  4,  8,  0,  0,  0,
101,120,101, 99,117,116,101,  0,  4, 26,  0,  0,  0,112,108,117,116,105,108, 32,
 45, 99,111,110,118,101,114,116, 32,106,115,111,110, 32, 45,111, 32, 39,  0,  4,
  3,  0,  0,  0, 39, 32,  0,  4,  3,  0,  0,  0,105,111,  0,  4,  5,  0,  0,  0,
111,112,101,110,  0,  4,  2,  0,  0,  0,114,  0,  0,  4,  5,  0,  0,  0,114,101,
 97,100,  0,  4,  3,  0,  0,  0, 42, 97,  0,  4,  6,  0,  0,  0, 99,108,111,115,
101,  0,  4,  7,  0,  0,  0,100,101, 99,111,100,101,  0,  4, 23,  0,  0,  0, 69,
114,114,111,114, 58, 32,102, 97,105,108,101,100, 32,116,111, 32,108,111, 97,100,
 32,  0,  4,  3,  0,  0,  0, 58, 32,  0,  4,  7,  0,  0,  0, 74, 83, 79, 78, 58,
 32,  0,  4,  9,  0,  0,  0,116,111,115,116,114,105,110,103,  0,  4, 47,  0,  0,
  0, 69,114,114,111,114, 58, 32,102, 97,105,108,101,100, 32,116,111, 32,111,112,
101,110, 32,109,111,100,105,102,121, 80,108,105,115,116, 32,105,110,112,117,116,
 32,102,105,108,101, 32, 39,  0,  4,  4,  0,  0,  0, 39, 58, 32,  0,  4,  7,  0,
  0,  0,114,101,109,111,118,101,  0,  4, 18,  0,  0,  0, 66, 97,115,101, 32, 73,
110,102,111, 46,112,108,105,115,116, 58, 32,  0,  4,  7,  0,  0,  0,101,110, 99,
111,100,101,  0,  4,  7,  0,  0,  0,105,110,100,101,110,116,  0,  1,  1,  4, 18,
  0,  0,  0, 98,117,110,100,108,101,100,105,115,112,108, 97,121,110, 97,109,101,
  0,  4, 20,  0,  0,  0, 67, 70, 66,117,110,100,108,101, 68,105,115,112,108, 97,
121, 78, 97,109,101,  0,  4, 17,  0,  0,  0, 98,117,110,100,108,101,101,120,101,
 99,117,116, 97, 98,108,101,  0,  4, 19,  0,  0,  0, 67, 70, 66,117,110,100,108,
101, 69,120,101, 99,117,116, 97, 98,108,101,  0,  4,  9,  0,  0,  0, 98,117,110,
100,108,101,105,100,  0,  4, 19,  0,  0,  0, 67, 70, 66,117,110,100,108,101, 73,
100,101,110,116,105,102,105,101,114,  0,  4, 11,  0,  0,  0, 98,117,110,100,108,
101,110, 97,109,101,  0,  4, 13,  0,  0,  0, 67, 70, 66,117,110,100,108,101, 78,
 97,109,101,  0,  4, 16,  0,  0,  0, 99,111,114,111,110, 97, 95, 98,117,105,108,
100, 95,105,100,  0,  4, 15,  0,  0,  0, 67,111,114,111,110, 97, 83, 68, 75, 66,
117,105,108,100,  0,  4, 15,  0,  0,  0, 85, 73, 68,101,118,105, 99,101, 70, 97,
109,105,108,121,  0,  4, 13,  0,  0,  0,116, 97,114,103,101,116, 68,101,118,105,
 99,101,  0,  3,  0,  0,  0,  0,  0,192, 95, 64,  3,  0,  0,  0,  0,  0,  0, 96,
 64,  3,  0,  0,  0,  0,  0,  0,  0,  0,  3,  0,  0,  0,  0,  0,  0,240, 63,  3,
  0,  0,  0,  0,  0,  0,  0, 64,  4,  8,  0,  0,  0,110,111,116, 32,115,101,116,
  0,  4, 16,  0,  0,  0, 67, 70, 66,117,110,100,108,101, 86,101,114,115,105,111,
110,  0,  4, 26,  0,  0,  0, 64, 84, 69, 77, 80, 76, 65, 84, 69, 95, 66, 85, 78,
 68, 76, 69, 95, 86, 69, 82, 83, 73, 79, 78, 64,  0,  4, 17,  0,  0,  0, 64, 66,
 85, 78, 68, 76, 69, 95, 86, 69, 82, 83, 73, 79, 78, 64,  0,  4, 27,  0,  0,  0,
 67, 70, 66,117,110,100,108,101, 83,104,111,114,116, 86,101,114,115,105,111,110,
 83,116,114,105,110,103,  0,  4, 30,  0,  0,  0, 64, 66, 85, 78, 68, 76, 69, 95,
 83, 72, 79, 82, 84, 95, 86, 69, 82, 83, 73, 79, 78, 95, 83, 84, 82, 73, 78, 71,
 64,  0,  4, 17,  0,  0,  0,115,101,116, 32, 98,121, 32, 83,105,109,117,108, 97,
116,111,114,  0,  4, 18,  0,  0,  0,115,101,116, 32, 98,121, 32, 73,110,102,111,
 46,112,108,105,115,116,  0,  4,  5,  0,  0,  0,100, 97,116,101,  0,  4, 13,  0,
  0,  0, 37, 89, 46, 37,109, 46, 37,100, 37, 72, 37, 77,  0,  4, 14,  0,  0,  0,
 98,117,110,100,108,101,118,101,114,115,105,111,110,  0,  4,  6,  0,  0,  0, 49,
 46, 48, 46, 48,  0,  4, 20,  0,  0,  0,115,101,116, 32,105,110, 32, 66,117,105,
108,100, 32,100,105, 97,108,111,103,  0,  4, 12,  0,  0,  0,111,114,105,101,110,
116, 97,116,105,111,110,  0,  4,  8,  0,  0,  0,100,101,102, 97,117,108,116,  0,
  4,  9,  0,  0,  0,112,111,114,116,114, 97,105,116,  0,  4,  9,  0,  0,  0,115,
101,116,116,105,110,103,115,  0,  4, 31,  0,  0,  0, 85, 73, 73,110,116,101,114,
102, 97, 99,101, 79,114,105,101,110,116, 97,116,105,111,110, 80,111,114,116,114,
 97,105,116,  0,  4, 10,  0,  0,  0,108, 97,110,100,115, 99, 97,112,101,  0,  4,
 15,  0,  0,  0,108, 97,110,100,115, 99, 97,112,101, 82,105,103,104,116,  0,  4,
 37,  0,  0,  0, 85, 73, 73,110,116,101,114,102, 97, 99,101, 79,114,105,101,110,
116, 97,116,105,111,110, 76, 97,110,100,115, 99, 97,112,101, 82,105,103,104,116,
  0,  4, 14,  0,  0,  0,108, 97,110,100,115, 99, 97,112,101, 76,101,102,116,  0,
  4, 36,  0,  0,  0, 85, 73, 73,110,116,101,114,102, 97, 99,101, 79,114,105,101,
110,116, 97,116,105,111,110, 76, 97,110,100,115, 99, 97,112,101, 76,101,102,116,
  0,  4,  6,  0,  0,  0,116, 97, 98,108,101,  0,  4,  7,  0,  0,  0,105,110,115,
101,114,116,  0,  4, 23,  0,  0,  0, 85, 73, 73,110,116,101,114,102, 97, 99,101,
 79,114,105,101,110,116, 97,116,105,111,110,  0,  4, 19,  0,  0,  0, 67,111,110,
116,101,110,116, 79,114,105,101,110,116, 97,116,105,111,110,  0,  4,  8,  0,  0,
  0, 99,111,110,116,101,110,116,  0,  4, 41,  0,  0,  0, 67,111,114,111,110, 97,
 86,105,101,119, 83,117,112,112,111,114,116,101,100, 73,110,116,101,114,102, 97,
 99,101, 79,114,105,101,110,116, 97,116,105,111,110,115,  0,  4, 10,  0,  0,  0,
115,117,112,112,111,114,116,101,100,  0,  4, 19,  0,  0,  0,112,111,114,116,114,
 97,105,116, 85,112,115,105,100,101, 68,111,119,110,  0,  4, 41,  0,  0,  0, 85,
 73, 73,110,116,101,114,102, 97, 99,101, 79,114,105,101,110,116, 97,116,105,111,
110, 80,111,114,116,114, 97,105,116, 85,112,115,105,100,101, 68,111,119,110,  0,
  4,  7,  0,  0,  0,105,112, 97,105,114,115,  0,  4, 33,  0,  0,  0, 85, 73, 83,
117,112,112,111,114,116,101,100, 73,110,116,101,114,102, 97, 99,101, 79,114,105,
101,110,116, 97,116,105,111,110,115,  0,  4,  7,  0,  0,  0,105,112,104,111,110,
101,  0,  4,  6,  0,  0,  0,112,108,105,115,116,  0,  4, 22,  0,  0,  0,115,101,
116, 32,105,110, 32, 98,117,105,108,100, 46,115,101,116,116,105,110,103,115,  0,
  4,  6,  0,  0,  0,112, 97,105,114,115,  0,  4,  1,  0,  0,  0,  0,  4,  5,  0,
  0,  0,116,121,112,101,  0,  4, 32,  0,  0,  0, 32, 32, 32, 32, 97,100,100,105,
110,103, 32,101,120,116,114, 97, 32,112,108,105,115,116, 32,115,101,116,116,105,
110,103, 32,  0,  4, 19,  0,  0,  0, 70,105,110, 97,108, 32, 73,110,102,111, 46,
112,108,105,115,116, 58, 32,  0,  4,  2,  0,  0,  0,119,  0,  4,  6,  0,  0,  0,
119,114,105,116,101,  0,  4, 25,  0,  0,  0,112,108,117,116,105,108, 32, 45, 99,
111,110,118,101,114,116, 32,120,109,108, 49, 32, 45,111, 32,  0,  4,  3,  0,  0,
  0, 32, 39,  0,  4,  2,  0,  0,  0, 39,  0,  4, 42,  0,  0,  0,109,111,100,105,
102,121, 80,108,105,115,116, 58, 32,102, 97,105,108,101,100, 32,116,111, 32,111,
112,101,110, 32,111,117,116,112,117,116, 32,102,105,108,101, 32, 39,  0,  4,  3,
  0,  0,  0, 37, 45,  0,  4,  7,  0,  0,  0,115,116,114,105,110,103,  0,  4,  4,
  0,  0,  0,108,101,110,  0,  4,  2,  0,  0,  0,115,  0,  4, 33,  0,  0,  0, 65,
112,112,108,105, 99, 97,116,105,111,110, 32,118,101,114,115,105,111,110, 32,105,
110,102,111,114,109, 97,116,105,111,110, 58,  0,  4, 14,  0,  0,  0, 32, 32, 32,
 32, 86,101,114,115,105,111,110, 58, 32,  0,  4,  7,  0,  0,  0,102,111,114,109,
 97,116,  0,  4, 32,  0,  0,  0, 32, 91, 67, 70, 66,117,110,100,108,101, 83,104,
111,114,116, 86,101,114,115,105,111,110, 83,116,114,105,110,103, 93, 32, 40,  0,
  4,  2,  0,  0,  0, 41,  0,  4, 14,  0,  0,  0, 32, 32, 32, 32, 32, 32, 66,117,
105,108,100, 58, 32,  0,  4, 21,  0,  0,  0, 32, 91, 67, 70, 66,117,110,100,108,
101, 86,101,114,115,105,111,110, 93, 32, 40,  0,  0,  0,  0,  0,  0,  0,  0,  0,
  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,

};

LUAOPEN_API int
luaload_CoronaPListSupport(lua_State *L)
{
	return luaL_loadbuffer(L,(const char*)B1,sizeof(B1),"CoronaPListSupport");
}

// ----------------------------------------------------------------------------

} // namespace Rtt

// ----------------------------------------------------------------------------