/*
 * Copyright (C) 2007 Red Hat, Inc.
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 2.1 of the License, or (at your option) any later version.
 *
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public
 * License along with this library; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307  USA
 *
 * Authors:
 *     Mark McLoughlin <markmc@redhat.com>
 */

#ifndef __VIR_UUID_H__
#define __VIR_UUID_H__

/**
 * VIR_UUID_RAW_LEN:
 * number of bytes used by an UUID in raw form
 */
#define VIR_UUID_RAW_LEN 16

int virUUIDGenerate(unsigned char *uuid);

int virUUIDParse(const char *uuid,
		 unsigned char *rawuuid);

#endif /* __VIR_UUID_H__ */
