/* -*- c -*-
 * qemu_protocol.x: private protocol for communicating between
 *   remote_internal driver and libvirtd.  This protocol is
 *   internal and may change at any time.
 *
 * Copyright (C) 2010-2012 Red Hat, Inc.
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
 * License along with this library.  If not, see
 * <http://www.gnu.org/licenses/>.
 *
 * Author: Chris Lalancette <clalance@redhat.com>
 */

%#include "internal.h"
%#include "remote_protocol.h"
%#include <arpa/inet.h>

/*----- Protocol. -----*/
struct qemu_monitor_command_args {
    remote_nonnull_domain dom;
    remote_nonnull_string cmd;
    unsigned int flags;
};

struct qemu_monitor_command_ret {
    remote_nonnull_string result;
};


struct qemu_domain_attach_args {
    unsigned int pid_value;
    unsigned int flags;
};

struct qemu_domain_attach_ret {
    remote_nonnull_domain dom;
};

struct qemu_domain_agent_command_args {
    remote_nonnull_domain dom;
    remote_nonnull_string cmd;
    int timeout;
    unsigned int flags;
};

struct qemu_domain_agent_command_ret {
    remote_string result;
};

/* Define the program number, protocol version and procedure numbers here. */
const QEMU_PROGRAM = 0x20008087;
const QEMU_PROTOCOL_VERSION = 1;

enum qemu_procedure {
    /* Each function must be preceded by a comment providing one or
     * more annotations:
     *
     * - @generate: none|client|server|both
     *
     *   Whether to generate the dispatch stubs for the server
     *   and/or client code.
     *
     * - @readstream: paramnumber
     * - @writestream: paramnumber
     *
     *   The @readstream or @writestream annotations let daemon and src/remote
     *   create a stream.  The direction is defined from the src/remote point
     *   of view.  A readstream transfers data from daemon to src/remote.  The
     *   <paramnumber> specifies at which offset the stream parameter is inserted
     *   in the function parameter list.
     *
     * - @priority: low|high
     *
     *   Each API that might eventually access hypervisor's monitor (and thus
     *   block) MUST fall into low priority. However, there are some exceptions
     *   to this rule, e.g. domainDestroy. Other APIs MAY be marked as high
     *   priority. If in doubt, it's safe to choose low. Low is taken as default,
     *   and thus can be left out.
     */
    /**
     * @generate: none
     * @priority: low
     */
    QEMU_PROC_MONITOR_COMMAND = 1,

    /**
     * @generate: both
     * @priority: low
     */
    QEMU_PROC_DOMAIN_ATTACH = 2,

    /**
     * @generate: both
     * @priority: low
     */
    QEMU_PROC_DOMAIN_AGENT_COMMAND = 3
};
