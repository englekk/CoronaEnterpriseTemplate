// ----------------------------------------------------------------------------
// 
// CoronaLuaIOS.h
// Copyright (c) 2013 Corona Labs Inc. All rights reserved.
// 
// ----------------------------------------------------------------------------

#ifndef _CoronaLuaIOS_H__
#define _CoronaLuaIOS_H__

#include "CoronaMacros.h"

struct lua_State;

@class NSDictionary;

// ----------------------------------------------------------------------------

CORONA_API NSDictionary *CoronaLuaCreateDictionary( lua_State *L, int index );

CORONA_API int CoronaLuaPushImage( lua_State *L, UIImage *image );

CORONA_API int CoronaLuaPushValue( lua_State *L, id value);

// ----------------------------------------------------------------------------

#endif // _CoronaLuaIOS_H__
