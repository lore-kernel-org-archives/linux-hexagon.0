From: Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 3.12 035/123] arc,hexagon: Delete asm/barrier.h
Date: Wed, 28 Oct 2015 14:50:52 +0100
Message-ID: <0cc61f06057ad62801bf72b384850f1f201dd034.1446021555.git.jslaby@suse.cz>
References: <a6f39d84d08b0e9d7f7e8bcb3d845ed676dd4e52.1446021555.git.jslaby@suse.cz>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <a6f39d84d08b0e9d7f7e8bcb3d845ed676dd4e52.1446021555.git.jslaby@suse.cz>
In-Reply-To: <cover.1446021555.git.jslaby@suse.cz>
References: <cover.1446021555.git.jslaby@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: stable@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Linus Torvalds <torvalds@linux-foundation.org>, Richard Kuo <rkuo@codeaurora.org>, Vineet Gupta <vgupta@synopsys.com>, linux-hexagon@vger.kernel.org, Ingo Molnar <mingo@kernel.org>, Jiri Slaby <jslaby@suse.cz>

From: Peter Zijlstra <peterz@infradead.org>

3.12-stable review patch.  If anyone has any objections, please let me know.

===============

commit 2ab08ee9f0a4eba27c7c4ce0b6d5118e8a18554b upstream.

Both already use asm-generic/barrier.h as per their
include/asm/Kbuild. Remove the stale files.

Signed-off-by: Peter Zijlstra <peterz@infradead.org>
Acked-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Link: http://lkml.kernel.org/n/tip-c7vlkshl3tblim0o8z2p70kt@git.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Richard Kuo <rkuo@codeaurora.org>
Cc: Vineet Gupta <vgupta@synopsys.com>
Cc: linux-hexagon@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 arch/arc/include/asm/barrier.h     | 37 -------------------------------------
 arch/hexagon/include/asm/barrier.h | 37 -------------------------------------
 2 files changed, 74 deletions(-)
 delete mode 100644 arch/arc/include/asm/barrier.h
 delete mode 100644 arch/hexagon/include/asm/barrier.h

diff --git a/arch/arc/include/asm/barrier.h b/arch/arc/include/asm/barrier.h
deleted file mode 100644
index c32245c3d1e9..000000000000
--- a/arch/arc/include/asm/barrier.h
+++ /dev/null
@@ -1,37 +0,0 @@
-/*
- * Copyright (C) 2004, 2007-2010, 2011-2012 Synopsys, Inc. (www.synopsys.com)
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-
-#ifndef __ASM_BARRIER_H
-#define __ASM_BARRIER_H
-
-#ifndef __ASSEMBLY__
-
-/* TODO-vineetg: Need to see what this does, don't we need sync anywhere */
-#define mb() __asm__ __volatile__ ("" : : : "memory")
-#define rmb() mb()
-#define wmb() mb()
-#define set_mb(var, value)  do { var = value; mb(); } while (0)
-#define set_wmb(var, value) do { var = value; wmb(); } while (0)
-#define read_barrier_depends()  mb()
-
-/* TODO-vineetg verify the correctness of macros here */
-#ifdef CONFIG_SMP
-#define smp_mb()        mb()
-#define smp_rmb()       rmb()
-#define smp_wmb()       wmb()
-#else
-#define smp_mb()        barrier()
-#define smp_rmb()       barrier()
-#define smp_wmb()       barrier()
-#endif
-
-#define smp_read_barrier_depends()      do { } while (0)
-
-#endif
-
-#endif
diff --git a/arch/hexagon/include/asm/barrier.h b/arch/hexagon/include/asm/barrier.h
deleted file mode 100644
index 4e863daea25b..000000000000
--- a/arch/hexagon/include/asm/barrier.h
+++ /dev/null
@@ -1,37 +0,0 @@
-/*
- * Memory barrier definitions for the Hexagon architecture
- *
- * Copyright (c) 2010-2011, The Linux Foundation. All rights reserved.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 and
- * only version 2 as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
- * 02110-1301, USA.
- */
-
-#ifndef _ASM_BARRIER_H
-#define _ASM_BARRIER_H
-
-#define rmb()				barrier()
-#define read_barrier_depends()		barrier()
-#define wmb()				barrier()
-#define mb()				barrier()
-#define smp_rmb()			barrier()
-#define smp_read_barrier_depends()	barrier()
-#define smp_wmb()			barrier()
-#define smp_mb()			barrier()
-
-/*  Set a value and use a memory barrier.  Used by the scheduler somewhere.  */
-#define set_mb(var, value) \
-	do { var = value; mb(); } while (0)
-
-#endif /* _ASM_BARRIER_H */
-- 
2.6.2
